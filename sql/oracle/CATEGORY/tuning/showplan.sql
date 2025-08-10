
--DESCRIBE: show an explain plan from the plan_table

set verify off

col lvl format a16
col opt format a20
col obj format a40

select lpad(' ',level-1) || level || '.' || decode(id,0,0,nvl(position,0)) lvl,
        decode(operation,'TABLE ACCESS','TBL ACCESS','BITMAP CONVERSION',
                'BITMAP CONV','BITMAP INDEX','BITMAP INX',operation) || ' ' ||
                decode(options,'BY ROWID','ROWID','CARTESIAN','CART',
                'TO ROWIDS','ROWID','SINGLE VALUE','SNGL',options) operation,
        decode(object_owner,null,'',
                decode(sign(23-length(rtrim(object_owner)||object_name)),
                        -1,object_name,rtrim(object_owner)||'.'||object_name)
                ) obj,
        object_instance,
        decode(optimizer,'CHOOSE','Choo','ANALYZED','Anal',optimizer) opt,
        decode(nvl(cost,0),0,'',
                decode(sign(cost-1048576),-1,
                        decode(sign(cost-9999),-1,
                                substr(to_char(cost, '9999'),2,99),
                                substr(to_char(trunc(cost/1024),'999'), 2,99)
                                        || 'K'
                                ),
                        substr(to_char(trunc(cost/1048576),'99999'),2,99) || 'M')
                ) cost,
        decode(nvl(cardinality,0),0,'',
                decode(sign(cardinality-1048576),-1,
                        decode(sign(cardinality-9999),-1,
                                substr(to_char(cardinality, '9999'),2,99),
                                substr(to_char(trunc(cardinality/1024),'999'),
                                        2,99) || 'K'
                                ),
                        substr(to_char(trunc(cardinality/1048576),'99999'),2,99)
                                || 'M'
                        )
                ) cardinality,
        decode(nvl(bytes,0),0,'',
                decode(sign(bytes-1048576),-1,
                        decode(sign(bytes-9999),-1,
                                substr(to_char(bytes, '9999'),2,99),
                                substr(to_char(trunc(bytes/1024),'999'),2,99)
                                        || 'K'
                                ),
                        substr(to_char(trunc(bytes/1048576),'99999'),2,99) || 'M'
                        )
                ) bytes
        from plan_table 
        start with id = 0 and statement_id = '&&myid'
        connect by prior id = parent_id and statement_id = '&&myid';

undefine myid

