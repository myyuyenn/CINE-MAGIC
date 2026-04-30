-- Bảng phim
CREATE TABLE movies (
    id INT PRIMARY KEY AUTO_INCREMENT,
    title NVARCHAR(200) NOT NULL,
    duration_minutes INT CHECK (duration_minutes > 0),
    age_restriction INT DEFAULT 0 CHECK (age_restriction IN (0,13,16,18))
);

-- Bảng phòng chiếu
CREATE TABLE rooms (
    id INT PRIMARY KEY AUTO_INCREMENT,
    name NVARCHAR(100) NOT NULL,
    max_seats INT CHECK (max_seats > 0),
    status VARCHAR(20) DEFAULT 'active' CHECK (status IN ('active','maintenance'))
);

-- Bảng suất chiếu
CREATE TABLE showtimes (
    id INT PRIMARY KEY AUTO_INCREMENT,
    movie_id INT NOT NULL,
    room_id INT NOT NULL,
    show_time DATETIME NOT NULL,
    ticket_price DECIMAL(10,2) CHECK (ticket_price >= 0),
    CONSTRAINT FK_Showtimes_Movie FOREIGN KEY (movie_id) REFERENCES movies(id),
    CONSTRAINT FK_Showtimes_Room FOREIGN KEY (room_id) REFERENCES rooms(id)
);

-- Bảng đặt vé
CREATE TABLE bookings (
    id INT PRIMARY KEY AUTO_INCREMENT,
    showtime_id INT NOT NULL,
    customer_name NVARCHAR(100) NOT NULL,
    phone VARCHAR(15),
    booking_date DATETIME DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT FK_Bookings_Showtime FOREIGN KEY (showtime_id) REFERENCES showtimes(id)
);
