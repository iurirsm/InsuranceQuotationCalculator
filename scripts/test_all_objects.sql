-- test_all_objects.sql

-- Enable DBMS_OUTPUT to display output messages
SET SERVEROUTPUT ON;

-- Clean up previous test data
DELETE FROM Audit_Log;
DELETE FROM Quotes;
DELETE FROM Customers WHERE email LIKE 'test_user%';
COMMIT;

PROMPT
PROMPT ==========================================
PROMPT Testing calculate_quote Procedure
PROMPT ==========================================

-- Test the calculate_quote procedure
DECLARE
    v_quote_amount NUMBER;
BEGIN
    Insurance_Pkg.calculate_quote(p_customer_id => 1, p_coverage_type_id => 1, p_quote_amount => v_quote_amount);
    DBMS_OUTPUT.PUT_LINE('Test 1 - Calculated Quote Amount: ' || v_quote_amount);
END;
/
PROMPT

PROMPT ==========================================
PROMPT Testing update_customer_info Procedure
PROMPT ==========================================

-- Test the update_customer_info procedure
BEGIN
    Insurance_Pkg.update_customer_info(p_customer_id => 1, p_email => 'test_user1@example.com', p_phone_number => '555-0001');
    DBMS_OUTPUT.PUT_LINE('Test 2 - Customer information updated successfully.');
END;
/
PROMPT

PROMPT ==========================================
PROMPT Testing get_customer_age Function
PROMPT ==========================================

-- Test the get_customer_age function
DECLARE
    v_age NUMBER;
BEGIN
    v_age := Insurance_Pkg.get_customer_age(p_customer_id => 1);
    DBMS_OUTPUT.PUT_LINE('Test 3 - Customer Age: ' || v_age);
END;
/
PROMPT

PROMPT ==========================================
PROMPT Testing is_customer_eligible Function
PROMPT ==========================================

-- Test the is_customer_eligible function
DECLARE
    v_eligibility VARCHAR2(3);
BEGIN
    v_eligibility := Insurance_Pkg.is_customer_eligible(p_customer_id => 1);
    DBMS_OUTPUT.PUT_LINE('Test 4 - Is Customer Eligible: ' || v_eligibility);
END;
/
PROMPT

PROMPT ==========================================
PROMPT Testing trg_quotes_insert Trigger
PROMPT ==========================================

-- Test the trg_quotes_insert trigger
INSERT INTO Quotes (quote_id, customer_id, coverage_type, quote_amount)
VALUES (quote_seq.NEXTVAL, 1, 'Basic', 100);
COMMIT;
DBMS_OUTPUT.PUT_LINE('Test 5 - Inserted into Quotes to test trg_quotes_insert.');
PROMPT

PROMPT ==========================================
PROMPT Verifying Audit_Log Entries
PROMPT ==========================================

-- Check the Audit_Log table for the trigger effect
SELECT * FROM Audit_Log WHERE table_name = 'QUOTES' AND operation = 'INSERT';
PROMPT

PROMPT ==========================================
PROMPT Testing trg_customers_delete Trigger
PROMPT ==========================================

-- Test the trg_customers_delete trigger
BEGIN
    DELETE FROM Customers WHERE customer_id = 1;
    COMMIT;
EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('Test 6 - Error: ' || SQLERRM);
END;
/
PROMPT

PROMPT ==========================================
PROMPT Testing calculate_quote Procedure with Invalid Data
PROMPT ==========================================

-- Test the calculate_quote procedure with an invalid coverage_type_id
DECLARE
    v_quote_amount NUMBER;
BEGIN
    -- Use an invalid coverage_type_id
    Insurance_Pkg.calculate_quote(p_customer_id => 1, p_coverage_type_id => 999, p_quote_amount => v_quote_amount);
    DBMS_OUTPUT.PUT_LINE('Test 7 - Calculated Quote Amount: ' || v_quote_amount);
EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('Test 7 - An error occurred: ' || SQLERRM);
END;
/
PROMPT

PROMPT ==========================================
PROMPT Testing update_customer_info Procedure with Invalid Customer ID
PROMPT ==========================================

-- Test the update_customer_info procedure with an invalid customer_id
BEGIN
    -- Use an invalid customer_id 
    Insurance_Pkg.update_customer_info(p_customer_id => 999, p_email => 'invalid@example.com', p_phone_number => '555-9999');
    DBMS_OUTPUT.PUT_LINE('Test 8 - Customer information updated successfully.');
EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('Test 8 - An error occurred: ' || SQLERRM);
END;
/
PROMPT

PROMPT ==========================================
PROMPT Testing get_customer_age Function with Non-Existent Customer
PROMPT ==========================================

-- Test the get_customer_age function with an invalid customer_id
DECLARE
    v_age NUMBER;
BEGIN
    -- Use an invalid customer_id
    v_age := Insurance_Pkg.get_customer_age(p_customer_id => 999);
    IF v_age IS NULL THEN
        DBMS_OUTPUT.PUT_LINE('Test 9 - Customer not found or age could not be calculated.');
    ELSE
        DBMS_OUTPUT.PUT_LINE('Test 9 - Customer Age: ' || v_age);
    END IF;
END;
/
PROMPT

PROMPT ==========================================
PROMPT Testing is_customer_eligible Function with Underage Customer
PROMPT ==========================================

-- Insert an underage customer
DECLARE
    v_new_customer_id NUMBER;
BEGIN
    SELECT customer_seq.NEXTVAL INTO v_new_customer_id FROM dual;
    INSERT INTO Customers (customer_id, first_name, last_name, date_of_birth, email)
    VALUES (v_new_customer_id, 'TestUnderage', 'User', TO_DATE('2007-01-01', 'YYYY-MM-DD'), 'test_underage@example.com');
    COMMIT;
    DBMS_OUTPUT.PUT_LINE('Test 10 - Underage customer inserted with customer_id: ' || v_new_customer_id);
END;
/

-- Test the is_customer_eligible function with the underage customer
DECLARE
    v_eligibility VARCHAR2(3);
    v_new_customer_id NUMBER;
BEGIN
    -- Retrieve the new customer_id
    SELECT customer_id INTO v_new_customer_id FROM Customers WHERE email = 'test_underage@example.com';
    v_eligibility := Insurance_Pkg.is_customer_eligible(p_customer_id => v_new_customer_id);
    DBMS_OUTPUT.PUT_LINE('Test 10 - Is Underage Customer Eligible: ' || v_eligibility);
END;
/
PROMPT

PROMPT ==========================================
PROMPT Verifying Audit_Log Entries After Tests
PROMPT ==========================================

-- View all entries in the Audit_Log table
SELECT * FROM Audit_Log;

PROMPT

PROMPT ==========================================
PROMPT Testing calculate_quote Procedure for Multiple Customers
PROMPT ==========================================

-- Test calculate_quote for multiple customers
DECLARE
    v_quote_amount NUMBER;
    v_customer_id NUMBER;
BEGIN
    FOR rec IN (SELECT customer_id FROM Customers WHERE ROWNUM <= 5) LOOP
        v_customer_id := rec.customer_id;
        Insurance_Pkg.calculate_quote(p_customer_id => v_customer_id, p_coverage_type_id => 1, p_quote_amount => v_quote_amount);
        DBMS_OUTPUT.PUT_LINE('Test 11 - Customer ID: ' || v_customer_id || ', Quote Amount: ' || v_quote_amount);
    END LOOP;
END;
/
PROMPT

PROMPT ==========================================
PROMPT Viewing Data in Tables After Testing
PROMPT ==========================================

-- View data in Customers table
SELECT * FROM Customers;

-- View data in Quotes table
SELECT * FROM Quotes;

-- View data in Audit_Log table
SELECT * FROM Audit_Log;

PROMPT

PROMPT ==========================================
PROMPT Tests Completed
PROMPT ==========================================

