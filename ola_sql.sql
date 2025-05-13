# 1)retrive all successful bookings
create view successful_bookings as
select * from ola_details where Booking_Status="Success"
seLECT* from successfull_bookings

# 2)Find the average ride distance for each vehicle type
SELECT Vehicle_Type,avg(Ride_Distance) as avg_ride from ola_details GROUP by Vehicle_Type
 
# 3)top 5 customer who booked highest number rides
 SELECT Customer_ID,count(1) as c from ola_details GROUP by Customer_ID order by c DESC limit 5

# 4) identify peak ride request hour sfor each vehivle type on weekends
with cte as (SELECT Vehicle_Type,hour(Time) as hour ,count(hour(Time)) as "number of time request per hour" ,rank() over(PARTITION by Vehicle_Type order by `number of time request per hour` DESC) as rank from ola_details where dayname(date) in ("Sunday","Saturday")  group by Vehicle_Type,hour )
SELECT * from cte where rank<4 ORDER by Vehicle_Type , rank

# 5)Find the cancellation rate by driver per vehiclet type
SELECT Vehicle_Type , COUNT(CASE when Booking_Status="Canceled by Driver" then 1 END)*100/count(*) as cancel_rate_by_driver from ola_details GROUP by Vehicle_Type

# 6)Out of all bookings that were cancelled by drivers, what proportion came from each vehicle type
SELECT Vehicle_Type,count(*)*100/(SELECT count(*) from ola_details where Booking_Status="Canceled by Driver") from ola_details WHERE Booking_Status="Canceled by Driver" GROUP by Vehicle_Type

# 7)Detect anomalies :booking where  v_TAT or C_TAT>30 minutes
SELECT * from ola_details where V_TAT>=30 or C_TAT>=30

# 8)Find customer with the highest cancellation rate
SELECT Customer_ID,count(CASE WHEn Booking_Status="Canceled by Customer"  then 1 END)*100/count(*) as cancel_rating  from ola_details GROUP BY Customer_ID order by cancel_rating DESC

  #below query is slow compared to above one
CREATE view cancel_vs_total_booking as
with cancel_booking as (SELECT Customer_ID ,COUNT(Customer_ID) as count from ola_details where Booking_Status="Canceled by Customer" group by Customer_ID ),
total_booking as (SELECT Customer_ID,COUNT(Customer_ID) as COUNT from ola_details GROUP by Customer_ID)
SELECT cb.Customer_ID,cb.count as cancel_count,t.count  as total_count from Cancel_booking as cb join total_booking as t on cb.customer_id=t.customer_id

SELECT customer_id,cancel_count*100/total_count as cancel_rate from cancel_vs_total_booking

# 9) Setect unusually low-rated successful rides(customer_rating<3.5 or driver_rating<3.5)
SELECT * from ola_details WHERE Booking_Status = "Success"  and (Customer_Rating<3.5 or Driver_Ratings<3.5)

# 10)Find average booking value per k for each vehicle type
SELECT Vehicle_Type,avg(Booking_Value/Ride_Distance) as "average price per km"  from ola_details where Booking_Status="Success" GROUP by Vehicle_Type

# 11)detect pickup-drop pairs with high cancellation rates
SELECT Pickup_Location,Drop_Location,count(*) as total_bookings,count(CASE when Booking_Status="Canceled by Driver" or Booking_Status="Canceled by Customer" then 1 END) as cancelled, count(CASE when Booking_Status="Canceled by Driver" or Booking_Status="Canceled by Customer" then 1 END)*100/count(*) as cancel_rate from ola_details  GROUP by Pickup_Location,Drop_Location order by cancel_rate DESC

# 12)calculate avearage VTAT and CTAT by vehicle and time of day block(morning/afternoon/Evening/Night)
SELECT Vehicle_Type,
case
    when hour(Time)<12 and hour(time)>4 then "Morning"
    WHEN hour(Time)>=12 and hour(time)<17 then "Afternoon"
    WHEN hour(Time)>=17 and hour(time)<20 then "Evening"
    WHEN hour(Time)>=20 and hour(time)<=24 then "Night"
    WHEN hour(Time)>=0 and hour(time)<=4 then "Night"
     end as "day_block",round(avg(V_TAT),2) as avg_VTAT,round(avg(C_TAT),2) as avg_CTAT  from ola_details WHERE Booking_Status="Success" group by Vehicle_Type,day_block

# 13)identify vehicle types that frequently result in incomplete rides
SELECT Vehicle_Type,count(*) from ola_details where Incomplete_Rides="Yes" GROUP BY Vehicle_Type
