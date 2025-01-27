# Optimizing Report Queries for MySQL 8.0

This document provides insights into optimizing report queries for a MySQL 8.0 database, focusing on performance improvement through indexing, schema modifications, and optimized queries.
I am running the project with roadrunner binaries. after downloading the binaries please run the project with bellow comand

``` ./rr serve comand ```

###I have redefine the relations to remove duplicate columns for foreign keys

``` Migrations are updated and each file has it's own Migration    ```


## Initial SQL Queries (Seeds)

### 1. Monthly Sales by Region
```sql
SELECT
    YEAR(order_date) AS year,
    MONTH(order_date) AS month,
    region_id,
    SUM(quantity * unit_price) AS total_sales_amount,
    COUNT(order_id) AS number_of_orders
FROM
    orders
JOIN
    stores ON orders.store_id = stores.store_id
WHERE
    order_date BETWEEN '2023-01-01' AND '2023-12-31'
GROUP BY
    YEAR(order_date), MONTH(order_date), region_id;
```

### 2. Top Categories by Store
```sql
SELECT
    store_id,
    category_id,
    SUM(quantity * unit_price) AS total_sales_amount,
    RANK() OVER (PARTITION BY store_id ORDER BY SUM(quantity * unit_price) DESC) AS rank_within_store
FROM
    orders
JOIN
    products ON orders.product_id = products.product_id
WHERE
    order_date BETWEEN '2023-01-01' AND '2023-03-31'
GROUP BY
    store_id, category_id;
```

## Challenges with Initial Queries

1. **Table Scans**
   - Full table scans due to missing indexes.
   - Aggregations like `SUM(quantity * unit_price)` add significant overhead.

2. **Joins**
   - Joining large tables (e.g., `orders` and `products`) adds processing time without proper indexing.

3. **Window Functions**
   - Using `RANK()` requires additional computations for each partition.

4. **Data Growth**
   - Increased data size exponentially impacts query performance.


## Schema Modifications

### 1. Adding Indexes
Composite indexes improve performance for filtering, grouping, and joining operations.

#### Suggested Indexes
```sql
-- Orders Table
CREATE INDEX idx_orders_date_store ON orders(order_date, store_id);
CREATE INDEX idx_orders_product ON orders(product_id);

-- Stores Table
CREATE INDEX idx_stores_store_id ON stores(store_id);

-- Products Table
CREATE INDEX idx_products_product_id ON products(product_id);
```

### 2. Precomputed Aggregations
Create summary tables for precomputed daily or monthly aggregates.

#### Example Summary Table
```sql
CREATE TABLE monthly_sales_by_region (
    year INT,
    month INT,
    region_id INT,
    total_sales_amount DECIMAL(15, 2),
    number_of_orders INT,
    PRIMARY KEY (year, month, region_id)
);
```

#### Daily Batch Update
```sql
INSERT INTO monthly_sales_by_region (year, month, region_id, total_sales_amount, number_of_orders)
SELECT
    YEAR(order_date), MONTH(order_date), region_id,
    SUM(quantity * unit_price), COUNT(order_id)
FROM
    orders
JOIN
    stores ON orders.store_id = stores.store_id
WHERE
    order_date BETWEEN CURDATE() - INTERVAL 1 DAY AND CURDATE()
GROUP BY
    YEAR(order_date), MONTH(order_date), region_id
ON DUPLICATE KEY UPDATE
    total_sales_amount = VALUES(total_sales_amount),
    number_of_orders = VALUES(number_of_orders);
```


## Optimized Queries

### 1. Monthly Sales by Region
```sql
SELECT
    year,
    month,
    region_id,
    total_sales_amount,
    number_of_orders
FROM
    monthly_sales_by_region
WHERE
    (year = 2023 AND month BETWEEN 1 AND 12)
ORDER BY
    year, month, region_id;
```

### 2. Top Categories by Store
Using a Common Table Expression (CTE):
```sql
WITH category_totals AS (
    SELECT
        store_id,
        category_id,
        SUM(quantity * unit_price) AS total_sales_amount
    FROM
        orders
    JOIN
        products ON orders.product_id = products.product_id
    WHERE
        order_date BETWEEN '2023-01-01' AND '2023-03-31'
    GROUP BY
        store_id, category_id
)
SELECT
    store_id,
    category_id,
    total_sales_amount,
    RANK() OVER (PARTITION BY store_id ORDER BY total_sales_amount DESC) AS rank_within_store
FROM
    category_totals
ORDER BY
    store_id, rank_within_store;
```


## Steps Taken to Optimize

1. **Identified Bottlenecks**
   - Slow aggregations due to missing indexes.
   - Join inefficiencies on large data sizes.
   - High resource usage by window functions.

2. **Schema Modifications**
   - Added composite indexes to accelerate joins and filtering.
   - Introduced summary tables to precompute monthly aggregations.

3. **Query Optimizations**
   - Leveraged summary tables for faster execution.
   - Used CTEs for cleaner, maintainable query structures.

4. **Scalability Testing**
   - Ensured performance stability with a 2x data growth using indexes and summary tables.
