/*
=============================================================================================
DDL script: create Gold Views
=============================================================================================
Script purpose: 
  This script creates views for the Gold layer in the data warehouse
  The gold layer represents the final dimension and fact tables (star schema)

  Each view performs transformations and combines data from silver layer to produce a clean, enriched, and business-ready dataset. 

Usage:
  - These views can be queried directly for analytics and reporting.
=============================================================================================
*/
--Create dimension: gold.dim_customer
if object_id('gold.dim_customers','v') is not null
  drop view gold.dim_customers;
go
create view gold.dim_customers as
select row_number() over(order by cst_id) as customer_key
	,ci.cst_id customer_id
	,ci.cst_key customer_number
	,ci.cst_firstname first_name
	,ci.cst_lastname last_name
	,la.CNTRY country
	,ci.cst_martial_status marital_status
	,case when ci.cst_gndr != 'n/a' then ci.cst_gndr --CRM is the master for gender information
	 else coalesce(ca.GEN,'n/a') end gender
	--,ci.cst_gndr
	,ca.BDATE birthdate
	,ci.cst_create_date create_date
	--,ca.GEN
from silver.crm_cus_info ci
left join silver.erp_cuz_az12 ca
on ci.cst_key = ca.CID
left join silver.erp_loc_a101 la
on ci.cst_key = la.CID

--After joining table, check if any duplicate were introduced by the join logic
--select cst_id, count(*) from CTE 
--group by cst_id
--having count(*) > 1

--doing data integration with gen and cst_gndr
select ci.cst_gndr
	,ca.GEN
	
from silver.crm_cus_info ci
left join silver.erp_cuz_az12 ca
on ci.cst_key = ca.CID
left join silver.erp_loc_a101 la
on ci.cst_key = la.CID
order by 1,2
--quality check of the gold table
select distinct gender from gold.dim_customers

--joining product information from crm & product category in erp
--select prd_key, count(*) from
if object_id('gold.dim_products','v') is not null
  drop view gold.dim_products;
go
create view gold.dim_products as
select row_number() over(order by pn.prd_start_dt,pn.prd_key) product_key
	,pn.prd_id product_id --put the friendly name
	,pn.prd_key product_number
	,pn.prd_nm product_name
	,pn.cat_id category_id
	,pc.CAT category
	,pc.SUBCAT subcategory
	,pc.MAINTENANCE maintenance
	,pn.prd_cost cost
	,pn.prd_line product_line
	,pn.prd_start_dt start_date
from silver.crm_prd_info pn
left join silver.erp_px_cat_g1v2 pc
on pn.cat_id = pc.ID
where prd_end_dt is null--filtering out all historical data
--group by prd_key
--having count(*) > 1 --checking is there any duplicate in the product key or not 

--create a fact table
if object_id('gold.fact_sales','v') is not null
  drop view gold.fact_sales;
go
create view gold.fact_sales as
select sd.sls_ord_num order_number --put the friendly name
	,pr.product_key
	--,sd.sls_prd_key
	--,sd.sls_cust_id
	,cu.customer_key
	,sd.sls_order_dt order_date
	,sd.sls_ship_dt shipping_date
	,sd.sls_due_dt due_date
	,sd.sls_sales sales_amount
	,sd.sls_quantity quantity
	,sd.sls_price price
from silver.crm_sales_details sd
left join gold.dim_products pr
on sd.sls_prd_key = pr.product_number
left join gold.dim_customers cu
on sd.sls_cust_id = cu.customer_id
--sort the columns into logical groups to improve readability

--checking again the golden layer
select * from gold.fact_sales f
left join gold.dim_customers c
on f.customer_key = c.customer_key
left join gold.dim_products p
on f.product_key = p.product_key
where p.product_key is null
