CREATE DATABASE IF NOT EXISTS hotel_management;
USE hotel_management;

DROP TABLE IF EXISTS Review;
DROP TABLE IF EXISTS ServiceOrder;
DROP TABLE IF EXISTS Payment;
DROP TABLE IF EXISTS BookingRoom;
DROP TABLE IF EXISTS Booking;
DROP TABLE IF EXISTS Service;
DROP TABLE IF EXISTS Staff;
DROP TABLE IF EXISTS Department;
DROP TABLE IF EXISTS Room;
DROP TABLE IF EXISTS RoomType;
DROP TABLE IF EXISTS Guest;

CREATE TABLE Guest (
    guest_id INT PRIMARY KEY,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    email VARCHAR(100) UNIQUE,
    phone VARCHAR(20),
    country VARCHAR(50)
);

CREATE TABLE RoomType (
    room_type_id INT PRIMARY KEY,
    type_name VARCHAR(50) NOT NULL,
    price_per_night DECIMAL(10,2) NOT NULL,
    capacity INT NOT NULL
);

CREATE TABLE Room (
    room_id INT PRIMARY KEY,
    room_number VARCHAR(10) UNIQUE NOT NULL,
    room_type_id INT NOT NULL,
    status VARCHAR(30) NOT NULL,
    FOREIGN KEY (room_type_id) REFERENCES RoomType(room_type_id)
);

CREATE TABLE Booking (
    booking_id INT PRIMARY KEY,
    guest_id INT NOT NULL,
    check_in_date DATE NOT NULL,
    check_out_date DATE NOT NULL,
    booking_status VARCHAR(30) NOT NULL,
    FOREIGN KEY (guest_id) REFERENCES Guest(guest_id)
);

CREATE TABLE BookingRoom (
    booking_room_id INT PRIMARY KEY,
    booking_id INT NOT NULL,
    room_id INT NOT NULL,
    FOREIGN KEY (booking_id) REFERENCES Booking(booking_id),
    FOREIGN KEY (room_id) REFERENCES Room(room_id)
);

CREATE TABLE Payment (
    payment_id INT PRIMARY KEY,
    booking_id INT NOT NULL,
    payment_date DATE,
    amount DECIMAL(10,2) NOT NULL,
    payment_method VARCHAR(30),
    payment_status VARCHAR(30) NOT NULL,
    FOREIGN KEY (booking_id) REFERENCES Booking(booking_id)
);

CREATE TABLE Department (
    department_id INT PRIMARY KEY,
    department_name VARCHAR(50) NOT NULL
);

CREATE TABLE Staff (
    staff_id INT PRIMARY KEY,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    department_id INT NOT NULL,
    position VARCHAR(50),
    salary DECIMAL(10,2),
    FOREIGN KEY (department_id) REFERENCES Department(department_id)
);

CREATE TABLE Service (
    service_id INT PRIMARY KEY,
    service_name VARCHAR(50) NOT NULL,
    service_price DECIMAL(10,2) NOT NULL
);

CREATE TABLE ServiceOrder (
    service_order_id INT PRIMARY KEY,
    booking_id INT NOT NULL,
    service_id INT NOT NULL,
    quantity INT NOT NULL,
    order_date DATE,
    FOREIGN KEY (booking_id) REFERENCES Booking(booking_id),
    FOREIGN KEY (service_id) REFERENCES Service(service_id)
);

CREATE TABLE Review (
    review_id INT PRIMARY KEY,
    booking_id INT NOT NULL,
    rating INT NOT NULL,
    comment VARCHAR(255),
    review_date DATE,
    FOREIGN KEY (booking_id) REFERENCES Booking(booking_id)
);
