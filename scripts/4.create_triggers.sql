-- Trigger to log insertions into Quotes
CREATE OR REPLACE TRIGGER trg_quotes_insert
AFTER INSERT ON Quotes
FOR EACH ROW
BEGIN
    INSERT INTO Audit_Log (log_id, table_name, operation)
    VALUES (audit_log_seq.NEXTVAL, 'Quotes', 'INSERT');
END;
/

-- Trigger to prevent deletion from Customers
CREATE OR REPLACE TRIGGER trg_customers_delete
BEFORE DELETE ON Customers
FOR EACH ROW
BEGIN
    RAISE_APPLICATION_ERROR(-20001, 'Deletion from Customers table is not allowed.');
END;
/
