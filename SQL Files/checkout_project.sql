show databases;
use 365_checkout_database;

show tables;

select distinct action_name from checkout_actions;

select * from checkout_carts c
right outer join checkout_actions a
on a.user_id=c.user_id
order by a.user_id;


select * from checkout_actions where user_id=278;
select char(',',action_name) from checkout_actions;

select count(distinct user_id) from checkout_carts;

select * from checkout_actions a
join checkout_carts c
on a.user_id=c.user_id
order by user_id;


select * from checkout_carts;

with t1 as (select action_date,count(*) as count_total_carts
from checkout_carts
group by 1
order by 1)
select t1.action_date,count_total_carts,
	count_total_checkout_attempts,
    count_successful_checkout_attempts
from t1
join (

select action_date,
	count(checkout) as count_total_checkout_attempts
from
(select *,
	case when left(action_name,8)='checkout' 
		then 'checkout_attempt'
		else 'other'  end as checkout,
    case when left(action_name,8)='checkout' 
		and right(action_name,1)='l' then 'checkout_fail'
        when left(action_name,8)='checkout' 
		and right(action_name,1)='s' then 'checkout_success'
        else 'other'
        end as checkout_result
 from checkout_actions) as t1
 where checkout='checkout_attempt'
 group by 1
 order by 1) as t2
 on t1.action_date=t2.action_date
 join
 
(select action_date,count(checkout_result) as count_successful_checkout_attempts from
(select *,
	case when left(action_name,8)='checkout' 
		then 'checkout_attempt'
		else 'other'  end as checkout,
    case when left(action_name,8)='checkout' 
		and right(action_name,1)='l' then 'checkout_fail'
        when left(action_name,8)='checkout' 
		and right(action_name,1)='s' then 'checkout_success'
        else 'other'
        end as checkout_result
 from checkout_actions) as t3
 where checkout_result='checkout_success'
 group by 1
 order by 1) as t4
 on t1.action_date=t4.action_date;



select * from checkout_actions;

select user_id,action_date,action_name,error_message,device
from checkout_actions
where action_name like 'checkout%' and right(action_name,1)='l';


select distinct action_name from checkout_actions;

