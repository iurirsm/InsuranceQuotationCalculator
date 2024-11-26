-- Function to get customer age
CREATE OR REPLACE FUNCTION get_customer_age (
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
END;
/

-- Function to check if customer is eligible
CREATE OR REPLACE FUNCTION is_customer_eligible (
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
END;
/
