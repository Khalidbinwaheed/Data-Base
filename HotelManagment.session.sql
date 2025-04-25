use hotelmanagment;

// Guest table

CREATE TABLE Guests (
    guest_id INT AUTO_INCREMENT PRIMARY KEY,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    email VARCHAR(100) UNIQUE,
    phone VARCHAR(20) NOT NULL,
    address VARCHAR(200),
    city VARCHAR(50),
    country VARCHAR(50),
    passport_number VARCHAR(50),
    date_of_birth DATE,
    registration_date DATETIME DEFAULT CURRENT_TIMESTAMP
);

// Room Types TABLE

CREATE TABLE RoomTypes (
    room_type_id INT AUTO_INCREMENT PRIMARY KEY,
    type_name VARCHAR(50) NOT NULL UNIQUE,
    description TEXT,
    base_price DECIMAL(10,2) NOT NULL,
    capacity INT NOT NULL,
    amenities TEXT
);

//Rooms TABLE

CREATE TABLE Rooms (
    room_id INT AUTO_INCREMENT PRIMARY KEY,
    room_number VARCHAR(10) NOT NULL UNIQUE,
    room_type_id INT NOT NULL,
    floor_number INT,
    availability BOOLEAN DEFAULT TRUE,
    maintenance_status BOOLEAN DEFAULT FALSE,
    FOREIGN KEY (room_type_id) REFERENCES RoomTypes(room_type_id)
);


// Reservations TABLE

CREATE TABLE Reservations (
    reservation_id INT AUTO_INCREMENT PRIMARY KEY,
    guest_id INT NOT NULL,
    room_id INT NOT NULL,
    check_in_date DATE NOT NULL,
    check_out_date DATE NOT NULL,
    adults INT DEFAULT 1,
    children INT DEFAULT 0,
    reservation_date DATETIME DEFAULT CURRENT_TIMESTAMP,
    status ENUM('confirmed', 'cancelled', 'checked-in', 'checked-out') DEFAULT 'confirmed',
    special_requests TEXT,
    FOREIGN KEY (guest_id) REFERENCES Guests(guest_id),
    FOREIGN KEY (room_id) REFERENCES Rooms(room_id)
);

// Payments TABLE
CREATE TABLE Payments (
    payment_id INT AUTO_INCREMENT PRIMARY KEY,
    reservation_id INT NOT NULL,
    payment_date DATETIME DEFAULT CURRENT_TIMESTAMP,
    amount DECIMAL(10,2) NOT NULL,
    payment_method ENUM('credit card', 'debit card', 'cash', 'bank transfer', 'other'),
    transaction_id VARCHAR(100),
    status ENUM('pending', 'completed', 'failed', 'refunded') DEFAULT 'pending',
    FOREIGN KEY (reservation_id) REFERENCES Reservations(reservation_id)
);

// Staff TABLE

CREATE TABLE Staff (
    staff_id INT AUTO_INCREMENT PRIMARY KEY,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    position VARCHAR(50) NOT NULL,
    email VARCHAR(100) UNIQUE,
    phone VARCHAR(20) NOT NULL,
    hire_date DATE NOT NULL,
    salary DECIMAL(10,2),
    department VARCHAR(50)
);

// Services TABLE

CREATE TABLE Services (
    service_id INT AUTO_INCREMENT PRIMARY KEY,
    service_name VARCHAR(100) NOT NULL,
    description TEXT,
    price DECIMAL(10,2) NOT NULL,
    availability BOOLEAN DEFAULT TRUE
);

// Service Requests TABLE

CREATE TABLE RoomService (
    service_log_id INT AUTO_INCREMENT PRIMARY KEY,
    reservation_id INT NOT NULL,
    service_id INT NOT NULL,
    request_time DATETIME DEFAULT CURRENT_TIMESTAMP,
    delivery_time DATETIME,
    quantity INT DEFAULT 1,
    notes TEXT,
    status ENUM('requested', 'in-progress', 'delivered', 'cancelled') DEFAULT 'requested',
    FOREIGN KEY (reservation_id) REFERENCES Reservations(reservation_id),
    FOREIGN KEY (service_id) REFERENCES Services(service_id)
);


CREATE INDEX idx_guest_name ON Guests(last_name, first_name);
CREATE INDEX idx_reservation_dates ON Reservations(check_in_date, check_out_date);
CREATE INDEX idx_room_availability ON Rooms(availability);
CREATE INDEX idx_payment_reservation ON Payments(reservation_id);


