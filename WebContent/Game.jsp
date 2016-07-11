<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ page import="java.sql.*, db.*, java.util.Date, java.text.SimpleDateFormat" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
	<meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <meta name="description" content="">
    <meta name="author" content="">

	<%
	
	String gameID = request.getParameter("id");
	if (gameID == null) {
		response.sendRedirect("Home.jsp");
	}
	
	try {
		
		Connection conn = DBConnection.getConnection();
		PreparedStatement pstmt = conn.prepareStatement("SELECT * FROM game WHERE gameID = ?");
		pstmt.setString(1, gameID);
		ResultSet rs = pstmt.executeQuery();
		rs.next();
		
		String gameTitle = rs.getString("gameTitle");
		String description = rs.getString("description");
		int newOrOld = rs.getInt("preOwned");
		String company = rs.getString("company");
		String imageLocation = rs.getString("imageLocation");
		if (imageLocation == null || imageLocation.equals("null")) {
			imageLocation = "images/game-covers/Placeholder.jpg";
		}
		Date releaseDate = rs.getDate("releaseDate");
		SimpleDateFormat dateFormat = new SimpleDateFormat("MMM d, yyyy");
		double price = rs.getDouble("price");
		String priceString = Double.toString(Math.abs(price));
		int integerPlaces = priceString.indexOf('.');
		int decimalPlaces = priceString.length() - integerPlaces - 1;
		
		if (decimalPlaces < 2) {
			priceString += "0";
		}
		
	%>

    <title><%=gameTitle%> | GameShop</title>

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
		
		<%
			// Post Comment Result
			String commentPost = request.getParameter("commentPost");
			if (commentPost != null && commentPost.equals("success")) {
				out.println(
					"<div class='row'>" +
			        	"<div class='col-lg-12'>" +
							"<div class='alert alert-success'>" +
			        			"<a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a>" +
								"<strong>Success!</strong> Comment successfully posted." +
							"</div>" +
			        	"</div>" +
					"</div>"
			    );
			} else if (commentPost != null && commentPost.equals("fail")) {
				out.println(
						"<div class='row'>" +
				        	"<div class='col-lg-12'>" +
								"<div class='alert alert-warning'>" +
				        			"<a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a>" +
									"<strong>Failed!</strong> Comment failed to post." +
								"</div>" +
				        	"</div>" +
						"</div>"
				    );
				}
		%>

        <div class="row">

            <div class="col-md-9">
                <div class="row game-info">
					<div class="col-sm-6">
                		<div class="thumbnail">
                    		<img class="img-responsive" src="<%=imageLocation%>" alt="">
                    	</div>
                    </div>
                    <div class="col-sm-6">
                        <div class="caption-full game-header">
	                        <h1><%=gameTitle%></h1>
	                        <p><%=description%></p>
	                    </div>
                    </div>
                </div>

				<div class="well">
					
					<div class="row">
	                    <div class="col-md-12">
	                        <h2>Reviews</h2>
	                    </div>
	                </div>
					
					<hr/>
					
					<%
						// Retrieve Comments
						PreparedStatement pstmtComments = conn.prepareStatement(
							"SELECT date, commenter, rating, comment " +
							"FROM game g, comment c " +
							"WHERE g.gameID = c.gameID " +
							"AND g.gameID = ? " +
							"ORDER BY date DESC");
						pstmtComments.setString(1, gameID);
						ResultSet rsComments = pstmtComments.executeQuery();
						
						while (rsComments.next()) {
							Date commentDate = rsComments.getDate("date");
							String commenter = rsComments.getString("commenter");
							int rating = rsComments.getInt("rating");
							String comment = rsComments.getString("comment");
							
							String commentStarHtml = "";
							for (int i = 0; i < rating; i++) {
								commentStarHtml += "<span class='glyphicon glyphicon-star'></span>";
							}
							for (int i = 0; i < 5 - rating; i++) {
								commentStarHtml += "<span class='glyphicon glyphicon-star-empty'></span>";
							}
							
							out.println(
								"<div class='row'>" +
				                    "<div class='col-md-12'>" +
				                        commentStarHtml +
				                        "<span class='pull-right date'>" + dateFormat.format(commentDate) + "</span>" +
				                        "<span class='commenter'>" + commenter + "</span>" +
				                        "<p>" + comment + "</p>" +
				                    "</div>" +
				                "</div>" +
				                "<hr/>"
							);
							
						}
					%>
					
				</div>
				<div class="well">
					
					<div class="row">
	                    <div class="col-md-12">
	                        <h3>Leave a Review <%=newOrOld == 0 ? "" : "<small>Disabled for Pre-Owned Games</small>"%></h3>
	                    </div>
	                </div>
	                
	                
	                <div class="row">
	                	<div class="col-md-12">
	                		<form role="form" action="ProcessPostComment.jsp" method="post">
								<div class="form-group">
									<fieldset <%=newOrOld == 0 ? "" : "disabled"%>>
										<input class="form-control" type="hidden" name="gameID" value="<%=gameID%>">
										
										<label for="nameInput">Name:</label>
										<input class="form-control" type="text" id="nameInput" name="name"><br/>
										
										<label>Rating:</label>			
										<input type="radio" class="star-input" name="stars" id="star-1" value="1" />
										<input type="radio" class="star-input" name="stars" id="star-2" value="2" />
										<input type="radio" class="star-input" name="stars" id="star-3" value="3" />
										<input type="radio" class="star-input" name="stars" id="star-4" value="4" />
										<input type="radio" class="star-input" name="stars" id="star-5" value="5" checked />
										
										<section class="star-selection">
										  <label for="star-1">
										    <svg width="255" height="240" viewBox="0 0 51 48">
										      <path d="m25,1 6,17h18l-14,11 5,17-15-10-15,10 5-17-14-11h18z"/>
										    </svg>
										  </label>
										  <label for="star-2">
										    <svg width="255" height="240" viewBox="0 0 51 48">
										      <path d="m25,1 6,17h18l-14,11 5,17-15-10-15,10 5-17-14-11h18z"/>
										    </svg>
										  </label>
										  <label for="star-3">
										    <svg width="255" height="240" viewBox="0 0 51 48">
										      <path d="m25,1 6,17h18l-14,11 5,17-15-10-15,10 5-17-14-11h18z"/>
										    </svg>
										  </label>
										  <label for="star-4">
										    <svg width="255" height="240" viewBox="0 0 51 48">
										      <path d="m25,1 6,17h18l-14,11 5,17-15-10-15,10 5-17-14-11h18z"/>
										    </svg>
										  </label>
										  <label for="star-5">
										    <svg width="255" height="240" viewBox="0 0 51 48">
										      <path d="m25,1 6,17h18l-14,11 5,17-15-10-15,10 5-17-14-11h18z"/>
										    </svg>
										  </label>
										</section>
										
										<label for="commentInput">Comment:</label>
										<textarea class="form-control" rows="4" cols="50" maxlength="500" id="commentInput" name="comment"></textarea><br/>
										
										<input class="form-control btn btn-primary" type="submit" name="btnSubmit" value="Submit">
									</fieldset>
								</div>
							</form>
	                	</div>
	                </div>

                </div>

            </div>
            
            <div class="col-md-3 right-pane">
                <div class="panel panel-default">
                	<div class="panel-body">
	                	<div class="buy-row">
	                		<p class="buy-label">Price: </p>
	               			<p class="price">$<%=priceString%></p>
	                	</div>
	                	<div class="clearfix"></div>
	                	<div class="buy-row">
	                		<p class="buy-label">Qty: </p>
	               			<input type="number" name="quantity" value="1" min="1">
	                	</div>
	                	<div class="clearfix"></div>
	                	<a href="#" class="btn btn-block btn-primary btn-warning"><span class="glyphicon glyphicon-shopping-cart"></span> Add to Cart</a>
	                	<hr/>
	                	<a href="#" class="btn btn-block btn-success">1-Click Purchase</a>
	                </div>
                </div>
                
                <%
	                // Retrieve Average Rating and Review Count
	                String commentSummaryStatement = 
					"SELECT COUNT(*) AS commentCount, ROUND(AVG(rating)) AS averageRating " +
					"FROM game g, comment c " +
					"WHERE g.gameID = c.gameID " +
					"AND g.gameID = ?";
	                
	                PreparedStatement pstmtCommentSummary = conn.prepareStatement(commentSummaryStatement);
					pstmtCommentSummary.setString(1, gameID);
					ResultSet rsCommentSummary = pstmtCommentSummary.executeQuery();
	                
	                rsCommentSummary.next();
					int commentCount = rsCommentSummary.getInt("commentCount");
					int averageRating = rsCommentSummary.getInt("averageRating");
                %>
                
                <div class="panel panel-default">
                	<div class="panel-body">
                		<p class="overall-rating"><%=averageRating%> <%=averageRating > 1 ? "stars" : "star"%></p>
                		<p class="overall-stars">
                			<%
	                			String commentStarHtml = "";
	        					for (int i = 0; i < averageRating; i++) {
	        						commentStarHtml += "<span class='glyphicon glyphicon-star'></span>";
	        					}
	        					for (int i = 0; i < 5 - averageRating; i++) {
	        						commentStarHtml += "<span class='glyphicon glyphicon-star-empty'></span>";
	        					}
	        					
	        					out.println(commentStarHtml);
                			%>
                		</p>
                		<p class="overall-reviews">
                			Based on<br/><span class="review-number"><%=commentCount%> <%=commentCount > 1 ? "reviews" : "review"%></span>
                		</p>
                	</div>
                </div>
                <div class="panel panel-default">
                	<div class="panel-body">
	                	<p class="text-muted meta-label">Publisher</p>
	                	<p class="meta-content"><%=company%></p>
	                	<hr/>
	                	<p class="text-muted meta-label">Release Date</p>
	                	<p class="meta-content"><%=dateFormat.format(releaseDate)%></p>
	                	<hr/>
	                	<p class="text-muted meta-label">Pre-Owned Status</p>
	                	<p class="meta-content"><%=newOrOld == 0 ? "New" : "Pre-Owned"%></p>
	                	<hr/>
	                	<p class="text-muted meta-label">Genres</p>
	                	<p class="meta-content">
	                		<%
	                			// Retrieve Genres
		                		String genreSqlStatement =
		            			"SELECT * " +
		            			"FROM game gm, genre gr, game_genre gmgr " +
		            			"WHERE gm.gameID = gmgr.gameID " +
		            			"AND   gr.genreID = gmgr.genreID " +
		            			"AND   gm.gameID LIKE ? ";
	                			PreparedStatement pstmtGenre = conn.prepareStatement(genreSqlStatement);
	                			pstmtGenre.setString(1, gameID);
	                			ResultSet rsGenre = pstmtGenre.executeQuery();
	                			while (rsGenre.next()) {
	                				String genreID = rsGenre.getString("genreID");
	                				String genreName = rsGenre.getString("genreName");
	                				out.println("<a href='Genre.jsp?id=" + genreID + "'>" + genreName + "<br/>");
	                			}
		                	%>
	                	</p>
	                </div>
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
                    <p>Copyright &copy; Your Website 2014</p>
                </div>
            </div>
        </footer>

    </div>
    <!-- /.container -->

	<%
	
	conn.close();
	
	} catch (Exception e) {
		System.out.println(e);
	}
	
	%>

    <!-- jQuery -->
    <script src="js/jquery.js"></script>

    <!-- Bootstrap Core JavaScript -->
    <script src="js/bootstrap.min.js"></script>
	
</body>
</html>