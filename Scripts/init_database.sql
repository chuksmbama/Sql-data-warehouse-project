-- Create Database and schemas
-- Script Purpose:
--   This script creates a new database named 'DataWarehouse' after checking if it already exists.
--   if the database exists, it is dropped and recreated. Additionally, the script sets up three schemas within the database: 'bronze', 'silver' and 'gold'
use master;
--create database DataWarehouse;

-- Drop and recreate the 'DataWarehouse' database
if exist (select 1 from sys.databases where name = 'DataWarehouse')
begin
  Alter database DataWarehouse set single_user with rollback immediate;
  drop database DataWarehouse;
end;
go
Creating a new Database
--Using the new created database
use DataWarehouse;
--GO is a sepreator
-- Creating the schemeas
create schema bronze;
go
create schema silver;
go
create schema gold;
go
