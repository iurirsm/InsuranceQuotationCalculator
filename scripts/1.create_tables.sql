-- Create Customers table
CREATE TABLE Customers (
    customer_id NUMBER PRIMARY KEY,
    first_name VARCHAR2(50) NOT NULL,
    last_name VARCHAR2(50) NOT NULL,
    date_of_birth DATE NOT NULL,
    email VARCHAR2(100) UNIQUE NOT NULL,
    phone_number VARCHAR2(15),
    address VARCHAR2(200)
);

-- Create Quotes table
CREATE TABLE Quotes (
    quote_id NUMBER PRIMARY KEY,
    customer_id NUMBER NOT NULL,
    coverage_type VARCHAR2(50) NOT NULL,
    quote_amount NUMBER(10,2) NOT NULL,
    quote_date DATE DEFAULT SYSDATE,
    FOREIGN KEY (customer_id) REFERENCES Customers(customer_id)
);

-- Create Coverage_Types table
CREATE TABLE Coverage_Types (
    coverage_type_id NUMBER PRIMARY KEY,
    coverage_name VARCHAR2(50) NOT NULL,
    base_rate NUMBER(10,2) NOT NULL
);

-- Create Audit_Log table
CREATE TABLE Audit_Log (
    log_id NUMBER PRIMARY KEY,
    table_name VARCHAR2(50) NOT NULL,
    operation VARCHAR2(10) NOT NULL,
    operation_date DATE DEFAULT SYSDATE
);

-- Create Payments table
CREATE TABLE Payments (
    payment_id NUMBER PRIMARY KEY,
    customer_id NUMBER NOT NULL,
    amount_paid NUMBER(10,2) NOT NULL,
    payment_date DATE DEFAULT SYSDATE,
    FOREIGN KEY (customer_id) REFERENCES Customers(customer_id)
);
