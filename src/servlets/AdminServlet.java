package servlets;

import dao.BusDAO;
import dao.UserDAO;
import dao.BookingDAO;
import model.Bus;
import model.User;
import model.Booking;
import model.Payment;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.util.List;

@WebServlet("/admin")
public class AdminServlet extends HttpServlet {
    private UserDAO userDAO;
    private BusDAO busDAO;
    private BookingDAO bookingDAO;

    @Override
    public void init() throws ServletException {
        userDAO = new UserDAO();
        busDAO = new BusDAO();
        bookingDAO = new BookingDAO();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("user") == null) {
            response.sendRedirect("login.jsp");
            return;
        }

        User user = (User) session.getAttribute("user");
        if (!"admin".equalsIgnoreCase(user.getUsername())) {
            response.sendRedirect("home");
            return;
        }

        String action = request.getParameter("action");

        if ("editUser".equals(action)) {
            int id = Integer.parseInt(request.getParameter("id"));
            User editUser = userDAO.getUserById(id);
            request.setAttribute("editUser", editUser);
        } else if ("editBus".equals(action)) {
            int id = Integer.parseInt(request.getParameter("id"));
            Bus editBus = busDAO.getBusById(id);
            request.setAttribute("editBus", editBus);
        }

        loadAdminData(request);
        request.getRequestDispatcher("/admin.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String action = request.getParameter("action");

        if ("addUser".equals(action)) {
            UserDAO.registerUser(
                request.getParameter("username"),
                request.getParameter("email"),
                request.getParameter("password")
            );
        } else if ("updateUser".equals(action)) {
            User user = new User();
            user.setId(Integer.parseInt(request.getParameter("id")));
            user.setUsername(request.getParameter("username"));
            user.setEmail(request.getParameter("email"));
            user.setRole(request.getParameter("role"));
            String password = request.getParameter("password");
            userDAO.updateUser(user, password);
        } else if ("deleteUser".equals(action)) {
            int id = Integer.parseInt(request.getParameter("id"));
            userDAO.deleteUser(id);
        } else if ("addBus".equals(action)) {
            Bus bus = new Bus(
                0,
                request.getParameter("busName"),
                request.getParameter("busType"),
                request.getParameter("source"),
                request.getParameter("destination"),
                request.getParameter("departureTime"),
                request.getParameter("arrivalTime"),
                request.getParameter("journeyDuration"),
                request.getParameter("travelDate"),
                Integer.parseInt(request.getParameter("fare")),
                Integer.parseInt(request.getParameter("totalSeats")),
                Integer.parseInt(request.getParameter("availableSeats")),
                request.getParameter("amenities")
            );
            busDAO.addBus(bus);
        } else if ("updateBus".equals(action)) {
            Bus bus = new Bus(
                Integer.parseInt(request.getParameter("id")),
                request.getParameter("busName"),
                request.getParameter("busType"),
                request.getParameter("source"),
                request.getParameter("destination"),
                request.getParameter("departureTime"),
                request.getParameter("arrivalTime"),
                request.getParameter("journeyDuration"),
                request.getParameter("travelDate"),
                Integer.parseInt(request.getParameter("fare")),
                Integer.parseInt(request.getParameter("totalSeats")),
                Integer.parseInt(request.getParameter("availableSeats")),
                request.getParameter("amenities")
            );
            busDAO.updateBus(bus);
        } else if ("deleteBus".equals(action)) {
            int id = Integer.parseInt(request.getParameter("id"));
            busDAO.deleteBus(id);
        } else if ("cancelBooking".equals(action)) {
            int id = Integer.parseInt(request.getParameter("id"));
            bookingDAO.cancelBooking(id);
        }

        loadAdminData(request);
        request.getRequestDispatcher("/admin.jsp").forward(request, response);
    }

    private void loadAdminData(HttpServletRequest request) {
        List<User> users = userDAO.getAllUsers();
        List<Bus> buses = BusDAO.getAllBuses();
        List<Booking> bookings = bookingDAO.getAllBookings();
        List<Payment> payments = bookingDAO.getAllPayments();
        request.setAttribute("users", users);
        request.setAttribute("buses", buses);
        request.setAttribute("bookings", bookings);
        request.setAttribute("payments", payments);
    }
}