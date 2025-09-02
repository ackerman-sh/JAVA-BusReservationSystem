<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page import="model.User" %>
<%
    User user = (User) session.getAttribute("user");
    if (user == null) {
        response.sendRedirect("login.jsp");
        return;
    }
    if (!"admin".equalsIgnoreCase(user.getUsername())) {
        response.sendRedirect("home/");
        return;
    }
%>
<html>
<head>
    <title>Admin Dashboard</title>
    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
            font-family: Arial, sans-serif;
        }

        body {
            background-color: #1a1a1a;
            color: #e0e0e0;
        }

        .admin-container {
            max-width: 1200px;
            margin: 20px auto;
            padding: 20px;
            background-color: #2a2a2a;
            border-radius: 8px;
            box-shadow: 0 4px 10px rgba(0, 0, 0, 0.5);
        }

        h2, h3 {
            color: #00b7eb;
        }

        .logout-btn {
            display: inline-block;
            padding: 10px 20px;
            background-color: #e74c3c;
            color: white;
            text-decoration: none;
            border-radius: 5px;
            transition: background-color 0.3s;
        }

        .logout-btn:hover {
            background-color: #c0392b;
        }

        hr {
            border: 1px solid #444;
            margin: 20px 0;
        }

        /* Tabs */
        .nav-tabs {
            list-style: none;
            display: flex;
            border-bottom: 2px solid #444;
            margin-bottom: 20px;
        }

        .nav-tabs li {
            margin-right: 10px;
        }

        .nav-tabs a {
            display: block;
            padding: 10px 20px;
            color: #e0e0e0;
            text-decoration: none;
            border-radius: 5px 5px 0 0;
            background-color: #333;
            transition: background-color 0.3s, color 0.3s;
        }

        .nav-tabs a:hover,
        .nav-tabs a.active {
            background-color: #00b7eb;
            color: #fff;
        }

        .tab-content {
            display: block;
        }

        .tab-pane {
            display: none;
        }

        .tab-pane.active {
            display: block;
        }

        /* Forms */
        form {
            background-color: #333;
            padding: 20px;
            border-radius: 5px;
            margin-bottom: 20px;
        }

        .mb-3 {
            margin-bottom: 15px;
        }

        label {
            display: block;
            margin-bottom: 5px;
            color: #e0e0e0;
        }

        input[type="text"],
        input[type="password"],
        input[type="email"],
        input[type="number"],
        select {
            width: 100%;
            padding: 10px;
            border: 1px solid #555;
            border-radius: 5px;
            background-color: #444;
            color: #e0e0e0;
            transition: border-color 0.3s;
        }

        input:focus,
        select:focus {
            outline: none;
            border-color: #00b7eb;
        }

        button,
        .btn {
            padding: 10px 20px;
            border: none;
            border-radius: 5px;
            cursor: pointer;
            transition: background-color 0.3s;
        }

        .btn-primary {
            background-color: #00b7eb;
            color: #fff;
        }

        .btn-primary:hover {
            background-color: #0097c7;
        }

        .btn-secondary {
            background-color: #666;
            color: #fff;
        }

        .btn-secondary:hover {
            background-color: #555;
        }

        .btn-warning {
            background-color: #f1c40f;
            color: #000;
        }

        .btn-warning:hover {
            background-color: #d4ac0d;
        }

        .btn-danger {
            background-color: #e74c3c;
            color: #fff;
        }

        .btn-danger:hover {
            background-color: #c0392b;
        }

        /* Tables */
        .table {
            width: 100%;
            border-collapse: collapse;
            background-color: #333;
            border-radius: 5px;
            overflow: hidden;
        }

        .table th,
        .table td {
            padding: 12px;
            text-align: left;
            border-bottom: 1px solid #444;
        }

        .table th {
            background-color: #444;
            color: #00b7eb;
        }

        .table tr:hover {
            background-color: #3a3a3a;
        }

        .table .actions {
            display: flex;
            gap: 10px;
        }

        /* Responsive */
        @media (max-width: 768px) {
            .admin-container {
                margin: 10px;
                padding: 15px;
            }

            .nav-tabs {
                flex-direction: column;
            }

            .nav-tabs li {
                margin-right: 0;
                margin-bottom: 10px;
            }

            .table {
                font-size: 14px;
            }

            .table th,
            .table td {
                padding: 8px;
            }
        }
    </style>
</head>
<body>
    <div class="admin-container">
        <h2>Welcome, <%= user.getUsername() %>!</h2>
        <p>Your role: <%= user.getRole() %></p>
        <a href="logout" class="logout-btn">Logout</a>
        <hr>

        <ul class="nav-tabs">
            <li><a href="#manage-users" class="active" onclick="showTab('manage-users')">Manage Users</a></li>
            <li><a href="#manage-bookings" onclick="showTab('manage-bookings')">Manage Bookings</a></li>
            <li><a href="#manage-buses" onclick="showTab('manage-buses')">Manage Buses</a></li>
            <li><a href="#view-payments" onclick="showTab('view-payments')">View Payments</a></li>
        </ul>

        <div class="tab-content">
            <!-- Manage Users -->
            <div class="tab-pane active" id="manage-users">
                <h3>Manage Users</h3>
                <form action="admin" method="post" class="mb-3">
                    <input type="hidden" name="action" value="${editUser != null ? 'updateUser' : 'addUser'}">
                    <input type="hidden" name="id" value="${editUser != null ? editUser.id : ''}">
                    <div class="mb-3">
                        <label>Username</label>
                        <input type="text" name="username" value="${editUser != null ? editUser.username : ''}" required>
                    </div>
                    <div class="mb-3">
                        <label>Password</label>
                        <input type="password" name="password" ${editUser != null ? '' : 'required'}>
                    </div>
                    <div class="mb-3">
                        <label>Email</label>
                        <input type="email" name="email" value="${editUser != null ? editUser.email : ''}" required>
                    </div>
                    <div class="mb-3">
                        <label>Role</label>
                        <select name="role">
                            <option value="user" ${editUser != null && editUser.role == 'user' ? 'selected' : ''}>User</option>
                            <option value="admin" ${editUser != null && editUser.role == 'admin' ? 'selected' : ''}>Admin</option>
                        </select>
                    </div>
                    <button type="submit" class="btn btn-primary">${editUser != null ? 'Update User' : 'Add User'}</button>
                    <c:if test="${editUser != null}">
                        <a href="admin" class="btn btn-secondary">Cancel Edit</a>
                    </c:if>
                </form>
                <table class="table">
                    <thead>
                        <tr>
                            <th>ID</th>
                            <th>Username</th>
                            <th>Email</th>
                            <th>Role</th>
                            <th>Actions</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:forEach var="user" items="${users}">
                            <tr>
                                <td>${user.id}</td>
                                <td>${user.username}</td>
                                <td>${user.email}</td>
                                <td>${user.role}</td>
                                <td class="actions">
                                    <a href="admin?action=editUser&id=${user.id}" class="btn btn-warning btn-sm">Edit</a>
                                    <a href="admin?action=deleteUser&id=${user.id}" class="btn btn-danger btn-sm" onclick="return confirm('Are you sure?')">Delete</a>
                                </td>
                            </tr>
                        </c:forEach>
                    </tbody>
                </table>
            </div>

            <!-- Manage Bookings -->
            <div class="tab-pane" id="manage-bookings">
                <h3>Manage Bookings</h3>
                <table class="table">
                    <thead>
                        <tr>
                            <th>ID</th>
                            <th>Username</th>
                            <th>Bus Name</th>
                            <th>Seat Number</th>
                            <th>Status</th>
                            <th>Booking Time</th>
                            <th>Actions</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:forEach var="booking" items="${bookings}">
                            <tr>
                                <td>${booking.id}</td>
                                <td>${booking.username}</td>
                                <td>${booking.busName}</td>
                                <td>${booking.seatNumber}</td>
                                <td>${booking.status}</td>
                                <td>${booking.bookingTime}</td>
                                <td class="actions">
                                    <a href="admin?action=cancelBooking&id=${booking.id}" class="btn btn-danger btn-sm" onclick="return confirm('Are you sure?')">Cancel</a>
                                </td>
                            </tr>
                        </c:forEach>
                    </tbody>
                </table>
            </div>

            <!-- Manage Buses -->
            <div class="tab-pane" id="manage-buses">
                <h3>Manage Buses</h3>
                <form action="admin" method="post" class="mb-3">
                    <input type="hidden" name="action" value="${editBus != null ? 'updateBus' : 'addBus'}">
                    <input type="hidden" name="id" value="${editBus != null ? editBus.id : ''}">
                    <div class="mb-3">
                        <label>Bus Name</label>
                        <input type="text" name="busName" value="${editBus != null ? editBus.busName : ''}" required>
                    </div>
                    <div class="mb-3">
                        <label>Bus Type</label>
                        <input type="text" name="busType" value="${editBus != null ? editBus.busType : ''}" required>
                    </div>
                    <div class="mb-3">
                        <label>Source</label>
                        <input type="text" name="source" value="${editBus != null ? editBus.source : ''}" required>
                    </div>
                    <div class="mb-3">
                        <label>Destination</label>
                        <input type="text" name="destination" value="${editBus != null ? editBus.destination : ''}" required>
                    </div>
                    <div class="mb-3">
                        <label>Departure Time</label>
                        <input type="text" name="departureTime" value="${editBus != null ? editBus.departureTime : ''}" required>
                    </div>
                    <div class="mb-3">
                        <label>Arrival Time</label>
                        <input type="text" name="arrivalTime" value="${editBus != null ? editBus.arrivalTime : ''}" required>
                    </div>
                    <div class="mb-3">
                        <label>Journey Duration</label>
                        <input type="text" name="journeyDuration" value="${editBus != null ? editBus.journeyDuration : ''}" required>
                    </div>
                    <div class="mb-3">
                        <label>Travel Date</label>
                        <input type="text" name="travelDate" value="${editBus != null ? editBus.travelDate : ''}" required>
                    </div>
                    <div class="mb-3">
                        <label>Fare</label>
                        <input type="number" name="fare" value="${editBus != null ? editBus.fare : ''}" required>
                    </div>
                    <div class="mb-3">
                        <label>Total Seats</label>
                        <input type="number" name="totalSeats" value="${editBus != null ? editBus.totalSeats : ''}" required>
                    </div>
                    <div class="mb-3">
                        <label>Available Seats</label>
                        <input type="number" name="availableSeats" value="${editBus != null ? editBus.availableSeats : ''}" required>
                    </div>
                    <div class="mb-3">
                        <label>Amenities</label>
                        <input type="text" name="amenities" value="${editBus != null ? editBus.amenities : ''}" required>
                    </div>
                    <button type="submit" class="btn btn-primary">${editBus != null ? 'Update Bus' : 'Add Bus'}</button>
                    <c:if test="${editBus != null}">
                        <a href="admin" class="btn btn-secondary">Cancel Edit</a>
                    </c:if>
                </form>
                <table class="table">
                    <thead>
                        <tr>
                            <th>ID</th>
                            <th>Bus Name</th>
                            <th>Source</th>
                            <th>Destination</th>
                            <th>Fare</th>
                            <th>Total Seats</th>
                            <th>Available Seats</th>
                            <th>Actions</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:forEach var="bus" items="${buses}">
                            <tr>
                                <td>${bus.id}</td>
                                <td>${bus.busName}</td>
                                <td>${bus.source}</td>
                                <td>${bus.destination}</td>
                                <td>${bus.fare}</td>
                                <td>${bus.totalSeats}</td>
                                <td>${bus.availableSeats}</td>
                                <td class="actions">
                                    <a href="admin?action=editBus&id=${bus.id}" class="btn btn-warning btn-sm">Edit</a>
                                    <a href="admin?action=deleteBus&id=${bus.id}" class="btn btn-danger btn-sm" onclick="return confirm('Are you sure?')">Delete</a>
                                </td>
                            </tr>
                        </c:forEach>
                    </tbody>
                </table>
            </div>

            <!-- View Payments -->
            <div class="tab-pane" id="view-payments">
                <h3>View Payments</h3>
                <table class="table">
                    <thead>
                        <tr>
                            <th>ID</th>
                            <th>Booking ID</th>
                            <th>Amount</th>
                            <th>Status</th>
                            <th>Payment Time</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:forEach var="payment" items="${payments}">
                            <tr>
                                <td>${payment.id}</td>
                                <td>${payment.bookingId}</td>
                                <td>${payment.amount}</td>
                                <td>${payment.paymentStatus}</td>
                                <td>${payment.paymentTime}</td>
                            </tr>
                        </c:forEach>
                    </tbody>
                </table>
            </div>
        </div>
    </div>

    <script>
        function showTab(tabId) {
            document.querySelectorAll('.tab-pane').forEach(pane => pane.classList.remove('active'));
            document.querySelectorAll('.nav-tabs a').forEach(link => link.classList.remove('active'));
            document.getElementById(tabId).classList.add('active');
            document.querySelector(`a[href="#${tabId}"]`).classList.add('active');
        }
    </script>
</body>
</html>