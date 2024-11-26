-- Insert records into Coverage_Types (reference/lookup table)
INSERT INTO Coverage_Types (coverage_type_id, coverage_name, base_rate)
VALUES (coverage_type_seq.NEXTVAL, 'Basic', 100);

INSERT INTO Coverage_Types (coverage_type_id, coverage_name, base_rate)
VALUES (coverage_type_seq.NEXTVAL, 'Standard', 150);

INSERT INTO Coverage_Types (coverage_type_id, coverage_name, base_rate)
VALUES (coverage_type_seq.NEXTVAL, 'Premium', 200);

INSERT INTO Coverage_Types (coverage_type_id, coverage_name, base_rate)
VALUES (coverage_type_seq.NEXTVAL, 'Ultimate', 250);

INSERT INTO Coverage_Types (coverage_type_id, coverage_name, base_rate)
VALUES (coverage_type_seq.NEXTVAL, 'Family Plan', 300);

-- Insert records into Customers (data table)
INSERT INTO Customers (customer_id, first_name, last_name, date_of_birth, email, phone_number, address)
VALUES (customer_seq.NEXTVAL, 'Alice', 'Smith', TO_DATE('1985-04-12', 'YYYY-MM-DD'), 'alice.smith@example.com', '555-1234', '123 Maple Street');

INSERT INTO Customers (customer_id, first_name, last_name, date_of_birth, email, phone_number, address)
VALUES (customer_seq.NEXTVAL, 'Bob', 'Johnson', TO_DATE('1978-07-23', 'YYYY-MM-DD'), 'bob.johnson@example.com', '555-5678', '456 Oak Avenue');

INSERT INTO Customers (customer_id, first_name, last_name, date_of_birth, email, phone_number, address)
VALUES (customer_seq.NEXTVAL, 'Carol', 'Williams', TO_DATE('1990-11-30', 'YYYY-MM-DD'), 'carol.williams@example.com', '555-8765', '789 Pine Road');

INSERT INTO Customers (customer_id, first_name, last_name, date_of_birth, email, phone_number, address)
VALUES (customer_seq.NEXTVAL, 'David', 'Brown', TO_DATE('1982-02-15', 'YYYY-MM-DD'), 'david.brown@example.com', '555-4321', '321 Birch Lane');

INSERT INTO Customers (customer_id, first_name, last_name, date_of_birth, email, phone_number, address)
VALUES (customer_seq.NEXTVAL, 'Eva', 'Davis', TO_DATE('1975-09-05', 'YYYY-MM-DD'), 'eva.davis@example.com', '555-9876', '654 Cedar Court');

INSERT INTO Customers (customer_id, first_name, last_name, date_of_birth, email, phone_number, address)
VALUES (customer_seq.NEXTVAL, 'Frank', 'Miller', TO_DATE('1988-12-20', 'YYYY-MM-DD'), 'frank.miller@example.com', '555-1357', '987 Elm Street');

INSERT INTO Customers (customer_id, first_name, last_name, date_of_birth, email, phone_number, address)
VALUES (customer_seq.NEXTVAL, 'Grace', 'Wilson', TO_DATE('1993-06-18', 'YYYY-MM-DD'), 'grace.wilson@example.com', '555-2468', '159 Spruce Way');

INSERT INTO Customers (customer_id, first_name, last_name, date_of_birth, email, phone_number, address)
VALUES (customer_seq.NEXTVAL, 'Henry', 'Moore', TO_DATE('1980-08-10', 'YYYY-MM-DD'), 'henry.moore@example.com', '555-3690', '753 Willow Drive');

INSERT INTO Customers (customer_id, first_name, last_name, date_of_birth, email, phone_number, address)
VALUES (customer_seq.NEXTVAL, 'Ivy', 'Taylor', TO_DATE('1983-05-27', 'YYYY-MM-DD'), 'ivy.taylor@example.com', '555-1470', '852 Aspen Circle');

INSERT INTO Customers (customer_id, first_name, last_name, date_of_birth, email, phone_number, address)
VALUES (customer_seq.NEXTVAL, 'Jack', 'Anderson', TO_DATE('1995-01-14', 'YYYY-MM-DD'), 'jack.anderson@example.com', '555-2580', '951 Poplar Place');

-- Insert records into Quotes (data table)
INSERT INTO Quotes (quote_id, customer_id, coverage_type, quote_amount)
VALUES (quote_seq.NEXTVAL, 1, 'Basic', 100);

INSERT INTO Quotes (quote_id, customer_id, coverage_type, quote_amount)
VALUES (quote_seq.NEXTVAL, 2, 'Standard', 150);

INSERT INTO Quotes (quote_id, customer_id, coverage_type, quote_amount)
VALUES (quote_seq.NEXTVAL, 3, 'Premium', 200);

INSERT INTO Quotes (quote_id, customer_id, coverage_type, quote_amount)
VALUES (quote_seq.NEXTVAL, 4, 'Ultimate', 250);

INSERT INTO Quotes (quote_id, customer_id, coverage_type, quote_amount)
VALUES (quote_seq.NEXTVAL, 5, 'Family Plan', 300);

INSERT INTO Quotes (quote_id, customer_id, coverage_type, quote_amount)
VALUES (quote_seq.NEXTVAL, 6, 'Basic', 100);

INSERT INTO Quotes (quote_id, customer_id, coverage_type, quote_amount)
VALUES (quote_seq.NEXTVAL, 7, 'Standard', 150);

INSERT INTO Quotes (quote_id, customer_id, coverage_type, quote_amount)
VALUES (quote_seq.NEXTVAL, 8, 'Premium', 200);

INSERT INTO Quotes (quote_id, customer_id, coverage_type, quote_amount)
VALUES (quote_seq.NEXTVAL, 9, 'Ultimate', 250);

INSERT INTO Quotes (quote_id, customer_id, coverage_type, quote_amount)
VALUES (quote_seq.NEXTVAL, 10, 'Family Plan', 300);

-- Insert records into Payments (data table)
INSERT INTO Payments (payment_id, customer_id, amount_paid, payment_date)
VALUES (payment_seq.NEXTVAL, 1, 100, SYSDATE - 10);

INSERT INTO Payments (payment_id, customer_id, amount_paid, payment_date)
VALUES (payment_seq.NEXTVAL, 2, 150, SYSDATE - 9);

INSERT INTO Payments (payment_id, customer_id, amount_paid, payment_date)
VALUES (payment_seq.NEXTVAL, 3, 200, SYSDATE - 8);

INSERT INTO Payments (payment_id, customer_id, amount_paid, payment_date)
VALUES (payment_seq.NEXTVAL, 4, 250, SYSDATE - 7);

INSERT INTO Payments (payment_id, customer_id, amount_paid, payment_date)
VALUES (payment_seq.NEXTVAL, 5, 300, SYSDATE - 6);

INSERT INTO Payments (payment_id, customer_id, amount_paid, payment_date)
VALUES (payment_seq.NEXTVAL, 6, 100, SYSDATE - 5);

INSERT INTO Payments (payment_id, customer_id, amount_paid, payment_date)
VALUES (payment_seq.NEXTVAL, 7, 150, SYSDATE - 4);

INSERT INTO Payments (payment_id, customer_id, amount_paid, payment_date)
VALUES (payment_seq.NEXTVAL, 8, 200, SYSDATE - 3);

INSERT INTO Payments (payment_id, customer_id, amount_paid, payment_date)
VALUES (payment_seq.NEXTVAL, 9, 250, SYSDATE - 2);

INSERT INTO Payments (payment_id, customer_id, amount_paid, payment_date)
VALUES (payment_seq.NEXTVAL, 10, 300, SYSDATE - 1);
