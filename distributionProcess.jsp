<%@ include file="Connection.jsp" %>
<%@ page import="java.sql.*" %>
<html>
    <head>
        <title>Distribution Process</title>
        <style>
            body {
                font-family: Arial, sans-serif;
                background-color: #f0f4f8; /* light grey-blue background */
                color: #333; /* dark grey text */
                margin: 40px;
            }
            h2 {
                color: #1e3a8a; /* deep blue */
            }
            .success {
                color: #1d4ed8; /* bright blue */
                background-color: #e0f2fe; /* light blue background */
                padding: 10px;
                border-radius: 5px;
            }
            .error {
                color: #b91c1c; /* red for errors */
                background-color: #fef2f2; /* light red background */
                padding: 10px;
                border-radius: 5px;
            }
            btn-container {
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
        <h2>Processing Distribution...</h2>
        <%
            String donationId = request.getParameter("donation_id");
            String reliefCenter = request.getParameter("relief_center");
            String distributedTo = request.getParameter("distributed_to");
            String quantity = request.getParameter("quantity");
            String distributionDate = request.getParameter("distribution_date");

            try {
                // Prepare SQL insert
                String sql = "INSERT INTO distribution "
                        + "(distribution_id, donation_id, relief_center, distributed_to, quantity, distribution_date) "
                        + "VALUES (distribution_seq.NEXTVAL, ?, ?, ?, ?, TO_DATE(?, 'YYYY-MM-DD'))";

                PreparedStatement ps = conn.prepareStatement(sql);
                ps.setInt(1, Integer.parseInt(donationId));
                ps.setString(2, reliefCenter);
                ps.setString(3, distributedTo);
                ps.setString(4, quantity);
                ps.setString(5, distributionDate);

                int result = ps.executeUpdate();
                ps.close();

                if (result > 0) {
        %>
        <p class="success">Donation distributed successfully!</p>
        <div class="btn-container"> <a href="home.jsp" class="btn">Back to Home</a> </div>
        <%
                } else {
        %>
        <p class="error">Something went wrong. Try again.</p>
       <div class="btn-container"> <a href="distribution.jsp" class="btn">Back to Form</a> </div>
        <%
                }
            } catch (Exception e) {
        %>
        <p class="error">Error: <%= e.getMessage()%></p>
        <div class="btn-container"> <a href="home.jsp" class="btn">Back to Home</a> </div>
        <%
            }
        %>
    </body>
</html>