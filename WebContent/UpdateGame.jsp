<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ page import="java.sql.*, db.*" %>
<!DOCTYPE html>
<html lang="en">

<head>

    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <meta name="description" content="">
    <meta name="author" content="">

    <title>Update Game | GameShop</title>

    <!-- Bootstrap Core CSS -->
    <link href="css/bootstrap.min.css" rel="stylesheet">

    <!-- Custom CSS -->
    <link href="css/style-admin.css" rel="stylesheet">

    <!-- Custom Fonts -->
    <link href="font-awesome/css/font-awesome.min.css" rel="stylesheet" type="text/css">

    <!-- HTML5 Shim and Respond.js IE8 support of HTML5 elements and media queries -->
    <!-- WARNING: Respond.js doesn't work if you view the page via file:// -->
    <!--[if lt IE 9]>
        <script src="https://oss.maxcdn.com/libs/html5shiv/3.7.0/html5shiv.js"></script>
        <script src="https://oss.maxcdn.com/libs/respond.js/1.4.2/respond.min.js"></script>
    <![endif]-->

</head>

<body>

    <div id="wrapper">

        <!-- Navigation -->
        <nav class="navbar navbar-inverse navbar-fixed-top" role="navigation">
            <!-- Brand and toggle get grouped for better mobile display -->
            <div class="navbar-header">
                <button type="button" class="navbar-toggle" data-toggle="collapse" data-target=".navbar-ex1-collapse">
                    <span class="sr-only">Toggle navigation</span>
                    <span class="icon-bar"></span>
                    <span class="icon-bar"></span>
                    <span class="icon-bar"></span>
                </button>
                <a class="navbar-brand" href="Dashboard.jsp">GameShop Admin Panel</a>
            </div>
            <!-- Top Menu Items -->
            <ul class="nav navbar-right top-nav">
                <li class="dropdown">
                    <a href="#" class="dropdown-toggle" data-toggle="dropdown"><i class="fa fa-user"></i> Administrator <b class="caret"></b></a>
                    <ul class="dropdown-menu">
                        <li>
                            <a href="Home.jsp"><i class="fa fa-fw fa-power-off"></i> Log Out</a>
                        </li>
                    </ul>
                </li>
            </ul>
            <!-- Sidebar Menu Items - These collapse to the responsive navigation menu on small screens -->
            <div class="collapse navbar-collapse navbar-ex1-collapse">
                <ul class="nav navbar-nav side-nav">
                    <li>
                        <a href="Dashboard.jsp"><i class="fa fa-fw fa-dashboard"></i> Dashboard</a>
                    </li>
                    <li class="active">
                        <a href="Manage.jsp"><i class="fa fa-fw fa-table"></i> Manage</a>
                    </li>
                </ul>
            </div>
            <!-- /.navbar-collapse -->
        </nav>

        <div id="page-wrapper">

            <div class="container-fluid">

                <!-- Page Heading -->
                <div class="row">
                    <div class="col-lg-12">
                        <h1 class="page-header">
                            Manage
                            <small>Update Game</small>
                        </h1>
                        <ol class="breadcrumb">
                            <li>
                                <i class="fa fa-dashboard"></i> <a href="Dashboard.jsp">Dashboard</a>
                            </li>
                            <li>
                                <i class="fa fa-table"></i> <a href="Manage.jsp">Manage</a>
                            </li>
                        </ol>
                    </div>
                </div>
                <!-- /.row -->

                <div class="row modify-section">
                    <div class="col-md-6">
                       	<%
							String gameID = request.getParameter("gameID");
						
							try {
								Connection conn = DBConnection.getConnection();
								PreparedStatement pstmt = conn.prepareStatement("SELECT * FROM game WHERE gameID = ?");
								pstmt.setString(1, gameID);
								ResultSet rs = pstmt.executeQuery();
								
								rs.next();
								String gameTitle = rs.getString("gameTitle");
								String description = rs.getString("description");
								double price = rs.getDouble("price");
								String imageLocation = rs.getString("imageLocation");
								int preOwned = rs.getInt("preOwned");
								String company = rs.getString("company");
								Date releaseDate = rs.getDate("releaseDate");
								
								// Retrieve Genres
		                		String genreSqlStatement =
		            			"SELECT genreName " +
		            			"FROM game gm, genre gr, game_genre gmgr " +
		            			"WHERE gm.gameID = gmgr.gameID " +
		            			"AND   gr.genreID = gmgr.genreID " +
		            			"AND   gm.gameID LIKE ?";
	                			PreparedStatement pstmtGenre = conn.prepareStatement(genreSqlStatement);
	                			pstmtGenre.setString(1, gameID);
	                			ResultSet rsGenre = pstmtGenre.executeQuery();
	                			String genres = "";
	                			while (rsGenre.next()) {
	                				String genreName = rsGenre.getString("genreName");
	                				genres += genreName;
	                				if (!rsGenre.isLast()) {
	                					genres += ",";
	                				}
	                			}
						%>
						<h2 class="modify-title">Updating <%=gameTitle%></h2>
						<form action="ProcessUpdateGame.jsp" method="post">
							<div class="form-group">
						
								<input type="hidden" class="form-control" name="gameID" value="<%=gameID%>">
							
								<label for="gameTitleInput">Game Title:</label>
								<input type="text" id="gameTitleInput" class="form-control" name="gameTitle" value="<%=gameTitle%>"/><br/>
								
								<label for="descriptionInput">Description:</label>
								<textarea id="descriptionInput" class="form-control" rows="8" cols="50" name="description"><%=description%></textarea><br/>
								
								<label for="priceInput">Price:</label>
								<input type="text" id="priceInput" class="form-control" name="price" value="<%=price%>"/><br/>
								
								<label for="genreInput">Genres (Eg. Action,Fantasy,Horror):</label>
								<input type="text" id="genreInput" class="form-control" name="genres" value="<%=genres%>"/><br/>
								
								<label for="imageLocationInput">Image Location:</label>
								<input type="text" id="imageLocationInput" class="form-control" name="imageLocation" value="<%=imageLocation%>"/><br/>
								
								<label for="preOwnedInput">Pre-Owned (0 for New, 1 for Pre-Owned):</label>
								<input type="text" id="preOwnedInput" class="form-control" name="preOwned" value="<%=preOwned%>"/><br/>
								
								<label for="companyInput">Company:</label>
								<input type="text" id="companyInput" class="form-control" name="company" value="<%=company%>"/><br/>
								
								<label for="releaseDateInput">Release Date (Eg. 2016-01-31):</label>
								<input type="text" id="releaseDateInput" class="form-control" name="releaseDate" value="<%=releaseDate%>"/><br/>
								
								<div class="row">
									<div class="col-sm-4">
										<a href="Manage.jsp"><button type="button" class="btn btn-block btn-danger btn-create">Cancel</button></a>
									</div>
									<div class="col-sm-4">
										<input type="reset" class="form-control btn btn-warning" name="btnReset" value="Reset"/>
									</div>
									<div class="col-sm-4">
										<input type="submit" class="form-control btn btn-primary" name="btnSubmit" value="Update"/>
									</div>
								</div>
								
							</div>
						</form>
						<%
							conn.close();
								
							} catch (Exception e) {
								System.out.println(e);
							}
						%>
                    </div>
                </div>
                <!-- /.row -->

            </div>
            <!-- /.container-fluid -->

        </div>
        <!-- /#page-wrapper -->

    </div>
    <!-- /#wrapper -->

    <!-- jQuery -->
    <script src="js/jquery.js"></script>

    <!-- Bootstrap Core JavaScript -->
    <script src="js/bootstrap.min.js"></script>

</body>

</html>
