select * from customer

select shipping_type,ROUND(AVG(purchase_amount),1)
from customer
where shipping_type in ('Standard','Express')
group by shipping_type 

select item_purchased,
ROUND(100 *SUM(CASE WHEN discount_applied = 'Yes' THEN 1 ELSE 0 END)/COUNT(*)) as discount_rate
from customer
group by item_purchased
order by discount_rate desc
limit 5;

with customer_type as (
select customer_id,previous_purchases,
CASE
    WHEN previous_purchases = 1 THEN 'New'
    WHEN previous_purchases BETWEEN 2 AND 10 THEN'Returning'
	ELSE 'Loyal'
	END AS customer_segment
from customer
)

select customer_segment,count(*) as number_of_customer
from customer_type 
group by customer_segment

 
with item_count as (
select category,item_purchased,
COUNT(customer_id) as total_orders,
ROW_NUMBER() over(partition by category order by count(customer_id)desc) as item_rank
from customer
group by category,item_purchased
)

select item_rank,category,item_purchased,total_orders
from item_count
where item_rank <=3;

 
select subscription_status,
COUNT(customer_id) as repeat_buyers
from customer
where previous_purchases > 5
group by subscription_status


select age_group,
SUM(purchase_amount) as total_revenue
from customer
group by age_group
order by total_revenue desc;