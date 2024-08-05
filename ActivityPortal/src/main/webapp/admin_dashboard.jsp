<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Admin Dashboard</title>
    <style>
        /* General Styles */
        body {
            font-family: 'Arial', sans-serif;
            background-color: #f8f9fa;
            margin: 0;
            padding: 0;
            color: #343a40;
        }

        h2 {
            color: #343a40;
            text-align: center;
            margin-top: 20px;
        }

        p {
            text-align: center;
            color: #6c757d;
        }

        /* Navigation Bar Styles */
        nav {
            background-color: #343a40;
            border-bottom: 3px solid #007bff;
        }

        nav ul {
            list-style-type: none;
            margin: 0;
            padding: 0;
            overflow: hidden;
            text-align: center;
        }

        nav ul li {
            display: inline;
        }

        nav ul li a {
            display: inline-block;
            color: #ffffff;
            text-align: center;
            padding: 14px 20px;
            text-decoration: none;
            transition: background-color 0.3s;
        }

        nav ul li a:hover {
            background-color: #007bff;
        }

        /* Container Styles */
        .container {
            max-width: 800px;
            margin: 50px auto;
            padding: 20px;
            background-color: #ffffff;
            box-shadow: 0px 0px 10px rgba(0, 0, 0, 0.1);
            border-radius: 8px;
        }

        /* Table Styles */
        table {
            width: 100%;
            border-collapse: collapse;
            margin-top: 20px;
        }

        table, th, td {
            border: 1px solid #dee2e6;
        }

        th, td {
            padding: 12px;
            text-align: left;
        }

        th {
            background-color: #007bff;
            color: #ffffff;
        }

        tr:nth-child(even) {
            background-color: #f2f2f2;
        }

        /* Form Styles */
        form {
            text-align: center;
            margin-top: 20px;
        }

        form input[type="submit"] {
            background-color: #007bff;
            color: white;
            border: none;
            padding: 10px 20px;
            text-decoration: none;
            margin: 4px 2px;
            cursor: pointer;
            border-radius: 5px;
            transition: background-color 0.3s;
        }

        form input[type="submit"]:hover {
            background-color: #0056b3;
        }

    </style>
</head>
<body>
    <nav>
        <ul>
            <li><a href="admin_dashboard.jsp">Home</a></li>
            <li><a href="activities.jsp">Activities</a></li>
            <li><a href="registered.jsp">Activity Details</a></li>
            <li><a href="submitActivity.jsp">Add Activities</a></li>
            <li><a href="logout.jsp">Logout</a></li>
        </ul>
    </nav>

    <div class="container">
        <h2>Admin Dashboard</h2>

        <form action="admin_dashboard.jsp" method="post">
            <input type="submit" name="view_users" value="View Users">
        </form>

        <% if (request.getMethod().equalsIgnoreCase("POST") && request.getParameter("view_users") != null) { %>
            <table>
                <tr>
                    <th>ID</th>
                    <th>Username</th>
                    <th>Email</th>
                    <th>Actions</th>
                </tr>
                <%
                    try {
                        Class.forName("com.mysql.cj.jdbc.Driver");
                        Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/project", "root", "Devaseesh*2005");
                        Statement stmt = conn.createStatement();
                        ResultSet rs = stmt.executeQuery("SELECT * FROM users");

                        while (rs.next()) {
                            int id = rs.getInt("id");
                            String username = rs.getString("username");
                            String email = rs.getString("email");
                %>
                            <tr>
                                <td><%= id %></td>
                                <td><%= username %></td>
                                <td><%= email %></td>
                                <td>
                                    <a href="edit_user.jsp?id=<%= id %>">Edit</a> | 
                                    <a href="delete_user.jsp?id=<%= id %>">Delete</a>
                                </td>
                            </tr>
                <%
                        }
                    } catch (Exception e) {
                        out.println("<p>Error: " + e.getMessage() + "</p>");
                    }
                %>
            </table>
        <% } %>

        <p><a href="logout.jsp">Logout</a></p>
    </div>
</body>
</html>
