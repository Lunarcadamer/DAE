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
                            <small>Upload Game Image</small>
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
						<h2 class="modify-title">Uploading Image for <%=gameTitle%></h2>
						<form method="post" action="UploadServlet" enctype="multipart/form-data">
							<div class="form-group">
								
								<input type="hidden" class="form-control" name="gameID" id="gameID" value="<%=gameID%>">
								
								<label for="fileChooser">Select Image to Upload:</label>
								<input type="file" name="dataFile" id="fileChooser" class="form-control"/>
								<p class="text-danger"><strong>Current image location in database will be overwritten.</strong></p>
								<div class="row">
									<div class="col-sm-4">
										<a href="Manage.jsp"><button type="button" class="btn btn-block btn-danger btn-create">Cancel</button></a>
									</div>
									<div class="col-sm-4">
										<input type="reset" class="form-control btn btn-warning" name="btnReset" value="Reset"/>
									</div>
									<div class="col-sm-4">
										<input type="submit" class="form-control btn btn-primary" name="btnSubmit" value="Upload"/>
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
