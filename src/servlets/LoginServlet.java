package servlets;

import model.User;
import dao.UserDAO;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;

@WebServlet("/login")
public class LoginServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // Get credentials
        String username = request.getParameter("username");
        String password = request.getParameter("password");

        // Basic null check (extra safety)
        if (username == null || password == null || username.trim().isEmpty() || password.trim().isEmpty()) {
            request.setAttribute("error", "Username and password are required.");
            request.getRequestDispatcher("login.jsp").forward(request, response);
            return;
        }

        // Authenticate user
        User user = UserDAO.authenticate(username, password);

        if (user != null) {
            HttpSession session = request.getSession();
            session.setAttribute("user", user);
            session.setMaxInactiveInterval(30 * 60); // 30 mins

            // Admin or normal user routing
            if ("admin".equalsIgnoreCase(user.getUsername())) {
                response.sendRedirect("admin");
            } else {
                response.sendRedirect("home");
            }
        } 
         else {
            // Failed login
            request.setAttribute("error", "Invalid username or password");
            request.getRequestDispatcher("login.jsp").forward(request, response);
        }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
                request.removeAttribute("error"); // optional, but clean
                request.getRequestDispatcher("login.jsp").forward(request, response);
    }
}
