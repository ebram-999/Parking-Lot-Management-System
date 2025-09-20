# Parking Lot Management System

This repository contains a SQL script for a Parking Lot Management System database. The script defines the database schema, including tables for Owners, Vehicles, Electric Vehicle Charging, Parking Lots, Parking Spaces, Staff, Reservations, and Payments. It also includes sample data insertion, update statements, and various SQL queries.

## Database Schema

The database is designed to manage various aspects of a parking lot, including:

- **Owners**: Information about vehicle owners.
- **Vehicles**: Details of vehicles, linked to owners.
- **ElectricVehicleCharging**: Records of electric vehicle charging sessions.
- **ParkingLot**: Information about different parking lots, including capacity and number of floors.
- **ParkingSpace**: Details of individual parking spaces within each lot.
- **Staff**: Information about parking lot staff, their roles, and assigned lots.
- **Reservation**: Records of parking space reservations.
- **Payment**: Payment details for reservations.

## Key Features

- **Comprehensive Data Model**: Covers all essential entities for a parking lot system.
- **Referential Integrity**: Uses foreign keys with `ON DELETE SET NULL`, `ON DELETE CASCADE`, and `ON UPDATE CASCADE` to maintain data consistency.
- **Data Validation**: Includes `CHECK` constraints for capacity, number of floors, and staff salaries.
- **Sample Data**: Populated with example data for testing and demonstration.
- **CRUD Operations**: Contains `INSERT`, `UPDATE`, and `DELETE` statements.
- **Query Examples**: Demonstrates various `SELECT` queries, including `JOIN` operations (INNER, LEFT), aggregate functions (`COUNT`), and nested queries.
- **Views**: Defines several views for simplified data access, such as `ActiveReservations`, `TotalPayments`, `OwnerDetails`, `VehicleDetails`, and `ChargingDetails`.

## Setup and Usage

To set up the database, execute the `ParkingLot Management System.sql` script in your SQL environment (e.g., MySQL, PostgreSQL). The script will create the tables, insert sample data, and define views.

```sql
-- Example of creating tables and inserting data
-- (Content of ParkingLot Management System.sql)
```

## ER Diagram (Conceptual)

*(An Entity-Relationship Diagram would typically be included here to visually represent the database schema. Since this is a text-based README, a textual description is provided above.)*

## Technologies Used

- SQL (Database Management System like MySQL, PostgreSQL, etc.)

## Future Enhancements

- Implement a user interface for easier interaction.
- Add more complex reporting features.
- Integrate with payment gateways for real-time transactions.


