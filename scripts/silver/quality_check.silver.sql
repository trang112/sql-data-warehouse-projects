/*
=================================================================================================
Quality checks
=================================================================================================
Script purpose: 
  This script perform various quality checks for data consistency, accuracy, and standardization across the 
  'silver' schema. it includes checks for:
  - Null or duplicate primary keys
  - Unwanted spaces in string fields
  - Data standardization and consistency
  - Invalid date ranges and orders
  - Data consitency between related fields
Usage notes: 
  - Run these checks after data loading silver layer
  - Investigate and resolve any discrepancies found during the checks
==================================================================================================
*/
--Check for nulls or duplicates in primary key
--expectation: no result
--similar check with cst_id
select prd_id
	, count(*)
from bronze.crm_prd_info
group by prd_id
having count(*) > 1 or prd_id is null 


--Check unwanted spaces
--expectation: No results
--check with prd_nm
select cst_lastname
from silver.crm_cus_info
where cst_lastname != trim(cst_lastname)


--Quality check: check the consistency of values in low cardinality columns
-- Data standardization & consistency 
--similar check with prd_line, gender in erp_cuz_az12
select distinct prd_line 
from silver.crm_prd_info


--Check for nulls or negative numbers
--expectation: no results
select prd_cost
from silver.crm_prd_info
where prd_cost <0 or prd_cost is null


--Check for invalid date orders - solutions: end dates = start date of the next record - 1
select * from silver.crm_prd_info
where prd_end_dt < prd_start_dt

select * from silver.crm_sales_details
where sls_order_dt > sls_ship_dt
or sls_order_dt > sls_due_dt

--identify out-of-range dates
select distinct BDATE from silver.erp_cuz_az12
where BDATE <'1924-01-01'or BDATE > getdate()

--Check for invalid value in the number to conver to date
select 
	nullif(sls_due_dt,0) sls_due_dt-- change the type of value, if value is 0, then change to null
from bronze.crm_sales_details
where sls_due_dt <= 0 or len(sls_due_dt) != 8 -- check any value is negative, because negative numbers or zeros can not be cast to a date
or sls_due_dt > 20500101 or sls_due_dt < 19000101 --check for outliers by validating the boundaries of the date range

--Check for the related tables
select replace(CID,'-','') CID
from bronze.erp_loc_a101
where replace(CID,'-','') not in (select cst_key from silver.crm_cus_info) 

