/*
	Retorna instrução de criação de tabelas para o banco destino

	@param alias aplido do nome da tabela no dicinoário de dados (SS009.CODTABLE)
	@param empresa código alphanumérico hexadecimal de 4 posições com o código da empresa
	@param unidade código da filial para a qual a instrução deve ser criada
	@param destino banco de dados no qual a instrução resultante será executada. fb = Firebird / pgsql = PostgreSQL

	@return instrução de criação da tabela
*/
create or replace function ddl_create_table(
	in alias varchar,
	in empresa varchar,
	in unidade integer,
	in destino varchar) 
returns text as
$$
declare
	stmt			text;
	stru			text;
	stablename	varchar;
	r				record;
	CRLF			varchar;
begin
	stmt := '';
	CRLF := '';
	--CRLF := chr(13) + chr(10);

	
	select t.modo, t.export, t.view, t.viewsql, t.status
	  into r
	  from ss009 t      
     where t.codtable = upper(alias);
	 
	if not Found then
		raise '[[Tabela ou visão % não localizado no banco de dados]]', alias;
	end if;
	
	stablename := lower(alias);
	if r.modo <> 0 and destino <> 'fb' then
	   stablename := stablename + empresa + sys_iif(r.modo = 1, '000', to_char(unidade, 'FM000'));
	end if;
	
	if r.view = 1 then
	   stmt := format('create view %s as %s', stablename, r.viewsql);
	   return stmt;
	else
	   stmt := format('create table %s ', stablename);
	end if;
	 
    stru := '';

	for r in (
		select f.columnname, dt.fb_datatype, dt.pg_datatype, dt.required_length, dt.required_precision, 
			   f.size, f.precision, f.allownull, f.default_, ct.datatype
	  	  from ss012 f
	           join ss085 ct
	         	 on ct.recno = f.content_type
	       	   join ss086 dt
	             on dt.datatype = ct.datatype			    
         where f.codtable = upper(alias)
         order by f.order_, f.recno)
	loop
		if stru <> '' then
			stru := trim(stru) + ', ' + CRLF;
      end if;

		stru := stru + format('"%s" %s', lower(r.columnname), sys_iif(destino = 'pgsql', r.pg_datatype, r.fb_datatype));

		if r.required_length = 1 then
			if (destino = 'fb') and (r.size > 18) then
				r.size := 18;
			end if;
			stru := stru + to_char(r.size, '(FM9999999');
			if r.required_precision = 1 then
				stru := stru + ', ' + to_char(r.precision, 'FM9999990');			
			end if;
			stru := stru + ')';
		end if;

		stru := stru + ' ';
		
		if r.default_ is not null then
			stru := stru + 'default ' + sys_iif(r.datatype in ('V'), quote_literal(r.default_), r.default_) + ' ';
		end if;

		if r.allownull = 1 then
			stru := stru + 'not null ';
		end if;

	end loop;	 

	stmt := format('%s(%s);', stmt, trim(stru));
 
	return stmt;
end;
$$
language plpgsql;