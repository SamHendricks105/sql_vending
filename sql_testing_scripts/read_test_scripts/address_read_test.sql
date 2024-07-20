USE Vending;

-- Step 1: Insert the row (without specifying the auto-incremented id)
INSERT INTO address (address, city, state, postal_code, country, latitude, longitude, created_at) 
VALUES (
    '123 Test St', 
    'Test City', 
    'Test State', 
    '12345', 
    'Test Country', 
    10.123456, 
    20.123456, 
    NOW()
);

-- Retrieve the last inserted id
SET @lastId = LAST_INSERT_ID();

-- Step 2: Query the row
SELECT address_id, address, city, state, postal_code, country
INTO @id, @address, @city, @state, @postal_code, @country
FROM address
WHERE address_id = @lastId;

-- Step 3: Verify the result
SET @testResult = IF(@address IN (SELECT address FROM address), 'Test Passed', 'Test Failed');

-- Output the result
SELECT @testResult AS Result;

-- Clean up: delete the test row
SET SQL_SAFE_UPDATES =0;
DELETE FROM address 
WHERE address = "123 Test St";
SET SQL_SAFE_UPDATES =1;