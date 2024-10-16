SHOW DATABASES;
USE restaurant_system;

CREATE TABLE menu(
    id INT PRIMARY KEY AUTO_INCREMENT,
    item_name VARCHAR(100) UNIQUE NOT NULL,
    price DECIMAL(10, 2) NOT NULL
);
INSERT INTO menu (item_name, price) VALUES 
('Veg Cheese Burger', 80),
('Caesar Salad', 100),
('Chocolate Cake', 200),
('Margherita Pizza', 250),
('Hakka Noodles', 200),
('Coffee', 50),
('Apple Pie', 150),
('Chilli Paneer', 120);
SELECT * FROM menu;

CREATE TABLE customers (
    customer_id INT PRIMARY KEY AUTO_INCREMENT,
    customer_name VARCHAR(100) NOT NULL,
    phone_number INT
);
DESCRIBE customers;
INSERT INTO customers (customer_name,phone_number) VALUES 
('Amit Kumar', 998887771),
('Simran Gupta', 787454516),
('Virat Singh', 755859546);

SELECT * FROM customers;
CREATE TABLE orders (
    order_id INT NOT NULL,
    item_id INT NOT NULL,
    item varchar(100),
    quantity int DEFAULT 1,
    price decimal(10,2),
    FOREIGN KEY (order_id) REFERENCES customers(customer_id),
    FOREIGN KEY (item_id) references menu(id)
);
INSERT INTO orders (order_id, item_id, item, quantity) VALUES
(4, 5, 'Hakka Noodles', 1),
(6, 1, 'Veg Cheese Burger', 2),
(6, 7, 'Apple Pie', 2),
(5, 6, 'Coffee', 1),
(5, 4, 'Margherita Pizza', 1);
SELECT * FROM orders;

-- Trigger to automatically update price of orders on insert.



CREATE TABLE employee (
	employee_id int PRIMARY KEY AUTO_INCREMENT,
    employee_name varchar(100) NOT NULL UNIQUE,
    job varchar(100) DEFAULT 'staff',
    salary decimal(10,2) CHECK(salary>0)
);
INSERT INTO employee(employee_name, job, salary) VALUES
('Deepak Kumar', 'Manager', 35000),
('Meenakshi S.', 'Receptionist', 30000),
('Akash Mishra', 'Waiter', 15000),
('Jay Bhide', 'Waiter', 15000),
('Pragati Sahay', 'Chef', 32000),
('Soni Behel', 'Cleaner', 12000);
SELECT * FROM employee;
