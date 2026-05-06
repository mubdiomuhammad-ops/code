<%@ page import="java.sql.*" %>
<%@ include file="Connection.jsp" %>
<%
    String type = request.getParameter("type"); // donation, disaster, distribution
    String idParam = request.getParameter("id");

    if (type != null && idParam != null && idParam.matches("\\d+")) {
        int id = Integer.parseInt(idParam);

        Statement st = conn.createStatement();

        if ("donation".equalsIgnoreCase(type)) {
            st.executeUpdate("DELETE FROM DISTRIBUTION WHERE donation_id=" + id);
            st.executeUpdate("DELETE FROM DONATIONS WHERE donation_id=" + id);
            response.sendRedirect("viewDonations.jsp");
            
        } else if ("disaster".equalsIgnoreCase(type)) {
            st.executeUpdate("DELETE FROM DONATIONS WHERE disaster_id=" + id);
            st.executeUpdate("DELETE FROM DISASTERS WHERE disaster_id=" + id);
            response.sendRedirect("viewDisasters.jsp");

        } else if ("distribution".equalsIgnoreCase(type)) {
            st.executeUpdate("DELETE FROM DISTRIBUTION WHERE distribution_id=" + id);
            response.sendRedirect("viewDistribution.jsp");

        } else {
            out.println("Invalid delete type specified.");
        }

        st.close();
    } else {
        out.println("No valid ID or type provided.");
    }
%>