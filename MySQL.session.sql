USE baseballgame;

-- This a table for team members    
CREATE TABLE Team (
    TeamID INT AUTO_INCREMENT PRIMARY KEY,
    TeamName VARCHAR(100) NOT NULL,
    TeamMascot VARCHAR(100)
);
-- this is a player table 
CREATE TABLE Player (
    PlayerID INT AUTO_INCREMENT PRIMARY KEY,
    FirstName VARCHAR(100) NOT NULL,
    LastName VARCHAR(100) NOT NULL,
    Age INT NOT NULL,
    TeamID INT,
    FOREIGN KEY (TeamID) REFERENCES Team(TeamID)
);


-- This is a coach table
CREATE TABLE Coach (
    CoachID INT AUTO_INCREMENT PRIMARY KEY,
    FirstName VARCHAR(100) NOT NULL,
    LastName VARCHAR(100) NOT NULL,
    PhoneNumber VARCHAR(15) NOT NULL
);


-- This is a Guardian table
CREATE TABLE Guardian (
    GuardianID INT AUTO_INCREMENT PRIMARY KEY,
    FirstName VARCHAR(100) NOT NULL,
    LastName VARCHAR(100) NOT NULL,
    PhoneNumber VARCHAR(15) NOT NULL,
    Street VARCHAR(100),
    City VARCHAR(100),
    State VARCHAR(100),
    ZipCode VARCHAR(10),
    PlayerID INT,
    FOREIGN KEY (PlayerID) REFERENCES Player(PlayerID)
);

SHOW TABLES;
DESCRIBE Team;
DESCRIBE Player;
DESCRIBE Coach;
DESCRIBE Guardian;

INSERT INTO Team (TeamName, TeamMascot) VALUES
('Red Sox', 'Wally the Green Monster'),
('Yankees', 'Yankee Doodle'),
('Dodgers', 'Dodger Dog');


SELECT * FROM Team;

INSERT INTO Player (FirstName, LastName, Age, TeamID) VALUES
('John', 'Doe', 25, 1),
('Jane', 'Smith', 22, 2),
('Jim', 'Brown', 30, 3);