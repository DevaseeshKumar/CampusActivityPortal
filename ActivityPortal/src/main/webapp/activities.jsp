<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Activities</title>
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

        /* Button Styles */
        .button {
            background-color: #007bff;
            color: white;
            border: none;
            padding: 5px 10px;
            cursor: pointer;
            border-radius: 4px;
            margin-right: 5px;
            transition: background-color 0.3s;
        }

        .button:hover {
            background-color: #0056b3;
        }

        .delete-button {
            background-color: #dc3545;
        }

        .delete-button:hover {
            background-color: #c82333;
        }
    </style>
</head>
<body>
    <nav>
        <ul>
            <li><a href="admin_dashboard.jsp">Home</a></li>
            <li><a href="activities.jsp">Activities</a></li>
            <li><a href="submitActivity.jsp">Add Activities</a></li>
            <li><a href="logout.jsp">Logout</a></li>
        </ul>
    </nav>

    <div class="container">
        <h2>Activities</h2>
        <table>
            <tr>
                <th>ID</th>
                <th>Title</th>
                <th>Description</th>
                <th>Count</th> <!-- New column for count -->
                <th>Actions</th>
            </tr>
            <%
                Connection conn = null;
                Statement stmt = null;
                ResultSet rs = null;

                try {
                    Class.forName("com.mysql.cj.jdbc.Driver");
                    conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/project", "root", "Devaseesh*2005");
                    stmt = conn.createStatement();
                    rs = stmt.executeQuery("SELECT id, title, description, count FROM activities"); // Updated SQL query

                    while (rs.next()) {
                        int id = rs.getInt("id");
                        String title = rs.getString("title");
                        String description = rs.getString("description");
                        int count = rs.getInt("count"); // Retrieve count
            %>
                        <tr>
                            <td><%= id %></td>
                            <td><%= title %></td>
                            <td><%= description %></td>
                            <td><%= count %></td> <!-- Display count -->
                            <td>
                                <form action="editActivity.jsp" method="post" style="display:inline;">
                                    <input type="hidden" name="id" value="<%= id %>">
                                    <input type="submit" value="Edit" class="button">
                                </form>
                                <form action="deleteActivity.jsp" method="post" style="display:inline;">
                                    <input type="hidden" name="id" value="<%= id %>">
                                    <input type="submit" value="Delete" class="button delete-button">
                                </form>
                            </td>
                        </tr>
            <%
                    }
                } catch (Exception e) {
                    out.println("<tr><td colspan='5'>Error: " + e.getMessage() + "</td></tr>"); // Updated colspan
                } finally {
                    if (rs != null) {
                        try {
                            rs.close();
                        } catch (SQLException e) {
                            e.printStackTrace();
                        }
                    }
                    if (stmt != null) {
                        try {
                            stmt.close();
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
            %>
        </table>
    </div>
</body>
</html>
