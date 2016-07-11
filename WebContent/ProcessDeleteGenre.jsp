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

	String genreID = request.getParameter("genreID");
	String genreName = request.getParameter("genreName");

	try {
		
		Connection conn = DBConnection.getConnection();
		PreparedStatement pstmt = conn.prepareStatement("DELETE FROM genre WHERE genreID = ?");
		pstmt.setString(1, genreID);
		int rs = pstmt.executeUpdate();
		
		conn.close();
		
		response.sendRedirect("Manage.jsp?deleteResult=success&deletedGenre=" + genreName);
		
	} catch (Exception e) {
		System.out.println(e);
		response.sendRedirect("Manage.jsp?deleteResult=fail&deletedGenre=" + genreName);
	}

%>

</body>
</html>