
/*
Math functions:

    ABS(): returns the absolute value of the input expression
    CAST(): converts an expression into another data type

Date and time functions:

    DATETIME(): returns the date and time of a time string
    DATE(): returns the date portion of a time string
    TIME(): returns the time portion of a time string
    STRFTIME(): returns a formatted date
*/
/*
Abs

The ABS() function returns the absolute value of the input expression.

The absolute value of a number is the distance of that number from zero, taken as a positive value. It can also be understood as the value of the number if we ignore its sign, such that negative values become positive, and positive values remain the same.
*/
SELECT ABS(-3); -- 3
SELECT ABS(5);  -- 5
SELECT first_name, ABS(guess - 804)
FROM guesses;
/*
Cast

The CAST() function is used to convert the value of an expression into another data type.

It has the following syntax:
*/
SELECT CAST(expr AS type-name);
/*
In the query above, the result would be rounded down to the nearest INTEGER number, 1, because 3 and 2 are both INTEGER values. Using CAST(), one of the values could be converted to a REAL so that the result is also of type REAL:
*/
SELECT CAST(3 AS REAL) / 2; -- 1.5
/*
In this query, CAST(3 AS REAL) will convert 3 to the REAL value 3.0. Then it will calculate 3.0 / 2 which equals to 1.5.

CAST() can also be used to convert TEXT values into a numerical value like REAL or INTEGER. When doing so, it will only consider any valid prefix at the beginning of the string that represents a numerical value.
*/
SELECT CAST('3.14 is pi' AS REAL);
/*This query will convert the TEXT value '3.14 is pi' into type REAL, considering only the prefix '3.14' and ignoring ' is pi', resulting in 3.14.
*/
SELECT item_name, (price - CAST(discount AS REAL)) * quantity
FROM bakery;
