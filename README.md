# BusReservationSystem

## Introduction

BusReservationSystem is a dynamic web application built with Java Servlets, JSP, and SQLite. It simulates a complete bus ticket booking system where passengers can register, log in, search buses, book tickets, and view bookings, while administrators can manage buses, bookings, and users.

This project is a manual Java build (no external frameworks), designed to demonstrate MVC principles, session-based authentication, and modular database-driven development.

## Features

### Passenger (User)
- Register and log in.
- View available buses.
- Book tickets and view booking history.
- Cancel bookings.

### Administrator
- Manage buses and user accounts.
- Access a secure admin dashboard.
- Control booking records and system settings.

### System
- SQLite-based lightweight persistence (bus.db).
- JSP-based frontend with HTML/CSS/JS.
- Session management for authentication and security.

## Requirements
- Java JDK 8+
- Apache Tomcat 9+
- SQLite (with JDBC driver)

**Libraries** (already included in `WebContent/WEB-INF/lib/`):
- sqlite-jdbc-3.49.1.0.jar
- jstl-1.2.jar
- tomcat9-servlet-api.jar

## Installation & Setup

1. **Clone the Repository**
   ```
   git clone https://github.com/ackerman-sh/BusReservationSystem
   cd BusReservationSystem
   ```

2. **Database Setup**
   The SQLite database is located at:
   ```
   database/bus.db
   ```
   Ensure it is accessible to the application (default connection string points here).

3. **Build the Project**
   Since this project is built manually without Maven/Gradle:
   - Navigate to the `src` folder:
     ```
     cd src
     ```
   - Compile the Java source files with required libraries:
     ```
     javac -cp "../WebContent/WEB-INF/lib/:../WebContent/WEB-INF/classes" -d ../WebContent/WEB-INF/classes $(find . -name "*.java")
     ```

4. **Deploy on Tomcat**
   - Copy the project folder into Tomcat’s `webapps/` directory:
     ```
     cp -r ../BusReservationSystem /path/to/tomcat/webapps/
     ```
   - Start Tomcat:
     ```
     ./catalina.sh run
     ```
   - Access in browser: [http://localhost:8080/BusReservationSystem](http://localhost:8080/BusReservationSystem)

## Usage

### Passenger
- Register at `/register.jsp`
- Log in at `/login.jsp`
- Browse available buses (`home.jsp`)
- Book tickets via `TicketBookingServlet`
- Cancel bookings via `CancelBookingServlet`

### Administrator
- Log in at `/admin.jsp`
- Manage buses, users, and bookings.

## Project Structure
```
BusReservationSystem/
├── database/
│   └── bus.db                  # SQLite database
├── src/
│   ├── dao/                    # Data Access Layer
│   │   ├── BookingDAO.java
│   │   ├── BusDAO.java
│   │   └── UserDAO.java
│   ├── model/                  # Data Models
│   │   ├── Booking.java
│   │   ├── Bus.java
│   │   ├── Payment.java
│   │   └── User.java
│   └── servlets/               # Application Controllers
│       ├── AdminServlet.java
│       ├── CancelBookingServlet.java
│       ├── HomeServlet.java
│       ├── LoginServlet.java
│       ├── LogoutServlet.java
│       ├── RegisterServlet.java
│       └── TicketBookingServlet.java
├── WebContent/
│   ├── *.jsp                   # JSP pages (login, register, home, admin)
│   ├── image/                  # Static assets
│   └── WEB-INF/
│       ├── classes/             # Compiled .class files
│       ├── lib/                # Required libraries (JSTL, JDBC, Servlet API)
│       └── web.xml             # Deployment descriptor
```

## Future Enhancements
- Payment gateway integration.
- Responsive frontend (Bootstrap/Tailwind).
- REST API for mobile app integration.
- Role-based authorization with finer access controls.

⚡ **Author**: ackerman-sh
