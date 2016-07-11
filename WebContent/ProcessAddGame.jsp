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
	String gameTitle = request.getParameter("gameTitle");
	String description = request.getParameter("description");
	double price = Double.parseDouble(request.getParameter("price"));
	String genres = request.getParameter("genres");
	String imageLocation = request.getParameter("imageLocation");
	int preOwned = Integer.parseInt(request.getParameter("preOwned"));
	String company = request.getParameter("company");
	String releaseDate = request.getParameter("releaseDate");

	try {
		
		Connection conn = DBConnection.getConnection();
		PreparedStatement pstmt = conn.prepareStatement("INSERT INTO game (gameTitle, description, price, imageLocation, preOwned, company, releaseDate) VALUES (?, ?, ?, ?, ?, ?, ?)");
		pstmt.setString(1, gameTitle);
		pstmt.setString(2, description);
		pstmt.setDouble(3, price);
		pstmt.setString(4, imageLocation);
		pstmt.setInt(5, preOwned);
		pstmt.setString(6, company);
		pstmt.setString(7, releaseDate);
		int rs = pstmt.executeUpdate();
		
		// Retrieves the generated ID of newly added game
		PreparedStatement pstmtRetrieveId = conn.prepareStatement("SELECT gameID FROM game WHERE gameTitle = ?");
		pstmtRetrieveId.setString(1, gameTitle);
		ResultSet rsRetrieveId = pstmtRetrieveId.executeQuery();
		rsRetrieveId.next();
		String gameID = rsRetrieveId.getString("gameID");
		
		// Genre Update
		// - Comma-separated to array
		String[] genresArray = genres.split(",");
		// - Convert Genre Names to IDs (also checks whether the name exists, if not exception thrown)
		PreparedStatement pstmtGenreLookup = conn.prepareStatement("SELECT genreID FROM genre WHERE genreName = ?");
		String[] genresIdArray = new String[genresArray.length];
		for (int i = 0; i < genresArray.length; i++) {
			pstmtGenreLookup.setString(1, genresArray[i]);
			ResultSet rsGenreLookup = pstmtGenreLookup.executeQuery();
			rsGenreLookup.next();
			genresIdArray[i] = rsGenreLookup.getString("genreID");
		}
		// - Insert new set of genres
		PreparedStatement pstmtGenreUpdate = conn.prepareStatement("INSERT INTO game_genre (gameID, genreID) VALUES (?, ?)");
		for (int i = 0; i < genresIdArray.length; i++) {
			pstmtGenreUpdate.setString(1, gameID);
			pstmtGenreUpdate.setString(2, genresIdArray[i]);
			int rsGenreUpdate = pstmtGenreUpdate.executeUpdate();
		}
		
		conn.close();
		
		response.sendRedirect("Manage.jsp?addResult=success&addedGame=" + gameTitle);
		
	} catch (Exception e) {
		System.out.println(e);
		response.sendRedirect("Manage.jsp?addResult=fail&addedGame=" + gameTitle);
	}

%>

</body>
</html>