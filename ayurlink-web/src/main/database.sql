CREATE DATABASE ayurvedadb;
DROP DATABASE ayurvedadb;

USE ayurvedadb;

CREATE TABLE users (
    id BIGINT AUTO_INCREMENT PRIMARY KEY,
    username VARCHAR(100) NOT NULL UNIQUE,
    password VARCHAR(255) NOT NULL,
    email VARCHAR(150) NOT NULL,
    phone VARCHAR(20) NOT NULL,
    role VARCHAR(50) NOT NULL,
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
    is_active BOOLEAN DEFAULT TRUE
);

CREATE TABLE admins (
    user_id BIGINT PRIMARY KEY,
    full_name VARCHAR(150) NOT NULL,
    is_super_admin BOOLEAN DEFAULT FALSE,
    FOREIGN KEY (user_id) REFERENCES users(id)
);
CREATE TABLE treatments (
    id BIGINT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    description TEXT,
    cost DECIMAL(10,2) NOT NULL,
    duration INT,
    image VARCHAR(255),
    suitable_for VARCHAR(255),
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
    is_active BOOLEAN DEFAULT TRUE
);
CREATE TABLE patients (
    user_id BIGINT PRIMARY KEY,
    nic VARCHAR(20) NOT NULL UNIQUE,
    full_name VARCHAR(150) NOT NULL,
    address VARCHAR(255),
    age INT,
    gender VARCHAR(20),
    medical_history TEXT,
    FOREIGN KEY (user_id) REFERENCES users(id));
    
    CREATE TABLE appointments (
    id BIGINT AUTO_INCREMENT PRIMARY KEY,
    patient_id BIGINT NOT NULL,
    doctor_id BIGINT NOT NULL,
    treatment_id BIGINT NOT NULL,
    appointment_date DATE NOT NULL,
    appointment_time TIME NOT NULL,
    ticket_number VARCHAR(50) NOT NULL UNIQUE,
    status VARCHAR(20) NOT NULL,
    notes TEXT,
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (patient_id) REFERENCES patients(user_id),
    FOREIGN KEY (doctor_id) REFERENCES doctors(user_id),
    FOREIGN KEY (treatment_id) REFERENCES treatments(id)
);

CREATE TABLE doctors (
    user_id BIGINT PRIMARY KEY,
    full_name VARCHAR(150) NOT NULL,
    specialization VARCHAR(100) NOT NULL,
    license_number VARCHAR(50) UNIQUE,
    consultation_fee DECIMAL(10,2),
    bio TEXT,
    FOREIGN KEY (user_id) REFERENCES users(id)
);
CREATE TABLE doctor_availability (
    id BIGINT AUTO_INCREMENT PRIMARY KEY,
    doctor_id BIGINT NOT NULL,
    availability VARCHAR(50),
    FOREIGN KEY (doctor_id) REFERENCES doctors(user_id)
);
CREATE TABLE doctor_earnings (
    id BIGINT AUTO_INCREMENT PRIMARY KEY,
    doctor_id BIGINT NOT NULL,
    payment_id BIGINT NOT NULL,
    gross_amount DOUBLE NOT NULL,
    admin_charge DOUBLE NOT NULL,
    net_earning DOUBLE NOT NULL,
    doctor_fee DOUBLE NOT NULL,
    treatment_fee DOUBLE NOT NULL,
    status VARCHAR(50) NOT NULL DEFAULT 'PENDING',
    payment_date DATETIME,
    settlement_date DATETIME,
    settlement_reference VARCHAR(100),
    notes TEXT,
    created_at DATETIME,
    updated_at DATETIME,
    UNIQUE KEY unique_payment_id (payment_id),
    FOREIGN KEY (doctor_id) REFERENCES doctors(id),
    FOREIGN KEY (payment_id) REFERENCES payments(id)
);
CREATE TABLE payments (
    id BIGINT AUTO_INCREMENT PRIMARY KEY,
    appointment_id BIGINT NOT NULL UNIQUE,
    doctor_fee DECIMAL(10,2) NOT NULL,
    treatment_fee DECIMAL(10,2) NOT NULL,
    clinic_charges DECIMAL(10,2) NOT NULL DEFAULT 500.0,
    total_amount DECIMAL(10,2) NOT NULL,
    payment_method VARCHAR(50) NOT NULL,
    status VARCHAR(50) NOT NULL DEFAULT 'PENDING',
    transaction_id VARCHAR(100) UNIQUE,
    payment_date DATETIME,
    receipt_file_path VARCHAR(500),
    receipt_file_name VARCHAR(255),
    receipt_upload_date DATETIME,
    receipt_verified BOOLEAN DEFAULT FALSE,
    verified_by VARCHAR(100),
    verification_date DATETIME,
    refund_amount DECIMAL(10,2),
    refund_date DATETIME,
    refund_reason TEXT,
    payment_notes TEXT,
    receipt_number VARCHAR(100) UNIQUE,
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
    updated_at DATETIME,
    FOREIGN KEY (appointment_id) REFERENCES appointments(id)
);

CREATE TABLE admin_charges (
    id BIGINT AUTO_INCREMENT PRIMARY KEY,
    payment_id BIGINT NOT NULL,
    clinic_charge DOUBLE NOT NULL,
    total_payment_amount DOUBLE NOT NULL,
    doctor_earning DOUBLE NOT NULL,
    treatment_name VARCHAR(255),
    doctor_name VARCHAR(255),
    patient_name VARCHAR(255),
    status VARCHAR(50) NOT NULL DEFAULT 'COLLECTED',
    charge_date DATETIME,
    notes TEXT,
    created_at DATETIME,
    updated_at DATETIME,
    UNIQUE KEY unique_payment_id (payment_id),
    FOREIGN KEY (payment_id) REFERENCES payments(id)
);










