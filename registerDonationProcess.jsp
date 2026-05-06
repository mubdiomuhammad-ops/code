<%@ page import="java.sql.*" %>
<%@ include file="Connection.jsp" %>

<%
String donor = request.getParameter("donor_name");
String phone = request.getParameter("contact"); 
String disaster = request.getParameter("disaster");
String type = request.getParameter("type");
String amount = request.getParameter("amount");
String goods = request.getParameter("goods");


PreparedStatement ps1 = conn.prepareStatement(
    "INSERT INTO donors (donor_id, donor_name, contact) VALUES (donor_seq.NEXTVAL, ?, ?)"
);
ps1.setString(1, donor);
ps1.setString(2, phone);
ps1.executeUpdate();


Statement st = conn.createStatement();
ResultSet rs = st.executeQuery("SELECT donor_seq.CURRVAL FROM dual");
rs.next();
int donorId = rs.getInt(1);


PreparedStatement ps2 = conn.prepareStatement(
    "INSERT INTO donations (donation_id, donor_id, disaster_id, donation_type, amount, goods_description, donation_date) " +
    "VALUES (donation_seq.NEXTVAL, ?, ?, ?, ?, ?, SYSDATE)"
);
ps2.setInt(1, donorId);
ps2.setInt(2, Integer.parseInt(disaster));
ps2.setString(3, type);
ps2.setString(4, amount);
ps2.setString(5, goods);

ps2.executeUpdate();

response.sendRedirect("viewDonations.jsp");
%>