CREATE OR REPLACE FUNCTION mcobjss001()
  RETURNS trigger AS
$BODY$
Begin if tg_op = 'DELETE' then delete from ss018 where obj_id = old.obj_id; return old; end if; if new.obj_id is null then select sys_createid('S', new.owner_ ) into new.obj_id; end if; Return new; End; $BODY$
  LANGUAGE plpgsql VOLATILE
