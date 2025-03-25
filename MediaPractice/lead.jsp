<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Lead Management System</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            text-align: center;
            margin: 20px;
            background-color: #f4f4f4;
        }
        .container {
            max-width: 800px;
            margin: auto;
            background: white;
            padding: 20px;
            border-radius: 8px;
            box-shadow: 0 2px 10px rgba(0, 0, 0, 0.1);
        }
        table {
            width: 100%;
            border-collapse: collapse;
            margin-top: 20px;
        }
        th, td {
            padding: 12px;
            border: 1px solid #ddd;
            text-align: center;
        }
        th {
            background-color: #4CAF50;
            color: white;
        }
        .high-score {
            background-color: #ffcccb;
            color: red;
            font-weight: bold;
        }
    </style>
</head>
<body>

    <div class="container">
        <h2>Lead Management System</h2>

        <!-- Form to Add a Lead -->
        <form action="AddLeadServlet" method="post">
            <label for="name">Name:</label>
            <input type="text" name="name" required>
            <label for="email">Email:</label>
            <input type="email" name="email" required>
            <button type="submit">Add Lead</button>
        </form>

        <!-- Display Leads -->
        <table>
            <thead>
                <tr>
                    <th>Name</th>
                    <th>Email</th>
                    <th>Lead Score</th>
                </tr>
            </thead>
            <tbody>
                <%
                    // Database connection
                    String JDBC_URL = "jdbc:mysql://localhost:3306/DairyProducts";
                    String DB_USER = "root";
                    String DB_PASSWORD = "Nagu@2004";

                    try {
                        Class.forName("com.mysql.cj.jdbc.Driver");
                        Connection conn = DriverManager.getConnection(JDBC_URL, DB_USER, DB_PASSWORD);
                        String sql = "SELECT name, email, lead_count FROM users";
                        PreparedStatement stmt = conn.prepareStatement(sql);
                        ResultSet rs = stmt.executeQuery();

                        while (rs.next()) {
                            int leadScore = rs.getInt("lead_count");
                            String rowClass = (leadScore > 5) ? "high-score" : "";
                %>
                            <tr class="<%= rowClass %>">
                                <td><%= rs.getString("name") %></td>
                                <td><%= rs.getString("email") %></td>
                                <td><%= leadScore %></td>
                            </tr>
                <%
                        }
                        conn.close();
                    } catch (Exception e) {
                        e.printStackTrace();
                    }
                %>
            </tbody>
        </table>
    </div>

</body>
</html>
