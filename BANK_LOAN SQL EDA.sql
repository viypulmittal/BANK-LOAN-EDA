SELECT COUNT(id) as Total_Loan_Applications From bank_loan;

SELECT COUNT(id) as MTD_Total_Loan_Applications from bank_loan
WHERE issue_date LIKE '%-12-%';

SELECT COUNT(id) as PMTD_Total_Loan_Applications from bank_loan
WHERE issue_date LIKE '%-11-%';

SELECT SUM(loan_amount) AS Total_funded_amount from bank_loan;

SELECT SUM(loan_amount) AS MTD_Total_funded_amount from bank_loan
WHERE issue_date LIKE '%-12-%';

SELECT SUM(loan_amount) AS PMTD_Total_funded_amount from bank_loan
WHERE issue_date LIKE '%-11-%';

SELECT SUM(TOTAL_PAYMENT) AS TOTAL_AMOUNT_COLLECTED FROM BANK_LOAN;

SELECT SUM(TOTAL_PAYMENT) AS MTD_TOTAL_AMOUNT_COLLECTED FROM BANK_LOAN
WHERE issue_date LIKE '%-12-%';

SELECT SUM(TOTAL_PAYMENT) AS PMTD_TOTAL_AMOUNT_COLLECTED FROM BANK_LOAN
WHERE issue_date LIKE '%-11-%';

SELECT ROUND(AVG(INT_RATE)*100,2) AS AVG_INTEREST_RATE FROM BANK_LOAN;

SELECT ROUND(AVG(INT_RATE)*100,2) AS MTD_AVG_INTEREST_RATE FROM BANK_LOAN
WHERE issue_date LIKE '%-12-%';

SELECT ROUND(AVG(INT_RATE)*100,2) AS PMTD_AVG_INTEREST_RATE FROM BANK_LOAN
WHERE issue_date LIKE '%-11-%';

SELECT ROUND(AVG(DTI)*100,2) AS AVG_DTI FROM bank_loan;

SELECT ROUND(AVG(DTI)*100,2) AS MDT_AVG_DTI FROM bank_loan
WHERE issue_date LIKE '%-12-%';

SELECT ROUND(AVG(DTI)*100,2) AS PMDT_AVG_DTI FROM bank_loan
WHERE issue_date LIKE '%-11-%';

SELECT (COUNT(CASE WHEN loan_status= 'Fully Paid' OR loan_status= 'Current' THEN id END ) * 100)
/
COUNT(id) AS Good_loan_percentage
FROM bank_loan;

SELECT COUNT(id) AS Good_Loan_Applications FROM bank_loan
WHERE loan_status IN ('Fully Paid','Current');

SELECT SUM(loan_amount) AS Good_Loan_funded_Amount FROM bank_loan
WHERE loan_status IN ('Fully Paid','Current');

SELECT SUM(total_payment) AS Good_Loan_Received_Amount FROM bank_loan
WHERE loan_status IN ('Fully Paid','Current');

SELECT (COUNT(CASE WHEN loan_status= 'Charged off' THEN id END)*100)
/
COUNT(id) AS Bad_Loan_Percentage FROM bank_loan;

SELECT COUNT(id) AS Bad_Loan_Applications from bank_loan
WHERE loan_status='Charged off';

SELECT SUM(loan_amount) AS Bad_loan_funded_amount FROM bank_loan
WHERE loan_status='Charged off';

SELECT SUM(total_payment) AS Bad_Loan_received_amount FROM bank_loan
WHERE loan_status='Charged off';

SELECT loan_status,
COUNT(id) AS Total_Loan_applications,
SUM(loan_amount) AS Total_funded_Loan_amount,
SUM(total_payment) AS total_loan_amount_received,
AVG(int_rate)*100 AS AVG_Interest_rate,
AVG(dti)*100 AS AVG_DTI
FROM bank_loan
GROUP BY loan_status;

SELECT loan_status,
SUM(loan_amount) AS MDT_funded_amt,
SUM(total_payment) AS MDT_received_amt
FROM bank_loan
WHERE issue_date LIKE '%-12-%'
GROUP BY loan_status;

SELECT loan_status,
SUM(loan_amount) AS PMDT_funded_amt,
SUM(total_payment) AS PMDT_received_amt
FROM bank_loan
WHERE issue_date LIKE '%-11-%'
GROUP BY loan_status;

#For Charts

SET SQL_SAFE_UPDATES = 0;


ALTER TABLE bank_loan
ADD COLUMN issued_date DATE;

UPDATE bank_loan
SET issued_date=str_to_date(issue_date, '%d-%m-%Y');

#we have created a column issued date with datatype date to perfrom date and time functions

SELECT MONTH(issued_date) AS S_Number,MONTHNAME(issued_date),COUNT(id) AS Total_Loan_Applications,
SUM(loan_amount) AS Total_Funded_amount,
SUM(total_payment) AS Total_received_amount
FROM bank_loan
GROUP BY 1,2
ORDER BY 1 ;

SELECT address_state AS State,
COUNT(id) AS Total_Loan_Applications,
SUM(loan_amount) AS Total_Funded_amount,
SUM(total_payment) AS Total_received_amount
FROM bank_loan
GROUP BY 1
ORDER BY 1 ;

SELECT term,
COUNT(id) AS Total_Loan_Applications,
SUM(loan_amount) AS Total_Funded_amount,
SUM(total_payment) AS Total_received_amount
FROM bank_loan
GROUP BY 1
ORDER BY 1 ;

SELECT emp_length,
COUNT(id) AS Total_Loan_Applications,
SUM(loan_amount) AS Total_Funded_amount,
SUM(total_payment) AS Total_received_amount
FROM bank_loan
GROUP BY 1
ORDER BY 1 ;

SELECT purpose,
COUNT(id) AS Total_Loan_Applications,
SUM(loan_amount) AS Total_Funded_amount,
SUM(total_payment) AS Total_received_amount
FROM bank_loan
GROUP BY 1
ORDER BY 1 ;

SELECT home_ownership,
COUNT(id) AS Total_Loan_Applications,
SUM(loan_amount) AS Total_Funded_amount,
SUM(total_payment) AS Total_received_amount
FROM bank_loan
GROUP BY 1
ORDER BY 1 ;
