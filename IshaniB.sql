-- SKY DELIVER DATABASE --

-- CREATE DATABASE --
    
CREATE DATABASE SkyDeliverDB;

-- CREATE TABLES --
 
CREATE TABLE Customer (
    CustomerID INT PRIMARY KEY,
    FirstName VARCHAR(50) NOT NULL,
    LastName VARCHAR(50) NOT NULL,
    Email VARCHAR(100) UNIQUE,
    Phone VARCHAR(15),
    Address VARCHAR(200)
);

CREATE TABLE DeliveryStatus (
    StatusID VARCHAR(10) PRIMARY KEY,
    StatusName VARCHAR(50) NOT NULL,
    Description VARCHAR(200)
);

CREATE TABLE DistributionHub (
    HubID VARCHAR(10) PRIMARY KEY,
    HubName VARCHAR(100) NOT NULL,
    Location VARCHAR(150) NOT NULL,
    ContactNumber VARCHAR(15),
    Email VARCHAR(50)
);

CREATE TABLE Drone (
    DroneID VARCHAR(10) PRIMARY KEY,
    HubID VARCHAR(10) NOT NULL,
    DroneModel VARCHAR(50) NOT NULL,
    BatteryLevel DECIMAL(5,2),
    PayloadCapacity DECIMAL(6,2),
    AvailabilityStatus VARCHAR(30),

    FOREIGN KEY (HubID) REFERENCES DistributionHub(HubID)
);


CREATE TABLE Delivery (
    DeliveryID VARCHAR(10) PRIMARY KEY,
    CustomerID INT NOT NULL,
    StatusID VARCHAR(10) NOT NULL,
    PickupLocation VARCHAR(150) NOT NULL,
    DropoffLocation VARCHAR(150) NOT NULL, 
    PickupTime DATETIME NULL,
    DropoffTime  DATETIME NULL,
    ParcelWeight DECIMAL(6,2),
    
   FOREIGN KEY (CustomerID) REFERENCES Customer(CustomerID),
   FOREIGN KEY (StatusID) REFERENCES DeliveryStatus(StatusID)
);


CREATE TABLE DroneAssignment (
    AssignmentID INT PRIMARY KEY,
    DeliveryID VARCHAR(10)  NOT NULL,
    DroneID VARCHAR(10) NOT NULL,
    AssignmentDate DATE NOT NULL,
    AssignedBy VARCHAR(100),

    FOREIGN KEY (DeliveryID) REFERENCES Delivery(DeliveryID),
    FOREIGN KEY (DroneID) REFERENCES Drone(DroneID)
);

CREATE TABLE Maintenance (
    MaintenanceID INT PRIMARY KEY,
    DroneID VARCHAR(10)  NOT NULL,
    MaintenanceDate DATE NOT NULL,
    MaintenanceType VARCHAR(50),
    Description VARCHAR(200),
    MaintenanceStatus VARCHAR(30),

   FOREIGN KEY (DroneID) REFERENCES Drone(DroneID)
);

CREATE TABLE BatteryCharging (
    ChargingID VARCHAR(10) PRIMARY KEY,
    DroneID VARCHAR(10) NOT NULL,
    StartTime DATETIME NOT NULL,
    EndTime DATETIME,
    BatteryBefore DECIMAL(5,2),
    BatteryAfter DECIMAL(5,2),

    FOREIGN KEY (DroneID) REFERENCES Drone(DroneID)
);


-- INSERT RECORDS –

INSERT INTO Customer(CustomerID, FirstName, LastName, Email, Phone, Address)
VALUES
(1, 'Kamal', 'Perera', 'kamal.perera@gmail.com', '0771234567', 'Colombo 03'),
(2, 'Nimal', 'Fernando', 'nimal.fernando@gmail.com', '0712345678', 'Kandy'),
(3, 'Saman', 'Silva', 'saman.silva@gmail.com', '0753456789', 'Galle'),
(4, 'Amal', 'Perera', 'amal.perera@gmail.com', '0764567890', 'Negombo'),
(5, 'Kasun', 'Fernando', 'kasun.fernando@gmail.com', '0785678901', 'Gampaha'),
(6, 'Tharindu', 'Silva', 'tharindu.silva@gmail.com', '0701234567', 'Matara'),
(7, 'Ravindu', 'Perera', 'ravindu.perera@gmail.com', '0772345678', 'Kurunegala'),
(8, 'Chamod', 'Fernando', 'chamod.fernando@gmail.com', '0713456789', 'Colombo 07'),
(9, 'Dinesh', 'Silva', 'dinesh.silva@gmail.com', '0754567890', 'Kalutara'),
(10, 'Isuru', 'Perera', 'isuru.perera@gmail.com', '0765678901', 'Panadura'),
(11, 'Akila', 'Fernando', 'akila.fernando@gmail.com', '0786789012', 'Wattala'),
(12, 'Pasindu', 'Silva', 'pasindu.silva@gmail.com', '0707890123', 'Kotte'),
(13, 'Shehan', 'Perera', 'shehan.perera@gmail.com', '0778901234', 'Dehiwala'),
(14, 'Rashmika', 'Fernando', 'rashmika.fernando@gmail.com', '0719012345', 'Moratuwa'),
(15, 'Janith', 'Silva', 'janith.silva@gmail.com', '0750123456', 'Mount Lavinia'),
(16, 'Sachin', 'Perera', 'sachin.perera@gmail.com', '0761234567', 'Rajagiriya'),
(17, 'Vishwa', 'Fernando', 'vishwa.fernando@gmail.com', '0782345678', 'Nugegoda'),
(18, 'Dinuka', 'Silva', 'dinuka.silva@gmail.com', '0703456789', 'Maharagama'),
(19, 'Yasiru', 'Perera', 'yasiru.perera@gmail.com', '0774567890', 'Battaramulla'),
(20, 'Malith', 'Fernando', 'malith.fernando@gmail.com', '0715678901', 'Colombo 05')
; 

INSERT INTO DeliveryStatus(StatusID, StatusName, Description)
VALUES
('ST001', 'Pending', 'Delivery request has been received and is waiting for processing.'),
('ST002', 'Confirmed', 'Delivery request has been confirmed by the system.'),
('ST003', 'Assigned', 'A drone has been assigned to the delivery.'),
('ST004', 'Pickup Scheduled', 'Pickup has been scheduled for the delivery.'),
('ST005', 'Ready for Pickup', 'Parcel is ready to be collected from the pickup location.'),
('ST006', 'Picked Up', 'Parcel has been collected from the pickup location.'),
('ST007', 'In Transit', 'Parcel is currently being transported to the destination.'),
('ST008', 'Arrived at Hub', 'Parcel has arrived at the distribution hub.'),
('ST009', 'Processing', 'Parcel is being processed at the distribution hub.'),
('ST010', 'Out for Delivery', 'Parcel is currently on the way to the drop-off location.'),
('ST011', 'Delivered', 'Parcel has been successfully delivered to the customer.'),
('ST012', 'Delivery Failed', 'The delivery could not be completed successfully.'),
('ST013', 'Cancelled', 'The delivery request has been cancelled.'),
('ST014', 'Rescheduled', 'The delivery has been scheduled for another time.'),
('ST015', 'Delayed', 'The delivery has been delayed due to operational reasons.'),
('ST016', 'Returned', 'The parcel has been returned to the sender.'),
('ST017', 'On Hold', 'The delivery is temporarily placed on hold.'),
('ST018', 'Drone Assigned', 'A suitable drone has been selected for the delivery.'),
('ST019', 'Pickup Completed', 'The parcel pickup process has been completed.'),
('ST020', 'Completed', 'The complete delivery process has been successfully finished.')
;


INSERT INTO DistributionHub(HubID, HubName, Location, ContactNumber, Email)
VALUES
('HUB001', 'Colombo Central Hub', 'Colombo 01', '0112345678', 'colombo@distributionhub.lk'),
('HUB002', 'Kandy Distribution Hub', 'Kandy', '0812345678', 'kandy@distributionhub.lk'),
('HUB003', 'Galle Distribution Hub', 'Galle', '0912345678', 'galle@distributionhub.lk'),
('HUB004', 'Gampaha Distribution Hub', 'Gampaha', '0332345678', 'gampaha@distributionhub.lk'),
('HUB005', 'Negombo Distribution Hub', 'Negombo', '0312345678', 'negombo@distributionhub.lk'),
('HUB006', 'Matara Distribution Hub', 'Matara', '0412345678', 'matara@distributionhub.lk'),
('HUB007', 'Kurunegala Distribution Hub', 'Kurunegala', '0372345678', 'kurunegala@distributionhub.lk'),
('HUB008', 'Kalutara Distribution Hub', 'Kalutara', '0342345678', 'kalutara@distributionhub.lk'),
('HUB009', 'Ratnapura Distribution Hub', 'Ratnapura', '0452345678', 'ratnapura@distributionhub.lk'),
('HUB010', 'Anuradhapura Distribution Hub', 'Anuradhapura', '0252345678', 'anuradhapura@distributionhub.lk'),
('HUB011', 'Jaffna Distribution Hub', 'Jaffna', '0212345678', 'jaffna@distributionhub.lk'),
('HUB012', 'Batticaloa Distribution Hub', 'Batticaloa', '0652345678', 'batticaloa@distributionhub.lk'),
('HUB013', 'Trincomalee Distribution Hub', 'Trincomalee', '0262345678', 'trincomalee@distributionhub.lk'),
('HUB014', 'Badulla Distribution Hub', 'Badulla', '0552345678', 'badulla@distributionhub.lk'),
('HUB015', 'Nuwara Eliya Distribution Hub', 'Nuwara Eliya', '0522345678', 'nuwaraeliya@distributionhub.lk'),
('HUB016', 'Avissawella Distribution Hub', 'Avissawella', '0362345678', 'avissawella@distributionhub.lk'),
('HUB017', 'Panadura Distribution Hub', 'Panadura', '0382345678', 'panadura@distributionhub.lk'),
('HUB018', 'Moratuwa Distribution Hub', 'Moratuwa', '0113456789', 'moratuwa@distributionhub.lk'),
('HUB019', 'Wattala Distribution Hub', 'Wattala', '0114567890', 'wattala@distributionhub.lk'),
('HUB020', 'Maharagama Distribution Hub', 'Maharagama', '0115678901', 'maharagama@distributionhub.lk')
;


INSERT INTO Drone(DroneID, HubID, DroneModel, BatteryLevel, PayloadCapacity, AvailabilityStatus)
VALUES
    ('DRN001', 'HUB001', 'Sky-X1', 95.50, 9.00, 'Available'),
    ('DRN002', 'HUB002', 'Sky-X2', 88.20, 9.00, 'Available'),
    ('DRN003', 'HUB003', 'Sky-Pro1', 76.80, 7.50, 'In Use'),
    ('DRN004', 'HUB005', 'Sky-Pro2', 92.40, 2.70, 'Available'),
    ('DRN005', 'HUB005', 'Sky-X3', 65.30, 9.00, 'Maintenance'),
    ('DRN006', 'HUB003', 'Sky-Max1', 81.60, 7.50, 'Available'),
    ('DRN007', 'HUB004', 'Sky-Max2', 97.10, 9.00, 'Available'),
    ('DRN008', 'HUB014', 'Sky-X4', 72.50, 2.70, 'In Use'),
    ('DRN009', 'HUB008', 'Sky-Pro3', 84.90, 9.00, 'Available'),
    ('DRN010', 'HUB007', 'Sky-Max3', 59.40, 7.50, 'Charging'),
    ('DRN011', 'HUB008', 'Sky-X5', 90.30, 9.00, 'Available'),
    ('DRN012', 'HUB009', 'Sky-M30 Series', 68.70, 2.70, 'In Use'),
    ('DRN013', 'HUB010', 'Sky-Pro4', 93.80, 9.00, 'Available'),
    ('DRN014', 'HUB012', 'Sky-Max4', 79.20, 7.50, 'Available'),
    ('DRN015', 'HUB014', 'Sky-X1', 61.50, 9.00, 'Maintenance'),
    ('DRN016', 'HUB001', 'Sky-M30 Series', 86.40, 2.70, 'Available'),
    ('DRN017', 'HUB002', 'Sky-Max5', 74.60, 9.00, 'In Use'),
    ('DRN018', 'HUB018', 'Sky-Max5', 96.20, 7.50, 'Available'),
    ('DRN019', 'HUB020', 'Sky-X7', 70.80, 9.00, 'Charging'),
    ('DRN020', 'HUB005', 'Sky-Pro6', 89.50, 2.70, 'Available')
    ;


INSERT INTO Delivery(DeliveryID, CustomerID, StatusID, PickupLocation, DropoffLocation, PickupTime, DropoffTime, ParcelWeight)
VALUES
('DL001', 1, 'ST011', 'Colombo 03', 'Colombo 01', '2026-08-01 09:00', '2026-08-01 10:30', 2.50),
('DL002', 2, 'ST007', 'Kandy', 'Peradeniya', '2026-08-02 10:00', NULL, 3.20),
('DL003', 3, 'ST011', 'Galle', 'Unawatuna', '2026-08-03 09:30', '2026-08-03 11:20', 1.80),
('DL004', 4, 'ST006', 'Negombo', 'Katunayake', '2026-08-04 11:00', NULL, 4.50),
('DL005', 5, 'ST007', 'Gampaha', 'Kadawatha', '2026-08-05 09:00', NULL, 5.00),
('DL006', 6, 'ST011', 'Matara', 'Weligama', '2026-08-06 08:30', '2026-08-06 10:10', 2.20),
('DL007', 7, 'ST010', 'Kurunegala', 'Kuliyapitiya', '2026-08-07 10:00', NULL, 6.00),
('DL008', 8, 'ST011', 'Colombo 07', 'Borella', '2026-08-08 08:45', '2026-08-08 10:00', 1.50),
('DL009', 9, 'ST007', 'Kalutara', 'Beruwala', '2026-08-09 10:30', NULL, 3.70),
('DL010', 10, 'ST011', 'Panadura', 'Wadduwa', '2026-08-10 08:00', '2026-08-10 09:15', 2.00),
('DL011', 11, 'ST003', 'Wattala', 'Colombo 04', NULL, NULL, 4.20),
('DL012', 12, 'ST004', 'Kotte', 'Nugegoda', NULL, NULL, 2.80),
('DL013', 13, 'ST011', 'Dehiwala', 'Wellawatte', '2026-08-13 08:45', '2026-08-13 10:20', 3.00),
('DL014', 14, 'ST007', 'Moratuwa', 'Ratmalana', '2026-08-14 10:00', NULL, 4.80),
('DL015', 15, 'ST011', 'Mount Lavinia', 'Dehiwala', '2026-08-15 08:30', '2026-08-15 09:45', 1.20),
('DL016', 16, 'ST005', 'Rajagiriya', 'Battaramulla', NULL, NULL, 3.50),
('DL017', 17, 'ST010', 'Nugegoda', 'Maharagama', '2026-08-17 09:15', NULL, 5.50),
('DL018', 18, 'ST011', 'Maharagama', 'Kottawa', '2026-08-18 08:15', '2026-08-18 09:40', 2.40),
('DL019', 19, 'ST002', 'Battaramulla', 'Kotte', NULL, NULL, 4.00),
('DL020', 20, 'ST003', 'Colombo 05', 'Colombo 02', NULL, NULL, 3.30)
;

INSERT INTO DroneAssignment (AssignmentID, DeliveryID, DroneID, AssignmentDate, AssignedBy)
VALUES
(1, 'DL001', 'DRN001', '2026-08-01', 'Admin'),
(2, 'DL002', 'DRN003', '2026-08-02', 'Admin'),
(3, 'DL003', 'DRN006', '2026-08-03', 'System'),
(4, 'DL004', 'DRN009', '2026-08-04', 'Admin'),
(5, 'DL005', 'DRN007', '2026-08-05', 'Manager'),
(6, 'DL006', 'DRN018', '2026-08-06', 'System'),
(7, 'DL007', 'DRN008', '2026-08-07', 'Manager'),
(8, 'DL008', 'DRN011', '2026-08-08', 'Admin'),
(9, 'DL009', 'DRN013', '2026-08-09', 'System'),
(10, 'DL010', 'DRN016', '2026-08-10', 'Admin'),
(11, 'DL011', 'DRN002', '2026-08-11', 'Manager'),
(12, 'DL012', 'DRN004', '2026-08-12', 'System'),
(13, 'DL013', 'DRN014', '2026-08-13', 'Admin'),
(14, 'DL014', 'DRN017', '2026-08-14', 'Manager'),
(15, 'DL015', 'DRN020', '2026-08-15', 'System'),
(16, 'DL016', 'DRN001', '2026-08-16', 'Admin'),
(17, 'DL017', 'DRN003', '2026-08-17', 'Manager'),
(18, 'DL018', 'DRN006', '2026-08-18', 'System'),
(19, 'DL019', 'DRN009', '2026-08-19', 'Admin'),
(20, 'DL020', 'DRN012', '2026-08-19', 'Manager')
;

INSERT INTO Maintenance
(MaintenanceID, DroneID, MaintenanceDate, MaintenanceType, Description, MaintenanceStatus)
VALUES
(1, 'DRN001', '2026-07-01', 'Routine Inspection', 'Battery and motor inspection', 'Completed'),
(2, 'DRN002', '2026-07-02', 'Battery Check', 'Battery performance checked', 'Completed'),
(3, 'DRN003', '2026-07-03', 'Motor Service', 'Motor performance checked', 'Completed'),
(4, 'DRN004', '2026-07-04', 'Software Update', 'Flight software updated', 'Completed'),
(5, 'DRN005', '2026-07-05', 'Motor Repair', 'Motor maintenance required', 'In Progress'),
(6, 'DRN006', '2026-07-06', 'Routine Inspection', 'General inspection completed', 'Completed'),
(7, 'DRN007', '2026-07-07', 'Battery Check', 'Battery health checked', 'Completed'),
(8, 'DRN008', '2026-07-08', 'Propeller Replacement', 'Propellers replaced', 'Completed'),
(9, 'DRN009', '2026-07-09', 'Routine Inspection', 'General maintenance', 'Completed'),
(10, 'DRN010', '2026-07-10', 'Battery Repair', 'Battery connector repaired', 'Completed'),
(11, 'DRN011', '2026-07-11', 'Software Update', 'Navigation software updated', 'Completed'),
(12, 'DRN012', '2026-07-12', 'Motor Service', 'Motor performance checked', 'Completed'),
(13, 'DRN013', '2026-07-13', 'Routine Inspection', 'General inspection completed', 'Completed'),
(14, 'DRN014', '2026-07-14', 'Battery Check', 'Battery capacity checked', 'Completed'),
(15, 'DRN015', '2026-07-15', 'Motor Repair', 'Motor replacement required', 'In Progress'),
(16, 'DRN016', '2026-07-16', 'Software Update', 'System software updated', 'Completed'),
(17, 'DRN017', '2026-07-17', 'Routine Inspection', 'General inspection completed', 'Completed'),
(18, 'DRN018', '2026-07-18', 'Battery Check', 'Battery health checked', 'Completed'),
(19, 'DRN019', '2026-07-19', 'Propeller Replacement', 'Propellers replaced', 'Completed'),
(20, 'DRN020', '2026-07-20', 'Routine Inspection', 'General maintenance completed', 'Completed')
;

INSERT INTO BatteryCharging
(ChargingID, DroneID, StartTime, EndTime, BatteryBefore, BatteryAfter)
VALUES
('CHG001', 'DRN001', '2026-08-01 06:00', '2026-08-01 07:30', 35.00, 95.00),
('CHG002', 'DRN002', '2026-08-02 06:30', '2026-08-02 08:00', 40.00, 96.00),
('CHG003', 'DRN003', '2026-08-03 07:00', '2026-08-03 08:30', 28.00, 90.00),
('CHG004', 'DRN004', '2026-08-04 06:00', '2026-08-04 07:20', 32.00, 94.00),
('CHG005', 'DRN005', '2026-08-05 05:30', '2026-08-05 07:00', 25.00, 92.00),
('CHG006', 'DRN006', '2026-08-06 06:00', '2026-08-06 07:30', 30.00, 93.00),
('CHG007', 'DRN007', '2026-08-07 06:30', '2026-08-07 08:00', 42.00, 98.00),
('CHG008', 'DRN008', '2026-08-08 07:00', '2026-08-08 08:20', 29.00, 91.00),
('CHG009', 'DRN009', '2026-08-09 06:00', '2026-08-09 07:30', 34.00, 94.00),
('CHG010', 'DRN010', '2026-08-10 05:30', '2026-08-10 07:00', 20.00, 90.00),
('CHG011', 'DRN011', '2026-08-11 06:00', '2026-08-11 07:20', 38.00, 95.00),
('CHG012', 'DRN012', '2026-08-12 06:30', '2026-08-12 08:00', 27.00, 92.00),
('CHG013', 'DRN013', '2026-08-13 06:00', '2026-08-13 07:30', 40.00, 96.00),
('CHG014', 'DRN014', '2026-08-14 07:00', '2026-08-14 08:30', 31.00, 93.00),
('CHG015', 'DRN015', '2026-08-15 05:30', '2026-08-15 07:00', 22.00, 89.00),
('CHG016', 'DRN016', '2026-08-16 06:00', '2026-08-16 07:20', 36.00, 94.00),
('CHG017', 'DRN017', '2026-08-17 06:30', '2026-08-17 08:00', 29.00, 91.00),
('CHG018', 'DRN018', '2026-08-18 06:00', '2026-08-18 07:30', 45.00, 98.00),
('CHG019', 'DRN019', '2026-08-19 05:30', '2026-08-19 07:00', 24.00, 90.00),
('CHG020', 'DRN020', '2026-08-19 06:00', '2026-08-19 07:30', 37.00, 95.00)
;

-- FETCHING DATA FROM A TABLE --

SELECT * FROM Customer;

SELECT * FROM DeliveryStatus;

SELECT * FROM DistributionHub;

SELECT * FROM Drone;

SELECT * FROM Delivery;

SELECT * FROM DroneAssignment;

SELECT * FROM Maintenance;

SELECT * FROM BatteryCharging;
 
 

-- STORED PROCEDURE –
 
CREATE PROCEDURE GetCustomerDeliveries
    @CustomerID INT
AS
BEGIN
    SELECT
        d.DeliveryID,
        d.CustomerID,
        CONCAT(c.FirstName, ' ', c.LastName) AS CustomerName,
        d.PickupLocation,
        d.DropoffLocation,
        ds.StatusName,
        d.PickupTime,
        d.DropoffTime,
        d.ParcelWeight

    FROM Delivery d
    INNER JOIN Customer c
        ON d.CustomerID = c.CustomerID
    INNER JOIN DeliveryStatus ds
        ON d.StatusID = ds.StatusID
    WHERE d.CustomerID = @CustomerID;
END;

-- TEST STORED PROCEDURE --

EXEC GetCustomerDeliveries
    @CustomerID = 1;
 
-- TRIGGER –

CREATE TABLE drone_status_log(
    log_id INT IDENTITY(1,1) PRIMARY KEY,
    drone_id VARCHAR(10),
    old_status VARCHAR(30),
    new_status VARCHAR(30),
    changed_at DATETIME DEFAULT GETDATE()
);

CREATE TRIGGER after_drone_status_update
ON Drone
AFTER UPDATE
AS
BEGIN
    INSERT INTO drone_status_log(drone_id, old_status, new_status)
    SELECT
        i.DroneID,
        d.AvailabilityStatus,
        i.AvailabilityStatus
    FROM inserted i
    INNER JOIN deleted d
        ON i.DroneID = d.DroneID
    WHERE i.AvailabilityStatus <> d.AvailabilityStatus;
END;

UPDATE Drone
SET AvailabilityStatus = 'Maintenance'
WHERE DroneID = 'DRN001';

SELECT *FROM drone_status_log;


-- SQL QUERIES –

-- List all drones with their current status and battery level –

SELECT
    DroneID,
    AvailabilityStatus AS CurrentStatus,
    BatteryLevel

FROM Drone
;

-- Find all deliveries that are currently 'In Transit' --

SELECT
    d.DeliveryID,
    d.CustomerID,
    d.PickupLocation,
    d.DropoffLocation,
    ds.StatusName

FROM Delivery d
INNER JOIN DeliveryStatus ds
    ON d.StatusID = ds.StatusID
WHERE ds.StatusName = 'In Transit'
;

-- Display deliveries with customer names and assigned drone IDs --

SELECT
    d.DeliveryID,
    CONCAT(c.FirstName, ' ', c.LastName) AS CustomerName,
    da.DroneID,
    d.PickupLocation,
    d.DropoffLocation
FROM Delivery d
INNER JOIN Customer c
    ON d.CustomerID = c.CustomerID
INNER JOIN DroneAssignment da
    ON d.DeliveryID = da.DeliveryID
;

-- Calculate total number of deliveries handled by each drone --

SELECT
    dr.DroneID,
    dr.DroneModel,
    COUNT(da.DeliveryID) AS TotalDeliveries
FROM Drone dr
LEFT JOIN DroneAssignment da
    ON dr.DroneID = da.DroneID
GROUP BY
    dr.DroneID,
    dr.DroneModel
ORDER BY
    TotalDeliveries DESC
;

-- Find the top 3 most efficient drones --

SELECT TOP 3
    da.DroneID,
    AVG (
        DATEDIFF
        (
            MINUTE,
            d.PickupTime,
            d.DropoffTime
        )
    ) 
AS AverageDeliveryTimeMinutes

FROM Delivery d
INNER JOIN DroneAssignment da
    ON d.DeliveryID = da.DeliveryID
WHERE d.PickupTime  IS NOT NULL
  AND d.DropoffTime IS NOT NULL
GROUP BY
    da.DroneID
ORDER BY
    AverageDeliveryTimeMinutes ASC
;
 
 --Test Cases--
 
 INSERT INTO Customer
(CustomerID, FirstName, LastName, Email, Phone, Address)
VALUES
(21, 'Test', 'Customer', 'test.customer@gmail.com', '0771151032', 'Colombo');

SELECT *FROM Customer
WHERE CustomerID = 21;


INSERT INTO Customer
(CustomerID, FirstName, LastName, Email, Phone, Address)
VALUES
(1, 'Duplicate', 'Customer', 'duplicate@gmail.com', '0770222022', 'Kandy');


INSERT INTO Delivery(DeliveryID, CustomerID, StatusID, PickupLocation, DropoffLocation, PickupTime, DropoffTime, ParcelWeight)
VALUES
('DL999', 999, 'ST001', 'Colombo', 'Kandy', NULL, NULL, 2.00);


INSERT INTO Customer(CustomerID, FirstName, LastName, Email, Phone, Address)
VALUES
(22, NULL, 'Test', 'test22@gmail.com', '0773333333', 'Galle');


SELECT
    d.DeliveryID,
    d.CustomerID,
    d.PickupLocation,
    d.DropoffLocation,
    ds.StatusName
FROM Delivery d
INNER JOIN DeliveryStatus ds
    ON d.StatusID = ds.StatusID
WHERE ds.StatusName = 'In Transit'
;


SELECT
    d.DeliveryID,
    CONCAT(c.FirstName, ' ', c.LastName) AS CustomerName,
    da.DroneID,
    d.PickupLocation,
    d.DropoffLocation
FROM Delivery d
INNER JOIN Customer c
    ON d.CustomerID = c.CustomerID
INNER JOIN DroneAssignment da
    ON d.DeliveryID = da.DeliveryID;


EXEC GetCustomerDeliveries
    @CustomerID = 1;


SELECT TOP 3
    da.DroneID,
    AVG(
        DATEDIFF(
            MINUTE,
            d.PickupTime,
            d.DropoffTime
        )
    ) AS AverageDeliveryTimeMinutes
FROM Delivery d
INNER JOIN DroneAssignment da
    ON d.DeliveryID = da.DeliveryID
WHERE d.PickupTime IS NOT NULL
  AND d.DropoffTime IS NOT NULL
GROUP BY da.DroneID
ORDER BY AverageDeliveryTimeMinutes ASC
;
