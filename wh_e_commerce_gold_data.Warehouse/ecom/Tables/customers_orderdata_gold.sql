CREATE TABLE [ecom].[customers_orderdata_gold] (
    [ProductID]     VARCHAR (8000)  NULL,
    [CustomerID]    VARCHAR (8000)  NULL,
    [OrderID]       VARCHAR (8000)  NULL,
    [OrderDate]     DATE            NULL,
    [Quantity]      VARCHAR (8000)  NULL,
    [TotalAmount]   DECIMAL (18, 2) NULL,
    [PaymentMethod] VARCHAR (8000)  NULL,
    [CustomerName]  VARCHAR (8000)  NULL,
    [Email]         VARCHAR (8000)  NULL,
    [Location]      VARCHAR (8000)  NULL,
    [SignupDate]    VARCHAR (8000)  NULL,
    [ProductName]   VARCHAR (8000)  NULL,
    [Category]      VARCHAR (8000)  NULL,
    [Stock]         VARCHAR (8000)  NULL,
    [UnitPrice]     VARCHAR (8000)  NULL
);


GO