<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Delete User</title>
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
        p {
            color: #6c757d;
        }
    </style>
</head>
<body>
    <h2>Delete User</h2>
    <%
        int id = Integer.parseInt(request.getParameter("id"));

        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/project", "root", "Devaseesh*2005");
            PreparedStatement ps = conn.prepareStatement("DELETE FROM users WHERE id=?");
            ps.setInt(1, id);
            ps.executeUpdate();

            out.println("<p>User deleted successfully!</p>");
            response.sendRedirect("admin_dashboard.jsp");
        } catch (Exception e) {
            out.println("<p>Error: " + e.getMessage() + "</p>");
        }
    %>
</body>
</html>
