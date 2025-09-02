<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="model.User" %>
<%
    User user = (User) session.getAttribute("user");
    String redirectLink;

    if (user == null) {
        redirectLink = "login";
    } else if ("admin".equalsIgnoreCase(user.getUsername())) {
        redirectLink = "admin";
    } else {
        redirectLink = "home";
    }
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>404 - Not Found</title>
    <style>
        body {
            margin: 0;
            padding: 0;
            background-color: #121212;
            color: #f5f5f5;
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            display: flex;
            flex-direction: column;
            align-items: center;
            justify-content: center;
            height: 100vh;
            text-align: center;
        }

        h1 {
            font-size: 6rem;
            color: #e53935;
            margin: 0;
        }

        p {
            font-size: 1.5rem;
            margin: 10px 0 30px;
            color: #bdbdbd;
        }

        a {
            text-decoration: none;
            color: #29b6f6;
            font-weight: bold;
            border: 2px solid #29b6f6;
            padding: 10px 20px;
            border-radius: 5px;
            transition: 0.3s;
        }

        a:hover {
            background-color: #29b6f6;
            color: #121212;
        }
    </style>
</head>
<body>
    <h1>404</h1>
    <h2>Page Not Found</h2>
    <p>Oops! The page you're looking for doesn't exist or has been moved.</p>
    <a href="<%= request.getContextPath() + "/" + redirectLink %>">Go Back </a>
</body>
</html>
