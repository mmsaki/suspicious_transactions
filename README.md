# Suspicious Transactions

<!--- <img src="https://external-content.duckduckgo.com/iu/?u=https%3A%2F%2Fwallpapers.moviemania.io%2Fdesktop%2Fmovie%2F4133%2F2491ad%2Fblow-desktop-wallpaper.jpg%3Fw%3D2552%26h%3D1442&f=1&nofb=1" alt="ether" width="100%"/>
-->

## Table of Contents
1. [Data Modeling](#data-modeling)
2. [Part 1: SQL Queries](#part-1-sql-queries)
3. [Part 2: Visual Analysis](#part-2-visual-analysis)
4. [Challenge](#challenge)

## Data Modeling
**File:** [Schema](./schema.sql)

* Create an entity relationship diagram (ERD) by inspecting the provided CSV files.

  ![Data Model](./images/ERD-export.png)

## Part 1: SQL Queries
**File:** [Query.sql](./query.sql)
* Some fraudsters hack a credit card by making several small transactions (generally less than $2.00), which are typically ignored by cardholders. 
  * How can you isolate (or group) the transactions of each cardholder? 
    ```
    SELECT card, sum(amount) as total_spent
    FROM transaction 
    GROUP BY card;
    ```
    * **Output:** [Group cardholder transactions](./output/grouping_cardholders.csv)
  * Count the transactions that are less than $2.00 per cardholder. 
    ```
    SELECT card, COUNT(amount) as tx_less_than_2
    FROM transaction
    WHERE amount < 2
    GROUP BY card
    ORDER BY tx_less_than_2 DESC;
    ```
    * **Output:** [Transaction count less than $2](./output/tx_less_than_2.csv)
    * *Question:* 
      * ***Is there any evidence to suggest that a credit card has been hacked? Explain your rationale.***
    * *Answer:* 
      * ***Yes, Possily. With the assumption of the small transaction hack, cards with the highest count of transations less than $2 have possibly been hacked.***
    * Take your investigation a step futher by considering the time period in which potentially fraudulent transactions are made. 
      ```
        SELECT date, card, COUNT(amount) as tx_less_than_2
        FROM transaction
        WHERE amount < 2
        GROUP BY card, date
        ORDER BY tx_less_than_2 DESC;
       ```
      * **Output:** [Small transactions grouped by dat](./output/tx_less_than_2.csv)
  * What are the top 100 highest transactions made between 7:00 am and 9:00 am? 
    ```
    SELECT date, amount
    FROM transaction
    WHERE EXTRACT(HOUR FROM date) BETWEEN '07' AND '08'
    ORDER BY amount DESC
    FETCH FIRST 100 ROWS ONLY;
    ```
      * **Output:** [Top 100 transactions between 7:00am and 9:00am](./output/top_100_highest_tx_7am_to_9am.csv)
      * *Question:*
        * ***Do you see any anomalous transactions that could be fraudulent***
      * *Answer:* 
        * **No**
      * *Question:* 
        * ***Is there a higher number of fraudulent transactions made during this time frame versus the rest of the day?***
      * *Answer:* 
        * ***No, the data does not show correlation to higher number of fradulent transactions.***
      * If you answered yes to the previous question, explain why you think there might be fraudulent transactions during this time frame.
        * ***N/A***
  * What are the top 5 merchants prone to being hacked using small transactions? 
    ```
    SELECT id_merchant, count(amount) as number_of_small_tx
    FROM transaction
    WHERE amount < 2
    GROUP BY id_merchant
    ORDER BY count(amount) DESC
    LIMIT 5;
    ```
      * **Output:** [Top 5 merchants prone to small transaction hack](./output/top_5_merchants_small_tx_hack.csv)

## Part 2: Visual Analysis
**File:** [Visualization Data Analysis](./visual_data_analysis.ipynb)
* The two most important customers of the firm may have been hacked. Verify if there are any fraudulent transactions in their history. For privacy reasons, you only know that their cardholder IDs are 2 and 18.

  * Using hvPlot, create a line plot representing the time series of transactions over the course of the year for each cardholder separately. 
    * Cardholder 2
      ![Cardholder 2 plot](./images/cardholder_2_line_plot.png)  
    * Cardholder 18
      ![Cardholder 18 plot](./images/cardholder_18_line_plot.png) 
  * Next, to better compare their patterns, create a single line plot that contains both card holders' trend data.  
    ![Combined cardholder plots](./images/combined_carholder_2%2618_plots.png)
  * *Question:* 
    * ***What difference do you observe between the consumption patterns? Does the difference suggest a fraudulent transaction? Explain your rationale.***
  * *Answer:*
    * ***Cardholder 2 has a small dollar amount spending habits while Cardholder 18 has larger dollar amount spending habits. The difference in spending habbits can indicate fradulent activity on the card if the spending amount is unusually different. For Example, Cardholder 18 has multiple unusual transactions of less than $2, different from their usual larger dollar amount spendidng habits. This could suggest fradulent activity, however the data is non-conclusive.***

* The CEO of the biggest customer of the firm suspects that someone has used her corporate credit card without authorization in the first quarter of 2018 to pay quite expensive restaurant bills. Again, for privacy reasons, you know only that the cardholder ID in question is 25.

  * Using Plotly Express, create a box plot, representing the expenditure data from January 2018 to June 2018 for cardholder ID 25.
    ![Cardholder 25 January to June bar plot](./images/cardholder_25_bar_jan_to_june.png)
    * Are there any outliers for cardholder ID 25? How many outliers are there per month?

    * Do you notice any anomalies? Describe your observations and conclusions.

<!--
## Challenge

* Use the [challenge starter notebook](Starter_Files/challenge.ipynb) to code two Python functions:

* One that uses standard deviation to identify anomalies for any cardholder.

* Another that uses interquartile range to identify anomalies for any cardholder.

* For help with outliers detection, read the following articles:

  * [How to Calculate Outliers](https://www.wikihow.com/Calculate-Outliers)

  * [Removing Outliers Using Standard Deviation in Python](https://www.kdnuggets.com/2017/02/removing-outliers-standard-deviation-python.html)

  * [How to Use Statistics to Identify Outliers in Data](https://machinelearningmastery.com/how-to-use-statistics-to-identify-outliers-in-data/)
-->