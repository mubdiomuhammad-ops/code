<%@ include file="Connection.jsp" %>
<%@ page import="java.sql.*" %>
<html>
    <head><title>Distribute Donations</title>

        <style>
            body {
                font-family: Arial;
                background: #f0f4f8; /* light grey-blue background */
                color: #333; /* dark grey text */
                margin: 0;
                padding: 0;
            }

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
                color: #1e3a5f; /* deep blue text */
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
                background-color: #d9e2ec; /* light grey hover */
                color: #1e3a5f;
            }

            nav ul li:hover .dropdown {
                display: block;
            }

            /* Page Content */
            h2 {
                text-align: center;
                color: #1e3a5f; /* deep blue heading */
                margin-top: 20px;
            }

            form {
                background: #ffffff; /* white form background */
                max-width: 500px;
                margin: 30px auto;
                padding: 25px;
                border-radius: 10px;
                box-shadow: 0 4px 12px rgba(0,0,0,0.1); /* subtle grey shadow */
            }

            label {
                font-weight: bold;
                display: block;
                margin-bottom: 6px;
                color: #333;
            }

            input[type="text"],
            input[type="date"],
            select {
                width: 100%;
                padding: 10px;
                margin-bottom: 15px;
                border: 1px solid #ccc; /* grey border */
                border-radius: 6px;
                background: #f9f9f9; /* light grey input background */
                color: #333;
                font-size: 14px;
            }

            input[type="text"]::placeholder {
                color: #888;
            }

            input[type="submit"] {
                background: #1e3a5f; /* deep blue button */
                color: #ffffff;
                padding: 10px 18px;
                border: none;
                border-radius: 6px;
                font-size: 15px;
                cursor: pointer;
                transition: background 0.3s ease, transform 0.2s ease;
               
            }

            input[type="submit"]:hover {
                background: #3a506b; /* blue-grey hover */
                transform: scale(1.05);
                
            }

            /* Back link */
            a {
                display: block;
                text-align: center;
                margin: 20px auto;
                color: #1e3a5f;
                text-decoration: none;
                font-weight: bold;
            }

            a:hover {
                color: #3a506b;
            }
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
        <h2>Distribute Donations to Relief Centers</h2>
        <form action="distributionProcess.jsp" method="post">
            <label>Select Donation:</label>
            <select name="donation_id" required>
                <option value="">--Select Donation--</option>
                <%            Statement stmt = conn.createStatement();
                    String donationQuery
                            = "SELECT d.donation_id, dn.donor_name, d.donation_type "
                            + "FROM donations d "
                            + "JOIN donors dn ON d.donor_id = dn.donor_id "
                            + "WHERE d.donation_id NOT IN (SELECT donation_id FROM distribution)";
                    ResultSet rs = stmt.executeQuery(donationQuery);
                    while (rs.next()) {
                %>
                <option value="<%=rs.getInt("donation_id")%>">
                    <%= rs.getString("donor_name") + " (" + rs.getString("donation_type") + ")"%>
                </option>
                <%
                    }
                    rs.close();
                    stmt.close();
                %>
            </select><br>

            <label>Relief Center:</label>
            <input type="text" name="relief_center" maxlength="100" required><br>

            <label>Distributed To:</label>
            <input type="text" name="distributed_to" maxlength="100" required><br>

            <label>Quantity:</label>
            <input type="text" name="quantity" maxlength="50" required><br>

            <label>Distribution Date:</label>
            <input type="date" name="distribution_date" required><br>

            <input type="submit" value="Distribute">
        </form>

        <div class="btn-container"> <a href="home.jsp" class="btn">Home</a> </div>
    </body>
</html>