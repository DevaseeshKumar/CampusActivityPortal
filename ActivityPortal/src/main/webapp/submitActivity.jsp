<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Add Activity</title>
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
        textarea,
        input[type="number"] {
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
            color: #28a745;
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
            <li><a href="admin_dashboard.jsp">Home</a></li>
            <li><a href="login.jsp">Login</a></li>
            <li><a href="submitActivity.jsp">Add Activities</a></li>
            <li><a href="logout.jsp">Logout</a></li>
        </ul>
    </nav>

    <h2>Submit Activity</h2>
    <form action="submitActivity.jsp" method="post">
        <label for="title">Title:</label>
        <input type="text" id="title" name="title" required><br><br>
        <label for="description">Description:</label>
        <textarea id="description" name="description" required></textarea><br><br>
        <label for="count">Count (number of users who can register):</label>
        <input type="number" id="count" name="count" min="1" required><br><br>
        <input type="submit" value="Submit">
    </form>

    <% 
        if (request.getMethod().equalsIgnoreCase("POST")) {
            String title = request.getParameter("title");
            String description = request.getParameter("description");
            int count = Integer.parseInt(request.getParameter("count"));

            Connection conn = null;
            PreparedStatement ps = null;
            try {
                Class.forName("com.mysql.cj.jdbc.Driver");
                conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/project", "root", "Devaseesh*2005");

                // Insert the new activity into the activities table
                ps = conn.prepareStatement("INSERT INTO activities (title, description, count) VALUES (?, ?, ?)");
                ps.setString(1, title);
                ps.setString(2, description);
                ps.setInt(3, count);
                ps.executeUpdate();
                ps.close();

                // Insert the new activity into the registered table
                ps = conn.prepareStatement("INSERT INTO registered (activity_name, count) VALUES (?, 0)");
                ps.setString(1, title);
                ps.executeUpdate();

                out.println("<p>Activity submitted successfully!</p>");
            } catch (Exception e) {
                out.println("<p>Error: " + e.getMessage() + "</p>");
                e.printStackTrace();
            } finally {
                if (ps != null) {
                    try {
                        ps.close();
                    } catch (SQLException e) {
                        e.printStackTrace();
                    }
                }
                if (conn != null) {
                    try {
                        conn.close();
                    } catch (SQLException e) {
                        e.printStackTrace();
                    }
                }
            }
        }
    %>
</body>
</html>
