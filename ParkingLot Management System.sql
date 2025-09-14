-- Create Owner table
CREATE TABLE Owner (
    OwnerID INT,
    FN VARCHAR(50),
    LN VARCHAR(50),
    Phone VARCHAR(15),
    Email VARCHAR(50),
    CONSTRAINT PK_Owner PRIMARY KEY (OwnerID),
    CONSTRAINT UQ_Owner_Phone UNIQUE (Phone),
    CONSTRAINT UQ_Owner_Email UNIQUE (Email)
);

-- Create Vehicle table with ON DELETE SET NULL and ON UPDATE CASCADE
CREATE TABLE Vehicle (
    VehicleID INT,
    OwnerID INT,
    Type VARCHAR(20),
    Color VARCHAR(20),
    LicensePlate VARCHAR(15),
    CONSTRAINT PK_Vehicle PRIMARY KEY (VehicleID),
    CONSTRAINT UQ_Vehicle_LicensePlate UNIQUE (LicensePlate),
    CONSTRAINT FK_Vehicle_Owner FOREIGN KEY (OwnerID) 
        REFERENCES Owner(OwnerID)
        ON DELETE SET NULL 
        ON UPDATE CASCADE
);

-- Create ElectricVehicleCharging table
CREATE TABLE ElectricVehicleCharging (
    ChargeID INT,
    VehicleID INT,
    StartTime TIMESTAMP,
    EndTime TIMESTAMP,
    TotalCost DECIMAL(10, 2),
    CONSTRAINT PK_EVC PRIMARY KEY (ChargeID),
    CONSTRAINT FK_EVC_Vehicle FOREIGN KEY (VehicleID) 
        REFERENCES Vehicle(VehicleID)
        ON DELETE CASCADE
        ON UPDATE CASCADE
);

-- Create ParkingLot table
CREATE TABLE ParkingLot (
    LotID INT,
    Name VARCHAR(50),
    Location VARCHAR(100),
    Capacity INT,
    NoOfFloors INT,
    CONSTRAINT PK_ParkingLot PRIMARY KEY (LotID),
    CONSTRAINT UQ_ParkingLot_Name UNIQUE (Name),
    CONSTRAINT CHK_ParkingLot_Capacity CHECK (Capacity > 0),
    CONSTRAINT CHK_ParkingLot_NoOfFloors CHECK (NoOfFloors > 0)
);

-- Create ParkingSpace table with ON DELETE CASCADE and ON UPDATE CASCADE
CREATE TABLE ParkingSpace (
    SpaceID INT,
    LotID INT,
    FloorNo INT,
    SpaceNo INT,
    Status VARCHAR(20),
    CONSTRAINT PK_ParkingSpace PRIMARY KEY (SpaceID),
    CONSTRAINT FK_ParkingSpace_Lot FOREIGN KEY (LotID) 
        REFERENCES ParkingLot(LotID)
        ON DELETE CASCADE
        ON UPDATE CASCADE,
    CONSTRAINT CHK_ParkingSpace_Status CHECK (Status IN ('Available', 'Occupied'))
);

-- Create Staff table
CREATE TABLE Staff (
    StaffID INT,
    Role VARCHAR(20),
    Contact VARCHAR(15),
    AssignedLotID INT,
    Name VARCHAR(50),
    Salary DECIMAL(10, 2),
    CONSTRAINT PK_Staff PRIMARY KEY (StaffID),
    CONSTRAINT UQ_Staff_Contact UNIQUE (Contact),
    CONSTRAINT FK_Staff_Lot FOREIGN KEY (AssignedLotID) 
        REFERENCES ParkingLot(LotID)
        ON DELETE SET NULL
        ON UPDATE CASCADE,
    CONSTRAINT Salary_Check CHECK (Salary BETWEEN 3000 AND 15000)
);

-- Create Reservation table
CREATE TABLE Reservation (
    ReservationID INT,
    SpaceID INT,
    StartTime TIMESTAMP,
    EndTime TIMESTAMP,
    Status VARCHAR(20),
    CONSTRAINT PK_Reservation PRIMARY KEY (ReservationID),
    CONSTRAINT FK_Reservation_Space FOREIGN KEY (SpaceID) 
        REFERENCES ParkingSpace(SpaceID)
        ON DELETE CASCADE
        ON UPDATE CASCADE
);

-- Create Payment table
CREATE TABLE Payment (
    PaymentID INT,
    ReservationID INT,
    Date DATE,
    Amount DECIMAL(10, 2),
    PaymentMethod VARCHAR(20),
    CONSTRAINT PK_Payment PRIMARY KEY (PaymentID),
    CONSTRAINT FK_Payment_Reservation FOREIGN KEY (ReservationID) 
        REFERENCES Reservation(ReservationID)
        ON DELETE CASCADE
        ON UPDATE CASCADE
);


INSERT INTO Owner (OwnerID, FN, LN, Phone, Email)
VALUES
(1, 'Shahd', 'Abdelhalim', '1234567890', 'shahd_a01010@cic-cairo.com'),
(2, 'Alaa', 'Essam', '1234567891', 'alaa_e00521@cic-cairo.com'),
(3, 'Ebram', 'Magdy', '1234567892', 'ebram_m00543@cic-cairo.com'),
(4, 'Mohammed', 'Ehab', '1234567893', 'mohammed_e01892@cic-cairo.com'),
(5, 'Alia', 'Hmeda', '1234567894', 'alia_hmeda@example.com'),
(6, 'Sahhd', 'Abdelhalim', '1234567895', 'sahhd_a01010@cic-cairo.com'),
(7, 'Alaa', 'Esasm', '1234567896', 'alaa_e00522@cic-cairo.com'),  
(8, 'Bream', 'Gdyam', '1234567897', 'bream_gdyam@cic-cairo.com'),
(9, 'Mohdema', 'Heab', '1234567898', 'mohdema_heab@cic-cairo.com'),
(10, 'Ila', 'Ahmed', '1234567899', 'ila_ahmed@example.com'),
(11, 'Hads', 'Almidabeh', '1234567810', 'hads_almidabeh@cic-cairo.com'),
(12, 'Laas', 'Aeessm', '1234567811', 'laas_aeessm@cic-cairo.com'),
(13, 'Emrab', 'Dygma', '1234567812', 'emrab_dygma@cic-cairo.com'),
(14, 'Momehd', 'Heab', '1234567813', 'momehd_heab@cic-cairo.com'),
(15, 'Ilh', 'Maeda', '1234567814', 'ilh_maeda@example.com'),
(16, 'Shada', 'Helamab', '1234567815', 'shada_helamab@cic-cairo.com'),
(17, 'Alas', 'Emas', '1234567816', 'alas_emas@cic-cairo.com'),
(18, 'Bram', 'Madyg', '1234567817', 'bram_madyg@cic-cairo.com'),
(19, 'Mhamed', 'Ebha', '1234567818', 'mhamed_ebha@cic-cairo.com'),
(20, 'Ali', 'Ahem', '1234567819', 'ali_ahem@example.com');
-- Insert data into the Vehicle table
INSERT INTO Vehicle (VehicleID, OwnerID, Type, Color, LicensePlate)
VALUES
(1, 1, 'Car', 'Red', 'ABC123'),
(2, 2, 'Truck', 'Blue', 'XYZ456'),
(3, 3, 'Car', 'Black', 'LMN789'),
(4, 4, 'SUV', 'White', 'PQR234'),
(5, 5, 'Car', 'Silver', 'DEF567'),
(6, 6, 'Motorcycle', 'Yellow', 'GHI890'),
(7, 7, 'Car', 'Green', 'JKL123'),
(8, 8, 'Truck', 'Orange', 'MNO456'),
(9, 9, 'SUV', 'Red', 'PQR678'),
(10, 10, 'Car', 'Blue', 'STU234'),
(11, 11, 'Motorcycle', 'Black', 'VWX345'),
(12, 12, 'Car', 'Yellow', 'YZA567'),
(13, 13, 'Truck', 'White', 'BCD678'),
(14, 14, 'Car', 'Silver', 'EFG789'),
(15, 15, 'SUV', 'Green', 'HIJ890'),
(16, 16, 'Motorcycle', 'Blue', 'KLM123'),
(17, 17, 'Car', 'Black', 'NOP234'),
(18, 18, 'Truck', 'Red', 'QRS345'),
(19, 19, 'SUV', 'Yellow', 'TUV567'),
(20, 20, 'Car', 'Silver', 'WXY678');
-- Insert data into the ElectricVehicleCharging table
INSERT INTO ElectricVehicleCharging (ChargeID, VehicleID, StartTime, EndTime, TotalCost)
VALUES
(1, 1, '2024-11-01 08:00:00', '2024-11-01 10:00:00', 15.50),
(2, 2, '2024-11-01 09:00:00', '2024-11-01 11:00:00', 20.75),
(3, 3, '2024-11-01 10:00:00', '2024-11-01 12:00:00', 18.60),
(4, 4, '2024-11-01 11:00:00', '2024-11-01 13:00:00', 22.30),
(5, 5, '2024-11-01 12:00:00', '2024-11-01 14:00:00', 19.20),
(6, 6, '2024-11-01 13:00:00', '2024-11-01 15:00:00', 12.90),
(7, 7, '2024-11-01 14:00:00', '2024-11-01 16:00:00', 17.40),
(8, 8, '2024-11-01 15:00:00', '2024-11-01 17:00:00', 21.50),
(9, 9, '2024-11-01 16:00:00', '2024-11-01 18:00:00', 16.80),
(10, 10, '2024-11-01 17:00:00', '2024-11-01 19:00:00', 14.70),
(11, 11, '2024-11-01 18:00:00', '2024-11-01 20:00:00', 13.50),
(12, 12, '2024-11-01 19:00:00', '2024-11-01 21:00:00', 20.00),
(13, 13, '2024-11-01 20:00:00', '2024-11-01 22:00:00', 23.10),
(14, 14, '2024-11-01 21:00:00', '2024-11-01 23:00:00', 19.30),
(15, 15, '2024-11-01 22:00:00', '2024-11-02 00:00:00', 18.20),
(16, 16, '2024-11-01 23:00:00', '2024-11-02 01:00:00', 14.50),
(17, 17, '2024-11-02 00:00:00', '2024-11-02 02:00:00', 16.00),
(18, 18, '2024-11-02 01:00:00', '2024-11-02 03:00:00', 21.20),
(19, 19, '2024-11-02 02:00:00', '2024-11-02 04:00:00', 22.10),
(20, 20, '2024-11-02 03:00:00', '2024-11-02 05:00:00', 17.60);
INSERT INTO ParkingLot (LotID, Name, Location, Capacity, NoOfFloors)
VALUES
(1, 'Central Park', 'Downtown', 200, 5),
(2, 'East Side Park', 'East City', 150, 4),
(3, 'West End Parking', 'West Street', 120, 3),
(4, 'Park Avenue', 'Avenue Street', 180, 6),
(5, 'City Center Parking', 'Central Square', 220, 5),
(6, 'Park Hill', 'Hill Road', 100, 2),
(7, 'Riverbank Lot', 'Riverside', 130, 4),
(8, 'Suburban Parking', 'Suburb Road', 90, 3),
(9, 'Mall Parking', 'Mall Street', 250, 7),
(10, 'Airport Lot', 'Airport Area', 300, 8),
(11, 'Train Station Lot', 'Railway Street', 160, 4),
(12, 'Hotel Parking', 'Luxury Avenue', 110, 3),
(13, 'Beachside Parking', 'Beach Road', 75, 2),
(14, 'University Lot', 'Campus Road', 180, 5),
(15, 'Market Square Parking', 'Market Street', 140, 3),
(16, 'Museum Parking', 'Museum Square', 90, 3),
(17, 'Hospital Parking', 'Medical Lane', 160, 4),
(18, 'Library Lot', 'Reading Street', 70, 2),
(19, 'Convention Center Lot', 'Expo Road', 200, 5),
(20, 'Sports Complex Parking', 'Stadium Avenue', 250, 6);
-- Insert data into the ParkingSpace table
INSERT INTO ParkingSpace (SpaceID, LotID, FloorNo, SpaceNo, Status)
VALUES
(1, 1, 1, 1, 'Available'),
(2, 1, 1, 2, 'Occupied'),
(3, 1, 2, 1, 'Available'),
(4, 1, 2, 2, 'Occupied'),
(5, 1, 3, 1, 'Available'),
(6, 1, 3, 2, 'Occupied'),
(7, 1, 4, 1, 'Available'),
(8, 1, 4, 2, 'Occupied'),
(9, 1, 5, 1, 'Available'),
(10, 1, 5, 2, 'Occupied'),
(11, 2, 1, 1, 'Available'),
(12, 2, 1, 2, 'Occupied'),
(13, 2, 2, 1, 'Available'),
(14, 2, 2, 2, 'Occupied'),
(15, 2, 3, 1, 'Available'),
(16, 2, 3, 2, 'Occupied'),
(17, 2, 4, 1, 'Available'),
(18, 2, 4, 2, 'Occupied'),
(19, 2, 5, 1, 'Available'),
(20, 2, 5, 2, 'Occupied');
-- Insert data into the Staff table
INSERT INTO Staff (StaffID, Role, Contact, AssignedLotID, Name)
VALUES
(1, 'Manager', '1234567801', 1, 'SA'),
(2, 'Security', '1234567802', 1, 'AE'),
(3, 'Parking Attendant', '1234567803', 1, 'EM'),
(4, 'Manager', '1234567804', 2, 'ME'),
(5, 'Security', '1234567805', 2, 'AL'),
(6, 'Parking Attendant', '1234567806', 2, 'LE'),
(7, 'Manager', '1234567807', 3, 'DS'),
(8, 'Security', '1234567808', 3, 'LM'),
(9, 'Parking Attendant', '1234567809', 3, 'JR'),
(10, 'Manager', '1234567810', 4, 'LS'),
(11, 'Security', '1234567811', 4, 'RC'),
(12, 'Parking Attendant', '1234567812', 4, 'WA'),
(13, 'Manager', '1234567813', 5, 'KB'),
(14, 'Security', '1234567814', 5, 'BA'),
(15, 'Parking Attendant', '1234567815', 5, 'SS'),
(16, 'Manager', '1234567816', 6, 'NY'),
(17, 'Security', '1234567817', 6, 'RK'),
(18, 'Parking Attendant', '1234567818', 6, 'ST'),
(19, 'Manager', '1234567819', 7, 'JS'),
(20, 'Security', '1234567820', 7, 'CR');
-- Insert data into the Reservation table
INSERT INTO Reservation (ReservationID, SpaceID, StartTime, EndTime, Status)
VALUES
(1, 1, '2024-11-01 08:00:00', '2024-11-01 12:00:00', 'Confirmed'),
(2, 2, '2024-11-01 09:00:00', '2024-11-01 13:00:00', 'Cancelled'),
(3, 3, '2024-11-01 10:00:00', '2024-11-01 14:00:00', 'Confirmed'),
(4, 4, '2024-11-01 11:00:00', '2024-11-01 15:00:00', 'Pending'),
(5, 5, '2024-11-01 12:00:00', '2024-11-01 16:00:00', 'Confirmed'),
(6, 6, '2024-11-01 13:00:00', '2024-11-01 17:00:00', 'Cancelled'),
(7, 7, '2024-11-02 08:00:00', '2024-11-02 12:00:00', 'Confirmed'),
(8, 8, '2024-11-02 09:00:00', '2024-11-02 13:00:00', 'Confirmed'),
(9, 9, '2024-11-02 10:00:00', '2024-11-02 14:00:00', 'Pending'),
(10, 10, '2024-11-02 11:00:00', '2024-11-02 15:00:00', 'Cancelled'),
(11, 11, '2024-11-02 12:00:00', '2024-11-02 16:00:00', 'Confirmed'),
(12, 12, '2024-11-02 13:00:00', '2024-11-02 17:00:00', 'Pending'),
(13, 13, '2024-11-03 08:00:00', '2024-11-03 12:00:00', 'Confirmed'),
(14, 14, '2024-11-03 09:00:00', '2024-11-03 13:00:00', 'Confirmed'),
(15, 15, '2024-11-03 10:00:00', '2024-11-03 14:00:00', 'Cancelled'),
(16, 16, '2024-11-03 11:00:00', '2024-11-03 15:00:00', 'Confirmed'),
(17, 17, '2024-11-03 12:00:00', '2024-11-03 16:00:00', 'Cancelled'),
(18, 18, '2024-11-03 13:00:00', '2024-11-03 17:00:00', 'Pending'),
(19, 19, '2024-11-03 14:00:00', '2024-11-03 18:00:00', 'Confirmed'),
(20, 20, '2024-11-03 15:00:00', '2024-11-03 19:00:00', 'Pending');
-- Insert data into the Payment table
INSERT INTO Payment (PaymentID, ReservationID, Date, Amount, PaymentMethod)
VALUES
(1, 1, '2024-11-01', 50.00, 'Credit Card'),
(2, 2, '2024-11-01', 30.00, 'Debit Card'),
(3, 3, '2024-11-01', 40.00, 'Cash'),
(4, 4, '2024-11-01', 45.00, 'Credit Card'),
(5, 5, '2024-11-01', 60.00, 'Debit Card'),
(6, 6, '2024-11-01', 55.00, 'Cash'),
(7, 7, '2024-11-01', 50.00, 'Credit Card'),
(8, 8, '2024-11-01', 45.00, 'Debit Card'),
(9, 9, '2024-11-01', 35.00, 'Cash'),
(10, 10, '2024-11-01', 60.00, 'Credit Card'),
(11, 11, '2024-11-02', 50.00, 'Debit Card'),
(12, 12, '2024-11-02', 40.00, 'Cash'),
(13, 13, '2024-11-02', 60.00, 'Credit Card'),
(14, 14, '2024-11-02', 45.00, 'Debit Card'),
(15, 15, '2024-11-02', 50.00, 'Cash'),
(16, 16, '2024-11-02', 55.00, 'Credit Card'),
(17, 17, '2024-11-02', 40.00, 'Debit Card'),
(18, 18, '2024-11-02', 45.00, 'Cash'),
(19, 19, '2024-11-02', 60.00, 'Credit Card'),
(20, 20, '2024-11-02', 50.00, 'Debit Card');


SELECT * 
FROM Owner;
SELECT * 
FROM Vehicle;
SELECT * 
FROM ElectricVehicleCharging;
SELECT * 
FROM ParkingLot;
SELECT * 
FROM ParkingSpace;
SELECT * 
FROM Staff;
SELECT * 
FROM Reservation;
SELECT * 
FROM Payment;


UPDATE Owner
SET Phone = '9876543210', Email = 'shahd_new@example.com'
WHERE OwnerID = 1;

UPDATE Owner
SET Phone = '9876543211', Email = 'alaa_new@example.com'
WHERE OwnerID = 2;

UPDATE Owner
SET Phone = '9876543212', Email = 'ebram_new@example.com'
WHERE OwnerID = 3;

UPDATE Owner
SET Phone = '9876543213', Email = 'mohammed_new@example.com'
WHERE OwnerID = 4;

UPDATE Owner
SET Phone = '9876543214', Email = 'alia_new@example.com'
WHERE OwnerID = 5;

UPDATE Owner
SET Phone = '9876543215', Email = 'sahhd_new@example.com'
WHERE OwnerID = 6;

UPDATE Owner
SET Phone = '9876543216', Email = 'alaa_7_new@example.com'
WHERE OwnerID = 7;

UPDATE Owner
SET Phone = '9876543217', Email = 'bream_new@example.com'
WHERE OwnerID = 8;

UPDATE Owner
SET Phone = '9876543218', Email = 'mohdema_new@example.com'
WHERE OwnerID = 9;

UPDATE Owner
SET Phone = '9876543219', Email = 'ila_new@example.com'
WHERE OwnerID = 10;
--update 2
UPDATE Vehicle
SET Color = 'Blue', Type = 'SUV'
WHERE VehicleID = 1;

UPDATE Vehicle
SET Color = 'Yellow', Type = 'Car'
WHERE VehicleID = 2;

UPDATE Vehicle
SET Color = 'Green', Type = 'Truck'
WHERE VehicleID = 3;

UPDATE Vehicle
SET Color = 'Red', Type = 'Motorcycle'
WHERE VehicleID = 4;

UPDATE Vehicle
SET Color = 'Black', Type = 'SUV'
WHERE VehicleID = 5;

UPDATE Vehicle
SET Color = 'Pink', Type = 'Car'
WHERE VehicleID = 6;

UPDATE Vehicle
SET Color = 'White', Type = 'Truck'
WHERE VehicleID = 7;

UPDATE Vehicle
SET Color = 'Orange', Type = 'SUV'
WHERE VehicleID = 8;

UPDATE Vehicle
SET Color = 'Purple', Type = 'Motorcycle'
WHERE VehicleID = 9;

UPDATE Vehicle
SET Color = 'Silver', Type = 'Car'
WHERE VehicleID = 10;

-- update no3

UPDATE ElectricVehicleCharging
SET TotalCost = 20.50
WHERE ChargeID = 1;

UPDATE ElectricVehicleCharging
SET TotalCost = 21.00
WHERE ChargeID = 2;

UPDATE ElectricVehicleCharging
SET TotalCost = 19.75
WHERE ChargeID = 3;

UPDATE ElectricVehicleCharging
SET TotalCost = 22.50
WHERE ChargeID = 4;

UPDATE ElectricVehicleCharging
SET TotalCost = 21.00
WHERE ChargeID = 5;

UPDATE ElectricVehicleCharging
SET TotalCost = 18.25
WHERE ChargeID = 6;

UPDATE ElectricVehicleCharging
SET TotalCost = 20.00
WHERE ChargeID = 7;

UPDATE ElectricVehicleCharging
SET TotalCost = 22.75
WHERE ChargeID = 8;

UPDATE ElectricVehicleCharging
SET TotalCost = 19.50
WHERE ChargeID = 9;

UPDATE ElectricVehicleCharging
SET TotalCost = 23.00
WHERE ChargeID = 10;

----upd no4

UPDATE Reservation
SET Status = 'Completed'
WHERE ReservationID = 1;

UPDATE Reservation
SET Status = 'Cancelled'
WHERE ReservationID = 2;

UPDATE Reservation
SET Status = 'Completed'
WHERE ReservationID = 3;

UPDATE Reservation
SET Status = 'Confirmed'
WHERE ReservationID = 4;

UPDATE Reservation
SET Status = 'Pending'
WHERE ReservationID = 5;

UPDATE Reservation
SET Status = 'Completed'
WHERE ReservationID = 6;

UPDATE Reservation
SET Status = 'Cancelled'
WHERE ReservationID = 7;

UPDATE Reservation
SET Status = 'Confirmed'
WHERE ReservationID = 8;

UPDATE Reservation
SET Status = 'Pending'
WHERE ReservationID = 9;

UPDATE Reservation
SET Status = 'Completed'
WHERE ReservationID = 10;

---upd no5

UPDATE Staff
SET Contact = '9876543221', Role = 'Supervisor'
WHERE StaffID = 1;

UPDATE Staff
SET Contact = '9876543222', Role = 'Supervisor'
WHERE StaffID = 2;

UPDATE Staff
SET Contact = '9876543223', Role = 'Attendant'
WHERE StaffID = 3;

UPDATE Staff
SET Contact = '9876543224', Role = 'Supervisor'
WHERE StaffID = 4;

UPDATE Staff
SET Contact = '9876543225', Role = 'Attendant'
WHERE StaffID = 5;

UPDATE Staff
SET Contact = '9876543226', Role = 'Supervisor'
WHERE StaffID = 6;

UPDATE Staff
SET Contact = '9876543227', Role = 'Security'
WHERE StaffID = 7;

UPDATE Staff
SET Contact = '9876543228', Role = 'Security'
WHERE StaffID = 8;

UPDATE Staff
SET Contact = '9876543229', Role = 'Attendant'
WHERE StaffID = 9;

UPDATE Staff
SET Contact = '9876543230', Role = 'Supervisor'
WHERE StaffID = 10;

----upd no 6

UPDATE ParkingSpace
SET Status = 'Occupied'
WHERE SpaceID = 1;

UPDATE ParkingSpace
SET Status = 'Available'
WHERE SpaceID = 2;

UPDATE ParkingSpace
SET Status = 'Occupied'
WHERE SpaceID = 3;

UPDATE ParkingSpace
SET Status = 'Available'
WHERE SpaceID = 4;

UPDATE ParkingSpace
SET Status = 'Occupied'
WHERE SpaceID = 5;

UPDATE ParkingSpace
SET Status = 'Available'
WHERE SpaceID = 6;

UPDATE ParkingSpace
SET Status = 'Occupied'
WHERE SpaceID = 7;

UPDATE ParkingSpace
SET Status = 'Available'
WHERE SpaceID = 8;

UPDATE ParkingSpace
SET Status = 'Occupied'
WHERE SpaceID = 9;

UPDATE ParkingSpace
SET Status = 'Available'
WHERE SpaceID = 10;
 
 --upd no7

 UPDATE ParkingLot
SET Capacity = 220, Location = 'New Downtown'
WHERE LotID = 1;

UPDATE ParkingLot
SET Capacity = 160, Location = 'East Urban Area'
WHERE LotID = 2;

UPDATE ParkingLot
SET Capacity = 130, Location = 'West City'
WHERE LotID = 3;

UPDATE ParkingLot
SET Capacity = 180, Location = 'Avenue Lane'
WHERE LotID = 4;

UPDATE ParkingLot
SET Capacity = 250, Location = 'City Center'
WHERE LotID = 5;

UPDATE ParkingLot
SET Capacity = 120, Location = 'Hill Road'
WHERE LotID = 6;

UPDATE ParkingLot
SET Capacity = 200, Location = 'Riverbank Side'
WHERE LotID = 7;

UPDATE ParkingLot
SET Capacity = 150, Location = 'Suburb Park'
WHERE LotID = 8;

UPDATE ParkingLot
SET Capacity = 180, Location = 'Mall Area'
WHERE LotID = 9;

UPDATE ParkingLot
SET Capacity = 300, Location = 'Airport Terminals'
WHERE LotID = 10;

------upd no8


UPDATE ParkingSpace SET Status = 'Occupied' WHERE SpaceID = 1;
UPDATE ParkingSpace SET Status = 'Available' WHERE SpaceID = 2;
UPDATE ParkingSpace SET Status = 'Occupied' WHERE SpaceID = 3;
UPDATE ParkingSpace SET Status = 'Available' WHERE SpaceID = 4;
UPDATE ParkingSpace SET Status = 'Occupied' WHERE SpaceID = 5;
UPDATE ParkingSpace SET Status = 'Available' WHERE SpaceID = 6;
UPDATE ParkingSpace SET Status = 'Occupied' WHERE SpaceID = 7;
UPDATE ParkingSpace SET Status = 'Available' WHERE SpaceID = 8;
UPDATE ParkingSpace SET Status = 'Occupied' WHERE SpaceID = 9;
UPDATE ParkingSpace SET Status = 'Available' WHERE SpaceID = 10;


ALTER TABLE Owner
ADD MiddleName VARCHAR(50);
-- Alter the column to change its data type
ALTER TABLE Owner
ALTER COLUMN MiddleName TYPE VARCHAR(100);
-- Drop the column from the Owner table
ALTER TABLE Owner
DROP COLUMN MiddleName;
-- Add a new constraint to the Phone column, drop it 
ALTER TABLE Owner
ADD CONSTRAINT UQ_Owner_Phonee UNIQUE (Phone);
ALTER TABLE Owner
DROP CONSTRAINT UQ_Owner_Phonee;


--Delete
DELETE FROM Payment WHERE PaymentID IN (1, 2, 3, 4, 5, 6, 7, 8, 9, 10);
DELETE FROM ElectricVehicleCharging WHERE ChargeID IN (1, 2, 3, 4, 5, 6, 7, 8, 9, 10);
DELETE FROM Staff WHERE StaffID IN (1, 2, 3, 4, 5, 6, 7, 8, 9, 10);
DELETE FROM Vehicle WHERE VehicleID IN (1, 2, 3, 4, 5, 6, 7, 8, 9, 10);
DELETE FROM Owner WHERE OwnerID IN (1, 2, 3, 4, 5, 6, 7, 8, 9, 10);
DELETE FROM Reservation WHERE ReservationID IN (1, 2, 3, 4, 5, 6, 7, 8, 9, 10);
DELETE FROM ParkingSpace WHERE SpaceID IN (1, 2, 3, 4, 5, 6, 7, 8, 9, 10);
DELETE FROM ParkingLot WHERE LotID IN (1, 2, 3, 4, 5, 6, 7, 8, 9, 10);


--Queries using selecting
SELECT * 
FROM Owner;

SELECT OwnerID AS "ID", FN AS "First Name", LN AS "Last Name", Phone, Email
FROM Owner;

SELECT 
    OwnerID AS "ID", 
FN AS "First Name", "LN AS "Last Name",   FN + ' ' + LN AS "Full Name" 
FROM Owner;
-- Query using OR operator
SELECT 
    SpaceID, LotID, FloorNo, SpaceNo, Status
FROM 
    ParkingSpace
WHERE 
    FloorNo = 1 OR Status = 'Occupied';

-- Query using BETWEEN
SELECT 
    StaffID, Name, Role, Salary
FROM 
    Staff
WHERE 
    Salary BETWEEN 5000 AND 10000;

-- Query using NOT BETWEEN
SELECT 
    StaffID, Name, Role, Salary
FROM 
    Staff
WHERE 
    Salary NOT BETWEEN 5000 AND 10000;


SELECT VehicleID, Type, Color 
FROM Vehicle 
WHERE Color = 'Red';

SELECT LotID, Name, Capacity 
FROM ParkingLot 
ORDER BY Capacity DESC;


SELECT * 
FROM Owner 
WHERE FN LIKE 'A%';


SELECT SpaceID, Status 
FROM ParkingSpace 
WHERE Status IS NULL;

--Joins
--Inner

SELECT O.OwnerID, O.FN, O.LN, V.VehicleID, V.Type, V.Color 
FROM Owner O
INNER JOIN Vehicle V ON O.OwnerID = V.OwnerID;


SELECT PL.LotID, PL.Name AS LotName, PS.SpaceID, PS.Status 
FROM ParkingLot PL
INNER JOIN ParkingSpace PS ON PL.LotID = PS.LotID;


SELECT R.ReservationID, PS.SpaceID, PS.Status, O.OwnerID, O.FN, O.LN 
FROM Reservation R
INNER JOIN ParkingSpace PS ON R.SpaceID = PS.SpaceID
INNER JOIN Owner O ON R.St = O.OwnerID;

SELECT P.PaymentID, P.Date, P.Amount, R.ReservationID, R.SpaceID 
FROM Payment P
INNER JOIN Reservation R ON P.ReservationID = R.ReservationID;

SELECT S.StaffID, S.Name, S.Role, PL.Name AS AssignedLot 
FROM Staff S
INNER JOIN ParkingLot PL ON S.AssignedLotID = PL.LotID;

--outer
SELECT PL.LotID, PL.Name, S.Name AS StaffName, S.Role 
FROM ParkingLot PL
LEFT JOIN Staff S ON PL.LotID = S.AssignedLotID;


--Aggergate
SELECT PL.LotID, PL.Name, COUNT(PS.SpaceID) AS TotalSpaces 
FROM ParkingLot PL
INNER JOIN ParkingSpace PS ON PL.LotID = PS.LotID
GROUP BY PL.LotID, PL.Name;


--Nested Query
SELECT V.VehicleID, V.LicensePlate, O.FN, O.LN 
FROM Vehicle V
INNER JOIN Owner O ON V.OwnerID = O.OwnerID
WHERE O.OwnerID IN (
    SELECT R.St 
    FROM Reservation R
);


--View
CREATE VIEW ActiveReservations AS
SELECT R.ReservationID, PS.SpaceID, PS.Status, R.Et AS ReservedDate
FROM Reservation R
INNER JOIN ParkingSpace PS ON R.SpaceID = PS.SpaceID
WHERE PS.Status = 'Reserved';

CREATE VIEW TotalPayments AS
SELECT R.ReservationID, SUM(P.Amount) AS TotalPayment 
FROM Payment P
INNER JOIN Reservation R ON P.ReservationID = R.ReservationID
GROUP BY R.ReservationID;

CREATE VIEW OwnerDetails AS
SELECT OwnerID, FN, LN, Phone, Email
FROM Owner;
INSERT INTO OwnerDetails (OwnerID, FN, LN, Phone, Email)
VALUES (1001, 'John', 'Doe', '123456789', 'john.doe@email.com');

CREATE VIEW VehicleDetails AS
SELECT VehicleID, LicensePlate, Color, Type
FROM Vehicle;
UPDATE VehicleDetails
SET Color = 'Blue'
WHERE VehicleID = 101;

CREATE VIEW ChargingDetails AS
SELECT ChargingID, VehicleID, TotalCost
FROM ElectricVehicleCharging;
DELETE FROM ChargingDetails 
WHERE ChargingID = 501;

