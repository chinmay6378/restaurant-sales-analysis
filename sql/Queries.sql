
CREATE TABLE customers (
  customer_id SERIAL PRIMARY KEY,
  name VARCHAR(50),
  phone VARCHAR(20),
  email VARCHAR(50)
);

CREATE TABLE menu_items (
  menu_item_id SERIAL PRIMARY KEY,
  item_name VARCHAR(50),
  category VARCHAR(30),
  price DECIMAL(5,2)
);

CREATE TABLE orders (
  order_id SERIAL PRIMARY KEY,
  customer_id INT REFERENCES customers(customer_id),
  order_date DATE,
  total_amount DECIMAL(7,2)
);

CREATE TABLE order_items (
  order_item_id SERIAL PRIMARY KEY,
  order_id INT REFERENCES orders(order_id),
  menu_item_id INT REFERENCES menu_items(menu_item_id),
  quantity INT
);

SELECT 
  DATE_TRUNC('month', order_date) AS month,
  SUM(total_amount) AS total_sales
FROM orders
GROUP BY month
ORDER BY month;

SELECT 
  mi.item_name,
  SUM(oi.quantity) AS total_sold
FROM order_items oi
JOIN menu_items mi ON oi.menu_item_id = mi.menu_item_id
GROUP BY mi.item_name
ORDER BY total_sold DESC
LIMIT 5;


SELECT 
  c.name,
  COUNT(o.order_id) AS num_orders,
  SUM(o.total_amount) AS total_spent
FROM customers c
JOIN orders o ON c.customer_id = o.customer_id
GROUP BY c.name
ORDER BY total_spent DESC
LIMIT 5;

SELECT 
  TO_CHAR(order_date, 'Day') AS weekday,
  COUNT(order_id) AS total_orders
FROM orders
GROUP BY weekday
ORDER BY total_orders DESC;

