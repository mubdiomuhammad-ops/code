<%@ page import="java.sql.*" %>
<%
    String url = "jdbc:oracle:thin:@localhost:1521:XE";
    String username = "SYSTEM";
    String password = "MMLAM";
    Class.forName("oracle.jdbc.driver.OracleDriver");
    Connection conn = DriverManager.getConnection(url, username, password);

%>