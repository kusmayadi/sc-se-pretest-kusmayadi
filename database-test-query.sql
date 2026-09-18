#2. Books that have never been loaned
SELECT b.title as Buku
FROM books AS b
WHERE NOT EXISTS (
    SELECT 1
    FROM book_loans AS bl
    WHERE bl.book_id = b.id
);

#3. Late loan users
SELECT
    u.name as User,
    DATEDIFF(bl.return_date, bl.due_date) * 1000 as Denda
FROM users u
INNER JOIN book_loans bl ON bl.user_id = u.id
WHERE bl.return_date > bl.due_date;

#4. User loan books
SELECT
    row_number() OVER (ORDER BY u.id) as No,
    u.name AS User,
    GROUP_CONCAT(DISTINCT b.title ORDER BY b.title SEPARATOR ', ') AS Buku
FROM users u
INNER JOIN book_loans bl ON bl.user_id = u.id
INNER JOIN books b ON b.id = bl.book_id
GROUP BY u.id, u.name;
