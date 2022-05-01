-- Drop tables
DROP TABLE IF EXISTS card_holder CASCADE;
DROP TABLE IF EXISTS credit_card CASCADE;
DROP TABLE IF EXISTS merchant CASCADE;
DROP TABLE IF EXISTS merchant_category CASCADE;
DROP TABLE IF EXISTS transaction CASCADE;

-- Create a table of card holders
CREATE TABLE card_holder (
    id int   NOT NULL PRIMARY KEY,
    Name VARCHAR   NOT NULL
);

-- Create a table of credit cards
CREATE TABLE credit_card (
    card VARCHAR(20)   NOT NULL PRIMARY KEY,
    cardholder_id int   NOT NULL
);

-- Create a table of merchants
CREATE TABLE merchant (
    id int   NOT NULL PRIMARY KEY,
    name VARCHAR   NOT NULL,
    id_merchant_category int   NOT NULL
);

-- Create a table of merchant categories
CREATE TABLE merchant_category (
    id int   NOT NULL PRIMARY KEY,
    Name VARCHAR   NOT NULL
);

-- Create a table of transactions
CREATE TABLE transaction (
    id int   NOT NULL PRIMARY KEY,
    date timestamp   NOT NULL,
    amount int   NOT NULL,
    card VARCHAR(20)   NOT NULL,
    id_merchant int   NOT NULL
);

-- Add constraint to credit_card table
ALTER TABLE credit_card ADD CONSTRAINT fk_credit_card_cardholder_id FOREIGN KEY(cardholder_id)
REFERENCES card_holder(id);

-- Add constraint to merchant table
ALTER TABLE merchant ADD CONSTRAINT fk_merchant_id_merchant_category FOREIGN KEY(id_merchant_category)
REFERENCES merchant_category(id);

-- Add constraint to transaction table
ALTER TABLE transaction ADD CONSTRAINT fk_transaction_card FOREIGN KEY(card)
REFERENCES credit_card(card);

-- Add constraint to transaction table
ALTER TABLE transaction ADD CONSTRAINT fk_transaction_id_merchant FOREIGN KEY(id_merchant)
REFERENCES merchant(id);