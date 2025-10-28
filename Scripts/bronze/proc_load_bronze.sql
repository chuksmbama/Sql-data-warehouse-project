-- Script Purpose: 
-- This stored procedure loads data into the 'bronze' schema from external csv files.
--Loading all the data (using bulk insert) into the database
create or alter procedure bronze.load_bronze as 
begin
	declare @start_time datetime, @end_time datetime, @batch_start_time datetime, @batch_end_time datetime;
begin try
print '=========================================================';
print 'Loading Bronze Layer';
print '=========================================================';

print '=========================================================';
print 'Loading CRM tables';
print '==========================================================';

set @start_time = getdate();
print '>> Truncating Table: bronze.crm_cust_info';
truncate table bronze.crm_cust_info;

print '>> Inserting Data into: bronze.crm_cust_info';
bulk insert bronze.crm_cust_info
from 'C:\Users\personal\Documents\Data Warehouse Project\sql-data-warehouse-project\datasets\source_crm\cust_info.csv'
with (
	firstrow = 2,
	fieldterminator = ',',
	tablock
);
set @end_time = getdate();
print '>> Load Duration: ' + cast(datediff(second, @start_time, @end_time) as nvarchar) + ' seconds'
print '>> ---------------'

set @start_time = getdate();
print '>> Truncating Table: bronze.crm_prd_info';
truncate table bronze.crm_prd_info;

print '>> Inserting Data into: bronze.crm_prd_info';
bulk insert bronze.crm_prd_info
from 'C:\Users\personal\Documents\Data Warehouse Project\sql-data-warehouse-project\datasets\source_crm\prd_info.csv'
with (
	firstrow = 2,
	fieldterminator = ',',
	tablock
);
set @end_time = getdate();
print '>> Load Duration: ' + cast(datediff(second, @start_time, @end_time) as nvarchar) + ' seconds'
print '>> ---------------'


set @start_time = getdate();
print '>> Truncating Table: bronze.crm_sales_details';
truncate table bronze.crm_sales_details;
print '>> Inserting Data into: bronze.crm_sales_details';
bulk insert bronze.crm_sales_details
from 'C:\Users\personal\Documents\Data Warehouse Project\sql-data-warehouse-project\datasets\source_crm\sales_details.csv'
with (
	firstrow = 2,
	fieldterminator = ',',
	tablock
);
set @end_time = getdate();
print '>> Load Duration: ' + cast(datediff(second, @start_time, @end_time) as nvarchar) + ' seconds'
print '>> ---------------'



print '=========================================================';
print 'Loading ERP tables';
print '==========================================================';


set @start_time = getdate();
print '>> Truncating Table: bronze.erp_cust_az12';
truncate table bronze.erp_cust_az12;

print '>> Inserting Data into: bronze.erp_cust_az12';
bulk insert bronze.erp_cust_az12
from 'C:\Users\personal\Documents\Data Warehouse Project\sql-data-warehouse-project\datasets\source_erp\CUST_AZ12.csv'
with (
	firstrow = 2,
	fieldterminator = ',',
	tablock
);
set @end_time = getdate();
print '>> Load Duration: ' + cast(datediff(second, @start_time, @end_time) as nvarchar) + ' seconds'
print '>> ---------------'





set @start_time = getdate();
print '>> Truncating Table: bronze.erp_loc_a101';
truncate table bronze.erp_loc_a101;

print '>> Inserting Data into: bronze.erp_loc_a101';
bulk insert bronze.erp_loc_a101
from 'C:\Users\personal\Documents\Data Warehouse Project\sql-data-warehouse-project\datasets\source_erp\LOC_A101.csv'
with (
	firstrow = 2,
	fieldterminator = ',',
	tablock
);
set @end_time = getdate();
print '>> Load Duration: ' + cast(datediff(second, @start_time, @end_time) as nvarchar) + ' seconds'
print '>> ---------------'




set @start_time = getdate();
print '>> Truncating Table: bronze.erp_px_cat_g1v2';
truncate table bronze.erp_px_cat_g1v2;

print '>> Inserting Data into: bronze.erp_px_cat_g1v2';
bulk insert bronze.erp_px_cat_g1v2
from 'C:\Users\personal\Documents\Data Warehouse Project\sql-data-warehouse-project\datasets\source_erp\PX_CAT_G1V2.csv'
with (
	firstrow = 2,
	fieldterminator = ',',
	tablock
);
set @end_time = getdate();
print '>> Load Duration: ' + cast(datediff(second, @start_time, @end_time) as nvarchar) + ' seconds'
print '>> ---------------'

set @batch_end_time = GETDATE();
print '================================';
print 'Loading Bronze Layer is Completed';
print ' Total Load Duration: ' + cast(datediff(second, @batch_start_time, @batch_end_time) as varchar) + ' seconds';
print '=================================';



end try
begin catch
print '========================================================================';
print 'ERROR OCCURED DURING LOADING BRONZE LAYER'
print 'Error Message' + error_message();
print 'Error Message' + cast (error_number() as nvarchar);
print 'Error Message' + cast (error_state() as nvarchar);
print '========================================================================';
end catch
end

EXEC bronze.load_bronze
