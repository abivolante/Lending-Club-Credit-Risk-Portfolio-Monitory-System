-- =====================================================
-- CREDIT RISK PORTFOLIO ANALYSIS
-- PHASE 1: PORTFOLIO OVERVIEW
-- =====================================================
--
-- Objective:
-- Establish a baseline understanding of portfolio size,
-- funded exposure, and exposure concentration across
-- borrower grades and loan statuses.
--
-- Dataset:
-- Lending Club Loan Portfolio
-- =====================================================


-- Total Loans Outstanding

SELECT
    COUNT(*) AS total_loans
FROM `lending-club-499707.lending_club.loan`;


-- Total Funded Exposure

SELECT
    SUM(loan_amnt) AS total_funded_exposure
FROM `lending-club-499707.lending_club.loan`;


-- Exposure Distribution by Credit Grade

WITH portfolio_exposure AS (
    SELECT
        SUM(loan_amnt) AS total_funded_exposure
    FROM `lending-club-499707.lending_club.loan`
),

grade_exposure AS (
    SELECT
        grade,
        SUM(loan_amnt) AS exposure
    FROM `lending-club-499707.lending_club.loan`
    GROUP BY grade
)

SELECT
    g.grade,
    g.exposure,
    ROUND(
        100.0 * g.exposure / p.total_funded_exposure,
        2
    ) AS exposure_pct
FROM grade_exposure AS g
CROSS JOIN portfolio_exposure AS p
ORDER BY g.exposure DESC;


-- Exposure Distribution by Loan Status

WITH portfolio_exposure AS (
    SELECT
        SUM(loan_amnt) AS total_funded_exposure
    FROM `lending-club-499707.lending_club.loan`
),

status_exposure AS (
    SELECT
        loan_status,
        SUM(loan_amnt) AS exposure
    FROM `lending-club-499707.lending_club.loan`
    GROUP BY loan_status
)

SELECT
    s.loan_status,
    s.exposure,
    ROUND(
        100.0 * s.exposure / p.total_funded_exposure,
        2
    ) AS exposure_pct
FROM status_exposure AS s
CROSS JOIN portfolio_exposure AS p
ORDER BY s.exposure DESC
