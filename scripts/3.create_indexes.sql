-- Index on Customers last_name
CREATE INDEX idx_customers_last_name ON Customers (last_name);

-- Index on Quotes coverage_type
CREATE INDEX idx_quotes_coverage_type ON Quotes (coverage_type);
