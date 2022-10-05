# mySQL Project 


About the Project:
        
              This project requires us to build a simple database to help us manage the booking process of a sports complex. The sports complex has the followingfacilities: 2 tennis courts, 2 badminton courts, 2 multi-purpose fields and 1 archery range. Each facility can be booked for a duration of one hour.Only registered users are allowed to make a booking. After booking, the complex allows users to cancel their bookings latest by the day prior to thebooked date. Cancellation is free. However, if this is the third (or more)consecutive cancellations, the complex imposes a $10 fine.

              
The database that we build should have the following elements:

             Tables:
                members
                pending_terminations
                rooms
                bookings

             View:
                member_bookings

             Stored Procedures:
                insert_new_member
                delete_member
                update_member_password
                update_member_email
                make_booking
                update_payment
                view_bookings
                search_room
                cancel_booking

             Trigger:
                payment_check

             Stored Function:
                check_cancellation

NOTE : For quering the database install mySQL workbench and copy paste the sportsDB,test file into the mySQL workbench or 
       clone the repository into the VS Code by finding the suitable mySQL extension in VS Code.              
    
 
