select tb.*,
       decode(balanorient, 1, '贷', '借') vdirection,
       decode(balanorient, 1, daimny - jiemny, jiemny - daimny) nsubjectmny
  from (select gd.pk_accountingbook,
               gd.pk_accasoa,
               bc.pk_customer pk_customer_old,
               bal.pk_areacl,
               fbo.pk_operstate,
               gd.pk_group,
               gd.pk_org,
               oov.pk_vid pk_org_v,
               ba.balanorient,
               ba.code def1,
               sum(gd.localcreditamount) daimny,
               sum(gd.localdebitamount) jiemny
          from gl_detail gd
          join gl_freevalue gf
            on gd.assid = gf.freevalueid
          join bd_account ba
            on gd.pk_account = ba.pk_account
          join org_orgs_v oov
            on gd.pk_org = oov.pk_org
          join bd_customer bc
            on bc.pk_customer in
               (substr(gf.typevalue1, 21, 40),
                substr(gf.typevalue2, 21, 40),
                substr(gf.typevalue3, 21, 40))
          left join bd_areacl bal
            on bal.pk_areacl in
               (substr(gf.typevalue1, 21, 40),
                substr(gf.typevalue2, 21, 40),
                substr(gf.typevalue3, 21, 40))
          left join fdcpub_bd_operstate fbo
            on fbo.pk_operstate in
               (substr(gf.typevalue1, 21, 40),
                substr(gf.typevalue2, 21, 40),
                substr(gf.typevalue3, 21, 40))
         where nvl(gd.dr, 0) = 0
           and bc.pk_customer in
               (select pk_customer
         
         from bd_customer
                 where name like '%1102房%')
         group by gd.pk_accountingbook,
                  gd.pk_accasoa,
                  bc.pk_customer,
                  bal.pk_areacl,
                  fbo.pk_operstate,
                  gd.pk_group,
                  gd.pk_org,
                  oov.pk_vid,
                  ba.balanorient,
                  ba.code) tb
 where daimny <> jiemny