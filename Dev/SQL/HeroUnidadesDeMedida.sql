CREATE OR REPLACE FUNCTION mc_000740001001()
  RETURNS trigger AS
$BODY$
Declare
   if1_codnat     sf10001000.f1_codnat%type;
   imsg           varchar;
   iAlterou       Integer;                      
Begin
   if tg_op = 'UPDATE' then
      if coalesce(old.sbf_rastro, -1) <> coalesce(new.sbf_rastro, -1) or
         coalesce(old.sbf_localiz, -1) <> coalesce(new.sbf_localiz, -1) or
         coalesce(old.z2_coduni, '') <> coalesce(new.z2_coduni, '') or
         coalesce(old.b1_coduni, '') <> coalesce(new.b1_coduni, '')
      then
         imsg := mc_002330001001(new.b1_codpro);
         --imsg := '';
         if imsg <> '' then
            raise exception '[[%]]', imsg;
         end if;
      end if;
      If (old.f1_codnat <> new.f1_codnat) Or (old.f1_codnat Is Null And new.f1_codnat Is Not Null) Then
         If new.sbf_ccusto <> 1 Then
            If (Select f1_dcusto From sf10001000 Where f1_codnat = new.f1_codnat) Is Not Null Then
               Raise Exception '[[ATENÇÃO. Não é possível alterar a natureza financeira para % porque ela obriga centro de custos e o produto não. Favor verificar.]]', new.f1_codnat;
            End If;
         End If;
      End If;
      If (old.sbf_ccusto <> new.sbf_ccusto) Or (old.sbf_ccusto Is Null And new.sbf_ccusto Is Not Null) Then
         If new.sbf_ccusto <> 1 Then
            If new.f1_codnat Is Null Then
               Select f1_codnat Into if1_codnat From sb10001000 Where b1_codpro = new.b1_codpro;
            Else
               if1_codnat := new.f1_codnat;
            End If;
            If if1_codnat Is Not Null Then
               If (Select f1_dcusto From sf10001000 Where f1_codnat = if1_codnat) Is Not Null Then
                  Raise Exception '[[ATENÇÃO. Não é possível alterar a obrigatoriedade do centro de custos porque a natureza financeira % obriga centro de custos e o produto deve acompanhar. Favor verificar.]]', if1_codnat;
               End If;
            End If;
         End If;
      End If;
      if coalesce(old.sbf_3oc, -1) <> coalesce(new.sbf_3oc, -1) then
         if exists(
            select 1
              from a0h0001001
             where b1_codpro = new.b1_codpro
             limit 1)
         then
            raise exception '[[O produto % não pode ter o controle de terceiros desabilitado porque já foi movimentado.]]', new.b1_codpro;
         end if;
      end if;
      if new.sbf_3oc = 1 and coalesce(old.sbf_3tipo, -1) <> coalesce(new.sbf_3tipo, -1) then
         if exists(
            select 1
              from a0h0001001
             where b1_codpro = new.b1_codpro
             limit 1)
         then
            raise exception '[[O produto % não pode ter o tipo alterado porque já foi movimentado.]]', new.b1_codpro;
         end if;
      end if;
   else
      if new.b3_codlocal_dev is null then
         new.b3_codlocal_dev := new.b3_codlocal;
      end if;
      if new.sbf_localiz = 1 and new.scm_ender_dev is null then
         new.scm_ender_dev := new.scm_ender;
      end if;
      select z2_coduni, b1_coduni
        into new.z2_coduni, new.b1_coduni
        from sb10001000
       where b1_codpro = new.b1_codpro;
   end if;
   new.sbf_qtddisp  := new.sbf_qtd  - (new.sbf_emp  + new.sbf_qtdbloq);
   new.sbf_sqtddisp := new.sbf_sqtd - (new.sbf_semp + new.sbf_sqtdbloq);
   if new.sbf_localiz <> 1 then
      new.scm_ender := null;
      new.scm_ender_dev := null;
   end if;
   if new.sbf_3oc = 1 then
      new.sbf_ccusto := 2; 
      new.sbf_reclassfin := 0; 
      new.sbf_desativo := 0; 
   end if;
   If tg_op <> 'DELETE' Then
      iAlterou := 0;
      If tg_op = 'UPDATE' Then
         If old.f1_codnat <> new.f1_codnat Or (old.f1_codnat Is Null And new.f1_codnat Is Not Null) Then
            iAlterou := 1;
         End If;
      End If;
      If iAlterou = 1 Or (tg_op = 'INSERT' And new.f1_codnat Is Not Null) Then
         If not ck_000070001000(new.f1_codnat) Then
            Raise Exception '[[ATENÇÃO. A natureza financeira % está inativa. Favor verificar.]]', new.f1_codnat;
         End If;
      End If;
      Return new;
   Else
      Return old;
   End If;
End;
$BODY$
  LANGUAGE plpgsql VOLATILE
  COST 100;
ALTER FUNCTION mc_000740001001()
  OWNER TO mc_tupi;
