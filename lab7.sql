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


