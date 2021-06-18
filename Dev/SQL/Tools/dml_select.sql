create or replace function dml_select(
	in alias varchar,
	in empresa varchar,
	in unidade integer,
	in destino varchar,
   in where_ text) 
returns text as
$$
declare
	stmt			text;
	stru			text;
	stablename	varchar;
	r				record;
	CRLF			varchar;
begin
	stmt := 'select';
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
	 
    stru := '';

	for r in (
		select f.columnname
	  	  from ss012 f	           
       where f.codtable = upper(alias)
       order by f.order_, f.recno)
	loop
		if stru <> '' then
			stru := stru + ', ' + CRLF;
      end if;

		stru := stru + lower(r.columnname);
	end loop;	 

	stmt := format('%s %s from %s', stmt, trim(stru), stablename);

   if where_ is not null then
      stmt := stmt + ' where ' + trim(where_);
   end if;
 
	return stmt;
end;
$$
language plpgsql;

create or replace function dml_select(
	in alias varchar,
	in empresa varchar,
	in unidade integer,
	in destino varchar) 
returns text as
$$
begin
	return dml_select(alias, empresa, unidade, destino, null);
end;
$$
language plpgsql;