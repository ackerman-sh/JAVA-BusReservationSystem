<%@ page import="model.Booking" %>
<%@ page import="java.util.List" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page import="model.User, model.Booking, java.util.List" %>

<%
    User user = (User) session.getAttribute("user");
    if (user == null) {
        response.sendRedirect("login.jsp");
        return;
    }   
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Dashboard - Bus Reservation System</title>
    <!-- Tailwind CSS CDN -->
    <script src="https://cdn.tailwindcss.com"></script>
    <!-- Font Awesome for Icons -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.2/css/all.min.css">
    <style>
        /* Custom Font */
        @import url('https://fonts.googleapis.com/css2?family=Inter:wght@300;400;600;700&display=swap');
        body {
            font-family: 'Inter', sans-serif;
            background-color: #1f2937; /* bg-gray-900 */
        }
        /* Animations */
        @keyframes cascadeIn {
            from { transform: translateY(30px) scale(0.95); opacity: 0; }
            to { transform: translateY(0) scale(1); opacity: 1; }
        }
        @keyframes typewriter {
            from { width: 0; }
            to { width: 100%; }
        }
        @keyframes blinkCaret {
            50% { border-color: transparent; }
        }
        @keyframes subtleGlow {
            0% { box-shadow: 0 0 5px rgba(45, 212, 191, 0.3); }
            50% { box-shadow: 0 0 10px rgba(45, 212, 191, 0.5); }
            100% { box-shadow: 0 0 5px rgba(45, 212, 191, 0.3); }
        }
        @keyframes progressRing {
            to { stroke-dashoffset: 0; }
        }
        .animate-cascade-in {
            animation: cascadeIn 0.6s ease-out forwards;
        }
        .animate-typewriter {
            overflow: hidden;
            white-space: nowrap;
            animation: typewriter 2s steps(40, end) forwards, blinkCaret 0.75s step-end infinite;
            border-right: 2px solid #2dd4bf;
        }
        .animate-subtle-glow {
            animation: subtleGlow 2s infinite ease-in-out;
        }
        /* Glassmorphic Card */
        .glassmorphic {
            background: rgba(255, 255, 255, 0.05);
            backdrop-filter: blur(10px);
            border: 1px solid rgba(255, 255, 255, 0.1);
            box-shadow: 0 4px 30px rgba(0, 0, 0, 0.2);
        }
        /* Wave Background */
        .wave-bg {
            position: fixed;
            bottom: 0;
            left: 0;
            width: 100%;
            height: 200px;
            background: url('data:image/svg+xml;utf8,<svg viewBox="0 0 1440 320" xmlns="http://www.w3.org/2000/svg"><path fill="%232dd4bf" fill-opacity="0.3" d="M0,224L80,213.3C160,203,320,181,480,181.3C640,181,800,203,960,213.3C1120,224,1280,224,1360,224L1440,224L1440,320L1360,320C1280,320,1120,320,960,320C800,320,640,320,480,320C320,320,160,320,80,320L0,320Z"></path></svg>') repeat-x;
            animation: wave 10s linear infinite;
            z-index: -1;
        }
        @keyframes wave {
            0% { background-position: 0 0; }
            100% { background-position: 1440px 0; }
        }
        /* Cursor Trail */
        .cursor-trail {
            position: fixed;
            width: 8px;
            height: 8px;
            background: rgba(45, 212, 191, 0.5);
            border-radius: 50%;
            pointer-events: none;
            transition: transform 0.3s ease;
            z-index: 1000;
        }
        /* Parallax Tilt */
        .tilt {
            transition: transform 0.2s ease;
        }
        /* Progress Ring */
        .progress-ring circle {
            stroke: #2dd4bf;
            stroke-dasharray: 283;
            stroke-dashoffset: 283;
            transition: stroke-dashoffset 1s ease;
        }
        .loading .progress-ring circle {
            animation: progressRing 1s ease forwards;
        }
        /* Smooth Transitions */
        input, button {
            transition: all 0.3s ease;
        }
        input:focus {
            transform: scale(1.02);
            box-shadow: 0 0 8px rgba(45, 212, 191, 0.4);
        }
        button:hover {
            transform: translateY(-2px);
            box-shadow: 0 0 12px rgba(45, 212, 191, 0.5);
        }
        /* Navbar */
        .navbar {
            background: rgba(255, 255, 255, 0.05);
            backdrop-filter: blur(10px);
            border-bottom: 1px solid rgba(255, 255, 255, 0.1);
            padding: 15px 30px;
            display: flex;
            justify-content: space-between;
            align-items: center;
            position: sticky;
            top: 0;
            z-index: 1000;
        }
        .profile-btn {
            background: none;
            border: none;
            color: #e5e7eb;
            font-size: 16px;
            cursor: pointer;
            display: flex;
            align-items: center;
            gap: 8px;
        }
        .profile-dropdown {
            display: none;
            position: absolute;
            top: 50px;
            left: 0;
            background: rgba(255, 255, 255, 0.05);
            backdrop-filter: blur(10px);
            border: 1px solid rgba(255, 255, 255, 0.1);
            padding: 15px;
            border-radius: 8px;
            width: 200px;
            z-index: 1000;
            color: #e5e7eb;
        }
        .profile-dropdown p {
            margin-bottom: 8px;
            font-size: 14px;
        }
        .nav-buttons button {
            background: #2dd4bf;
            color: white;
            border: none;
            padding: 10px 15px;
            border-radius: 8px;
            font-size: 16px;
            cursor: pointer;
            margin: 0 5px;
            display: inline-flex;
            align-items: center;
            gap: 8px;
        }
        .logout-btn {
            background: #ef4444;
            color: white;
            border: none;
            padding: 8px 15px;
            border-radius: 8px;
            cursor: pointer;
        }
        /* Panels */
        .panel {
            margin: 20px auto;
            padding: 20px;
            width: 80%;
            max-width: 1200px;
            border-radius: 8px;
            opacity: 0;
        }
        .panel h2 {
            color: #2dd4bf;
            font-size: 2em;
            margin-bottom: 20px;
            text-align: center;
        }
        .panel p {
            color: #9ca3af;
            font-size: 16px;
            line-height: 1.8;
        }
        /* Filter Section */
        .filter-container {
            padding: 20px;
            border-radius: 8px;
            display: flex;
            flex-wrap: wrap;
            justify-content: space-between;
            gap: 20px;
        }
        .filter-group {
            width: 48%;
            margin-bottom: 20px;
        }
        .filter-group label {
            font-weight: 600;
            color: #e5e7eb;
            font-size: 12px;
            display: block;
            margin-bottom: 5px;
        }
        .filter-group input {
            width: 100%;
            padding: 8px;
            background: rgba(255, 255, 255, 0.05);
            border: 1px solid #374151;
            border-radius: 5px;
            font-size: 14px;
            color: #e5e7eb;
            transition: border-color 0.3s ease;
        }
        .filter-group input:focus {
            border-color: #2dd4bf;
            outline: none;
        }
        .filter-group input::placeholder {
            color: #6b7280;
        }
        .results-title {
            font-size: 1.5em;
            color: #2dd4bf;
            font-weight: bold;
            margin: 20px 0;
        }
        /* Bus List */
        #busesList {
            display: flex;
            flex-wrap: wrap;
            justify-content: space-between;
            gap: 20px;
        }
        .bus {
            border-radius: 8px;
            padding: 15px;
            width: 100%;
            max-width: 280px;
            text-align: center;
            transition: transform 0.3s ease;
        }
        .bus:hover {
            transform: translateY(-5px);
        }
        .bus h3 {
            font-size: 1.5em;
            color: #2dd4bf;
            margin: 10px 0;
        }
        .bus p {
            font-size: 14px;
            color: #9ca3af;
            margin: 5px 0;
        }
        .bus .fare {
            font-size: 1.2em;
            font-weight: bold;
            color: #2dd4bf;
        }
        .book-button {
            background: #2dd4bf;
            color: white;
            border: none;
            border-radius: 8px;
            padding: 10px;
            font-size: 16px;
            cursor: pointer;
            width: 100%;
            margin-top: 10px;
        }
        .book-button:hover {
            background: #26a69a;
        }
        /* Seat Selection */
        #SeatBookingOverlay {
            position: fixed;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            background: rgba(0, 0, 0, 0.7);
            display: none;
            justify-content: center;
            align-items: center;
            z-index: 9999;
        }
        #SeatBookingContent {
            padding: 20px;
            border-radius: 8px;
            width: 90%;
            max-width: 400px;
            text-align: center;
        }
        .seat {
            width: 40px;
            height: 40px;
            border-radius: 5px;
            text-align: center;
            line-height: 40px;
            font-size: 14px;
            cursor: pointer;
            margin: 5px;
            display: inline-block;
        }
        .available {
            background: rgb(2, 252, 23);
            color: white;
        }
        .occupied {
            background: red;
            color: #d1d5db;
            cursor: not-allowed;
        }
        .selected {
            background: #2dd4bf !important;
            color: white;
        }
        .row {
            margin: 10px 0;
        }
        #TicketBooking {
            position: fixed;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            background: rgba(0, 0, 0, 0.7);
            display: none;
            justify-content: center;
            align-items: center;
            z-index: 9999;
        }
        #TicketSuccess {
            position: fixed;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            background: rgba(0, 0, 0, 0.7);
            display: none;
            justify-content: center;
            align-items: center;
            z-index: 9999;
        }
        #TicketSuccessContent {
            padding: 20px;
            border-radius: 8px;
            width: 90%;
            max-width: 400px;
            text-align: center;
        }
        #TicketBookingContent {
            padding: 20px;
            border-radius: 8px;
            width: 90%;
            max-width: 400px;
            text-align: center;
        }
        /* Responsive Design */
        @media screen and (max-width: 768px) {
            .filter-group {
                width: 100%;
            }
            .filter-container {
                flex-direction: column;
            }
            .panel {
                width: 90%;
            }
            .bus {
                max-width: 100%;
            }
        }
        /* Initial Hidden State */
        .form-element {
            opacity: 0;
        }
        /* Table Styles */
        .booking-table {
            width: 100%;
            border-collapse: collapse;
            margin-top: 20px;
        }
        .booking-table th, .booking-table td {
            padding: 10px;
            text-align: left;
            color: #e5e7eb;
            border-bottom: 1px solid rgba(255, 255, 255, 0.1);
        }
        .booking-table th {
            background: rgba(45, 212, 191, 0.1);
            color: #2dd4bf;
        }
        .cancel-btn {
            background: #ef4444;
            color: white;
            border: none;
            padding: 5px 10px;
            border-radius: 5px;
            cursor: pointer;
        }
        .cancel-btn:hover {
            background: #dc2626;
        }
        #busNameFilter::placeholder,
        #sourceFilter::placeholder,
        #destinationFilter::placeholder,
        #fareFilter::placeholder,
        #availableSeatsFilter::placeholder {
            padding-left: 5%;
        }
    </style>
</head>
<body class="min-h-screen">
    <!-- Wave Background -->
    <div class="wave-bg"></div>

    <div class="navbar glassmorphic animate-cascade-in">
        <div class="nav-left">
            <button class="profile-btn" id="profileButton" onclick="toggleDropdown()">
                <i class="fas fa-user-circle"></i> Profile
            </button>
            <div class="profile-dropdown glassmorphic" id="profileDropdown">
                <p><strong>Username:</strong> <%= user.getUsername() %></p>
                <p><strong>Email:</strong> <%= user.getEmail() %></p>
                <p><strong>Role:</strong> <%= user.getRole() %></p>
            </div>
        </div>
        <div class="nav-buttons">
            <button onclick="showPanel('home-panel')">
                <i class="fas fa-home"></i> Home
            </button>
            <button onclick="showPanel('search-panel')">
                <i class="fas fa-search"></i> Fetch Bus Details
            </button>
            <button onclick="showPanel('history-panel')">
                <i class="fas fa-history"></i> Booking History
            </button>
            <button onclick="showPanel('mytrip-panel')">
                <i class="fas fa-suitcase"></i> My Trip
            </button>
        </div>
        <a href="logout">
            <button class="logout-btn animate-subtle-glow">
                <i class="fas fa-sign-out-alt"></i> Logout
            </button>
        </a>
    </div>

    <div class="container" style="margin-left: 10%;">
        <div class="panel glassmorphic tilt animate-cascade-in" id="home-panel">
            <h2 class="form-element" style="animation-delay: 0.2s;">
                <span class="animate-typewriter inline-block">Welcome, <%= user.getUsername() %>!</span>
            </h2>
            <hr class="border-gray-700 my-4">
            <p class="text-gray-400 form-element" style="animation-delay: 0.3s;">
                The Bus Reservation System is a web-based application designed to simplify and automate the process of booking bus tickets. It allows users to search for available buses, select seats, and confirm bookings with real-time updates. Admins can manage buses, routes, schedules, and monitor all bookings through a secure dashboard. The system reduces manual work, improves efficiency, and ensures accurate record-keeping for both passengers and operators.
            </p>
            <p class="text-gray-400 mt-4 form-element" style="animation-delay: 0.4s;">
                Use the navigation bar to explore and manage your bookings.
            </p>
        </div>

        <div class="panel glassmorphic tilt animate-cascade-in" id="search-panel" style="display:none;">
            <h2 class="form-element" style="animation-delay: 0.2s;">
                <span class="animate-typewriter inline-block">Available Buses</span>
            </h2>
            <div class="filter-container glassmorphic form-element" style="animation-delay: 0.3s;">
                <div class="filter-group">
                    <label for="busNameFilter">Bus Name</label>
                    <div class="relative">
                        <i class="fas fa-bus absolute left-4 top-1/2 transform -translate-y-1/2 text-teal-400"></i>
                        <input type="text" id="busNameFilter" onkeyup="filterResults()" style="padding-left: 10px;" placeholder="Enter bus name" class="w-full pl-12 p-3 bg-gray-800/50 text-gray-200 border border-gray-700 rounded-lg focus:ring-teal-400 focus:border-teal-400 animate-subtle-glow">
                    </div>
                </div>
                <div class="filter-group">
                    <label for="sourceFilter">Source</label>
                    <div class="relative">
                        <i class="fas fa-map-marker-alt absolute left-4 top-1/2 transform -translate-y-1/2 text-teal-400"></i>
                        <input type="text" id="sourceFilter" onkeyup="filterResults()" placeholder="Enter source" class="w-full pl-12 p-3 bg-gray-800/50 text-gray-200 border border-gray-700 rounded-lg focus:ring-teal-400 focus:border-teal-400 animate-subtle-glow">
                    </div>
                </div>
                <div class="filter-group">
                    <label for="destinationFilter">Destination</label>
                    <div class="relative">
                        <i class="fas fa-map-marker-alt absolute left-4 top-1/2 transform -translate-y-1/2 text-teal-400"></i>
                        <input type="text" id="destinationFilter" onkeyup="filterResults()" placeholder="Enter destination" class="w-full pl-12 p-3 bg-gray-800/50 text-gray-200 border border-gray-700 rounded-lg focus:ring-teal-400 focus:border-teal-400 animate-subtle-glow">
                    </div>
                </div>
                <div class="filter-group">
                    <label for="fareFilter">Fare</label>
                    <div class="relative">
                        <i class="fas fa-rupee-sign absolute left-4 top-1/2 transform -translate-y-1/2 text-teal-400"></i>
                        <input type="number" id="fareFilter" onkeyup="filterResults()" placeholder="Enter fare" class="w-full pl-12 p-3 bg-gray-800/50 text-gray-200 border border-gray-700 rounded-lg focus:ring-teal-400 focus:border-teal-400 animate-subtle-glow">
                    </div>
                </div>
                <div class="filter-group">
                    <label for="availableSeatsFilter">Available Seats</label>
                    <div class="relative">
                        <i class="fas fa-chair absolute left-4 top-1/2 transform -translate-y-1/2 text-teal-400"></i>
                        <input type="number" id="availableSeatsFilter" onkeyup="filterResults()" placeholder="Enter seats" class="w-full pl-12 p-3 bg-gray-800/50 text-gray-200 border border-gray-700 rounded-lg focus:ring-teal-400 focus:border-teal-400 animate-subtle-glow">
                    </div>
                </div>
            </div>
            <h3 class="results-title form-element" style="animation-delay: 0.4s;">Search Results</h3>
            <div id="busesList" class="form-element" style="animation-delay: 0.5s;">
                <c:forEach var="bus" items="${buses}">
                    <div class="bus glassmorphic tilt">
                        <h3 class="bus-name">${bus.busName}</h3>
                        <p class="bus-type">Type: ${bus.busType}</p>
                        <p class="source">Source: ${bus.source}</p>
                        <p class="destination">Destination: ${bus.destination}</p>
                        <p class="departure-time">Departure: ${bus.departureTime}</p>
                        <p class="arrival-time">Arrival: ${bus.arrivalTime}</p>
                        <p class="journey-duration">Journey Duration: ${bus.journeyDuration}</p>
                        <p class="travel-date">Travel Date: ${bus.travelDate}</p>
                        <p class="fare">Fare: ₹${bus.fare}</p>
                        <p class="total-seats">Total Seats: ${bus.totalSeats}</p>
                        <p class="available-seats">Available Seats: ${bus.availableSeats}</p>
                        <p class="amenities">Amenities: ${bus.amenities}</p>
                        <button class="book-button animate-subtle-glow" onclick="openSeatBooking()">
                            <i class="fas fa-chair"></i> Book Seat
                        </button>
                        <button class="book-button animate-subtle-glow" onclick="setTimeout(bookTicket, 2000);">
                            <i class="fas fa-ticket-alt"></i> Book Ticket
                        </button>
                    </div>
                </c:forEach>
            </div>
        </div>

        <div class="panel glassmorphic tilt animate-cascade-in" id="history-panel" style="display:none;">
            <h2 class="form-element" style="animation-delay: 0.2s;">
                <span class="animate-typewriter inline-block">Booking History</span>
            </h2>
            <c:choose>
                <c:when test="${empty bookings}">
                    <p class="text-gray-400 form-element" style="animation-delay: 0.3s;">You may not have any bookings yet!</p>
                </c:when>
                <c:otherwise>
                    <h3 style="color: white; font-weight: bolder;">Your Bookings :</h3>
                    <table class="booking-table form-element" style="animation-delay: 0.3s;" >
                        <thead>
                            <tr>
                                <th>Bus Name</th>
                                <th>Seat Number</th>
                                <th>Status</th>
                                <th>Booking Time</th>
                            </tr>
                        </thead>
                        <tbody>
                            <c:forEach var="activeBooking" items="${activeBookings}">
                                <tr>
                                    <td>${activeBooking.busName}</td>
                                    <td>${activeBooking.seatNumber}</td>
                                    <td>${activeBooking.status}</td>
                                    <td>${activeBooking.bookingTime}</td>
                                </tr>
                            </c:forEach>
                        </tbody>
                    </table>
                </c:otherwise>
            </c:choose>
        </div>
        <div class="panel glassmorphic tilt animate-cascade-in" id="mytrip-panel" style="display:none;">
            <h2 class="form-element" style="animation-delay: 0.2s;">
                <span class="animate-typewriter inline-block">My Trip</span>
            </h2>
            <c:choose>
                <c:when test="${empty activeBookings}">
                    <p class="text-gray-400 form-element" style="animation-delay: 0.3s;">You have no active bookings.</p>
                </c:when>
                <c:otherwise>
                    <table class="booking-table form-element" style="animation-delay: 0.3s;">
                        <thead>
                            <tr>
                                <th>ID</th>
                                <th>Bus Name</th>
                                <th>Seat Number</th>
                                <th>Status</th>
                                <th>Booking Time</th>
                                <th>Action</th>
                            </tr>
                        </thead>
                        <tbody>
                            <c:forEach var="booking" items="${activeBookings}">
                                <tr>
                                    <td>${booking.id}</td>
                                    <td>${booking.busName}</td>
                                    <td>${booking.seatNumber}</td>
                                    <td>${booking.status}</td>
                                    <td>${booking.bookingTime}</td>
                                    <td>
                                        <c:if test="${booking.status != 'cancelled'}">
                                            <a href="cancelBooking?id=${booking.id}" class="cancel-btn" onclick="return confirm('Are you sure you want to cancel this booking?')">Cancel</a>
                                        </c:if>
                                    </td>
                                </tr>
                            </c:forEach>
                        </tbody>
                    </table>
                </c:otherwise>
            </c:choose>
        </div>

        
        <div id="SeatBookingOverlay">
            <div id="SeatBookingContent" class="glassmorphic tilt">
                <h2 class="text-2xl font-bold text-teal-400 mb-4">Choose Your Seats</h2>
                <p class="text-gray-400 mb-4">We will shortly email about Available Seats</p>
                <div id="seatsContainer"></div>
                <button class="book-button animate-subtle-glow mt-4" onclick="closeSeatBooking()">
                    <i class="fas fa-check"></i> Select
                </button>
            </div>
        </div>
        <div id="TicketBooking">
            <div id="TicketBookingContent" class="glassmorphic tilt">
                <h2 class="text-2xl font-bold text-teal-400 mb-4">Please pay the Amount</h2>
                <img src="image/upi.png" alt="UPI Image" class="upi-image mb-4" />
                <p style="color: white;">Name - [Your Payment] <br>UPI Handle - [Your ID]</p>
                <button class="book-button animate-subtle-glow" onclick="closebookTicket()">
                    <i class="fas fa-check"></i> Done Payment!
                </button>
            </div>
        </div>

        <div id="TicketSuccess">
            <div id="TicketSuccessContent" class="glassmorphic tilt">
                <h2 class="text-2xl font-bold text-teal-400 mb-4">Ticket Booked Successfully</h2>
                
                <p style="color: white;">Ticket copy is shared to your Registered Mail address <br> Thank You !! </p>
                <button class="book-button animate-subtle-glow" onclick="closebookTicketSuccess()">
                    <i class="fas fa-check"></i> Close !
                </button>
            </div>
        </div>
    </div>

    <script>

        if (localStorage.getItem('selectedSeats')){
            localStorage.removeItem('selectedSeats');

        }
        
        window.addEventListener('load', () => {
            const elements = document.querySelectorAll('.form-element');
            elements.forEach((element) => {
                element.classList.add('animate-cascade-in');
                element.style.opacity = '1';
            });
        });

        // Parallax Tilt Effect
        const tiltElements = document.querySelectorAll('.tilt');
        document.addEventListener('mousemove', (e) => {
            tiltElements.forEach((tiltElement) => {
                const rect = tiltElement.getBoundingClientRect();
                const x = e.clientX - rect.left - rect.width / 2;
                const y = e.clientY - rect.top - rect.height / 2;
                const tiltX = (y / rect.height) * 10;
                const tiltY = -(x / rect.width) * 10;
                tiltElement.style.transform = `perspective(1000px) rotateX(${tiltX}deg) rotateY(${tiltY}deg)`;
            });
        });
        document.addEventListener('mouseleave', () => {
            tiltElements.forEach((tiltElement) => {
                tiltElement.style.transform = 'perspective(1000px) rotateX(0deg) rotateY(0deg)';
            });
        });

        // Cursor Trail Effect
        let trailCount = 0;
        document.addEventListener('mousemove', (e) => {
            if (trailCount % 5 === 0) {
                const trail = document.createElement('div');
                trail.className = 'cursor-trail';
                trail.style.left = `${e.pageX}px`;
                trail.style.top = `${e.pageY}px`;
                document.body.appendChild(trail);
                setTimeout(() => {
                    trail.style.transform = 'scale(0)';
                    setTimeout(() => trail.remove(), 300);
                }, 500);
            }
            trailCount++;
        });

        // Navbar Dropdown
        function toggleDropdown() {
            const dropdown = document.getElementById("profileDropdown");
            dropdown.style.display = dropdown.style.display === "block" ? "none" : "block";
        }

        document.addEventListener('click', function(e) {
            const dropdown = document.getElementById("profileDropdown");
            const button = document.getElementById("profileButton");
            if (!dropdown.contains(e.target) && e.target !== button) {
                dropdown.style.display = "none";
            }
        });

        // Panel Switching
        function showPanel(panelId) {
            document.querySelectorAll(".panel").forEach(panel => {
                panel.style.display = "none";
            });
            const target = document.getElementById(panelId);
            if (target) target.style.display = "block";
        }

        // Filter Results
        function filterResults() {
            const busName = document.getElementById('busNameFilter').value.toLowerCase();
            const source = document.getElementById('sourceFilter').value.toLowerCase();
            const destination = document.getElementById('destinationFilter').value.toLowerCase();
            const fare = document.getElementById('fareFilter').value;
            const availableSeats = document.getElementById('availableSeatsFilter').value;
            const busesList = document.getElementById('busesList').children;

            for (let i = 0; i < busesList.length; i++) {
                const bus = busesList[i];
                const busNameText = bus.querySelector('.bus-name').innerText.toLowerCase();
                const sourceText = bus.querySelector('.source').innerText.toLowerCase();
                const destinationText = bus.querySelector('.destination').innerText.toLowerCase();
                const fareText = bus.querySelector('.fare').innerText.replace('₹', '').trim();
                const availableSeatsText = bus.querySelector('.available-seats').innerText.trim();

                let matchesFilter = true;
                if (busName && !busNameText.includes(busName)) matchesFilter = false;
                if (source && !sourceText.includes(source)) matchesFilter = false;
                if (destination && !destinationText.includes(destination)) matchesFilter = false;
                if (fare && fareText != fare) matchesFilter = false;
                if (availableSeats && availableSeatsText != availableSeats) matchesFilter = false;

                bus.style.display = matchesFilter ? 'block' : 'none';
            }
        }

        // Ticket Booking
        function bookTicket() {
            var overlay = document.getElementById('TicketBooking');
            fetch("/ticketbooking?ticketbooking=true", {
                method: "POST"
            })
            .then(response => response.text())
            .then(data => {
                console.log(data);
            })
            .catch(error => {
                console.error("Error:", error);
            });
            overlay.style.display = 'flex';
        }

        function closebookTicket() {
            localStorage.removeItem('selectedSeats');
            var overlay = document.getElementById('TicketBooking');
            overlay.style.display = 'none';
            openbookTicketSuccess()
        }
        
        function closebookTicketSuccess(){
            var overlay = document.getElementById('TicketSuccess');
            overlay.style.display = 'none';
        }
        function openbookTicketSuccess(){
            var overlay = document.getElementById('TicketSuccess');
            overlay.style.display = 'flex';
        }

        // Seat Selection
        function openSeatBooking() {
            var overlay = document.getElementById('SeatBookingOverlay');
            overlay.style.display = 'flex';
            generateSeats(4, 8);
        }

        function closeSeatBooking() {
            var overlay = document.getElementById('SeatBookingOverlay');
            overlay.style.display = 'none';
        }

        function generateSeats(columns, rows) {
            var container = document.getElementById('seatsContainer');
            container.innerHTML = '';
            const totalSeats = columns * rows;
            const occupiedCount = Math.floor(Math.random() * 12) + 3; 
            const occupiedSeats = new Set();
            while (occupiedSeats.size < occupiedCount) {
                occupiedSeats.add(Math.floor(Math.random() * totalSeats));
            }
            const selectedSeats = JSON.parse(localStorage.getItem('selectedSeats') || '[]');

            for (var i = 0; i < rows; i++) {
                var rowDiv = document.createElement('div');
                rowDiv.classList.add('row');
                for (var j = 0; j < columns; j++) {
                    var seatId = i * columns + j;
                    var seatDiv = document.createElement('div');
                    seatDiv.classList.add('seat');
                    seatDiv.setAttribute('data-id', seatId);

                    if (occupiedSeats.has(seatId)) {
                        seatDiv.classList.add('occupied');
                        seatDiv.setAttribute('data-status', 'occupied');
                    } else if (selectedSeats.includes(seatId)) {
                        seatDiv.classList.add('selected');
                        seatDiv.setAttribute('data-status', 'selected');
                    } else {
                        seatDiv.classList.add('available');
                        seatDiv.setAttribute('data-status', 'available');
                    }

                    seatDiv.onclick = function() {
                        toggleSeatStatus(this);
                    };
                    rowDiv.appendChild(seatDiv);
                }
                container.appendChild(rowDiv);
            }
        }


        function toggleSeatStatus(seat) {
            var status = seat.getAttribute('data-status');
            var seatId = parseInt(seat.getAttribute('data-id'));
            var selectedSeats = JSON.parse(localStorage.getItem('selectedSeats') || '[]');

            if (status === 'occupied') {
                return; // Can't select occupied seats
            } else if (status === 'available') {
                seat.classList.remove('available');
                seat.classList.add('selected');
                seat.setAttribute('data-status', 'selected');
                selectedSeats.push(seatId);
            } else if (status === 'selected') {
                seat.classList.remove('selected');
                seat.classList.add('available');
                seatDiv.setAttribute('data-status', 'available');
                selectedSeats = selectedSeats.filter(id => id !== seatId);
            }

            localStorage.setItem('selectedSeats', JSON.stringify(selectedSeats));
        }
    </script>
</body>
</html>