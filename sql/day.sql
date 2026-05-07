#Creaing a Database and Using it

mysql> use ecommerce;
Reading table information for completion of table and column names
You can turn off this feature to get a quicker startup with -A

Database changed
mysql> SELECT * FROM orders LIMIT 10;
+-----------+-----------+-------------------------------------+----------+---------------------+-----------+------------+----------------+------------+---------+
| InvoiceNo | StockCode | Description                         | Quantity | InvoiceDate         | UnitPrice | CustomerID | Country        | TotalPrice | Month   |
+-----------+-----------+-------------------------------------+----------+---------------------+-----------+------------+----------------+------------+---------+
| 536365    | 85123A    | WHITE HANGING HEART T-LIGHT HOLDER  |        6 | 2010-12-01 08:26:00 |      2.55 |      17850 | United Kingdom |       15.3 | 2010-12 |
| 536365    | 71053     | WHITE METAL LANTERN                 |        6 | 2010-12-01 08:26:00 |      3.39 |      17850 | United Kingdom |      20.34 | 2010-12 |
| 536365    | 84406B    | CREAM CUPID HEARTS COAT HANGER      |        8 | 2010-12-01 08:26:00 |      2.75 |      17850 | United Kingdom |         22 | 2010-12 |
| 536365    | 84029G    | KNITTED UNION FLAG HOT WATER BOTTLE |        6 | 2010-12-01 08:26:00 |      3.39 |      17850 | United Kingdom |      20.34 | 2010-12 |
| 536365    | 84029E    | RED WOOLLY HOTTIE WHITE HEART.      |        6 | 2010-12-01 08:26:00 |      3.39 |      17850 | United Kingdom |      20.34 | 2010-12 |
| 536365    | 22752     | SET 7 BABUSHKA NESTING BOXES        |        2 | 2010-12-01 08:26:00 |      7.65 |      17850 | United Kingdom |       15.3 | 2010-12 |
| 536365    | 21730     | GLASS STAR FROSTED T-LIGHT HOLDER   |        6 | 2010-12-01 08:26:00 |      4.25 |      17850 | United Kingdom |       25.5 | 2010-12 |
| 536366    | 22633     | HAND WARMER UNION JACK              |        6 | 2010-12-01 08:28:00 |      1.85 |      17850 | United Kingdom |       11.1 | 2010-12 |
| 536366    | 22632     | HAND WARMER RED POLKA DOT           |        6 | 2010-12-01 08:28:00 |      1.85 |      17850 | United Kingdom |       11.1 | 2010-12 |
| 536367    | 84879     | ASSORTED COLOUR BIRD ORNAMENT       |       32 | 2010-12-01 08:34:00 |      1.69 |      13047 | United Kingdom |      54.08 | 2010-12 |
+-----------+-----------+-------------------------------------+----------+---------------------+-----------+------------+----------------+------------+---------+
10 rows in set (0.00 sec)

#total_customers

mysql> SELECT COUNT(DISTINCT CustomerID) AS total_customers
    -> FROM orders;
+-----------------+
| total_customers |
+-----------------+
|            4339 |
+-----------------+
#total_Revenue As per the year


mysql> SELECT
    -> Month,
    -> SUM(TOTALPrice) AS revenue
    -> FROM orders
    -> GROUP BY Month
    -> ORDER BY Month;
+---------+--------------------+
| Month   | revenue            |
+---------+--------------------+
| 2010-12 |  572713.8905310929 |
| 2011-01 |  569445.0413282365 |
| 2011-02 |  447137.3501986712 |
| 2011-03 |  595500.7600669861 |
| 2011-04 | 469200.36047326575 |
| 2011-05 |  678594.5586726665 |
| 2011-06 |  661213.6886946484 |
| 2011-07 |  600091.0098538677 |
| 2011-08 |  645343.8984802142 |
| 2011-09 |  952838.3813118075 |
| 2011-10 | 1039318.7886277586 |
| 2011-11 | 1161817.3779313825 |
| 2011-12 | 518192.78326601535 |
+---------+--------------------+
13 rows in set (0.34 sec)

# total_spent by CustomerID
mysql> SELECT
    -> CustomerID,
    -> SUM(TotalPrice) AS total_spent
    -> FROM orders
    -> GROUP BY CustomerID
    -> ORDER BY total_spent DESC
    -> LIMIT 10;
+------------+--------------------+
| CustomerID | total_spent        |
+------------+--------------------+
|      14646 |  280206.0201046169 |
|      18102 | 259657.30027222633 |
|      17450 | 194550.79052352905 |
|      16446 | 168472.49374997616 |
|      14911 | 143825.06006598473 |
|      12415 | 124914.53000074625 |
|      14156 | 117379.63005077839 |
|      17511 |  91062.38004624844 |
|      16029 |  81024.84001159668 |
|      12346 |      77183.6015625 |
+------------+--------------------+
10 rows in set (0.14 sec)

#Total Entire revenue

mysql> SELECT SUM(TotalPrice) FROM orders;
+-------------------+
| SUM(TotalPrice)   |
+-------------------+
| 8911407.889436614 |
+-------------------+
1 row in set (0.10 sec)

#Churn Analysis


mysql> SELECT CustomerID
    -> FROM orders
    -> GROUP BY CustomerID
    -> HAVING MAX(InvoiceDate) < (
    ->     SELECT DATE_SUB(MAX(InvoiceDate), INTERVAL 3 MONTH) FROM orders
    -> );
+------------+
| CustomerID |
+------------+
|      17850 |
|      13748 |
|      15100 |
|      18074 |
|      16250 |
|      13747 |
|      12791 |
|      14045 |
|      17908 |
|      16583 |
|      18085 |
|      17968 |
|      17897 |
|      16552 |
|      14729 |
|      12868 |
|      14078 |
|      14237 |
|      16955 |
|      15350 |
|      15922 |
|      15165 |
|      16456 |
|      17643 |
|      13093 |
|      16048 |
|      16274 |
|      14496 |
|      12947 |
|      17460 |
|      14142 |
|      13065 |
|      16835 |
|      15235 |
|      18011 |
|      13715 |
|      17732 |


    -> FROM orders
    -> GROUP BY CustomerID
    -> HAVING MAX(InvoiceDate) < (
    ->     SELECT DATE_SUB(MAX(InvoiceDate), INTERVAL 3 MONTH)
    ->     FROM orders
    -> )
    -> LIMIT 6;
+------------+
| CustomerID |
+------------+
|      17850 |
|      13748 |
|      15100 |
|      18074 |
|      16250 |
|      13747 |
+------------+
6 rows in set (0.23 sec)


