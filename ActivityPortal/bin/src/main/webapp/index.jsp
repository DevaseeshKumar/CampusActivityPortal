<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Campus Activity Portal</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f8f9fa;
            margin: 0;
            padding: 0;
            color: #343a40;
            text-align: center;
        }
        h1 {
            color: #343a40;
            margin-top: 20px;
        }
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
    </style>
</head>
<body>
    <h1>Welcome to Campus Activity Portal</h1>
    <nav>
        <ul>
            <li><a href="home.jsp">Home</a></li>
            <li><a href="login.jsp">Login</a></li>
            <li><a href="register.jsp">Register</a></li>
        </ul>
    </nav>
</body>
</html>
