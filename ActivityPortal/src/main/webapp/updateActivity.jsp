<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Update Activity</title>
</head>
<body>
    <h2>Update Activity</h2>
    <%
        Connection conn = null;
        PreparedStatement ps = null;
        String id = request.getParameter("id");
        String title = request.getParameter("title");
        String description = request.getParameter("description");
        String countStr = request.getParameter("count");

        if (id == null || id.isEmpty() || title == null || title.isEmpty() || description == null || description.isEmpty() || countStr == null || countStr.isEmpty()) {
            out.println("<p>Error: Title, Description, or Count is missing.</p>");
        } else {
            try {
                Class.forName("com.mysql.cj.jdbc.Driver");
                conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/project", "root", "Devaseesh*2005");

                int count = Integer.parseInt(countStr);

                ps = conn.prepareStatement("UPDATE activities SET title = ?, description = ?, count = ? WHERE id = ?");
                ps.setString(1, title);
                ps.setString(2, description);
                ps.setInt(3, count);
                ps.setInt(4, Integer.parseInt(id));

                int rowsUpdated = ps.executeUpdate();

                if (rowsUpdated > 0) {
                    out.println("<p>Activity updated successfully!</p>");
                } else {
                    out.println("<p>Error: Activity not found or update failed.</p>");
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
        }
    %>
    <a href="activities.jsp">Back to Activities</a>
</body>
</html>
