drop table date_udf;
drop table date_udf_string;

create table date_udf (d date);
create table date_udf_string (d string);
from src
  insert overwrite table date_udf 
    select '2011-05-06' limit 1
  insert overwrite table date_udf_string
    select '2011-05-06' limit 1;

-- Test UDFs with date input
select unix_timestamp(d), year(d), month(d), day(d), dayofmonth(d),
    weekofyear(d), to_date(d)
  from date_udf;

select date_add(d, 5), date_sub(d, 10)
  from date_udf;

select datediff(d, d), datediff(d, '2002-03-21'), datediff('2002-03-21', d),
    datediff(cast ('2002-03-21 00:00:00' as timestamp), d),
    datediff(d, cast ('2002-03-21 00:00:00' as timestamp))
  from date_udf;

-- Test UDFs with string input
select unix_timestamp(d), year(d), month(d), day(d), dayofmonth(d), 
    weekofyear(d), to_date(d)
  from date_udf_string;

select date_add(d, 5), date_sub(d, 10)  from date_udf_string;

select datediff(d, d), datediff(d, '2002-03-21'), datediff('2002-03-21', d),
    datediff('2002-03-21 00:00:00', d),
    datediff(d, '2002-03-21 00:00:00')
  from date_udf_string;

drop table date_udf;
drop table date_udf_string;
