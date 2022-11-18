-- Question #1
-- Based on the ERD provided, write a SQL query to find the number of occurrences that an ingredient named “Lobster Ravioli” was sold at each store. 
-- Rank the stores by dishes sold with the highest occurrence first.
SELECT 
    Sales.store_id, 
    COUNT(Sales.ingredient_id) AS Number_of_Sales
FROM
    Ingredient INNER JOIN Sales ON Ingredient.ingredient_id=Sales.ingredient_id
WHERE
    Ingredient.ingredient_name = "Lobster Ravioli"
GROUP BY
    Sales.store_id
ORDER BY
    COUNT(Sales.ingredient_id) DESC;


-- Question #2
-- Revise the query from Question #1 to limit the dataset queried between April 1st, 2021 to May 1st, 2021. 
--Return only the stores that have sold more than 45 Lobster Ravioli dishes.

SELECT 
    Sales.store_id, 
    COUNT(Sales.ingredient_id) AS Number_of_Sales
FROM
    Ingredient
    INNER JOIN Sales ON Ingredient.ingredient_id=Sales.ingredient_id
WHERE
    Ingredient.ingredient_name = "Lobster Ravioli" AND Sales.business_date BETWEEN '2021-04-01' AND '2021-05-01'
GROUP BY
    Sales.store_id
HAVING
    COUNT(Sales.ingredient_id) > 45
ORDER BY
    COUNT(Sales.ingredient_id) DESC;

-- Question #3
-- Referencing the Sales table, write the corresponding `CREATE` SQL DDL statement. 
--Include and provide justification for any improvements or add-ons as you see fit.

CREATE TABLE IF NOT EXISTS Sales (
    sale_id int unsigned NOT NULL,
    store_id int unsigned NOT NULL,
    business_date date NOT NULL,
    ingredient_id int unsigned NOT NULL,
    sold_price float unsigned NOT NULL,
    PRIMARY KEY (sale_id),
    FOREIGN KEY (store_id) REFERENCES Store(store_id),
    FOREIGN KEY (ingredient_id) REFERENCES Ingredient(ingredient_id)
) DEFAULT CHARSET=utf8;