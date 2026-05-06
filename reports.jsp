<%@ page import="java.sql.*" %>
<%@ include file="Connection.jsp" %>

<html>
<head>
    <title>Relief Reports</title>
    <style>
        body {
            background: linear-gradient(to right, #f7f9fc, #e6ebf1); 
            color: #333;
            font-family: 'Segoe UI', Arial, Helvetica, sans-serif;
            margin: 0;
        }

        header {
            background: linear-gradient(90deg, #1e3a5f, #27496d);
            padding: 15px 40px;
            box-shadow: 0 4px 6px rgba(0,0,0,0.2);
        }

        nav {
            display: flex;
            justify-content: space-between;
            align-items: center;
        }

        .logo {
            font-size: 24px;
            font-weight: bold;
            color: #ffffff;
            letter-spacing: 1px;
        }

        nav ul {
            list-style: none;
            display: flex;
            gap: 25px;
            padding: 0;
            margin: 0;
        }

        nav ul li {
            position: relative;
        }

        nav ul li a {
            color: #ffffff;
            text-decoration: none;
            padding: 8px 12px;
            font-size: 16px;
            transition: all 0.3s ease;
        }

        nav ul li a:hover {
            background-color: #ffffff;
            color: #1e3a5f;
            border-radius: 5px;
            box-shadow: 0 2px 6px rgba(0,0,0,0.2);
        }

        .dropdown {
            display: none;
            position: absolute;
            background-color: #2c3e50;
            min-width: 180px;
            top: 35px;
            left: 0;
            border-radius: 5px;
            box-shadow: 0 4px 8px rgba(0,0,0,0.3);
            animation: fadeIn 0.3s ease;
        }

        .dropdown li a {
            display: block;
            padding: 10px;
            color: #ffffff;
            transition: background 0.3s ease;
        }

        .dropdown li a:hover {
            background-color: #ffffff;
            color: #1e3a5f;
        }

        nav ul li:hover .dropdown {
            display: block;
        }

        .container {
            width: 85%;
            margin: 40px auto;
            display: flex;
            flex-direction: column;
            gap: 40px;
        }

        .card {
            background: #ffffff;
            padding: 25px;
            border-radius: 12px;
            box-shadow: 0 6px 12px rgba(0,0,0,0.1);
            transition: transform 0.3s ease;
        }

        .card:hover {
            transform: translateY(-5px);
        }

        h2 {
            color: #1e3a5f;
            text-align: center;
            margin-bottom: 20px;
        }

        table {
            width: 100%;
            border-collapse: collapse;
            margin-top: 10px;
        }

        th, td {
            padding: 12px;
            border: 1px solid #ccc;
            text-align: center;
            font-size: 15px;
        }

        th {
            background: #1e3a5f;
            color: #ffffff;
        }

        tr:nth-child(even) {
            background-color: #f9f9f9;
        }

        tr:hover {
            background-color: #e6ebf1;
        }

        @keyframes fadeIn {
            from {opacity: 0;}
            to {opacity: 1;}
        }
    </style>
</head>

<body>
    <header>
        <nav>
            <div class="logo">Donation System</div>
            <ul>
                <li><a href="home.jsp">Home</a></li>
                <li>
                    <a href="#">Register</a>
                    <ul class="dropdown">
                        <li><a href="addDisaster.jsp">Add Disasters</a></li>
                        <li><a href="registerDonation.jsp">Donor & Donation</a></li>
                        <li><a href="distribution.jsp">Distribute</a></li>
                    </ul>
                </li>
                <li>
                    <a href="#">View</a>
                    <ul class="dropdown">
                        <li><a href="viewDonations.jsp">View Donations</a></li>
                        <li><a href="viewDisasters.jsp">View Disasters</a></li>
                        <li><a href="viewDistribution.jsp">View Distribution</a></li>
                    </ul>
                </li>
                <li><a href="reports.jsp">Relief Reports</a></li>
            </ul>
        </nav>
    </header>

    <div class="container">
        <div class="card">
            <h2>Donation Summary</h2>
            <table>
                <tr><th>Total Donations</th><th>Total Money</th><th>Total Goods</th></tr>
                <%
                    Statement st = conn.createStatement();
                    ResultSet rs = st.executeQuery(
                        "SELECT COUNT(*), NVL(SUM(amount),0), COUNT(CASE WHEN donation_type='GOODS' THEN 1 END) FROM donations"
                    );
                    rs.next();
                %>
                <tr>
                    <td><%=rs.getInt(1)%></td>
                    <td><%=rs.getDouble(2)%></td>
                    <td><%=rs.getInt(3)%></td>
                </tr>
            </table>
        </div>

        <div class="card">
            <h2>Distribution Summary</h2>
            <table>
                <tr><th>Total Distributions</th><th>People Helped</th></tr>
                <%
                    ResultSet rs2 = st.executeQuery("SELECT COUNT(*), COUNT(DISTINCT DISTRIBUTED_TO) FROM distribution");
                    rs2.next();
                %>
                <tr>
                    <td><%=rs2.getInt(1)%></td>
                    <td><%=rs2.getInt(2)%></td>
                </tr>
            </table>
        </div>
    </div>
</body>
</html>