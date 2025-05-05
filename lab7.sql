CREATE Table sailors (
    sid INT PRIMARY KEY,
    sname VARCHAR(50),
    rating INT,
    age Decimal(3, 1)
);

CREATE Table boats (
    bid INT PRIMARY KEY,
    bname VARCHAR(50),
    color VARCHAR(20)
);

CREATE Table reserves (
    sid INT,
    bid INT,
    day DATE,
    PRIMARY KEY (sid, bid, day),
    FOREIGN KEY (sid) REFERENCES sailors(sid),
    FOREIGN KEY (bid) REFERENCES boats(bid)
);

INSERT INTO sailors (sid, sname, rating, age) VALUES
(1, 'khalid bin waheed', 7, 19.0),
(2, 'Bilal Ahmad', 4, 22.0),
(3, 'Tanveer', 8, 21.5),
(4, 'Maryam Khalid', 9, 20.5),
(5, 'Ilyas Ahad', 2, 25.0);


SELECT * FROM sailors;


insert INTO boats (bid, bname, color) VALUES
(1, 'Titanic', 'White'),
(2, 'Queen Mary', 'Black'),
(3, 'Nautilus', 'Blue'),
(4, 'Poseidon', 'Red'),
(5, 'Aquarius', 'Green');

SELECT * FROM boats;


INSERT INTO reserves (sid, bid, day) VALUES
(1, 1, '2023-10-01'),
(2, 2, '2023-10-02'),
(3, 3, '2023-10-03'),
(4, 4, '2023-10-04'),
(5, 5, '2023-10-05');



SELECT * FROM reserves;


SELECT s.*
FROM Sailors s
JOIN Reserves r ON s.sid = r.sid
WHERE r.bid = 1;

SELECT b.bname
FROM Boats b
JOIN Reserves r ON b.bid = r.bid
JOIN Sailors s ON r.sid = s.sid
WHERE s.sname = 'khalid bin waheed';

SELECT s.sname
FROM Sailors s
JOIN Reserves r ON s.sid = r.sid
JOIN Boats b ON r.bid = b.bid
WHERE b.color = 'red'
ORDER BY s.age;

SELECT DISTINCT s.sname
FROM Sailors s
JOIN Reserves r ON s.sid = r.sid;

SELECT s.sid, s.sname
FROM Sailors s
JOIN Reserves r1 ON s.sid = r1.sid
JOIN Reserves r2 ON s.sid = r2.sid
WHERE r1.bid <> r2.bid AND r1.day = r2.day;

SELECT DISTINCT s.sid
FROM Sailors s
JOIN Reserves r ON s.sid = r.sid
JOIN Boats b ON r.bid = b.bid
WHERE b.color = 'red' OR b.color = 'green';

SELECT sname, age
FROM Sailors
WHERE age = (SELECT MIN(age) FROM Sailors);

SELECT COUNT(DISTINCT sname) AS unique_sailor_names
FROM Sailors;

SELECT rating, AVG(age) AS average_age
FROM Sailors
GROUP BY rating;