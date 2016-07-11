<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ page import="java.sql.*, db.*, java.util.Date, java.text.SimpleDateFormat" %>
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
	String nameInput = request.getParameter("name");
	int ratingInput = Integer.parseInt(request.getParameter("stars"));
	String commentInput = request.getParameter("comment");

	try {
		
		Connection conn = DBConnection.getConnection();
		PreparedStatement pstmtPostComment = conn.prepareStatement("INSERT INTO comment (gameID, date, commenter, rating, comment) VALUES (?, ?, ?, ?, ?)");
		pstmtPostComment.setString(1, gameID);
		
		SimpleDateFormat postCommentDateFormat = new SimpleDateFormat("yyyy/MM/dd HH:mm:ss");
		Date date = new Date();
		pstmtPostComment.setString(2, postCommentDateFormat.format(date));
		
		pstmtPostComment.setString(3, nameInput);
		pstmtPostComment.setInt(4, ratingInput);
		pstmtPostComment.setString(5, commentInput);
		
		int rsPostComment = pstmtPostComment.executeUpdate();
		
		conn.close();
		
		response.sendRedirect("Game.jsp?id=" + gameID + "&commentPost=success");
		
	} catch (Exception e) {
		System.out.println(e);
		response.sendRedirect("Game.jsp?id=" + gameID + "&commentPost=fail");
	}

%>

</body>
</html>