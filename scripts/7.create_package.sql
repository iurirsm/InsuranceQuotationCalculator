-- Package Specification
CREATE OR REPLACE PACKAGE Insurance_Pkg AS
    -- Public procedures
    PROCEDURE calculate_quote (
        p_customer_id IN NUMBER,
        p_coverage_type_id IN NUMBER,
        p_quote_amount OUT NUMBER
    );

    PROCEDURE update_customer_info (
        p_customer_id IN NUMBER,
        p_email IN VARCHAR2,
        p_phone_number IN VARCHAR2
    );

    -- Public functions
    FUNCTION get_customer_age (
        p_customer_id IN NUMBER
    ) RETURN NUMBER;

    FUNCTION is_customer_eligible (
        p_customer_id IN NUMBER
    ) RETURN VARCHAR2;
END Insurance_Pkg;
/

-- Package Body
CREATE OR REPLACE PACKAGE BODY Insurance_Pkg AS

    PROCEDURE calculate_quote (
        p_customer_id IN NUMBER,
        p_coverage_type_id IN NUMBER,
        p_quote_amount OUT NUMBER
    ) IS
        v_base_rate NUMBER;
    BEGIN
        -- Fetch base rate
        SELECT base_rate INTO v_base_rate
        FROM Coverage_Types
        WHERE coverage_type_id = p_coverage_type_id;

        -- Assign quote amount
        p_quote_amount := v_base_rate;

        -- Insert into Quotes table
        INSERT INTO Quotes (quote_id, customer_id, coverage_type, quote_amount)
        VALUES (
            quote_seq.NEXTVAL,
            p_customer_id,
            (SELECT coverage_name FROM Coverage_Types WHERE coverage_type_id = p_coverage_type_id),
            p_quote_amount
        );
    EXCEPTION
        WHEN NO_DATA_FOUND THEN
            RAISE_APPLICATION_ERROR(-20002, 'Coverage type not found.');
        WHEN OTHERS THEN
            RAISE_APPLICATION_ERROR(-20003, 'An error occurred while calculating the quote: ' || SQLERRM);
    END calculate_quote;

    PROCEDURE update_customer_info (
        p_customer_id IN NUMBER,
        p_email IN VARCHAR2,
        p_phone_number IN VARCHAR2
    ) IS
    BEGIN
        UPDATE Customers
        SET email = p_email,
            phone_number = p_phone_number
        WHERE customer_id = p_customer_id;
    EXCEPTION
        WHEN NO_DATA_FOUND THEN
            RAISE_APPLICATION_ERROR(-20004, 'Customer not found.');
        WHEN OTHERS THEN
            RAISE_APPLICATION_ERROR(-20005, 'An error occurred while updating customer info: ' || SQLERRM);
    END update_customer_info;

    FUNCTION get_customer_age (
        p_customer_id IN NUMBER
    ) RETURN NUMBER IS
        v_age NUMBER;
    BEGIN
        SELECT FLOOR(MONTHS_BETWEEN(SYSDATE, date_of_birth)/12)
        INTO v_age
        FROM Customers
        WHERE customer_id = p_customer_id;

        RETURN v_age;
    EXCEPTION
        WHEN NO_DATA_FOUND THEN
            RETURN NULL;
        WHEN OTHERS THEN
            RETURN NULL;
    END get_customer_age;

    FUNCTION is_customer_eligible (
        p_customer_id IN NUMBER
    ) RETURN VARCHAR2 IS
        v_age NUMBER;
    BEGIN
        v_age := get_customer_age(p_customer_id);
        IF v_age >= 18 THEN
            RETURN 'Yes';
        ELSE
            RETURN 'No';
        END IF;
    EXCEPTION
        WHEN OTHERS THEN
            RETURN 'No';
    END is_customer_eligible;

END Insurance_Pkg;
/
