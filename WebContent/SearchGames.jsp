<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ page import="java.sql.*, db.*" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
	<meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <meta name="description" content="">
    <meta name="author" content="">

    <title>Search | GameShop</title>

    <!-- Bootstrap Core CSS -->
    <link href="css/bootstrap.min.css" rel="stylesheet">

    <!-- Custom CSS -->
    <link href="css/style.css" rel="stylesheet">

    <!-- HTML5 Shim and Respond.js IE8 support of HTML5 elements and media queries -->
    <!-- WARNING: Respond.js doesn't work if you view the page via file:// -->
    <!--[if lt IE 9]>
        <script src="https://oss.maxcdn.com/libs/html5shiv/3.7.0/html5shiv.js"></script>
        <script src="https://oss.maxcdn.com/libs/respond.js/1.4.2/respond.min.js"></script>
    <![endif]-->
</head>
<body>

	<!-- Navigation -->
    <nav class="navbar navbar-inverse navbar-fixed-top" role="navigation">
        <div class="container">
            <!-- Brand and toggle get grouped for better mobile display -->
            <div class="navbar-header">
                <button type="button" class="navbar-toggle" data-toggle="collapse" data-target="#bs-example-navbar-collapse-1">
                    <span class="sr-only">Toggle navigation</span>
                    <span class="icon-bar"></span>
                    <span class="icon-bar"></span>
                    <span class="icon-bar"></span>
                </button>
                <a class="navbar-brand" href="Home.jsp">GameShop</a>
            </div>
            <!-- Collect the nav links, forms, and other content for toggling -->
            <div class="collapse navbar-collapse" id="bs-example-navbar-collapse-1">
                <ul class="nav navbar-nav">
                    <li>
                        <a href="Home.jsp">Home</a>
                    </li>
                    <li>
                        <a href="SearchGames.jsp">Search</a>
                    </li>
                    <li>
                        <a href="LoginPage.jsp">Login</a>
                    </li>
                </ul>
            </div>
            <!-- /.navbar-collapse -->
        </div>
        <!-- /.container -->
    </nav>

    <!-- Page Content -->
    <div class="container">
        <div class="row">
        	<div class="col-md-4">
                <p class="lead">Search</p>
                <form action="SearchGames.jsp" class="search-form" method="get">
					<div class="form-group">
						<label for="gameTitleInput">Game Title: </label>
						<input type="text" id="gameTitleInput" class="form-control" name="gameTitle"/><br/>
						
						<label for="gameGenreSelect">Game Genre: </label>
						<select id="gameGenreSelect" class="form-control" name="gameGenre">
							<option value="all">All</option>
							<%
								try {
									Connection conn = DBConnection.getConnection();
									PreparedStatement pstmtRetrieveGenres = conn.prepareStatement("SELECT genreName FROM genre");
									ResultSet rsRetrieveGenres = pstmtRetrieveGenres.executeQuery();
									while (rsRetrieveGenres.next()) {
										String genreName = rsRetrieveGenres.getString("genreName");
										out.println("<option value='" + genreName + "'>" + genreName + "</option>");
									}
							%>
						</select>
						
						<div class="radio">
							<label for="newOrOld-all"><input type="radio" id="newOrOld-all" name="newOrOld" value="-1" checked>All</label>
							<label for="newOrOld-new"><input type="radio" id="newOrOld-new" name="newOrOld" value="0">New</label>
							<label for="newOrOld-old"><input type="radio" id="newOrOld-old" name="newOrOld" value="1">Pre-Owned</label>
						</div>
						
						<input type="submit" class="form-control btn btn-primary" name="btnSubmit" value="Search"/>
					</div>
				</form>
                <hr/>
            </div>
        
            <div class="col-md-8">
                <p class="lead search-results-header">Search Results</p>
                <%
						if (request.getParameter("gameTitle") == null || request.getParameter("gameGenre") == null || request.getParameter("newOrOld") == null) {
							return;
						}
						
						String gameTitle = request.getParameter("gameTitle");
						String gameGenre = request.getParameter("gameGenre");
						int newOrOld = Integer.parseInt(request.getParameter("newOrOld"));
						
						boolean gameTitleEntered = !gameTitle.equals("");
						boolean listSelected = !gameGenre.equals("all");
						boolean radioSelected = newOrOld != -1;
						
						String sqlStatement =
							"SELECT DISTINCT gm.gameTitle, gm.gameID, description, imageLocation, price " +
							"FROM game gm, genre gr, game_genre gmgr " +
							"WHERE gm.gameID = gmgr.gameID " +
							"AND   gr.genreID = gmgr.genreID " +
							"AND   gm.gameTitle LIKE ? ";
						if (listSelected) {
							sqlStatement += "AND gr.genreName LIKE ? ";
						}
						if (radioSelected) {
							sqlStatement += "AND gm.preOwned = ? ";
						}
						sqlStatement += "ORDER BY gm.releaseDate DESC";
						
						PreparedStatement pstmt = conn.prepareStatement(sqlStatement);
						pstmt.setString(1, "%" + gameTitle + "%");
						if (listSelected && radioSelected) {
							pstmt.setString(2, "%" + gameGenre + "%");
							pstmt.setInt(3, newOrOld);
						} else if (listSelected) {
							pstmt.setString(2, "%" + gameGenre + "%");
						} else if (radioSelected) {
							pstmt.setInt(2, newOrOld);
						}
						ResultSet rs = pstmt.executeQuery();
						
						if (!rs.isBeforeFirst()) {
							out.println("<p>No Results Found</p>");
						} else {
							if (!gameTitleEntered && !listSelected && !radioSelected) {
								out.println("<p class='all-games'>All Games</p>");
							} else {
								if (gameTitleEntered) {
									out.println("<div class='search-tag'><p>" + gameTitle + "</p><p><a href='SearchGames.jsp?gameTitle=&gameGenre=" + gameGenre + "&newOrOld=" + newOrOld + "'>x</a></p></div>");
								}
								if (listSelected) {
									out.println("<div class='search-tag'><p>" + gameGenre + "</p><p><a href='SearchGames.jsp?gameTitle=" + gameTitle + "&gameGenre=all&newOrOld=" + newOrOld + "'>x</a></p></div>");
								}
								if (radioSelected) {
									String newOrOldWord = newOrOld == 0 ? "New" : "Pre-Owned";
									out.println("<div class='search-tag'><p>" + newOrOldWord + "</p><p><a href='SearchGames.jsp?gameTitle=" + gameTitle + "&gameGenre=" + gameGenre + "&newOrOld=-1'>x</a></p></div>");
								}
							}
							
							String commentStatement =
								"SELECT COUNT(*) AS commentCount, ROUND(AVG(rating)) AS averageRating " +
								"FROM game g, comment c " +
								"WHERE g.gameID = c.gameID " +
								"AND g.gameID = ?";
				%>
                <div class="row">
					<%
							while (rs.next()) {	
								int gameID = rs.getInt("gameID");
								String gameTitleResult = rs.getString("gameTitle");
								String description = rs.getString("description");
								String imageLocation = rs.getString("imageLocation");
								if (imageLocation == null || imageLocation.equals("null")) {
									imageLocation = "images/game-covers/Placeholder.jpg";
								}
								double price = rs.getDouble("price");
								String priceString = Double.toString(Math.abs(price));
								int integerPlaces = priceString.indexOf('.');
								int decimalPlaces = priceString.length() - integerPlaces - 1;
								
								if (decimalPlaces < 2) {
									priceString += "0";
								}
								
								int descDisplayLength = 100;
								if (description.length() > descDisplayLength) {
									description = description.substring(0, descDisplayLength);
									description += "...";
								}
								
								PreparedStatement pstmtCommentCount = conn.prepareStatement(commentStatement);
								pstmtCommentCount.setInt(1, gameID);
								ResultSet rsComment = pstmtCommentCount.executeQuery();
								
								rsComment.next();
								int commentCount = rsComment.getInt("commentCount");
								int averageRating = rsComment.getInt("averageRating");
								
								out.println(
										"<div class='col-sm-4 col-lg-4 col-md-4'>" +
											"<div class='thumbnail'>" +
												"<a href='Game.jsp?id=" + gameID + "'>" +
													"<img src='" + imageLocation + "' alt=''>" +
												"</a>" +
					                            "<div class='caption'>" +
					                                "<h4 class='pull-right'>$" + priceString + "</h4>" +
					                                "<h4><a href='Game.jsp?id=" + gameID + "'>" + gameTitleResult + "</a></h4>" +
					                                "<p>" + description + "</p>" +
					                            "</div>" +
					                            "<div class='ratings'>" +
					                                "<p class='pull-right reviews'>" + commentCount + " " + (commentCount > 1 ? "reviews" : "review")+ "</p>" +
					                                "<p>");
									
													for (int i = 0; i < averageRating; i++) {
														out.println("<span class='glyphicon glyphicon-star'></span>");
													}
													for (int i = 0; i < 5 - averageRating; i++) {
														out.println("<span class='glyphicon glyphicon-star-empty'></span>");
													}
					                                // Filled Star "<span class='glyphicon glyphicon-star'></span>"
					                                // Empty Star  "<span class='glyphicon glyphicon-star-empty'></span>"
					                                
									                out.println(
					                                "</p>" +
					                            "</div>" +
					                        "</div>" +
					                    "</div>");
								
							}
						}
						
						conn.close();
						
					} catch (Exception e) {
						System.out.println(e);
					}
				%>
			</div>
		</div>
	</div>
	
	
</body>
</html>