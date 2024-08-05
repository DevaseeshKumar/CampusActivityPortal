<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Register for Activity</title>
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
        .activity-details {
            margin-top: 20px;
            text-align: center;
        }
        .activity-details h3 {
            color: #007bff;
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
            <li><a href="user_dashboard.jsp">Home</a></li>
            <li><a href="registerActivity.jsp">Register Activity</a></li>
            <li><a href="logout.jsp">Logout</a></li>
        </ul>
    </nav>

    <h2>Register for Activity</h2>

    <%
        Connection conn = null;
        PreparedStatement ps = null;
        ResultSet rs = null;

        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/project", "root", "Devaseesh*2005");

            // Retrieve all activities with details
            ps = conn.prepareStatement("SELECT title, description, count FROM activities");
            rs = ps.executeQuery();

            while (rs.next()) {
                String title = rs.getString("title");
                String description = rs.getString("description");
                int availableCount = rs.getInt("count");
    %>
        <div class="activity-details">
            <h3><%= title %></h3>
            <p><strong>Description:</strong> <%= description %></p>
            <p><strong>Available Slots:</strong> <%= availableCount %></p>
            <form action="registerActivity.jsp" method="post">
                <input type="hidden" name="activity" value="<%= title %>">
                <input type="submit" value="Register for this Activity" <% if (availableCount <= 0) { %>disabled<% } %>>
            </form>
        </div>
    <%
            }
        } catch (Exception e) {
            out.println("<p>Error: " + e.getMessage() + "</p>");
            e.printStackTrace();
        } finally {
            if (rs != null) {
                try {
                    rs.close();
                } catch (SQLException e) {
                    e.printStackTrace();
                }
            }
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
    %>

    <%
        if (request.getMethod().equalsIgnoreCase("POST")) {
            String activity = request.getParameter("activity");
            // Assuming userId is obtained from session or another method
            String userId = "exampleUserId"; // Replace this with actual user ID retrieval logic

            Connection conn2 = null;
            PreparedStatement ps2 = null;
            ResultSet rs2 = null;
            try {
                Class.forName("com.mysql.cj.jdbc.Driver");
                conn2 = DriverManager.getConnection("jdbc:mysql://localhost:3306/project", "root", "Devaseesh*2005");

                // Check if the activity has available slots
                ps2 = conn2.prepareStatement("SELECT count FROM activities WHERE title = ?");
                ps2.setString(1, activity);
                rs2 = ps2.executeQuery();
                if (rs2.next()) {
                    int availableCount = rs2.getInt("count");

                    if (availableCount > 0) {
                        // Register the user for the activity
                        ps2 = conn2.prepareStatement("INSERT INTO registered (activity_name, count) VALUES (?, 1) ON DUPLICATE KEY UPDATE count = count + 1");
                        ps2.setString(1, activity);
                        ps2.executeUpdate();

                        // Update the count of available slots
                        ps2 = conn2.prepareStatement("UPDATE activities SET count = count - 1 WHERE title = ?");
                        ps2.setString(1, activity);
                        ps2.executeUpdate();

                        out.println("<p>Registered for " + activity + " successfully!</p>");
                    } else {
                        out.println("<p>No slots available for this activity.</p>");
                    }
                } else {
                    out.println("<p>Activity not found.</p>");
                }
            } catch (Exception e) {
                out.println("<p>Error: " + e.getMessage() + "</p>");
                e.printStackTrace();
            } finally {
                if (rs2 != null) {
                    try {
                        rs2.close();
                    } catch (SQLException e) {
                        e.printStackTrace();
                    }
                }
                if (ps2 != null) {
                    try {
                        ps2.close();
                    } catch (SQLException e) {
                        e.printStackTrace();
                    }
                }
                if (conn2 != null) {
                    try {
                        conn2.close();
                    } catch (SQLException e) {
                        e.printStackTrace();
                    }
                }
            }
        }
    %>
</body>
</html>
