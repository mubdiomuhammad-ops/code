<%@ page import="java.sql.*" %>
<%@ include file="Connection.jsp" %>

<%
    String id = request.getParameter("disaster_id");
    String name = request.getParameter("disaster_name");
    String location = request.getParameter("location");
    String type = request.getParameter("disaster_type");
    String date = request.getParameter("disaster_date");
    String status = request.getParameter("status");

    PreparedStatement ps = conn.prepareStatement(
        "INSERT INTO disasters VALUES (?, ?, ?, ?, TO_DATE(?, 'YYYY-MM-DD'), ?)"
    );

    ps.setString(1,id);
    ps.setString(2, name);
    ps.setString(3,location );
    ps.setString(4, type);
    ps.setString(5, date);
    ps.setString(6, status);

    ps.executeUpdate();
    response.sendRedirect("viewDisasters.jsp");
%>
