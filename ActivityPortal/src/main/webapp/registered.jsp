<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Registered Activities</title>
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
        table {
            width: 80%;
            margin: 20px auto;
            border-collapse: collapse;
        }
        table, th, td {
            border: 1px solid #ced4da;
        }
        th, td {
            padding: 10px;
            text-align: left;
        }
        th {
            background-color: #007bff;
            color: white;
        }
        tr:nth-child(even) {
            background-color: #f2f2f2;
        }
    </style>
</head>
<body>
    <h2>Registered Activities</h2>
    <table>
        <thead>
            <tr>
                <th>Activity Name</th>
                <th>Count of Registered Users</th>
            </tr>
        </thead>
        <tbody>
            <%
                Connection conn = null;
                PreparedStatement ps = null;
                ResultSet rs = null;
                
                try {
                    Class.forName("com.mysql.cj.jdbc.Driver");
                    conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/project", "root", "Devaseesh*2005");
                    
                    // Fetch the activity names and count of registered users
                    String query = "SELECT activity_name, COUNT(*) as registered_count FROM registered GROUP BY activity_name";
                    ps = conn.prepareStatement(query);
                    rs = ps.executeQuery();
                    
                    // Display data in the table
                    while (rs.next()) {
                        String activityName = rs.getString("activity_name");
                        int registeredCount = rs.getInt("registered_count");
            %>
                        <tr>
                            <td><%= activityName %></td>
                            <td><%= registeredCount %></td>
                        </tr>
            <%
                    }
                } catch (Exception e) {
                    out.println("<tr><td colspan='2'>Error: " + e.getMessage() + "</td></tr>");
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
        </tbody>
    </table>
</body>
</html>
