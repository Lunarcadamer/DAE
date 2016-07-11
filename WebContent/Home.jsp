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

    <title>Home | GameShop</title>

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
                        <a href="#">Home</a>
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

            <div class="col-md-3">
                <p class="lead">Home</p>
                <div class="list-group">
                	<%
	                	try {
							
							Connection conn = DBConnection.getConnection();
							PreparedStatement pstmtGenre = conn.prepareStatement("SELECT * FROM genre");
							ResultSet rsGenre = pstmtGenre.executeQuery();
							
							while (rsGenre.next()) {	
								String genreName = rsGenre.getString("genreName");
								int genreID = rsGenre.getInt("genreID");
								
								out.println("<a href='Genre.jsp?id=" + genreID + "' class='list-group-item'>" + genreName + "</a>");
							}
							
                	%>
                </div>
            </div>

            <div class="col-md-9">

                <div class="row carousel-holder">

                    <div class="col-md-12">
                        <div id="carousel-example-generic" class="carousel slide" data-ride="carousel">
                            <ol class="carousel-indicators">
                                <li data-target="#carousel-example-generic" data-slide-to="0" class="active"></li>
                                <li data-target="#carousel-example-generic" data-slide-to="1"></li>
                                <li data-target="#carousel-example-generic" data-slide-to="2"></li>
                            </ol>
                            <div class="carousel-inner">
                                <div class="item active">
                                    <img class="slide-image" src="images/game-covers/OverwatchLandscape.jpg" alt="">
                                </div>
                                <div class="item">
                                    <img class="slide-image" src="images/game-covers/Halo5Landscape.jpg" alt="">
                                </div>
                                <div class="item">
                                    <img class="slide-image" src="images/game-covers/Battlefield1Landscape.jpg" alt="">
                                </div>
                            </div>
                            <a class="left carousel-control" href="#carousel-example-generic" data-slide="prev">
                                <span class="glyphicon glyphicon-chevron-left"></span>
                            </a>
                            <a class="right carousel-control" href="#carousel-example-generic" data-slide="next">
                                <span class="glyphicon glyphicon-chevron-right"></span>
                            </a>
                        </div>
                    </div>

                </div>

                <div class="row">

					<%	
							PreparedStatement pstmtGames = conn.prepareStatement("SELECT * FROM game ORDER BY releaseDate DESC");
							ResultSet rsGames = pstmtGames.executeQuery();
							
							String commentStatement =
								"SELECT COUNT(*) AS commentCount, ROUND(AVG(rating)) AS averageRating " +
								"FROM game g, comment c " +
								"WHERE g.gameID = c.gameID " +
								"AND g.gameID = ?";
							
							while (rsGames.next()) {	
								int gameID = rsGames.getInt("gameID");
								String gameTitle = rsGames.getString("gameTitle");
								String description = rsGames.getString("description");
								String imageLocation = rsGames.getString("imageLocation");
								if (imageLocation == null || imageLocation.equals("null")) {
									imageLocation = "images/game-covers/Placeholder.jpg";
								}
								double price = rsGames.getDouble("price");
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
				                                "<h4 class='game-name'><a href='Game.jsp?id=" + gameID + "'>" + gameTitle + "</a></h4>" +
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
							
							conn.close();
							
						} catch (Exception e) {
							System.out.println(e);
						}
						
					%>

                </div>

            </div>

        </div>

    </div>
    <!-- /.container -->

    <div class="container">

        <hr>

        <!-- Footer -->
        <footer>
            <div class="row">
                <div class="col-lg-12">
                    <p>Made by Shawn Pang and Aloysius Chia</p>
                </div>
            </div>
        </footer>

    </div>
    <!-- /.container -->

    <!-- jQuery -->
    <script src="js/jquery.js"></script>

    <!-- Bootstrap Core JavaScript -->
    <script src="js/bootstrap.min.js"></script>
	
</body>
</html>