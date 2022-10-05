                /* CREATING DATABASE */

create database sports_booking;


                /*  USING DATABASE */

use sports_booking;


               /*   CREATING TABLE members  */

create table members (
		id varchar(255) primary key,
        password1 varchar(255) not null,
        email varchar(255) not null,
        members_since timestamp default now() not null,
        payment_due decimal(6,2) not null default 0
        );

               /*    CREATING TABLE pending_terminations */
   
create table pending_terminations (
		id varchar(255) primary key,
        password1 varchar(255) not null,
        payment_due decimal(6,2) not null default 0,
        request_date timestamp not null default now()
       );  

               /* CREATING TABLE rooms */

create table rooms(
        id varchar(255) primary key,
        room_type varchar(255) not null,
        price  decimal(6,2) not null
       );

              /* CREATING TABLE bookings */

create table  bookings(
      id int primary key auto_increment,
      room_id varchar(255) not null,
      booked_date date not null,
      booked_time time not null,
      member_id varchar(255) not null,
      datetime_of_booking timestamp default now() not null,
      payment_status varchar(255) not null default 'unpaid',
      constraint uc1 unique (room_id, booked_date, booked_time)
       );


             /* ADDING FOREIGN KEY CONSTRAINTS FOR TABLES members AND rooms */

ALTER TABLE bookings
ADD CONSTRAINT fk1 FOREIGN KEY (member_id) REFERENCES
members (id) ON DELETE CASCADE ON UPDATE CASCADE,
ADD CONSTRAINT fk2 FOREIGN KEY (room_id) REFERENCES rooms
(id) ON DELETE CASCADE ON UPDATE CASCADE;

             /* INSERTING VALUES INTO members */

INSERT INTO members (id, password1, email, 
payment_due) VALUES
('nikhil', 'nikhil@123', 'nikhilchall123@gmail.com',  0),
('guna', 'guna@abc', 'sekharguna2018@gmail.com', 0),
('vinay', 'chvinay@123', 'chinnappareddy@gmail.com', 0),
('madhav', 'saimadhav@123', 'gaddesaimadhav@gmail.com', 10),
('varma', 'varma@abc', 'gandamallavarma@gmail.com', 0),
('buchi', 'buchi@123', 'chowdhary@gmail.com', 10),
('ram', 'ram@123', 'gundivenkatsai@gmail.com', 0),
('praneeth', 'praneeth@abc', 'jampulasai@gmail.com',0),
('balaji', 'saibalaji@123', 'nadakuditi@gmail.com', 0),
('satwik', 'satwik@abc', 'sangannagari@gmail.com', 0),
('maheeth', 'maheeth@abc', 'thotakura@gmail.com', 0);

             /* INSERTING VALUES INTO rooms */

INSERT INTO rooms (id, room_type, price) VALUES
('AR', 'Archery Range', 120),
('B1', 'Badminton Court', 8),
('B2', 'Badminton Court', 8),
('MPF1', 'Multi Purpose Field', 50),
('MPF2', 'Multi Purpose Field', 60),
('T1', 'Tennis Court', 10),
('T2', 'Tennis Court', 10);

             /*  INSERTING VALUES INTO bookings */

INSERT INTO bookings (id, room_id, booked_date, booked_time,
member_id, payment_status) VALUES
(1, 'AR', '2022-12-26', '13:00:00', 'nikhil', 'Paid'),
(2, 'MPF1', '2022-12-30', '17:00:00', 'guna', 'Paid'),
(3, 'T2', '2022-12-31', '16:00:00', 'vinay','Paid'),
(4, 'T1', '2022-11-05', '08:00:00', 'madhav', 'Unpaid'),
(5, 'MPF2', '2022-11-02', '11:00:00', 'varma',  'Paid'),
(6, 'B1', '2022-10-28', '16:00:00', 'buchi', 'Paid'),
(7, 'B1', '2022-10-15', '14:00:00', 'ram','Cancelled'),
(8, 'T2', '2022-10-23', '13:00:00', 'praneeth', 'Cancelled'),
(9, 'T1', '2022-11-25', '10:00:00', 'balaji', 'Unpaid'),
(10, 'B2', '2022-10-12', '15:00:00', 'satwik', 'Paid'),
(11, 'B2', '2022-11-12', '15:00:00', 'maheeth', 'Paid');

              /*   CREATING VIEW BY JOINING(INNER JOIN) OF TABLES rooms AND bookings */

create view member_bookings as 
select bookings.id,room_id , room_type,booked_date,booked_time,
member_id,datetime_of_booking,price,payment_status 
from 
bookings join rooms 
on
bookings.room_id= rooms.id
order by
bookings.id;

             /* CREATING PROCEDURE insert_new_member */

DELIMITER $$ 
CREATE PROCEDURE insert_new_member(IN p_id varchar(255),in p_password1 varchar(255) ,in  p_email varchar(255))
BEGIN 
    INSERT INTO  members (id,password1,email) VALUES
    (p_id,p_password1,p_email);
END $$ 

            /* CREATING  PROCEDURE  delete_member */
create procedure delete_member(in p_id varchar(255))
BEGIN 
    DELETE FROM members where id = p_id;
END $$ 

            /* CREATING PROCEDURE uodate_member_password1 */
 create procedure update_member_password1( in p_id varchar(255), in p_password1 varchar(255))
BEGIN 
     update members set password1 = p_password1 where id = p_id;
END $$  

            /* CREATING PROCEDURE update_member_email  */

 create procedure update_member_email( in  p_id varchar(255) , in p_email varchar(255))
BEGIN 
  update members set email = p_email where id = p_id;
END $$  

            /* CREATING PROCEDURE male_booking */

create procedure make_booking (in p_room_id varchar(255), in p_booked_date date,in p_booked_time time, in p_member_id varchar(255))
BEGIN 
    DECLARE v_price decimal(6,2);
    declare v_payment_due decimal(6,2);
    select price into v_price from rooms where id=p_room_id;
    insert into bookings (room_id, booked_date, booked_time , member_id ) values
    ( p_room_id,p_booked_date, p_booked_time , p_member_id );
    select payment_due into v_payment_due from members where id= p_member_id;
    update members set payment_due = v_payment_due+ v_price where id=p_member_id;
END $$ 

            /* CREATING PROCEDURE update_payment */

CREATE PROCEDURE update_payment(in p_id varchar(255))
BEGIN 
   declare v_member_id varchar(255);
   declare v_payment_due decimal(6,2);
   declare v_price decimal(6,2);
   update bookings set payment_status = 'paid' where id = p_id;
   select member_id ,price into v_member_id, v_price from member_bookings where id =p_id;
   SELECT payment_due INTO v_payment_due FROM members WHERE id= v_member_id;
    UPDATE members SET payment_due = v_payment_due - v_price WHERE id = v_member_id;
END $$

             /* CREATING PROCEDURE view_booking */

create procedure view_booking(in p_id varchar(255))
BEGIN 
   select * from member_booking where id = p_id;
END $$  
 CREATE PROCEDURE search_room (IN p_room_type VARCHAR(255), IN p_booked_date DATE, IN p_booked_time TIME)
BEGIN
SELECT * FROM rooms WHERE id NOT IN (SELECT room_id FROM bookings WHERE booked_date = p_booked_date AND booked_time =
p_booked_time AND payment_status != 'Cancelled') AND room_type = p_room_type;
END $$

            /* CREATING PROCEDURE cancel_booking */

CREATE PROCEDURE cancel_booking (IN p_booking_id INT, OUT
p_message VARCHAR(255))
BEGIN
DECLARE v_cancellation INT;
DECLARE v_member_id VARCHAR(255);
DECLARE v_payment_status VARCHAR(255);
DECLARE v_booked_date DATE;
DECLARE v_price DECIMAL(6, 2);
DECLARE v_payment_due VARCHAR(255);
SET v_cancellation = 0;
SELECT member_id, booked_date, price, payment_status INTO
v_member_id, v_booked_date, v_price, v_payment_status FROM
member_bookings WHERE id = p_booking_id;
SELECT payment_due INTO v_payment_due FROM members WHERE id
= v_member_id;
IF curdate() >= v_booked_date THEN
SELECT 'Cancellation cannot be done on/after the
booked date' INTO p_message;
ELSEIF v_payment_status = 'Cancelled' OR
v_payment_status = 'Paid' THEN
SELECT 'Booking has already been cancelled or
paid' INTO p_message;
ELSE
UPDATE bookings SET payment_status = 'Cancelled'
WHERE id = p_booking_id;
SET v_payment_due = v_payment_due -
v_price;
SET v_cancellation = check_cancellation
(p_booking_id);
IF v_cancellation >= 2 THEN SET v_payment_due =
v_payment_due + 10;
END IF;
UPDATE members SET payment_due = v_payment_due
WHERE id = v_member_id;
SELECT 'Booking Cancelled' INTO p_message;
END IF;
END $$

             /* CRRATING TRIGGER payment_check */

CREATE TRIGGER payment_check BEFORE DELETE ON members FOR EACH
ROW
BEGIN
DECLARE v_payment_due DECIMAL(6, 2);
SELECT payment_due INTO v_payment_due FROM members WHERE id
= OLD.id;
IF v_payment_due > 0 THEN
INSERT INTO pending_terminations (id, email,
payment_due) VALUES (OLD.id, OLD.email, OLD.payment_due);
END IF;
END $$    

            /* CREATING STORED FUNCTION check_cancellation */
                  
CREATE FUNCTION check_cancellation (p_booking_id INT) RETURNS INT
DETERMINISTIC
BEGIN
DECLARE v_done INT;
DECLARE v_cancellation INT;
DECLARE v_current_payment_status VARCHAR(255);
DECLARE cur CURSOR FOR
SELECT payment_status FROM bookings WHERE member_id =
(SELECT member_id FROM bookings WHERE id = p_booking_id) ORDER BY
datetime_of_booking DESC;
DECLARE CONTINUE HANDLER FOR NOT FOUND SET v_done = 1;
SET v_done = 0;
SET v_cancellation = 0;
OPEN cur;
cancellation_loop : LOOP
FETCH cur INTO v_current_payment_status;
IF v_current_payment_status != 'Cancelled' OR v_done =
1 THEN LEAVE cancellation_loop;
ELSE SET v_cancellation = v_cancellation + 1;
END IF;
END LOOP;
CLOSE cur;
RETURN v_cancellation;
END $$