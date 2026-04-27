/*
==============================================================================================
Quality checks:
==============================================================================================
Scripts purpose:
  This script performs quality check to validate the integrity, consitency, and accuracy of the Gold layer.
  These checks ensure: 
  - Uniqueness of surrogate keys in dimension tables
  - Refernetial integrity between fact and dimension table
  - Validation of relationships in the data model for analytical purpose
Usage note: 
  - Run these checks after data loading silver layer
  - Investigate and resolve any discripancies found during the checks
==============================================================================================
*/

