<%@ page import="java.sql.*" %>
<%@ include file="Connection.jsp" %>

<!DOCTYPE html>
<html>
    <head>
        <title>Distribution Records</title>
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
                background-color: #3a506b; /* muted blue-grey dropdown */
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
                background: #f0f4f8; /* light grey-blue alternate rows */
            }

            tr:nth-child(odd) {
                background: #ffffff; /* white rows */
            }

            tr:hover {
                background: #d9e2ec; /* subtle grey hover */
            }
             a {
                color: #1e3a5f;
                text-decoration: none;
                font-weight: bold;
            }

            a:hover {
                color: #3a506b;
            }

            /* Button Styling */
            .btn-container {
                text-align: center;
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
        <h2>Distribution Records</h2>

        <table>
            <tr>
                <th>ID</th><th>Donation</th><th>Type</th><th>Relief Center</th><th>Receiver</th><th>Goods/Amount</th><th>Date</th><th>Actions</th>
            </tr>

            <%    Statement st = conn.createStatement();
                ResultSet rs = st.executeQuery(
                        "SELECT dist.distribution_id, d.donation_id, d.donation_type, d.goods_description, d.amount, dist.relief_center, dist.distributed_to, dist.quantity, dist.distribution_date "
                        + "FROM distribution dist JOIN donations d ON dist.donation_id=d.donation_id"
                );
                while (rs.next()) {
                    String type = rs.getString("donation_type");
            %>
            <tr>
                <td><%=rs.getInt("distribution_id")%></td>
                <td><%=rs.getInt("donation_id")%></td>
                <td><%=type%></td>
                <td><%=rs.getString("relief_center")%></td>
                <td><%=rs.getString("distributed_to")%></td>
                <td><%=("GOODS".equalsIgnoreCase(type) ? rs.getString("goods_description") : rs.getDouble("amount"))%></td>
                <td><%=rs.getDate("distribution_date")%></td>
                <td>
                     <a href="delete.jsp?type=distribution&id=<%= rs.getInt("distribution_id")%>">Delete</a>
                </td>
            </tr>
            <% }%>
        </table>
        <div class="btn-container"> <a href="home.jsp" class="btn">Back to Home</a> </div>


    </body>
</html>