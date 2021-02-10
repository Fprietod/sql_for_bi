/*
SQL provides functions to work with dates.

In SQL, dates are typically written in one of the following formats:

    Date: YYYY-MM-DD
    Datetime or Timestamp: YYYY-MM-DD hh:mm:ss

These strings that represent dates are also known as time strings.

The DATETIME() function will return the entire time string which includes the date and time portions.
*/
SELECT DATETIME('2020-09-01 17:38:22');
/*To obtain the current date and time, you can provide the string 'now' to the function, which returns the date and time in UTC.
*/
SELECT DATETIME('now');
/*
To obtain the date and time converted to your local timezone, you can provide a modifier localtime.
*/
SELECT DATETIME('now', 'localtime');
/*
The DATE() function allows us to extract just the date portion of a time string, which consists of the year, month and day.
*/
SELECT DATE('2020-09-01 17:38:22'); -- 2020-09-01
/*The TIME() function allows us to extract just the time portion of a time string, which consists of the hour, minute and second.
*/
SELECT TIME('2020-09-01 17:38:22'); -- 17:38:22
/*
Date and Time Functions II

We can provide additional arguments, called modifiers, to date functions in addition to the time string. Modifiers are applied from left to right as they are listed in the function, so order matters.
*/
The sintaxys is as follows:
SELECT DATETIME(timestring, modifier1, modifier2, ...);
/*The following modifiers can be used to shift the date backwards to a specified part of the date.

    start of year: shifts the date to the beginning of the current year.
    start of month: shifts the date to the beginning of the current month.
    start of day: shifts the date to the beginning of the current day.

*/
/*
For example, the following returns the beginning of September 2005.*/
SELECT DATE('2005-09-15', 'start of month');
/*The following modifiers add a specified amount to the date and time of the time string.

    '+-N years': offsets the year
    '+-N months': offsets the month
    '+-N days': offsets the day
    '+-N hours': offsets the hour
    '+-N minutes': offsets the minute
    '+-N seconds': offsets the second

After each offset is applied, the result date and time is normalized so that it will always be valid.
*/
/*For example, we can have the following statement.
*/
SELECT DATETIME('2020-02-10', 'start of month', '-1 day', '+7 hours');
/*
First, it will apply the modifier 'start of month' which will shift to the beginning of the month, '2020-02-01 00:00:00'. It will include the time portion because we are using the DATETIME() function.

Then, it will apply the modifier '-1 day' which will offset the day by -1, resulting in '2020-01-31 00:00:00'.

Finally, it will apply the modifier '+7 hours', which will add 7 hours to the time, giving the final result of '2020-01-31 07:00:00'.
*/
/*
For each order in the bakery table, the order will be ready for pick up 2 days after the order is made, at 7:00AM, 7 days a week. The order will always be ready 2 days after the order, no matter what time of day the order was made.

Utilizing the date and time functions and some modifiers, find out when each order can be picked up.
*/
SELECT DATETIME(order_date, 'start of day', '+2 days', '+7 hours')
FROM bakery;

/*
Date and Time Functions III

The STRFTIME() function allows you to return a formatted date, as specified in a format string.

It has the following syntax:
*/
STRFTIME(format, timestring, modifier1, modifier2, ...)
/*
The first argument, format, is the format string.

The second argument is the timestring.

The remaining arguments are 0 or more optional modifiers to transform the time string.

Let’s go into some more detail about the format string. The format string allows you to extract specific parts of the date and time. Recall the time string format of YYYY-MM-DD HH:MM:SS. Each part of this time string can be extracted utilizing what are known as substitutions inside the format string.
*/
/*
The substitutions to extract each part of the date and time are the following:

    %Y returns the year (YYYY)
    %m returns the month (01-12)
    %d returns the day of month (01-31)
    %H returns the hour (00-23)
    %M returns the minute (00-59)
    %S returns the second (00-59)
*/
/*For example, to extract the month and year of the current date,
*/
SELECT STRFTIME('%m %Y', 'now');
-- And to extract just the current day,
SELECT STRFTIME('%d', 'now');
/*
The owners of the bakery want to find out what day most people placed orders.

Use STRFTIME() with the COUNT() function to find out how many orders were made on each day.
*/
SELECT strftime('%d', order_date) AS 'order_day',
COUNT(*)
FROM bakery
GROUP BY 1
ORDER BY 2 DESC;
