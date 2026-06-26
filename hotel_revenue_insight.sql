create database hotel_rev_insights_db;
use hotel_rev_insights_db;
show databases;
ALTER TABLE dim_date
MODIFY COLUMN `date` DATE,
MODIFY COLUMN `mmm yy` VARCHAR(20),
MODIFY COLUMN `week no` VARCHAR(10),
MODIFY COLUMN day_type VARCHAR(20);

ALTER TABLE dim_hotels
MODIFY COLUMN property_id INT,
MODIFY COLUMN property_name VARCHAR(100),
MODIFY COLUMN category VARCHAR(50),
MODIFY COLUMN city VARCHAR(50);

ALTER TABLE dim_rooms
MODIFY COLUMN room_id VARCHAR(20),
MODIFY COLUMN room_class VARCHAR(50);

ALTER TABLE fact_aggregated_bookings
MODIFY COLUMN property_id INT,
MODIFY COLUMN check_in_date DATE,
MODIFY COLUMN room_category VARCHAR(20),
MODIFY COLUMN successful_bookings INT,
MODIFY COLUMN capacity INT;

ALTER TABLE fact_bookings
MODIFY COLUMN booking_id VARCHAR(50),
MODIFY COLUMN property_id INT,
MODIFY COLUMN booking_date DATE,
MODIFY COLUMN check_in_date DATE,
MODIFY COLUMN checkout_date DATE,
MODIFY COLUMN no_guests INT,
MODIFY COLUMN room_category VARCHAR(20),
MODIFY COLUMN booking_platform VARCHAR(50),
MODIFY COLUMN ratings_given FLOAT,
MODIFY COLUMN booking_status VARCHAR(50),
MODIFY COLUMN revenue_generated FLOAT,
MODIFY COLUMN revenue_realized FLOAT;


ALTER TABLE dim_date
ADD PRIMARY KEY (`date`);

ALTER TABLE dim_hotels
ADD PRIMARY KEY (property_id);

ALTER TABLE dim_rooms
ADD PRIMARY KEY (room_id);



ALTER TABLE fact_bookings
ADD CONSTRAINT fk_fb_hotel
FOREIGN KEY (property_id)
REFERENCES dim_hotels(property_id);

ALTER TABLE fact_bookings
ADD CONSTRAINT fk_fb_date
FOREIGN KEY (check_in_date)
REFERENCES dim_date(`date`);

ALTER TABLE fact_aggregated_bookings
ADD CONSTRAINT fk_fab_hotel
FOREIGN KEY (property_id)
REFERENCES dim_hotels(property_id);

ALTER TABLE fact_aggregated_bookings
ADD CONSTRAINT fk_fab_date
FOREIGN KEY (check_in_date)
REFERENCES dim_date(`date`);

ALTER TABLE fact_bookings
ADD CONSTRAINT fk_fb_room
FOREIGN KEY (room_category)
REFERENCES dim_rooms(room_id);

ALTER TABLE fact_aggregated_bookings
ADD CONSTRAINT fk_fab_room
FOREIGN KEY (room_category)
REFERENCES dim_rooms(room_id);