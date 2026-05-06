<%@ include file="Connection.jsp" %>
<%@ page import="java.sql.*" %>
<%    int id = Integer.parseInt(request.getParameter("id"));
    PreparedStatement ps = conn.prepareStatement(
            "SELECT d.donation_id, d.donation_type, d.amount, d.goods_description, "
            + "d.disaster_id, dn.donor_name "
            + "FROM DONATIONS d "
            + "JOIN DONORS dn ON d.donor_id = dn.donor_id "
            + "WHERE d.donation_id=?"
    );
    ps.setInt(1, id);
    ResultSet rs = ps.executeQuery();
    if (rs.next()) {
%>
<html>
    <head><title>Update Donation</title>
        <style>
            body {
                background: #f0f0f0; 
                color: #000000;
                font-family: Arial, Helvetica, sans-serif;
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
                background-color: #d9d9d9; 
                color: #1e3a5f;
                border-radius: 5px;
            }

            .dropdown {
                display: none;
                position: absolute;
                background-color: #2c3e50;
                min-width: 180px;
                top: 35px;
                left: 0;
                border-radius: 5px;
            }

            .dropdown li {
                display: block;
            }

            .dropdown li a {
                display: block;
                padding: 10px;
                color: #ffffff;
            }

            .dropdown li a:hover {
                background-color: #d9d9d9; 
                color: #1e3a5f; 
            }

            nav ul li:hover .dropdown {
                display: block;
            }
            h2 {
                color: #1e3a5f;
                text-align: center;
            }

           
          

         
            form {
                width: 450px;
                margin: 40px auto;
                padding: 25px;
                background-color: #ffffff; 
                border-radius: 10px;
                box-shadow: 0px 4px 12px rgba(0, 0, 0, 0.1);
            }

          
            h2 {
                text-align: center;
                color: #1b3c73;  
            }

           
            form label {
                font-weight: bold;
                color: #333;
            }

            
            input[type="text"],
            input[type="number"],
            select {
                width: 100%;
                padding: 8px 10px;
                margin: 8px 0 15px 0;
                border: 1px solid #ccc;
                border-radius: 6px;
                background-color: #f9fafc;   
                transition: 0.3s;
            }

           
            input:focus,
            select:focus {
                border-color: #1b3c73;
                outline: none;
                box-shadow: 0 0 5px rgba(27, 60, 115, 0.3);
            }

           
            #moneyFields,
            #goodsFields {
                background-color: #eef2f7; 
                padding: 12px;
                border-radius: 6px;
                margin-bottom: 15px;
            }




            .btn-container {
                text-align: center;
                margin-top: 20px;
            }
            .btn {
                display: inline-block;
                padding: 12px 25px;
                background-color: #1e3a5f;
                color: #ffffff;
                text-decoration: none;
                border-radius: 6px;
                font-weight: bold;
                transition: background-color 0.3s ease, color 0.3s ease;
                margin: 20px auto;
            }

            .btn:hover {
                background-color: #d9e2ec;
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
        <h2>Update Donation</h2>
        <form action="updateDonationProcess.jsp" method="post">
            <input type="hidden" name="donation_id" value="<%=rs.getInt("donation_id")%>">

            Donor Name: <input type="text" name="donor_name" 
                               value="<%=rs.getString("donor_name")%>" required><br>
            Donation Type:
            <select name="donation_type" id="donation_type" onchange="toggleFields()" required>
                <option value="money" <%= "money".equals(rs.getString("donation_type")) ? "selected" : ""%>>Money</option>
                <option value="goods" <%= "goods".equals(rs.getString("donation_type")) ? "selected" : ""%>>Goods</option>
            </select><br>

            <div id="moneyFields" style="display:<%= "money".equals(rs.getString("donation_type")) ? "block" : "none"%>;">
                Amount: <input type="number" name="amount" value="<%=rs.getObject("amount") != null ? rs.getDouble("amount") : ""%>">
            </div>

            <div id="goodsFields" style="display:<%= "goods".equals(rs.getString("donation_type")) ? "block" : "none"%>;">
                Goods Description: <input type="text" name="goods_description" value="<%=rs.getString("goods_description")%>">
            </div>

            Assign to Disaster (Optional):
            <select name="disaster_id">
                <option value="">--None--</option>
                <%
                    Statement stmt2 = conn.createStatement();
                    ResultSet rs2 = stmt2.executeQuery("SELECT * FROM DISASTERS ORDER BY disaster_date DESC");
                    while (rs2.next()) {
                %>
                <option value="<%= rs2.getInt("disaster_id")%>" 
                        <%= rs.getInt("disaster_id") == rs2.getInt("disaster_id") ? "selected" : ""%>>
                    <%= rs2.getString("disaster_name") + " (" + rs2.getString("location") + ")"%>
                </option>
                <%
                    }
                    rs2.close();
                    stmt2.close();
                %>
            </select><br>

            <div class="btn-container"> 
                <input type="submit"  class="btn" value="Update Donation"> 
            </div>
        </form>

        <script>
            function toggleFields() {
                var type = document.getElementById("donation_type").value;
                document.getElementById("moneyFields").style.display = (type === "money") ? "block" : "none";
                document.getElementById("goodsFields").style.display = (type === "goods") ? "block" : "none";
            }
        </script>

        <div class="btn-container"> <a href="viewDonation.jsp" class="btn">Back To Donations</a> </div>
    </body>
</html>
<% }
    rs.close();
    ps.close();
%>