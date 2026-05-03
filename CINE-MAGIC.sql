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

-- Thêm 4 bộ phim (có 1 phim giới hạn 18 tuổi)
INSERT INTO movies (title, duration_minutes, age_restriction) VALUES
(N'Avengers: Secret Wars', 150, 13),
(N'Dune: Part Two', 165, 16),
(N'Inside Out 2', 120, 0),
(N'Joker: Folie à Deux', 140, 18);

-- Thêm 3 phòng chiếu (1 phòng bảo trì)
INSERT INTO rooms (name, max_seats, status) VALUES
(N'Phòng 1', 120, 'active'),
(N'Phòng 2', 100, 'active'),
(N'Phòng 3', 80, 'maintenance');

-- Thêm 5 lịch chiếu (không xếp vào phòng bảo trì)
INSERT INTO showtimes (movie_id, room_id, show_time, ticket_price) VALUES
(1, 1, '2026-05-02 09:00:00', 90000),
(2, 2, '2026-05-02 14:00:00', 95000),
(3, 1, '2026-05-02 16:30:00', 80000),
(4, 2, '2026-05-02 19:00:00', 100000),
(1, 1, '2026-05-03 10:00:00', 90000);

-- Thêm 10 vé đặt rải rác cho các lịch chiếu khác nhau
INSERT INTO bookings (showtime_id, customer_name, phone) VALUES
(1, N'Nguyễn Văn A', '0901234567'),
(1, N'Trần Thị B', '0912345678'),
(2, N'Lê Văn C', '0923456789'),
(2, N'Phạm Thị D', '0934567890'),
(3, N'Hoàng Văn E', '0945678901'),
(3, N'Đỗ Thị F', '0956789012'),
(4, N'Ngô Văn G', '0967890123'),
(4, N'Vũ Thị H', '0978901234'),
(5, N'Bùi Văn I', '0989012345'),
(5, N'Đặng Thị K', '0990123456');

UPDATE rooms
SET status = 'maintenance'
WHERE id = 1;

UPDATE showtimes
SET room_id = 2
WHERE room_id = 1;


DELETE FROM bookings
WHERE phone = '0987654321';

DELETE FROM bookings
WHERE showtime_id IN (SELECT id FROM showtimes WHERE movie_id = 3);

DELETE FROM showtimes
WHERE movie_id = 3;


DELETE FROM movies
WHERE id = 3;


SELECT id, title, duration_minutes
FROM movies
WHERE duration_minutes BETWEEN 90 AND 120;

SELECT id, customer_name, phone, booking_date
FROM bookings
WHERE showtime_id = 2
ORDER BY booking_date DESC;

SELECT id, title, duration_minutes, age_restriction
FROM movies
WHERE age_restriction = 18 OR duration_minutes > 150;

SELECT id, movie_id, room_id, show_time, ticket_price
FROM showtimes
WHERE ticket_price > 100000
  AND MONTH(show_time) = MONTH(CURRENT_DATE)
  AND YEAR(show_time) = YEAR(CURRENT_DATE);

