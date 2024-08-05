<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Edit Activity</title>
</head>
<body>
    <h2>Edit Activity</h2>
    <%
        Connection conn = null;
        PreparedStatement ps = null;
        ResultSet rs = null;
        String id = request.getParameter("id");

        if (id != null) {
            try {
                Class.forName("com.mysql.cj.jdbc.Driver");
                conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/project", "root", "Devaseesh*2005");

                ps = conn.prepareStatement("SELECT * FROM activities WHERE id = ?");
                ps.setInt(1, Integer.parseInt(id));
                rs = ps.executeQuery();

                if (rs.next()) {
                    String title = rs.getString("title");
                    String description = rs.getString("description");
                    int count = rs.getInt("count"); // Retrieve count
    %>
        <form action="updateActivity.jsp" method="post">
            <input type="hidden" name="id" value="<%= id %>">
            <label for="title">Title:</label>
            <input type="text" id="title" name="title" value="<%= title %>" required>
            <br><br>
            <label for="description">Description:</label>
            <textarea id="description" name="description" required><%= description %></textarea>
            <br><br>
            <label for="count">Count:</label>
            <input type="number" id="count" name="count" value="<%= count %>" required>
            <br><br>
            <input type="submit" value="Update">
        </form>
    <%
                } else {
                    out.println("<p>Activity not found.</p>");
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
        }
    %>
    <a href="activities.jsp">Back to Activities</a>
</body>
</html>
