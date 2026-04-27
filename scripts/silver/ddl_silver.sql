
/*
=====================================================
DDL Script: create silver tables (ngôn ngữ định nghĩa dữ liệu)
=====================================================
Script purpose: 
  This script creates tables in the 'silver' schema, dropping existing tables if they already exist
  Run this script to re define the DDL structure of 'silver' tables
=====================================================
*/
-- Create silver layers
USE Datawarehouse
GO
--Drop het noi dung table then tao tu dau
if object_id('silver.crm_cus_info' , 'U') is not null
	drop table silver.crm_cus_info;
CREATE TABLE silver.crm_cus_info(
	cst_id				int,
	cst_key				nvarchar(50),
	cst_firstname		nvarchar(50),
	cst_lastname		nvarchar(50),
	cst_martial_status	nvarchar(50),
	cst_gndr			nvarchar(50),
	cst_create_date		DATE,
	dwh_create_date		datetime2 default getdate()
	)
go

if object_id('silver.crm_prd_info' , 'U') is not null
	drop table silver.crm_prd_info;
CREATE TABLE silver.crm_prd_info(
	prd_id		int,
	cat_id		nvarchar(50),
	prd_key		nvarchar(50),
	prd_nm		nvarchar(50),
	prd_cost	int,
	prd_line	nvarchar(50),
	prd_start_dt date,
	prd_end_dt	date,
	dwh_create_date		datetime2 default getdate()
	)
go

if object_id('silver.crm_sales_details' , 'U') is not null
	drop table silver.crm_sales_details;
CREATE TABLE silver.crm_sales_details(
	sls_ord_num		nvarchar(50),
	sls_prd_key		nvarchar(50),
	sls_cust_id		nvarchar(50),
	sls_order_dt	date,
	sls_ship_dt		date,
	sls_due_dt		date,
	sls_sales		int,
	sls_quantity	int,
	sls_price		int,
	dwh_create_date		datetime2 default getdate()
	)
go

if object_id('silver.erp_cuz_az12' , 'U') is not null
	drop table silver.erp_cuz_az12;
CREATE TABLE silver.erp_cuz_az12(
	CID nvarchar(50),
	BDATE date,
	GEN nvarchar(50),
	dwh_create_date		datetime2 default getdate()
	)
go

if object_id('silver.erp_loc_a101' , 'U') is not null
	drop table silver.erp_loc_a101;
CREATE TABLE silver.erp_loc_a101(
	CID		nvarchar(50),
	CNTRY	nvarchar(50),
	dwh_create_date		datetime2 default getdate()
	)
go

if object_id('silver.erp_px_cat_g1v2' , 'U') is not null
	drop table silver.erp_px_cat_g1v2;
CREATE TABLE silver.erp_px_cat_g1v2(
	ID			nvarchar(50),
	CAT			nvarchar(50),
	SUBCAT		nvarchar(50),
	MAINTENANCE nvarchar(50),
	dwh_create_date		datetime2 default getdate()
	)
go
