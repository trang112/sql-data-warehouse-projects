# Data dictionary for Gold Layer
## 1.gold.dim_customers
- Purpose: stores customer details enriched with demographic and geographic data
- Columns:

| Column Name   | Data Type     | Description                                                                     |
| ------------- | ------------- | --------------------------------------------------------------------------------|    
| customer_key  | INT           | surrogate key uniquely identifying each customer record in the dimention table. | 
| customer_id   | INT           | unique numerical identifier assigned to each customer.                             |   
| customer_number   | nvarchar(50)      |alphanumeric identifier representing the customer, used for tracking and referencing                             |   
| first_name   | nvarchar(50)       |the customer first name, as recorded in the system                    |  
| last_name   | nvarchar(50)       |the customer last name, as recorded in the system                    |
| country   | nvarchar(50)       |the country of residence for the customer (eg Australia)                    |  
| marital_status   | nvarchar(50)       |the marital status of a customer (e.g Married, single)        |
| gender   | nvarchar(50)       |the gender of a customer (e.g Male, female, n/a)        |
| birthdate   | date       |the date of birth of the customer       |
| create_date   | date       |the date and time when the customer record was created in the system       |

## 2.gold.dim_products
- Purpose: provides information about the products and their attributes
- Columns:

| Column Name   | Data Type     | Description                                                                     |
| ------------- | ------------- | --------------------------------------------------------------------------------|    
| product_key  | INT | surrogate key uniquely identifying each product record in the dimension table. |
| product_id  | INT | A unique identifier assigned to the product for internal tracking and referencing | 
| product_number  | nvarchar(50) | A structure alphanumeric code representing the product, offen used for categorization or inventory |
| category_id  | nvarchar(50) | A unique identifier for the product's category, linking to its high-level classification |
| category  | nvarchar(50) | The broader classification of the product to group related items |
| subcategory  | nvarchar(50) | A more detailed classification of the product within the category, such as product type |
| maintenance  | nvarchar(50) | Indicates whether the product requires maintenance (e.g Yes, No)|
| cost  | INT | The cost or base price of the product, measured in monetary units|
| product_line  | nvarchar(50) | The specific product line or series to which product belongs (e.g Road, Mountain,..)|
| start_date   | date       |the date when the product became available for sale or use, stored in   |

## 3.gold.fact_sales
- Purpose: stores transactional sales data for analytical purposes
- Columns:

| Column Name   | Data Type     | Description                                                                     |
| ------------- | ------------- | --------------------------------------------------------------------------------|    
| order_number | nvarchar(50) | A unique alphanumeric identifier for each sales order (e.g SO54496|
| product_key  | INT | surrogate key uniquely identifying each product record in the dimension table. | 
| customer_key  | INT           | surrogate key uniquely identifying each customer record in the dimention table. | 
| order_date  | date | The date when the order was placed |
| shipping_date  | date | The date when the order was shipped to the customer |
| due_date  | date | The date when the order payment was due |
|sales_amount  |int| The total monetary value of the sale for the line item, in whole currency unit (e.g 25)|
|quantity  |int| The number of units of the product ordered for the line item|
|price  |int| The price per unit of the product for the line item, in whole currency units|
