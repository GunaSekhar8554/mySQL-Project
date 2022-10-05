/* THIS FILE CONTAINS ALL THE FINAL TESTING QUERIES */

-- NOTE : IF U WANT TO TEST THE QUERIES THE datetime_of_booking SHOULD BE AFTER THE members_since BECAUSE THE DATA TYPE OF 
-- datetime_of_booking attribute is TIMESTAMP 

SELECT * FROM members;

/*
  password1          email                                       member_since      payment_due     id 
saibalaji@123	 nadakuditi@gmail.com	                    2022-10-04 17:35:04	   110.00	     balaji
buchi@123	     chowdhary@gmail.com	                    2022-10-04 17:35:04	   20.00	     buchi
18Oct1976	     gs79732336@gmail.com	                    2022-10-05 09:38:03	   0.00	         GunaSekhar
saimadhav@123	 gaddesaimadhav@gmail.com	                2022-10-04 17:35:04	   10.00	     madhav
nikhil@123	     nikhilchall123@gmail.com	                2022-10-04 17:35:04	   0.00	         nikhil
praneeth@abc	 jampulasai@gmail.com	                    2022-10-04 17:35:04	   0.00	         praneeth
ram@123	         gundivenkatasairamakrishna@gmail.com	    2022-10-04 17:35:04	   0.00	         ram
satwik@abc	     sangannagari@gmail.com	                    2022-10-04 17:35:04	   0.00	         satwik
varma@abc	     gandamallavarma@gmail.com	                2022-10-04 17:35:04	   120.00	     varma
chvinay@123	     chinnappareddy@gmail.com	                2022-10-04 17:35:04	   0.00	         vinay
*/			

SELECT * FROM pending_terminations;

/* id      password1      payment_due     request_date
  NULL       NULL             NULL            NULL
*/

SELECT * FROM bookings;

/*
id    roomid    booking_date     booked_time     member_id     datetime_of_boooking    payment_status      
1	    AR	     2022-12-26	       13:00:00	       nikhil	    2022-10-04 17:50:10	     Paid
3	    T2	     2022-12-31	       16:00:00	       vinay	    2022-10-04 17:50:10	     Paid
4	    T1	     2022-11-05	       08:00:00	       madhav	    2022-10-04 17:50:10	     Unpaid
5	    MPF2	 2022-11-02	       11:00:00	       varma	    2022-10-04 17:50:10	     Paid
6	    B1	     2022-10-28	       16:00:00	       buchi	    2022-10-04 17:50:10	     Paid
7	    B1	     2022-10-15	       14:00:00	       ram	        2022-10-04 17:50:10	     Cancelled
8	    T2	     2022-10-23	       13:00:00	       praneeth	    2022-10-04 17:50:10	     Cancelled
9	    T1	     2022-11-25	       10:00:00	       balaji	    2022-10-04 17:50:10	     paid
10	    B2	     2022-10-12	       15:00:00	       satwik	    2022-10-04 17:50:10	     Paid
13	    AR	     2022-11-26	       13:00:00	       varma	    2022-10-05 09:48:02	     unpaid
14	    T1	     2022-10-19	       11:00:00	       buchi	    2022-10-05 09:48:32	     unpaid
15	    AR	     2022-10-19	       11:00:00	       balaji	    2022-10-05 09:49:06	     unpaid
*/						

SELECT * FROM rooms;

/*
 id     rooom_type          price
AR	  Archery Range	        120.00
B1	  Badminton Court	    8.00
B2	  Badminton Court	    8.00
MPF1  Multi Purpose Field	50.00
MPF2  Multi Purpose Field	60.00
T1	  Tennis Court	        10.00
T2	  Tennis Court	        10.00
*/		

CALL insert_new_member ('GunaSekhar', 'guna@abc','gs79732336@gmail.com');

/* CALLED insert_new_member STORED PROCEDURE TO INSERT NEW MEMBER  */

SELECT * FROM members ORDER BY members_since DESC;

/* 
id	           password1	    email	                             members_since	         payment_due
GunaSekhar	  18Oct1976	      gs79732336@gmail.com	                2022-10-05 09:38:03	       0.00
balaji	      saibalaji@123	  nadakuditi@gmail.com	                2022-10-04 17:35:04	       110.00
buchi	      buchi@123	      chowdhary@gmail.com	                2022-10-04 17:35:04	       20.00
guna          guna@abc        sekharguna2018@gmail.com              2022-10-04 17:35:04        0.00
madhav	      saimadhav@123	  gaddesaimadhav@gmail.com	            2022-10-04 17:35:04	       10.00
nikhil	      nikhil@123	  nikhilchall123@gmail.com	            2022-10-04 17:35:04	       0.00
praneeth	  praneeth@abc	  jampulasai@gmail.com	                2022-10-04 17:35:04	       0.00
ram	          ram@123	      gundivenkatasairamakrishna@gmail.com	2022-10-04 17:35:04	       0.00
satwik	      satwik@abc	  sangannagari@gmail.com	            2022-10-04 17:35:04	       0.00
varma	      varma@abc	      gandamallavarma@gmail.com	            2022-10-04 17:35:04	       120.00
vinay	      chvinay@123	  chinnappareddy@gmail.com	            2022-10-04 17:35:04	       0.00
*/				

CALL delete_member ('guna');

/* CALLED  delete_member PROCEDURE TO DELETE A MEMBER FROM member TABLE */

CALL delete_member ('maheeth');

/*  CALLED  delete_member PROCEDURE TO DELETE A MEMBER FROM member TABLE */

SELECT * FROM members;

/* SELECTING EVERY ATTRIBUTE FROM members TABLE */

SELECT * FROM pending_terminations;

/* SELECTING EVERY ATTRIBUTE FROM pending_terminations TAB;E */

CALL update_member_password1 ('GunaSekhar', '18Oct1976');

/* UPDATING p1sword1 OF EXISTING MEMBER BY CALLING update_member_password1 STORED PROCEDURE */

CALL update_member_email ('ram', 'gundivenkatasairamakrishna@gmail.com');

/* UPDATING email OF EXISTING MEMBER BY CALLING update_member_email STORED PROCEDURE */

SELECT * FROM members;

/* SELECTING EVERY ATTRIBUTE FROM members TABLE */

SELECT * FROM members WHERE id = 'madhav';

/* SELECTING EVERY ATTRIBUTE FROM members TABLE WHOSE id IS madhav */

SELECT * FROM bookings WHERE member_id = 'ram';

/* SELECTING EVERY ATTRIBUTE FROM members TABLE WHOSE id IS ram */

CALL update_payment (9);

/* UPDATING THE PAYMENT OF EXISTING MEMBER BY CALLING THE upadte_payment STORED PROCEDURE */

SELECT * FROM members WHERE id = 'ram';

/* SELECTING EVERY ATTRIBUTE FROM members TABLE WHOSE id IS ram */

SELECT * FROM bookings WHERE member_id = 'vinay';

/* SELECTING EVERY ATTRIBUTE FROM members TABLE WHOSE id IS vinay */

CALL search_room('Archery Range', '2022-12-26', '13:00:00');

/* CALLING search_room STORED PROCEDIRE */

CALL search_room('Badminton Court', '20-11-15', '14:00:00');

/* CALLING search_room STORED PROCEDIRE */

CALL search_room('Badminton Court', '2022-11-12', '15:00:00');

/* CALLING search_room STORED PROCEDIRE */

CALL make_booking ('AR', '2022-11-26', '13:00:00', 'varma');

/* CALLING make_booking STORED PROCEDURE TO MAKE A BIIKING */

CALL make_booking ('T1', CURDATE() + INTERVAL 2 WEEK, '11:00:00', 'buchi');

/* CALLING make_booking STORED PROCEDURE TO MAKE A BIIKING */

CALL make_booking ('AR', CURDATE() + INTERVAL 2 WEEK,'11:00:00', 'balaji');

/* CALLING make_booking STORED PROCEDURE TO MAKE A BIIKING */

SELECT * FROM bookings;

/* SELECTING EVERY ATTRIBUTE FROM bookings TABLE */

SELECT * FROM members;

/* SELECTING EVERY ATTRIBUTE FROM members TABLE */