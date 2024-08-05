<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Edit User</title>
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
        input[type="email"],
        input[type="password"],
        textarea {
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
    </style>
</head>
<body>
    <h2>Edit User</h2>
    <%
        int id = Integer.parseInt(request.getParameter("id"));
        if (request.getMethod().equalsIgnoreCase("POST")) {
            String username = request.getParameter("username");
            String email = request.getParameter("email");

            try {
                Class.forName("com.mysql.cj.jdbc.Driver");
                Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/project", "root", "Devaseesh*2005");
                PreparedStatement ps = conn.prepareStatement("UPDATE users SET username=?, email=? WHERE id=?");
                ps.setString(1, username);
                ps.setString(2, email);
                ps.setInt(3, id);
                ps.executeUpdate();

                out.println("<p>User updated successfully!</p>");
                response.sendRedirect("admin_dashboard.jsp");
            } catch (Exception e) {
                out.println("<p>Error: " + e.getMessage() + "</p>");
            }
        } else {
            try {
                Class.forName("com.mysql.cj.jdbc.Driver");
                Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/project", "root", "Devaseesh*2005");
                PreparedStatement ps = conn.prepareStatement("SELECT * FROM users WHERE id=?");
                ps.setInt(1, id);
                ResultSet rs = ps.executeQuery();
                if (rs.next()) {
                    String username = rs.getString("username");
                    String email = rs.getString("email");
            %>
                    <form action="edit_user.jsp?id=<%= id %>" method="post">
                        <label for="username">Username:</label>
                        <input type="text" id="username" name="username" value="<%= username %>" required><br><br>
                        <label for="email">Email:</label>
                        <input type="email" id="email" name="email" value="<%= email %>" required><br><br>
                        <input type="submit" value="Update">
                    </form>
            <%
                }
            } catch (Exception e) {
                out.println("<p>Error: " + e.getMessage() + "</p>");
            }
        }
    %>
</body>
</html>
