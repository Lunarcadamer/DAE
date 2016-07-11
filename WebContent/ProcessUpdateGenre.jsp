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
	String games = request.getParameter("games");
	
	try {
		
		Connection conn = DBConnection.getConnection();
		PreparedStatement pstmt = conn.prepareStatement("UPDATE genre SET genreName = ? WHERE genreID = ?");
		pstmt.setString(1, genreName);
		pstmt.setString(2, genreID);
		int rs = pstmt.executeUpdate();
		
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
			// - Delete all games associated with a game
			PreparedStatement pstmtGameDelete = conn.prepareStatement("DELETE FROM game_genre WHERE genreID = ?");
			pstmtGameDelete.setString(1, genreID);
			int rsGameDelete = pstmtGameDelete.executeUpdate();
			// - Insert new set of games
			PreparedStatement pstmtGameUpdate = conn.prepareStatement("INSERT INTO game_genre (genreID, gameID) VALUES (?, ?)");
			for (int i = 0; i < gamesIdArray.length; i++) {
				pstmtGameUpdate.setString(1, genreID);
				pstmtGameUpdate.setString(2, gamesIdArray[i]);
				int rsGenreUpdate = pstmtGameUpdate.executeUpdate();
			}
		}
		
		conn.close();
		
		response.sendRedirect("Manage.jsp?updateResult=success&updatedGenre=" + genreName);
		
	} catch (Exception e) {
		out.println(e);
		response.sendRedirect("Manage.jsp?updateResult=fail&updatedGenre=" + genreName);
	}

%>

</body>
</html>