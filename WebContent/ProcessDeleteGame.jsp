<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ page import="java.sql.*, db.*" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
	<title>Insert title here</title>
    <link rel="stylesheet" href="css/style.css" />
</head>
<body>

<%

	String gameID = request.getParameter("gameID");
	String gameTitle = request.getParameter("gameTitle");

	try {
		
		Connection conn = DBConnection.getConnection();
		PreparedStatement pstmt = conn.prepareStatement("DELETE FROM game_genre WHERE gameID = ?");
		pstmt.setString(1, gameID);
		int rs = pstmt.executeUpdate();
		PreparedStatement pstmt2 = conn.prepareStatement("DELETE FROM game WHERE gameID = ?");
		pstmt2.setString(1, gameID);
		int rs2 = pstmt2.executeUpdate();
		
		conn.close();
		
		response.sendRedirect("Manage.jsp?deleteResult=success&deletedGame=" + gameTitle);
		
	} catch (Exception e) {
		System.out.println(e);
		response.sendRedirect("Manage.jsp?deleteResult=fail&deletedGame=" + gameTitle);
	}

%>

</body>
</html>