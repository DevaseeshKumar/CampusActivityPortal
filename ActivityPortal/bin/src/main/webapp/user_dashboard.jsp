<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>User Dashboard</title>
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
        h3 {
            color: #343a40;
            margin-top: 20px;
        }
        div {
            margin: 20px auto;
            width: 80%;
            text-align: left;
            padding: 10px;
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
        /* Profile form styles */
        .profile-form {
            margin: 20px auto;
            width: 60%;
            text-align: left;
            padding: 20px;
            border: 1px solid #ced4da;
            border-radius: 4px;
            background-color: #ffffff;
        }
        .profile-form label {
            display: block;
            margin: 10px 0 5px;
        }
        .profile-form input[type="text"],
        .profile-form input[type="email"],
        .profile-form input[type="password"] {
            width: 100%;
            padding: 8px;
            margin-bottom: 10px;
            border: 1px solid #ced4da;
            border-radius: 4px;
        }
        .profile-form input[type="submit"] {
            background-color: #28a745;
            color: white;
            border: none;
            padding: 10px 20px;
            cursor: pointer;
            border-radius: 4px;
            transition: background-color 0.3s;
        }
        .profile-form input[type="submit"]:hover {
            background-color: #218838;
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

    <h2>User Dashboard</h2>

    <% 
        String username = (String) session.getAttribute("username");
        if (username != null) {
    %>
        <p>Welcome, <%= username %>!</p>
    <% 
        } else {
            response.sendRedirect("login.jsp");
        }
    %>

    <h3>Edit Profile</h3>
    <form action="user_dashboard.jsp" method="post">
        <input type="submit" name="edit_profile" value="Edit Profile">
    </form>

    <% if (request.getMethod().equalsIgnoreCase("POST") && request.getParameter("edit_profile") != null) { %>
        <form action="updateProfile.jsp" method="post" class="profile-form">
            <label for="newUsername">New Username:</label>
            <input type="text" id="newUsername" name="newUsername" required><br><br>
            <label for="newEmail">New Email:</label>
            <input type="email" id="newEmail" name="newEmail" required><br><br>
            <label for="newPassword">New Password:</label>
            <input type="password" id="newPassword" name="newPassword" required><br><br>
            <input type="submit" value="Update Profile">
        </form>
    <% } %>

</body>
</html>
