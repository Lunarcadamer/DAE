<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ page import="java.sql.*, java.security.*, db.*" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Insert title here</title>
</head>
<body>

	<%
	
	String username = request.getParameter("username");
	String password = request.getParameter("password");
	
	try {
		
		MessageDigest passwordHash;
        try {
            passwordHash = MessageDigest.getInstance("SHA-256");
        } catch (NoSuchAlgorithmException e) {
            System.err.println("No such hash algorithm found.");
            return;
        }
        passwordHash.update(password.getBytes());
        byte[] digest = passwordHash.digest();
        StringBuilder output = new StringBuilder();
        for (byte b : digest) {
            output.append(String.format("%02x", b & 0xff));
        }
		
		Connection conn = DBConnection.getConnection();
		PreparedStatement pstmt = conn.prepareStatement("SELECT * FROM user WHERE username = ? AND password = ?");
		pstmt.setString(1, username);
		pstmt.setString(2, output.toString());
		ResultSet rs = pstmt.executeQuery();
		
		if (rs.next()) {
			response.sendRedirect("Dashboard.jsp");
		} else {
			response.sendRedirect("LoginPage.jsp?login=fail");
		}
		
		conn.close();
		
	} catch (Exception e) {
		System.out.println(e);
	}
		
	%>
</body>
</html>