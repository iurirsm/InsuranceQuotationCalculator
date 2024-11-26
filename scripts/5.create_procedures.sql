-- Procedure to calculate quote
CREATE OR REPLACE PROCEDURE calculate_quote (
    p_customer_id IN NUMBER,
    p_coverage_type_id IN NUMBER,
    p_quote_amount OUT NUMBER
) AS
    v_base_rate NUMBER;
BEGIN
    SELECT base_rate INTO v_base_rate
    FROM Coverage_Types
    WHERE coverage_type_id = p_coverage_type_id;

    p_quote_amount := v_base_rate;

    INSERT INTO Quotes (quote_id, customer_id, coverage_type, quote_amount)
    VALUES (quote_seq.NEXTVAL, p_customer_id, v_base_rate, p_quote_amount);
EXCEPTION
    WHEN NO_DATA_FOUND THEN
        RAISE_APPLICATION_ERROR(-20002, 'Coverage type not found.');
    WHEN OTHERS THEN
        RAISE_APPLICATION_ERROR(-20003, 'An error occurred while calculating the quote.');
END;
/

-- Procedure to update customer information
CREATE OR REPLACE PROCEDURE update_customer_info (
    p_customer_id IN NUMBER,
    p_email IN VARCHAR2,
    p_phone_number IN VARCHAR2
) AS
BEGIN
    UPDATE Customers
    SET email = p_email,
        phone_number = p_phone_number
    WHERE customer_id = p_customer_id;
EXCEPTION
    WHEN NO_DATA_FOUND THEN
        RAISE_APPLICATION_ERROR(-20004, 'Customer not found.');
    WHEN OTHERS THEN
        RAISE_APPLICATION_ERROR(-20005, 'An error occurred while updating customer info.');
END;
/
