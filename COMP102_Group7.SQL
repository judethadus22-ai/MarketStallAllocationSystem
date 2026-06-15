marketstalllloctionsytem

CREATE TABLE Trader (
    TraderID INT AUTO_INCREMENT PRIMARY KEY,
    FirstName VARCHAR(50) NOT NULL,
    LastName VARCHAR(50) NOT NULL,
    PhoneNumber VARCHAR(20),
    NationalID VARCHAR(20) UNIQUE,
    Gender ENUM('M','F')
);
CREATE TABLE Stall (
    StallID INT AUTO_INCREMENT PRIMARY KEY,
    StallNumber VARCHAR(20) NOT NULL UNIQUE,
    LocationDescription VARCHAR(255),
    StallType VARCHAR(50),
    Status ENUM('Available','Occupied','Under Maintenance')
);
CREATE TABLE Allocation (
    AllocationID INT AUTO_INCREMENT PRIMARY KEY,
    TraderID INT NOT NULL,
    StallID INT NOT NULL,
    AllocationDate DATE NOT NULL,
    LeaseDuration INT NOT NULL,

    FOREIGN KEY (TraderID)
    REFERENCES Trader(TraderID),

    FOREIGN KEY (StallID)
    REFERENCES Stall(StallID)
);
CREATE TABLE Inspector (
    InspectorID INT AUTO_INCREMENT PRIMARY KEY,
    FirstName VARCHAR(50),
    LastName VARCHAR(50),
    PhoneNumber VARCHAR(20)
);
CREATE TABLE InspectionRecords (
    InspectionID INT AUTO_INCREMENT PRIMARY KEY,
    StallID INT NOT NULL,
    InspectorID INT NOT NULL,
    ObservationDate DATE,
    Notes VARCHAR(255),

    FOREIGN KEY (StallID)
    REFERENCES Stall(StallID),

    FOREIGN KEY (InspectorID)
    REFERENCES Inspector(InspectorID)
);
INSERT INTO Trader
(FirstName, LastName, PhoneNumber, NationalID, Gender)
VALUES
('John','Kamara','076123456','SL1001','M'),
('Aminata','Sesay','078654321','SL1002','F'),
('Mohamed','Bangura','079777777','SL1003','M'),
('Fatmata','Koroma','074444444','SL1004','F');

INSERT INTO Stall
(StallNumber, LocationDescription, StallType, Status)
VALUES
('A01','Main Market Entrance','Food','Occupied'),
('A02','Main Market Entrance','Clothing','Occupied'),
('B01','East Wing','Electronics','Available'),
('B02','East Wing','Vegetables','Occupied');

INSERT INTO Allocation
(TraderID, StallID, AllocationDate, LeaseDuration)
VALUES
(1,1,'2026-04-01',12),
(2,2,'2026-04-05',6),
(3,4,'2026-04-10',12);

INSERT INTO Inspector
(FirstName, LastName, PhoneNumber)
VALUES
('Peter','Johnson','077888888'),
('Mariama','Conteh','075999999');

INSERT INTO InspectionRecords
(StallID, InspectorID, ObservationDate, Notes)
VALUES
(1,1,'2026-05-01','Clean and operating normally'),
(2,2,'2026-05-03','Minor maintenance required');

SELECT * FROM Trader;

UPDATE Stall
SET Status = 'Under Maintenance'
WHERE StallID = 2;

DELETE FROM InspectionRecords
WHERE InspectionID = 2;

SELECT * FROM Stall;

SELECT * FROM Trader;

SELECT * FROM Stall
WHERE Status = 'Occupied';

SELECT * FROM Trader
ORDER BY LastName ASC;

SELECT COUNT(*) AS TotalTraders
FROM Trader;

SELECT Status, COUNT(*) AS TotalStalls
FROM Stall
GROUP BY Status;

SELECT
T.FirstName,
T.LastName,
S.StallNumber,
S.StallType
FROM Trader T
JOIN Allocation A
ON T.TraderID = A.TraderID
JOIN Stall S
ON A.StallID = S.StallID;

CREATE USER 'member1'@'localhost'
IDENTIFIED BY 'Member123';

ALTER USER 'member1'@'localhost'
IDENTIFIED BY 'NewPassword123';

GRANT SELECT, INSERT, UPDATE
ON MarketStallAllocationSystem.*
TO 'member1'@'localhost';

FLUSH PRIVILEGES;