<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.Connection" %>
<%@ page import="java.sql.DriverManager" %>
<%@ page import="java.sql.PreparedStatement" %>
<%@ page import="java.sql.ResultSet" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Login</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f8f9fa;
            margin: 0;
            padding: 0;
            color: #343a40;
            text-align: center;
        }
        h2 {
            color: #343a40;
            margin-top: 20px;
        }
        form {
            margin-top: 20px;
            text-align: center;
        }
        label {
            display: block;
            margin: 10px 0 5px;
        }
        input[type="text"],
        input[type="password"] {
            width: 80%;
            padding: 8px;
            margin-bottom: 10px;
            border: 1px solid #ced4da;
            border-radius: 4px;
        }
        input[type="submit"] {
            background-color: #007bff;
            color: white;
            border: none;
            padding: 10px 20px;
            cursor: pointer;
            border-radius: 4px;
            transition: background-color 0.3s;
        }
        input[type="submit"]:hover {
            background-color: #0056b3;
        }
        p {
            color: #dc3545;
        }
        /* Navigation bar styles */
        nav {
            background-color: #343a40;
            padding: 10px 0;
        }
        nav ul {
            list-style-type: none;
            padding: 0;
            margin: 0;
            text-align: center;
        }
        nav ul li {
            display: inline;
            margin-right: 20px;
        }
        nav ul li a {
            color: #ffffff;
            text-decoration: none;
            font-weight: bold;
            padding: 8px 16px;
            display: inline-block;
            transition: background-color 0.3s;
        }
        nav ul li a:hover {
            background-color: #495057;
            border-radius: 4px;
        }
    </style>
</head>
<body>
    <nav>
        <ul>
            <li><a href="home.jsp">Home</a></li>
            <li><a href="login.jsp">Login</a></li>
            <li><a href="logout.jsp">Logout</a></li>
        </ul>
    </nav>

    <h2>Login</h2>
    <form action="login.jsp" method="post">
        <label for="username">Username:</label>
        <input type="text" id="username" name="username" required><br><br>
        <label for="password">Password:</label>
        <input type="password" id="password" name="password" required><br><br>
        <input type="submit" value="Login">
    </form>

    <% 
    if (request.getMethod().equalsIgnoreCase("POST")) {
        String username = request.getParameter("username");
        String password = request.getParameter("password");
        
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/project", "root", "Devaseesh*2005");
            
            // Check for admin login
            PreparedStatement psAdmin = conn.prepareStatement("SELECT * FROM admins WHERE username=? AND password=?");
            psAdmin.setString(1, username);
            psAdmin.setString(2, password);
            ResultSet rsAdmin = psAdmin.executeQuery();

            if (rsAdmin.next()) {
                // Redirect to admin dashboard
                response.sendRedirect("admin_dashboard.jsp");
            } else {
                // Check for user login
                PreparedStatement psUser = conn.prepareStatement("SELECT * FROM users WHERE username=? AND password=?");
                psUser.setString(1, username);
                psUser.setString(2, password);
                ResultSet rsUser = psUser.executeQuery();

                if (rsUser.next()) {
                    // Set username in session and redirect to user dashboard
                    session.setAttribute("username", username);
                    response.sendRedirect("user_dashboard.jsp");
                } else {
                    out.println("<p>Invalid username or password.</p>");
                }
            }
        } catch (Exception e) {
            out.println("<p>Error: " + e.getMessage() + "</p>");
        }
    }
    %>
</body>
</html>
