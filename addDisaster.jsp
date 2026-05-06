<%@ include file="Connection.jsp" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<html>
    <head>
        <title>Add Disaster</title>
        <style>
            body {
                font-family: Arial;
                background: #f0f4f8; /* light grey-blue*/ 
                color: #333; /* dark grey */
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
                color: #ffffff; /* white */
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
            }

            nav ul li a:hover {
                background-color: #d9e2ec; /* light grey */
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
                background-color: #d9e2ec; /* light grey */
                color: #1e3a5f;
            }

            nav ul li:hover .dropdown {
                display: block;
            }

            main {
                padding: 50px;
                text-align: center;
            }

            form {
                background: #ffffff; 
                padding: 25px;
                border-radius: 10px;
                display: inline-block;
                box-shadow: 0 4px 8px rgba(0,0,0,0.1); /* subtle grey shadow */
            }

            input, select {
                padding: 10px;
                margin: 10px;
                width: 250px;
                border: 1px solid #ccc; /* grey border */
                border-radius: 5px;
            }

            input[type=submit] {
                background: #1e3a5f; /* deep blue button */
                color: #ffffff; /* white text */
                border: none;
                cursor: pointer;
            }

            input[type=submit]:hover {
                background: #3a506b; /* blue-grey hover */
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
        <main>
            <h2>Disaster Entry Form</h2>
            <form action="disasterProcess.jsp" method="post">
                <label for="disaster_id">Disaster ID:</label><br>
                <input type="number" id="disaster_id" name="disaster_id" required><br><br>

                <label for="disaster_name">Disaster Name:</label><br>
                <input type="text" id="disaster_name" name="disaster_name" maxlength="100" required><br><br>

                <label for="location">Location:</label><br>
                <input type="text" id="location" name="location" maxlength="100" required><br><br>

                <label for="disaster_type">Disaster Type:</label><br>
                <input type="text" id="disaster_type" name="disaster_type" maxlength="50" required><br><br>

                <label for="disaster_date">Disaster Date:</label><br>
                <input type="date" id="disaster_date" name="disaster_date" required><br><br>

                <label for="status">Status:</label><br>
                <select id="status" name="status" required>
                    <option value="Active">Active</option>
                    <option value="Resolved">Resolved</option>
                    <option value="Ongoing">Ongoing</option>
                </select><br><br>

                <input type="submit" value="Submit">
            </form>
        </main>
    </body>
</html>