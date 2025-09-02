package servlets;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;

@WebServlet("/logout")
public class LogoutServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        // Invalidate the session to log out the user
        HttpSession session = request.getSession(false); // Don't create a new session if one doesn't exist
        if (session != null) {
            session.invalidate();  // Destroys the session
        }
        
        // Redirect to the login page
        response.sendRedirect("login.jsp");
    }
}
