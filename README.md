# OLA Data Analysis Project

This project analyzes a simulated dataset of 40,000 OLA ride bookings from July  using **SQL** and **Power BI**.  
It covers key business questions related to ride volume, cancellations, customer behavior, operational efficiency, and revenue insights.

## Tools Used
- SQL (MySQL)
- Power BI
- Excel (data preprocessing)
- Word (report documentation)

## Dataset Overview
The dataset includes:
- 40,000 rows
- 20+ fields such as `Date`, `Time`, `Booking Status`, `Vehicle Type`, `Pickup & Drop Location`, `VTAT`, `CTAT`, `Booking Value`, and Ratings.

## Key SQL Questions Solved
1. Retrieve all successful bookings
2. Find average ride distance per vehicle type
3. Identify top 5 customers by number of bookings
4. Peak ride request hours for each vehicle on weekends
5. Cancellation rate by driver per vehicle type
6. Share of each vehicle in total driver cancellations
7. Anomalies: VTAT or CTAT > 30 minutes
8. Customers with highest cancellation rate
9. Unusually low-rated rides (Customer/Driver rating < 3.5)
10. Avg. booking value per km by vehicle
11. High-cancellation pickup-drop pairs
12. Avg. VTAT/CTAT by time block (Morning, Afternoon, Evening, Night)
13. Vehicle types with most incomplete rides

## Power BI Insights
- Ride volume trends over time
- Booking status breakdown (success, cancelled, incomplete)
- Customer vs. driver rating comparisons
- Revenue by vehicle type and payment method
- Cancellation reasons (customer and driver)
- Top customers by total booking value

## Project Highlights
- Solved **13+ real-world business queries** using advanced SQL techniques (CTEs, CASE, window functions)
- Built a clear and interactive **Power BI dashboard**
- Generated actionable insights for fleet planning, cancellation reduction, and customer experience

## Project Files
- [`OLA_Project_Report.docx`](./OLA_Project_Report.docx) – Full report with explanations and insights
- `/SQL/queries.sql` – All SQL queries used
- `/PowerBI/dashboard.pbix` – Power BI dashboard file

## Conclusion
This project showcases how SQL and Power BI can be used together to extract valuable insights from mobility platform data, aiding in better operational and customer experience decisions.
