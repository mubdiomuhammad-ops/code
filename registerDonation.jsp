

<%-- 
    Document   : register.jsp
    Created on : Feb 10, 2026, 9:40:44 AM
    Author     : Lam
--%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ include file="Connection.jsp" %> 
<!DOCTYPE html>
<html>
    <head>
        <title>Register Donation</title>
        <style>
            body {
                font-family: Arial, sans-serif;
                background: #f0f4f8;
                color: #333;         
                margin: 0;
                padding: 0;
                display: flex;
                flex-direction: column;
                min-height: 100vh;
            }

           
            header {
                background-color: #1e3a5f;
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
                color: #ffffff;
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
                background-color: #d9e2ec;
                color: #1e3a5f; 
                border-radius: 5px;
            }

            .dropdown {
                display: none;
                position: absolute;
                background-color: #3a506b;
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

            main {
                flex: 1;
            }

            h2 {
                text-align: center;
                color: #1e3a5f; 
                margin-top: 20px;
            }

            form {
                background: #ffffff;
                max-width: 500px;
                margin: 30px auto;
                padding: 25px;
                border-radius: 10px;
                box-shadow: 0 4px 12px rgba(0,0,0,0.1);
            }

            label {
                font-weight: bold;
                display: block;
                margin-bottom: 6px;
                color: #333;
            }

            input[type="text"],
            input[type="number"],
            select {
                width: 100%;
                padding: 10px;
                margin-bottom: 15px;
                border: 1px solid #ccc; 
                border-radius: 6px;
                background: #f9f9f9;
                color: #333;
                font-size: 14px;
            }

            input[type="text"]::placeholder,
            input[type="number"]::placeholder {
                color: #888;
            }

            input[type="submit"] {
                background: #1e3a5f;
                color: #ffffff;
                padding: 10px 18px;
                border: none;
                border-radius: 6px;
                font-size: 15px;
                cursor: pointer;
                transition: background 0.3s ease, transform 0.2s ease;
            }

            input[type="submit"]:hover {
                background: #3a506b; 
                transform: scale(1.05);
            }

            .field-group {
                margin-bottom: 15px;
            }

            /* Section separation */
            #moneyFields, #goodsFields {
                background: #f0f4f8;
                padding: 12px;
                border-radius: 6px;
                margin-bottom: 15px;
                border: 1px solid #ccc;
            }

            footer {
                text-align: center;
                padding: 15px;
                background: #e0e6ed;
                color: #555;
                font-size: 14px;
                margin-top: auto;
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
            <h2>Register a Donation</h2>
            <form action="registerDonationProcess.jsp" method="post">



                <div class="field-group">
                    <label>Donor Name:</label>
                    <input type="text" name="donor_name" placeholder="Enter donor name" required>
                </div>

                <div class="field-group">
                    <label>Contact:</label>
                    <input type="number" name="contact" placeholder="Enter contact number" required>
                </div>

                <div class="field-group">
                    <label>Disasters:</label>
                    <select name="disaster" required>
                        <%                ResultSet rs = conn.createStatement().executeQuery("SELECT * FROM disasters");
                            while (rs.next()) {
                        %>
                        <option value="<%= rs.getInt(1)%>"><%= rs.getString(2)%></option>
                        <% }%>
                    </select>
                </div>

                <div class="field-group">
                    <label>Donation Type:</label>
                    <select name="type" id="donation_type" onchange="toggleFields()" required>
                        <option value="">--Select--</option>
                        <option value="money">Money</option>
                        <option value="goods">Goods</option>
                    </select>
                </div>

                <div id="moneyFields" style="display:none;">
                    <label>Amount:</label>
                    <input type="number" name="amount" min="1" step="0.01" placeholder="Enter donation amount">
                </div>

                <div id="goodsFields" style="display:none;">
                    <label>Goods Description:</label>
                    <input type="text" name="goods" placeholder="Describe the goods">
                </div>

                <input type="submit" value="Submit">

            </form>

        </main>

        <footer>
            &copy; 2025 Charity Donation Management System | Built with love️ to support communities
        </footer>
        <script>
            function toggleFields() {
                var type = document.getElementById("donation_type").value;
                document.getElementById("moneyFields").style.display = (type === "money") ? "block" : "none";
                document.getElementById("goodsFields").style.display = (type === "goods") ? "block" : "none";
            }
        </script>
    </body>
</html>

