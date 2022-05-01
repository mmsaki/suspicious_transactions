
-- Part1 : Grouping transactions of each credit card
SELECT card, sum(amount) as total_spent
FROM transaction 
GROUP BY card;

-- Part1 : Count transactions less than $2 per cardholder
SELECT card, COUNT(amount) as tx_less_than_2
FROM transaction
WHERE amount < 2
GROUP BY card
ORDER BY tx_less_than_2 DESC;

-- Part1 : Count transactions less than $2 per cardholder group by date
SELECT date, card, COUNT(amount) as tx_less_than_2
FROM transaction
WHERE amount < 2
GROUP BY card, date
ORDER BY tx_less_than_2 DESC;


-- Part1 : Top 100 highest transactions made between 7:00am and 9:00am
SELECT date, amount
FROM transaction
WHERE EXTRACT(HOUR FROM date) BETWEEN '07' AND '08'
ORDER BY amount DESC
FETCH FIRST 100 ROWS ONLY;


-- Part1 : Top 5 merchants prone to being hacked using small transactions
SELECT id_merchant, count(amount) as number_of_small_tx
FROM transaction
WHERE amount < 2
GROUP BY id_merchant
ORDER BY count(amount) DESC
LIMIT 5;

-- Part 2: Joining cardholder_id to transaction table where Card holder is 2 or 18
SELECT transaction.amount, credit_card.card, credit_card.cardholder_id
FROM transaction
LEFT JOIN credit_card 
ON transaction.card = credit_card.card
WHERE credit_card.cardholder_id = 2 or credit_card.cardholder_id = 18;

-- Part 2: Transactions for cardholder_id 25 change to month names and day number from january to june
SELECT to_char(transaction.date, 'month') as month, to_char(transaction.date, 'DD') as day, transaction.amount
FROM transaction
LEFT JOIN credit_card
ON transaction.card = credit_card.card
WHERE credit_card.cardholder_id = 25
and date >= '2018-01-01 00:00:00' 
and date < '2018-07-01 00:00:00';