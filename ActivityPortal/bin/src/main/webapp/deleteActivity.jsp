<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Delete Activity</title>
</head>
<body>
    <h2>Delete Activity</h2>
    <%
        Connection conn = null;
        PreparedStatement ps = null;
        String id = request.getParameter("id");

        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/project", "root", "Devaseesh*2005");

            if (id != null) {
                ps = conn.prepareStatement("DELETE FROM activities WHERE id = ?");
                ps.setInt(1, Integer.parseInt(id));
                int rowsAffected = ps.executeUpdate();

                if (rowsAffected > 0) {
                    out.println("<p>Activity deleted successfully.</p>");
                } else {
                    out.println("<p>Activity not found.</p>");
                }
            }
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
    %>
</body>
</html>
