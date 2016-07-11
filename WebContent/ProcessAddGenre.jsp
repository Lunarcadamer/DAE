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
	String genreName = request.getParameter("genreName");
	String games = request.getParameter("games");

	try {
		
		Connection conn = DBConnection.getConnection();
		PreparedStatement pstmt = conn.prepareStatement("INSERT INTO genre (genreName) VALUES (?)");
		pstmt.setString(1, genreName);
		int rs = pstmt.executeUpdate();
		
		// Retrieves the generated ID of newly added genre
		PreparedStatement pstmtRetrieveId = conn.prepareStatement("SELECT genreID FROM genre WHERE genreName = ?");
		pstmtRetrieveId.setString(1, genreName);
		ResultSet rsRetrieveId = pstmtRetrieveId.executeQuery();
		rsRetrieveId.next();
		String genreID = rsRetrieveId.getString("genreID");
		
		// Game Update
		// - Comma-separated to array
		String[] gamesArray = games.split(",");
		// - Convert Game Names to IDs (also checks whether the name exists, if not exception thrown)
		if (gamesArray.length == 0){
			PreparedStatement pstmtGameLookup = conn.prepareStatement("SELECT gameID FROM game WHERE gameTitle = ?");
			String[] gamesIdArray = new String[gamesArray.length];
			for (int i = 0; i < gamesArray.length; i++) {
				pstmtGameLookup.setString(1, gamesArray[i]);
				ResultSet rsGameLookup = pstmtGameLookup.executeQuery();
				rsGameLookup.next();
				gamesIdArray[i] = rsGameLookup.getString("gameID");
			}
		// - Insert new set of genres
			PreparedStatement pstmtGameUpdate = conn.prepareStatement("INSERT INTO game_genre (genreID, gameID) VALUES (?, ?)");
			for (int i = 0; i < gamesIdArray.length; i++) {
				pstmtGameUpdate.setString(1, genreID);
				pstmtGameUpdate.setString(2, gamesIdArray[i]);
				int rsGameUpdate = pstmtGameUpdate.executeUpdate();
			}
		}
		
		conn.close();
		
		response.sendRedirect("Manage.jsp?addResult=success&addedGenre=" + genreName);
		
	} catch (Exception e) {
		System.out.println(e);
		response.sendRedirect("Manage.jsp?addResult=fail&addedGenre=" + genreName);
	}

%>

</body>
</html>