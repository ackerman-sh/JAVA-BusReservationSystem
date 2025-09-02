package servlets;

import dao.BusDAO;
import dao.BookingDAO;
import model.User;
import model.Bus;
import model.Booking;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;
import java.util.List;

@WebServlet("/home")
public class HomeServlet extends HttpServlet {
    private BookingDAO bookingDAO;

    @Override
    public void init() throws ServletException {
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
        if ("admin".equalsIgnoreCase(user.getUsername())) {
            response.sendRedirect("logout");
            return;
        }

        List<Bus> buses = BusDAO.getAllBuses();
        List<Booking> bookings = bookingDAO.getAllBookings();
        List<Booking> activeBookings = bookingDAO.getActiveBookingsByUsername(user.getUsername());

        request.setAttribute("buses", buses);
        request.setAttribute("bookings", bookings);
        request.setAttribute("activeBookings", activeBookings);
        request.setAttribute("user", user);
        request.getRequestDispatcher("/home.jsp").forward(request, response);
    }
}