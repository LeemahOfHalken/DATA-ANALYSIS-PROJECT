-- CREATING A table in the database
CREATE TABLE Customers(
-- using the database
CustomerID integer auto_increment primary key,
FirstName varchar(255) not null,
LastName varchar(255) not null,
City varchar(255) not null,
State varchar(255) not null);

create table Branches(
-- using the database
BranchID integer auto_increment primary key,
BranchName varchar(255) not null,
City varchar(255) not null,
State varchar(255) not null);

create table Accounts(
-- using the database
AccountID integer auto_increment primary key,
CustomerID integer(11) not null,
BranchID integer(11) not null,
AccountType varchar(255) not null,
Balance varchar(255) not null,

Constraint foreign key(CustomerID) references Customers(CustomerID),
constraint foreign key(BranchID) references Branches(BranchID)
);

create table Transactions(
-- using the database
TransactionID integer auto_increment primary key,
AccountID integer(11) not null,
TransactionDate date,
Amount varchar(255) not null,

constraint foreign key(AccountID) references Accounts(AccountID)
);

-- inserting data into a table
insert into Customers(FirstName, LastName, City, State)
values("John", "Doe","New York","NY"),
 ("Jane", "Doe", "New York", "NY"),
 ("Bob","Smith", "San Francisco"," CA"),
 ("Alice", "JohnSon","San Francisco", "CA"),
 ("Micheal" ,"Lee","Los Angeles", "CA"),
 ("Jennifer", "Wang", "Los Angeles", "CA");
 
 insert into Branches(BranchName, City, State)
 values("Main","New York", "NY"),
 ("Downtown","San Francisco", "CA"),
 ("West LA", "Los Angeles", "CA"),
 ("East LA", "Los Angeles", "LA"),
 ("Uptown","New York", "NY"),
 ("Financial District", "San Francisco", "CA"),
 ("MidTown", "New York", "NY"),
 ("SouthBay", "San Francisco", "CA"),
 ("Downtown","Los Angeles", "CA"),
 ("Chinatown","New York", "NY"),
 ("Marina", "San Francisco","CA"),
 ("Beverly Hills","Los Angeles","CA"),
 ("Brooklyn","New York","NY"),
 ("North Beach","San Francisco","CA"),
 ("Pasadena","Los Angeles", "CA");
 
 insert into Accounts(CustomerID, BranchID, AccountType, Balance)
 values( "1", "5", "checking", "1000"),
 ( "1", "5", "savings", "5000"),
 ( "2", "1", "checking", "2500"),
 ( "2", "1", "savings", "10000"),
 ( "3", "2", "checking", "7500"),
 ( "3", "2", "savings", "15000"),
 ( "4", "8", "checking", "5000"),
 ( "4", "8", "savings", "20000"),
 ( "5", "14", "checking", "10000"),
 ( "5", "14", "savings", "50000"),
 ( "6", "2", "checking", "5000"),
 ( "6", "2", "savings", "10000"),
 ( "1", "5", "Credit Card", "-500"),
 ( "2", "1", "Credit Card", "-1000"),
 ( "3", "2", "Credit Card", "-2000");
 
 insert into Transactions(AccountID, TransactionDate, Amount)
 values("1","2022-01-01", "-500"),
 ("1","2022-01-02", "-250"),
 ("2","2022-01-03", "1000"),
 ("3","2022-01-04", "-1000"),
 ("3","2022-01-05", "500"),
 ("4","2022-01-06", "1000"),
 ("4","2022-01-07", "-500"),
 ("5","2022-01-08", "-2500"),
 ("6","2022-01-09", "500"),
 ("6","2022-01-10", "-1000"),
 ("7","2022-01-11", "-500"),
 ("7","2022-01-12", "-250"),
 ("8","2022-01-13", "1000"),
 ("8","2022-01-14", "-1000"),
 ("9","2022-01-15", "500");
 
 
-- Question 1: What are the names of all the customers who live in New York?
select FirstName, LastName, City
from customers
where City =  "New York"; 

-- Question 2: What is the total number of accounts in the Accounts table?
select count(*) as TotalAccounts
from accounts;

-- Question 3: What is the total balance of all checking accounts?
select sum(Balance) as TotalCheckingBalance
from accounts
where AccountType = "checking";

-- Question 4:What is the total balance of all accounts associated with customers who live in LosAngeles?
select sum(Balance) as TotalBalanceOfLAaccounts
from accounts
join customers 
on accounts.CustomerID = customers.CustomerID
where City= "Los Angeles";

-- Question 5: Which branch has the highest average account balance? 
SELECT branches.BranchID, BranchName, AVG(Balance) AS AverageBalance
FROM Accounts
join branches
on branches.BranchID = accounts.BranchID
group by BranchID
ORDER BY AverageBalance DESC
limit 1;

-- Question 6: Which customer has the highest current balance in their accounts?
select sum(Balance) as CustHighBalance, FirstName,LastName
from accounts
join customers
on accounts.CustomerID = customers.CustomerID
group by customers.CustomerID
order by CustHighBalance desc
limit 1;

-- Question 7:Which customer has made the most transactions in the Transactions table? 
SELECT Customers.CustomerID, FirstName, LastName, COUNT(*) AS TransactionCount
FROM Transactions
join Accounts On transactions.accountID = accounts.accountID
join customers on accounts.customerID = customers.customerID
GROUP BY CustomerID
ORDER BY TransactionCount DESC
LIMIT 1;

-- Question 8: Which branch has the highest total balance across all of its accounts?
select sum(Balance) as HighestTotalBalance, branches.BranchName
from accounts
join branches
on branches.BranchID = accounts.BranchID
group by branches.BranchID
order by HighestTotalBalance desc
limit 1;

-- Question 9: Which customer has the highest total balance across all of their accounts, including savings and checking accounts?
SELECT SUM(accounts.Balance) AS CustHighBalance, customers.FirstName, customers.LastName
FROM accounts
JOIN customers 
ON accounts.CustomerID = customers.CustomerID
WHERE accounts.AccountType IN ('savings', 'checkings')
GROUP BY customers.CustomerID, customers.FirstName, customers.LastName
ORDER BY CustHighBalance DESC
LIMIT 1;

-- Question 10: Which branch has the highest number of transactions in the Transactions table?
SELECT Branches.BranchID, BranchName, COUNT(*) AS TransactionCount
FROM Transactions
join Accounts On transactions.accountID = accounts.accountID
join Branches on accounts.branchID = branches.branchID
GROUP BY Branches.BranchID
ORDER BY TransactionCount DESC
LIMIT 1;