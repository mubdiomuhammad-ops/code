<%@ page import="java.sql.*" %>
<%@ include file="Connection.jsp" %>

<html>
    <head>
        <title>Donations</title>
        <style>
            body {
                background: #f0f4f8; /* light grey-blue background */
                color: #333;         /* dark grey text */
                font-family: Arial, sans-serif;
                margin: 0;
                padding: 0;
            }

            /* Header & Navbar */
            header {
                background-color: #1e3a5f; /* deep blue */
                padding: 15px 40px;
            }

            nav {
                display: flex;
                justify-content: space-between;
                align-items: center;
            }

            .logo {
                font-size: 22px;
                font-weight: bold;
                color: #ffffff; /* white logo text */
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
                color: #ffffff; /* white links */
                text-decoration: none;
                padding: 8px 12px;
                font-size: 16px;
            }

            nav ul li a:hover {
                background-color: #d9e2ec; /* light grey hover */
                color: #1e3a5f;
                border-radius: 5px;
            }

            .dropdown {
                display: none;
                position: absolute;
                background-color: #3a506b; /* muted blue-grey */
                min-width: 180px;
                top: 35px;
                left: 0;
                border-radius: 5px;
            }

            .dropdown li a {
                display: block;
                padding: 10px;
                color: #ffffff;
            }

            .dropdown li a:hover {
                background-color: #d9e2ec;
                color: #1e3a5f;
            }

            nav ul li:hover .dropdown {
                display: block;
            }

            /* Table Styling */
            h2 {
                text-align: center;
                color: #1e3a5f; /* deep blue heading */
                margin-top: 20px;
            }

            table {
                width: 90%;
                margin: 40px auto;
                border-collapse: collapse;
                background: #ffffff; /* white table background */
                box-shadow: 0 4px 12px rgba(0,0,0,0.1);
            }

            th, td {
                padding: 12px;
                border: 1px solid #ccc; /* grey border */
                text-align: center;
            }

            th {
                background: #1e3a5f; /* deep blue header */
                color: #ffffff;      /* white text */
            }

            tr:nth-child(even) {
                background: #f0f4f8; /* light grey-blue row */
            }

            tr:nth-child(odd) {
                background: #ffffff; /* white row */
            }

            /* Links & Buttons */
            a {
                color: #1e3a5f;
                text-decoration: none;
                font-weight: bold;
            }

            a:hover {
                color: #3a506b;
            }

            .btn-container {
                text-align: center; /* centers the button horizontally */
                margin-top: 20px;
            }
            .btn {
                display: inline-block;
                padding: 12px 25px;
                background-color: #1e3a5f; /* deep blue */
                color: #ffffff;
                text-decoration: none;
                border-radius: 6px;
                font-weight: bold;
                transition: background-color 0.3s ease, color 0.3s ease;
                margin: 20px auto;
            }

            .btn:hover {
                background-color: #d9e2ec; /* grey hover */
                color: #1e3a5f;
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
        <h2>All Donations</h2>

        <table>
            <tr>
                <th>ID</th><th>Donor</th><th>Disaster</th><th>Type</th><th>Amount</th><th>Goods</th><th>Date</th><th>Actions</th>
            </tr>

            <%    Statement st = conn.createStatement();
                ResultSet rs = st.executeQuery(
                        "SELECT d.donation_id, r.donor_name, s.disaster_name, "
                        + "d.donation_type, d.amount, d.goods_description, d.donation_date "
                        + "FROM donations d "
                        + "JOIN donors r ON d.donor_id = r.donor_id "
                        + "JOIN disasters s ON d.disaster_id = s.disaster_id"
                );

                while (rs.next()) {
            %>
            <tr>
                <td><%= rs.getInt("donation_id")%></td>
                <td><%= rs.getString("donor_name")%></td>
                <td><%= rs.getString("disaster_name")%></td>
                <td><%= rs.getString("donation_type")%></td>
                <td><%= rs.getString("amount")%></td>
                <td><%= rs.getString("goods_description")%></td>
                <td><%= rs.getDate("donation_date")%></td>
                <td>
                    <a href="updateDonation.jsp?id=<%= rs.getInt("donation_id")%>">Update</a> |
                    <a href="delete.jsp?type=donation&id=<%= rs.getInt("donation_id")%>">Delete</a>
                </td>
            </tr>

            <% }%>

        </table>
        <div class="btn-container"> <a href="home.jsp" class="btn">Back to Home</a> </div>
    </body>
</html>