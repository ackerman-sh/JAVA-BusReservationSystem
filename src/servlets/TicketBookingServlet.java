package servlets;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;


@WebServlet("/ticketbooking")
public class TicketBookingServlet extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String ticketBooking = request.getParameter("ticketbooking");

        if ("true".equals(ticketBooking)) {
            System.out.println("Ticket booking received!");
            response.setContentType("text/plain");
            response.getWriter().write("Ticket booking noted down successfully!");
        } else {
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Invalid request");
        }
    }
}
