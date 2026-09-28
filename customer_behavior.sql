select * from customer 

select gender, SUM(purchase_amount) as revenue
from customer
group by gender

select customer_id, purchase_amount
from customer
where discount_applied = 'Yes' and purchase_amount >= (select AVG(purchase_amount) from customer)

select item_purchased,ROUND(AVG(review_rating::numeric),2) as "average product rating"
from customer
group by item_purchased
order by avg(review_rating) desc
limit 5;

select shipping_type,ROUND(AVG(purchase_amount),2)
from customer
where shipping_type in ('Standard','Express')
group by shipping_type

select subscription_status,
COUNT(customer_id) as total_customers,
ROUND(AVG(purchase_amount),2) as spend,
ROUND(SUM(purchase_amount),2) as total_revenue
from customer
group by subscription_status
order by total_revenue,spend desc;
