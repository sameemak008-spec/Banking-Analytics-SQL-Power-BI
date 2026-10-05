-- task :

SELECT COUNT(*) AS Total_Customers
FROM customers;

SELECT
    registration_year,
    COUNT(customer_id) AS Total_Registrations
FROM customers
GROUP BY registration_year
ORDER BY registration_year;

SELECT
    city,
    COUNT(customer_id) AS Total_Customers
FROM customers
GROUP BY city
ORDER BY Total_Customers DESC;

SELECT
    registration_year,
    registration_month,
    COUNT(customer_id) AS New_Customers
FROM customers
GROUP BY registration_year, registration_month
ORDER BY registration_year, registration_month;

-- task 2;

SELECT
    ROUND(AVG(credit_score), 2) AS Average_Credit_Score
FROM customers;

SELECT
    MAX(credit_score) AS Highest_Credit_Score,
    MIN(credit_score) AS Lowest_Credit_Score
FROM customers;

SELECT
    CASE
        WHEN credit_score >= 800 THEN 'Excellent'
        WHEN credit_score >= 740 THEN 'Very Good'
        WHEN credit_score >= 670 THEN 'Good'
        WHEN credit_score >= 580 THEN 'Fair'
        ELSE 'Poor'
    END AS Credit_Segment,
    COUNT(*) AS Total_Customers
FROM customers
GROUP BY Credit_Segment
ORDER BY
CASE Credit_Segment
    WHEN 'Excellent' THEN 1
    WHEN 'Very Good' THEN 2
    WHEN 'Good' THEN 3
    WHEN 'Fair' THEN 4
    WHEN 'Poor' THEN 5
END;

SELECT
    CASE
        WHEN credit_score BETWEEN 300 AND 499 THEN '300-499'
        WHEN credit_score BETWEEN 500 AND 599 THEN '500-599'
        WHEN credit_score BETWEEN 600 AND 699 THEN '600-699'
        WHEN credit_score BETWEEN 700 AND 799 THEN '700-799'
        WHEN credit_score BETWEEN 800 AND 850 THEN '800-850'
        ELSE 'Unknown'
    END AS Credit_Score_Range,
    COUNT(*) AS Total_Customers
FROM customers
GROUP BY Credit_Score_Range
ORDER BY Credit_Score_Range;

-- task 3;

SELECT COUNT(*) AS Total_Accounts
FROM accounts;

SELECT
    account_type,
    COUNT(account_id) AS Total_Accounts
FROM accounts
GROUP BY account_type
ORDER BY Total_Accounts DESC;

SELECT
    ROUND(AVG(balance_usd), 2) AS Average_Account_Balance
FROM accounts;

SELECT
    ROUND(SUM(balance_usd), 2) AS Total_Account_Balance
FROM accounts;

SELECT
    account_id,
    customer_id,
    account_type,
    balance_usd
FROM accounts
ORDER BY balance_usd DESC
LIMIT 10;

-- task 4;

SELECT
    c.customer_id,
    c.first_name,
    c.last_name,
    c.city,
    ROUND(SUM(a.balance_usd), 2) AS Total_Balance
FROM customers c
JOIN accounts a
    ON c.customer_id = a.customer_id
GROUP BY
    c.customer_id,
    c.first_name,
    c.last_name,
    c.city
ORDER BY Total_Balance DESC
LIMIT 10;

SELECT
    c.customer_id,
    c.first_name,
    c.last_name,
    ROUND(AVG(a.balance_usd), 2) AS Average_Balance
FROM customers c
JOIN accounts a
    ON c.customer_id = a.customer_id
GROUP BY
    c.customer_id,
    c.first_name,
    c.last_name
ORDER BY Average_Balance DESC;

SELECT
    c.customer_id,
    c.first_name,
    c.last_name,
    c.city,
    COUNT(a.account_id) AS Total_Accounts,
    ROUND(SUM(a.balance_usd), 2) AS Total_Balance
FROM customers c
JOIN accounts a
    ON c.customer_id = a.customer_id
GROUP BY
    c.customer_id,
    c.first_name,
    c.last_name,
    c.city
ORDER BY Total_Balance DESC;

SELECT
    c.customer_id,
    c.first_name,
    c.last_name,
    c.city,
    ROUND(SUM(a.balance_usd), 2) AS Total_Balance,
    RANK() OVER (
        ORDER BY SUM(a.balance_usd) DESC
    ) AS Customer_Rank
FROM customers c
JOIN accounts a
    ON c.customer_id = a.customer_id
GROUP BY
    c.customer_id,
    c.first_name,
    c.last_name,
c.city
ORDER BY Customer_Rank;

-- task 5 ;
SELECT
    COUNT(transaction_id) AS Total_Transactions,
    ROUND(SUM(amount_usd), 2) AS Total_Transaction_Volume
FROM transactions;

SELECT
    ROUND(AVG(amount_usd), 2) AS Average_Transaction_Amount
FROM transactions;

SELECT
    DATE(transaction_date) AS Transaction_Date,
    COUNT(transaction_id) AS Total_Transactions,
    ROUND(SUM(amount_usd), 2) AS Total_Amount
FROM transactions
GROUP BY DATE(transaction_date)
ORDER BY Transaction_Date;

SELECT
    transaction_year,
    transaction_month,
    COUNT(transaction_id) AS Total_Transactions,
    ROUND(SUM(amount_usd), 2) AS Total_Amount,
    ROUND(AVG(amount_usd), 2) AS Average_Amount
FROM transactions
GROUP BY transaction_year, transaction_month
ORDER BY transaction_year, transaction_month;

SELECT
    transaction_year,
    COUNT(transaction_id) AS Total_Transactions,
    ROUND(SUM(amount_usd), 2) AS Total_Amount,
    ROUND(AVG(amount_usd), 2) AS Average_Amount
FROM transactions
GROUP BY transaction_year
ORDER BY transaction_year;

-- task 6 ;
SELECT
    c.customer_id,
    c.first_name,
    c.last_name,
    c.city,
    ROUND(SUM(t.amount_usd), 2) AS Total_Transaction_Value
FROM customers c
JOIN accounts a
    ON c.customer_id = a.customer_id
JOIN transactions t
    ON a.account_id = t.account_id
GROUP BY
    c.customer_id,
    c.first_name,
    c.last_name,
    c.city
ORDER BY Total_Transaction_Value DESC;

SELECT
    c.customer_id,
    c.first_name,
    c.last_name,
    ROUND(AVG(t.amount_usd), 2) AS Average_Transaction_Value
FROM customers c
JOIN accounts a
    ON c.customer_id = a.customer_id
JOIN transactions t
    ON a.account_id = t.account_id
GROUP BY
    c.customer_id,
    c.first_name,
    c.last_name
ORDER BY Average_Transaction_Value DESC;

SELECT
    c.customer_id,
    c.first_name,
    c.last_name,
    COUNT(t.transaction_id) AS Total_Transactions
FROM customers c
JOIN accounts a
    ON c.customer_id = a.customer_id
JOIN transactions t
    ON a.account_id = t.account_id
GROUP BY
    c.customer_id,
    c.first_name,
    c.last_name
ORDER BY Total_Transactions DESC;

SELECT
    c.customer_id,
    c.first_name,
    c.last_name,
    c.city,
    ROUND(SUM(t.amount_usd), 2) AS Total_Spent
FROM customers c
JOIN accounts a
    ON c.customer_id = a.customer_id
JOIN transactions t
    ON a.account_id = t.account_id
GROUP BY
    c.customer_id,
    c.first_name,
    c.last_name,
    c.city
ORDER BY Total_Spent DESC
LIMIT 10;


-- task 7 ;

SELECT
    m.merchant_id,
    m.merchant_name,
    m.city,
    COUNT(t.transaction_id) AS Total_Transactions
FROM merchants m
JOIN transactions t
    ON m.merchant_id = t.merchant_id
GROUP BY
    m.merchant_id,
    m.merchant_name,
    m.city
ORDER BY Total_Transactions DESC;

SELECT
    m.merchant_id,
    m.merchant_name,
    m.city,
    ROUND(SUM(t.amount_usd), 2) AS Total_Transaction_Value
FROM merchants m
JOIN transactions t
    ON m.merchant_id = t.merchant_id
GROUP BY
    m.merchant_id,
    m.merchant_name,
    m.city
ORDER BY Total_Transaction_Value DESC;

SELECT COUNT(*)
FROM transactions;

SHOW INDEX FROM transactions;

SELECT
    m.merchant_id,
    m.merchant_name,
    m.city,
    ROUND(SUM(t.amount_usd),2) AS Total_Transaction_Value
FROM merchants m
JOIN (
    SELECT *
    FROM transactions
    LIMIT 10000
) t
ON m.merchant_id = t.merchant_id
GROUP BY
    m.merchant_id,
    m.merchant_name,
    m.city
ORDER BY Total_Transaction_Value DESC;

SELECT
    m.merchant_id,
    m.merchant_name,
    m.city,
    ROUND(SUM(t.amount_usd), 2) AS Total_Transaction_Value,
    RANK() OVER (
        ORDER BY SUM(t.amount_usd) DESC
    ) AS Merchant_Rank
FROM merchants m
JOIN transactions t
    ON m.merchant_id = t.merchant_id
GROUP BY
    m.merchant_id,
    m.merchant_name,
    m.city
ORDER BY Merchant_Rank;

-- task 8;

SELECT
    city,
    COUNT(merchant_id) AS Total_Merchants
FROM merchants
GROUP BY city
ORDER BY Total_Merchants DESC;

SELECT
    city,
    COUNT(merchant_id) AS Total_Merchants
FROM merchants
GROUP BY city
ORDER BY Total_Merchants DESC
LIMIT 10;

SELECT
    m.city,
    ROUND(AVG(t.amount_usd), 2) AS Average_Transaction_Value
FROM merchants m
JOIN transactions t
    ON m.merchant_id = t.merchant_id
GROUP BY m.city
ORDER BY Average_Transaction_Value DESC;

-- task 9;
SELECT
    ROUND(SUM(loan_amount), 2) AS Total_Loan_Amount
FROM loans;

SELECT
    ROUND(AVG(loan_amount), 2) AS Average_Loan_Amount
FROM loans;

SELECT
    loan_id,
    customer_id,
    loan_amount,
    interest_rate,
    start_date
FROM loans
ORDER BY loan_amount DESC
LIMIT 10;

SELECT
    ROUND(AVG(interest_rate), 2) AS Average_Interest_Rate
FROM loans;

SELECT
    c.customer_id,
    c.first_name,
    c.last_name,
    c.city,
    COUNT(l.loan_id) AS Total_Loans,
    ROUND(SUM(l.loan_amount), 2) AS Total_Loan_Amount
FROM customers c
JOIN loans l
    ON c.customer_id = l.customer_id
GROUP BY
    c.customer_id,
    c.first_name,
    c.last_name,
    c.city
ORDER BY Total_Loan_Amount DESC;

-- task 10;

SELECT
    COUNT(card_id) AS Total_Cards_Issued
FROM cards;

SELECT
    card_type,
    COUNT(card_id) AS Total_Cards
FROM cards
GROUP BY card_type
ORDER BY Total_Cards DESC;

SELECT
    YEAR(expiration_date) AS Expiration_Year,
    COUNT(card_id) AS Total_Cards
FROM cards
GROUP BY YEAR(expiration_date)
ORDER BY Expiration_Year;

SELECT
    a.account_id,
    a.customer_id,
    COUNT(c.card_id) AS Total_Cards
FROM accounts a
JOIN cards c
    ON a.account_id = c.account_id
GROUP BY
    a.account_id,
    a.customer_id
HAVING COUNT(c.card_id) > 1
ORDER BY Total_Cards DESC;

-- task 11;

SELECT
    c.customer_id,
    c.first_name,
    c.last_name,
    c.city,
    COUNT(l.loan_id) AS Total_Loans
FROM customers c
JOIN loans l
    ON c.customer_id = l.customer_id
GROUP BY
    c.customer_id,
    c.first_name,
    c.last_name,
    c.city
ORDER BY Total_Loans DESC;


SELECT
    c.customer_id,
    c.first_name,
    c.last_name,
    ROUND(AVG(l.loan_amount), 2) AS Average_Loan_Amount
FROM customers c
JOIN loans l
    ON c.customer_id = l.customer_id
GROUP BY
    c.customer_id,
    c.first_name,
    c.last_name
ORDER BY Average_Loan_Amount DESC;

SELECT
    c.customer_id,
    c.first_name,
    c.last_name,
    COUNT(l.loan_id) AS Total_Loans,
    ROUND(SUM(l.loan_amount), 2) AS Total_Loan_Amount
FROM customers c
JOIN loans l
    ON c.customer_id = l.customer_id
GROUP BY
    c.customer_id,
    c.first_name,
    c.last_name
HAVING COUNT(l.loan_id) > 1
ORDER BY Total_Loans DESC;

SELECT
    c.customer_id,
    c.first_name,
    c.last_name,
    l.loan_id,
    l.loan_amount,
    l.interest_rate
FROM customers c
JOIN loans l
    ON c.customer_id = l.customer_id
ORDER BY l.loan_amount DESC
LIMIT 10;


SELECT
    c.city,
    COUNT(l.loan_id) AS Total_Loans,
    ROUND(SUM(l.loan_amount), 2) AS Total_Loan_Amount,
    ROUND(AVG(l.loan_amount), 2) AS Average_Loan_Amount
FROM customers c
JOIN loans l
    ON c.customer_id = l.customer_id
GROUP BY c.city
ORDER BY Total_Loan_Amount DESC;

SELECT
    c.customer_id,
    c.first_name,
    c.last_name,
    ROUND(AVG(l.interest_rate), 2) AS Average_Interest_Rate
FROM customers c
JOIN loans l
    ON c.customer_id = l.customer_id
GROUP BY
    c.customer_id,
    c.first_name,
    c.last_name
ORDER BY Average_Interest_Rate DESC;

-- task 12;

SELECT
    c.customer_id,
    c.first_name,
    c.last_name,
    c.city,
    COUNT(a.account_id) AS Total_Accounts
FROM customers c
JOIN accounts a
    ON c.customer_id = a.customer_id
GROUP BY
    c.customer_id,
    c.first_name,
    c.last_name,
    c.city
HAVING COUNT(a.account_id) > 1
ORDER BY Total_Accounts DESC;

SELECT
    c.customer_id,
    c.first_name,
    c.last_name,
    COUNT(cd.card_id) AS Total_Cards
FROM customers c
JOIN accounts a
    ON c.customer_id = a.customer_id
JOIN cards cd
    ON a.account_id = cd.account_id
GROUP BY
    c.customer_id,
    c.first_name,
    c.last_name
HAVING COUNT(cd.card_id) > 1
ORDER BY Total_Cards DESC;

SELECT DISTINCT
    c.customer_id,
    c.first_name,
    c.last_name,
    c.city
FROM customers c
JOIN accounts a
    ON c.customer_id = a.customer_id
JOIN loans l
    ON c.customer_id = l.customer_id
ORDER BY c.customer_id;

SELECT
    c.customer_id,
    c.first_name,
    c.last_name,
    c.city,

    COUNT(DISTINCT a.account_id) AS Total_Accounts,
    COUNT(DISTINCT cd.card_id) AS Total_Cards,
    COUNT(DISTINCT l.loan_id) AS Total_Loans,
    COUNT(DISTINCT t.transaction_id) AS Total_Transactions,

    ROUND(IFNULL(SUM(DISTINCT a.balance_usd),0),2) AS Total_Balance,
    ROUND(IFNULL(SUM(DISTINCT l.loan_amount),0),2) AS Total_Loan_Amount,
    ROUND(IFNULL(SUM(t.amount_usd),0),2) AS Total_Transaction_Value

FROM customers c

LEFT JOIN accounts a
       ON c.customer_id = a.customer_id

LEFT JOIN cards cd
       ON a.account_id = cd.account_id

LEFT JOIN transactions t
       ON a.account_id = t.account_id

LEFT JOIN loans l
       ON c.customer_id = l.customer_id

GROUP BY
    c.customer_id,
    c.first_name,
    c.last_name,
    c.city

ORDER BY Total_Transaction_Value DESC;


SELECT
    COUNT(DISTINCT c.customer_id) AS Total_Customers,
    COUNT(DISTINCT a.account_id) AS Total_Accounts,
    COUNT(DISTINCT cd.card_id) AS Total_Cards,
    COUNT(DISTINCT l.loan_id) AS Total_Loans,
    COUNT(DISTINCT t.transaction_id) AS Total_Transactions,

    ROUND(SUM(DISTINCT a.balance_usd),2) AS Total_Balance,
    ROUND(SUM(DISTINCT l.loan_amount),2) AS Total_Loan_Amount,
    ROUND(SUM(t.amount_usd),2) AS Total_Transaction_Value

FROM customers c

LEFT JOIN accounts a
       ON c.customer_id = a.customer_id

LEFT JOIN cards cd
       ON a.account_id = cd.account_id

LEFT JOIN transactions t
       ON a.account_id = t.account_id

LEFT JOIN loans l
       ON c.customer_id = l.customer_id;
       
       -- task 13;
       
       SELECT
    transaction_year,
    transaction_month,
    COUNT(transaction_id) AS Total_Transactions,
    ROUND(SUM(amount_usd), 2) AS Total_Transaction_Value
FROM transactions
GROUP BY
    transaction_year,
    transaction_month
ORDER BY
    transaction_year,
    transaction_month;
    
    SELECT
    transaction_year,
    transaction_quarter,
    COUNT(transaction_id) AS Total_Transactions,
    ROUND(SUM(amount_usd), 2) AS Total_Transaction_Value
FROM transactions
GROUP BY
    transaction_year,
    transaction_quarter
ORDER BY
    transaction_year,
    transaction_quarter;
    
    SELECT
    transaction_year,
    COUNT(transaction_id) AS Total_Transactions,
    ROUND(SUM(amount_usd), 2) AS Total_Transaction_Value,
    ROUND(AVG(amount_usd), 2) AS Average_Transaction_Value
FROM transactions
GROUP BY transaction_year
ORDER BY transaction_year;

SELECT
    transaction_year,
    transaction_month,
    COUNT(transaction_id) AS Total_Transactions,
    ROUND(SUM(amount_usd), 2) AS Total_Transaction_Value
FROM transactions
GROUP BY
    transaction_year,
    transaction_month
ORDER BY Total_Transaction_Value DESC
LIMIT 10;

SELECT
    transaction_year,
    transaction_month,
    COUNT(transaction_id) AS Total_Transactions,
    ROUND(SUM(amount_usd), 2) AS Total_Transaction_Value
FROM transactions
GROUP BY
    transaction_year,
    transaction_month
ORDER BY Total_Transaction_Value ASC
LIMIT 10;

SELECT
    transaction_year,
    transaction_month,
    ROUND(AVG(amount_usd), 2) AS Average_Monthly_Transaction_Value
FROM transactions
GROUP BY
    transaction_year,
    transaction_month
ORDER BY
    transaction_year,
    transaction_month;
    
    -- task 14 ;
    
    SELECT
    c.customer_id,
    c.first_name,
    c.last_name,
    c.city,
    ROUND(SUM(t.amount_usd),2) AS Lifetime_Transaction_Value
FROM customers c
JOIN accounts a
    ON c.customer_id = a.customer_id
JOIN transactions t
    ON a.account_id = t.account_id
GROUP BY
    c.customer_id,
    c.first_name,
    c.last_name,
    c.city
ORDER BY Lifetime_Transaction_Value DESC
LIMIT 10;


SELECT
    ROUND(AVG(Customer_Total),2) AS Average_Lifetime_Transaction_Value
FROM
(
    SELECT
        c.customer_id,
        SUM(t.amount_usd) AS Customer_Total
    FROM customers c
    JOIN accounts a
        ON c.customer_id = a.customer_id
    JOIN transactions t
        ON a.account_id = t.account_id
    GROUP BY c.customer_id
) AS CustomerSummary;

SELECT COUNT(*) FROM transactions;

SELECT COUNT(*) FROM accounts;

SELECT COUNT(*) FROM customers;

SHOW INDEX FROM accounts;

SHOW INDEX FROM transactions;

SELECT
    ROUND(AVG(total_value), 2) AS Average_Lifetime_Transaction_Value
FROM (
    SELECT
        a.customer_id,
        SUM(t.amount_usd) AS total_value
    FROM accounts a
    JOIN transactions t
        ON a.account_id = t.account_id
    GROUP BY a.customer_id
) AS customer_totals;


SELECT
    c.customer_id,
    c.first_name,
    c.last_name,
    c.city,
    COUNT(t.transaction_id) AS Total_Transactions,
    ROUND(SUM(t.amount_usd),2) AS Total_Spent
FROM customers c
JOIN accounts a
    ON c.customer_id = a.customer_id
JOIN transactions t
    ON a.account_id = t.account_id
GROUP BY
    c.customer_id,
    c.first_name,
    c.last_name,
    c.city
ORDER BY Total_Spent DESC
LIMIT 10;

-- task 15;

SELECT
    account_type,
    COUNT(account_id) AS Total_Accounts
FROM accounts
GROUP BY account_type
ORDER BY Total_Accounts DESC;
SELECT
    account_type,
    ROUND(SUM(balance_usd), 2) AS Total_Balance
FROM accounts
GROUP BY account_type
ORDER BY Total_Balance DESC;

SELECT
    account_type,
    ROUND(AVG(balance_usd), 2) AS Average_Balance
FROM accounts
GROUP BY account_type
ORDER BY Average_Balance DESC;

SELECT
    a.account_type,
    ROUND(AVG(t.amount_usd), 2) AS Average_Transaction_Value
FROM accounts a
JOIN transactions t
    ON a.account_id = t.account_id
GROUP BY a.account_type
ORDER BY Average_Transaction_Value DESC;

SELECT
    a.account_type,
    COUNT(t.transaction_id) AS Total_Transactions
FROM accounts a
JOIN transactions t
    ON a.account_id = t.account_id
GROUP BY a.account_type
ORDER BY Total_Transactions DESC;

-- task 16;

SELECT
    m.merchant_id,
    m.merchant_name,
    m.city,
    ROUND(SUM(t.amount_usd), 2) AS Total_Transaction_Value
FROM merchants m
JOIN transactions t
    ON m.merchant_id = t.merchant_id
GROUP BY
    m.merchant_id,
    m.merchant_name,
    m.city
ORDER BY Total_Transaction_Value DESC;


SHOW INDEX FROM transactions;
SHOW INDEX FROM merchants;

CREATE INDEX idx_transactions_merchant
ON transactions(merchant_id);

SELECT COUNT(*)
FROM merchants m
JOIN transactions t
ON m.merchant_id = t.merchant_id;

SELECT
    m.merchant_id,
    m.merchant_name,
    m.city,
    COUNT(t.transaction_id) AS Total_Transactions,
    ROUND(SUM(t.amount_usd), 2) AS Total_Transaction_Value
FROM merchants m
JOIN transactions t
    ON m.merchant_id = t.merchant_id
GROUP BY
    m.merchant_id,
    m.merchant_name,
    m.city
ORDER BY Total_Transaction_Value DESC
LIMIT 20;

-- task 17;

SELECT
    card_type,
    COUNT(card_id) AS Total_Cards
FROM cards
GROUP BY card_type
ORDER BY Total_Cards DESC;

SELECT
    a.account_id,
    a.customer_id,
    COUNT(c.card_id) AS Total_Cards
FROM accounts a
JOIN cards c
    ON a.account_id = c.account_id
GROUP BY
    a.account_id,
    a.customer_id
HAVING COUNT(c.card_id) > 1
ORDER BY Total_Cards DESC;

SELECT
    YEAR(expiration_date) AS Expiration_Year,
    COUNT(card_id) AS Total_Cards
FROM cards
GROUP BY YEAR(expiration_date)
ORDER BY Expiration_Year;

SELECT
    cu.customer_id,
    cu.first_name,
    cu.last_name,
    cu.city,
    COUNT(c.card_id) AS Total_Cards
FROM customers cu
JOIN accounts a
    ON cu.customer_id = a.customer_id
JOIN cards c
    ON a.account_id = c.account_id
GROUP BY
    cu.customer_id,
    cu.first_name,
    cu.last_name,
    cu.city
ORDER BY Total_Cards DESC;

-- task 18 ;

SELECT
    customer_id,
    first_name,
    last_name,
    credit_score,
    CASE
        WHEN credit_score >= 750 THEN 'Excellent'
        WHEN credit_score BETWEEN 700 AND 749 THEN 'Good'
        WHEN credit_score BETWEEN 650 AND 699 THEN 'Fair'
        WHEN credit_score BETWEEN 600 AND 649 THEN 'Poor'
        ELSE 'Very Poor'
    END AS Credit_Segment
FROM customers
ORDER BY credit_score DESC;

SELECT
    CASE
        WHEN c.credit_score >= 750 THEN 'Excellent'
        WHEN c.credit_score BETWEEN 700 AND 749 THEN 'Good'
        WHEN c.credit_score BETWEEN 650 AND 699 THEN 'Fair'
        WHEN c.credit_score BETWEEN 600 AND 649 THEN 'Poor'
        ELSE 'Very Poor'
    END AS Credit_Segment,

    ROUND(AVG(a.balance_usd),2) AS Average_Account_Balance

FROM customers c
JOIN accounts a
    ON c.customer_id = a.customer_id

GROUP BY Credit_Segment
ORDER BY
CASE Credit_Segment
    WHEN 'Excellent' THEN 1
    WHEN 'Good' THEN 2
    WHEN 'Fair' THEN 3
    WHEN 'Poor' THEN 4
    ELSE 5
END;

SELECT
    CASE
        WHEN c.credit_score >= 750 THEN 'Excellent'
        WHEN c.credit_score BETWEEN 700 AND 749 THEN 'Good'
        WHEN c.credit_score BETWEEN 650 AND 699 THEN 'Fair'
        WHEN c.credit_score BETWEEN 600 AND 649 THEN 'Poor'
        ELSE 'Very Poor'
    END AS Credit_Segment,

    ROUND(AVG(l.loan_amount),2) AS Average_Loan_Amount

FROM customers c
JOIN loans l
    ON c.customer_id = l.customer_id

GROUP BY Credit_Segment
ORDER BY
CASE Credit_Segment
    WHEN 'Excellent' THEN 1
    WHEN 'Good' THEN 2
    WHEN 'Fair' THEN 3
    WHEN 'Poor' THEN 4
    ELSE 5
END;

SELECT
    CASE
        WHEN credit_score >= 750 THEN 'Excellent'
        WHEN credit_score BETWEEN 700 AND 749 THEN 'Good'
        WHEN credit_score BETWEEN 650 AND 699 THEN 'Fair'
        WHEN credit_score BETWEEN 600 AND 649 THEN 'Poor'
        ELSE 'Very Poor'
    END AS Credit_Segment,

    COUNT(customer_id) AS Total_Customers

FROM customers

GROUP BY Credit_Segment
ORDER BY
CASE Credit_Segment
    WHEN 'Excellent' THEN 1
    WHEN 'Good' THEN 2
    WHEN 'Fair' THEN 3
    WHEN 'Poor' THEN 4
    ELSE 5
END;

-- task 19 ;

SELECT COUNT(*) AS Total_Customers
FROM customers;

SELECT COUNT(*) AS Total_Accounts
FROM accounts;

SELECT COUNT(*) AS Total_Transactions
FROM transactions;

SELECT
    ROUND(SUM(balance_usd), 2) AS Total_Account_Balance
FROM accounts;

SELECT
    ROUND(SUM(loan_amount), 2) AS Total_Loan_Amount
FROM loans;

SELECT
    ROUND(AVG(credit_score), 2) AS Average_Credit_Score
FROM customers;

SELECT
    c.customer_id,
    c.first_name,
    c.last_name,
    c.city,
    ROUND(SUM(t.amount_usd), 2) AS Total_Transaction_Value
FROM customers c
JOIN accounts a
    ON c.customer_id = a.customer_id
JOIN transactions t
    ON a.account_id = t.account_id
GROUP BY
    c.customer_id,
    c.first_name,
    c.last_name,
    c.city
ORDER BY Total_Transaction_Value DESC
LIMIT 10;