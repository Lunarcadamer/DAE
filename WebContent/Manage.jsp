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

    <title>Manage Products | GameShop</title>

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
                        </h1>
                        <ol class="breadcrumb">
                            <li>
                                <i class="fa fa-dashboard"></i>  <a href="Dashboard.jsp">Dashboard</a>
                            </li>
                            <li class="active">
                                <i class="fa fa-table"></i> Manage
                            </li>
                        </ol>
                    </div>
                </div>
                <!-- /.row -->

				<%
					String updatedGame = request.getParameter("updatedGame");
            		String updatedGenre = request.getParameter("updatedGenre");
					String updateResult = request.getParameter("updateResult");
					if (updateResult != null && (updatedGame != null || updatedGenre != null) && updateResult.equals("success")) {
						out.println(
							"<div class='row'>" +
					        	"<div class='col-lg-12'>" +
									"<div class='alert alert-success'>" +
					        			"<a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a>" +
										"<strong>Success!</strong> " + (updatedGame != null ? updatedGame : updatedGenre) + " successfully updated." +
									"</div>" +
					        	"</div>" +
							"</div>"
					    );
					} else if (updateResult != null && (updatedGame != null || updatedGenre != null) && updateResult.equals("fail")) {
						out.println(
							"<div class='row'>" +
					        	"<div class='col-lg-12'>" +
									"<div class='alert alert-danger'>" +
					        			"<a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a>" +
										"<strong>Failed!</strong> " + (updatedGame != null ? updatedGame : updatedGenre) + " failed to update." +
									"</div>" +
					        	"</div>" +
							"</div>"
					    );
					}
					
					String uploadedImageGame = request.getParameter("uploadedImageGame");
					String uploadImageResult = request.getParameter("uploadImageResult");
					if (uploadImageResult != null && uploadedImageGame != null && uploadImageResult.equals("success")) {
						out.println(
							"<div class='row'>" +
					        	"<div class='col-lg-12'>" +
									"<div class='alert alert-success'>" +
					        			"<a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a>" +
										"<strong>Success!</strong> Successfully uploaded image for " + uploadedImageGame + "." +
									"</div>" +
					        	"</div>" +
							"</div>"
					    );
					} else if (uploadImageResult != null && uploadedImageGame != null && (uploadImageResult.equals("fail") || uploadImageResult.equals("failUnknown"))) {
						out.println(
							"<div class='row'>" +
					        	"<div class='col-lg-12'>" +
									"<div class='alert alert-danger'>" +
					        			"<a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a>" +
										"<strong>Failed!</strong> Successfully uploaded image for " + uploadedImageGame + ". Reason: " + (uploadImageResult.equals("fail") ? "FileUploadException." : "Unknown.") +
									"</div>" +
					        	"</div>" +
							"</div>"
					    );
					}
					
					String deletedGame = request.getParameter("deletedGame");
					String deletedGenre = request.getParameter("deletedGenre");
					String deleteResult = request.getParameter("deleteResult");
					if (deleteResult != null && (deletedGame != null || deletedGenre != null) && deleteResult.equals("success")) {
						out.println(
							"<div class='row'>" +
					        	"<div class='col-lg-12'>" +
									"<div class='alert alert-success'>" +
					        			"<a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a>" +
										"<strong>Success!</strong> " + (deletedGame != null ? deletedGame : deletedGenre) + " successfully deleted." +
									"</div>" +
					        	"</div>" +
							"</div>"
					    );
					} else if (deleteResult != null && (deletedGame != null || deletedGenre != null) && deleteResult.equals("fail")) {
						out.println(
							"<div class='row'>" +
					        	"<div class='col-lg-12'>" +
									"<div class='alert alert-danger'>" +
					        			"<a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a>" +
										"<strong>Failed!</strong> " + (deletedGame != null ? deletedGame : deletedGenre) + " failed to delete." + (deletedGenre != null ? "There are still games associated with " + deletedGenre + " genre." : "") +
									"</div>" +
					        	"</div>" +
							"</div>"
					    );
					}
					
					String addedGame = request.getParameter("addedGame");
					String addedGenre = request.getParameter("addedGenre");
					String addResult = request.getParameter("addResult");
					if (addResult != null && (addedGame != null || addedGenre != null) && addResult.equals("success")) {
						out.println(
							"<div class='row'>" +
					        	"<div class='col-lg-12'>" +
									"<div class='alert alert-success'>" +
					        			"<a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a>" +
										"<strong>Success!</strong> " + (addedGame != null ? addedGame : addedGenre) + " successfully added." +
									"</div>" +
					        	"</div>" +
							"</div>"
					    );
					} else if (addResult != null && (addedGame != null || addedGenre != null) && addResult.equals("fail")) {
						out.println(
							"<div class='row'>" +
					        	"<div class='col-lg-12'>" +
									"<div class='alert alert-danger'>" +
					        			"<a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a>" +
										"<strong>Failed!</strong> " + (addedGame != null ? addedGame : addedGenre) + " failed to add." +
									"</div>" +
					        	"</div>" +
							"</div>"
					    );
					}
				%>

				<!-- Content -->
                <div class="row modify-section">
                    <div class="col-md-6">
                        <h2>Games</h2>
                        <a href="AddGame.jsp" class="pull-right add-btn"><button type="button" class="btn btn-sm btn-primary btn-create">Add Game</button></a>
                        <div class="table-responsive">
                            <table class="table table-bordered table-hover table-striped">
                               	<thead>
                               		<tr>
                               			<th>Game ID</th><th>Game Title</th><th><em class="fa fa-cog"></em></th>
                               		</tr>
                               	</thead>
                               	<tbody>
                               	<%	
                               		try {
										Connection conn = DBConnection.getConnection();
										PreparedStatement pstmt = conn.prepareStatement("SELECT * FROM game ORDER BY GameTitle");
										ResultSet rs = pstmt.executeQuery();
										
										out.println("");
										while (rs.next()) {	
											String gameID = rs.getString("gameID");
											String gameTitle = rs.getString("gameTitle");
											
											out.println("<tr>");
											out.println("<td>" + gameID + "</td>");
											out.println("<td>" + gameTitle + "</td>");
											out.println("<td align='center'><a href='UpdateGame.jsp?gameID=" + gameID + "' class='btn btn-default'><em class='fa fa-pencil'></em></a>");
											out.println("<a href='UploadImage.jsp?gameID=" + gameID + "' class='btn btn-info'><em class='fa fa-upload'></em></a>");
											out.println("<a href='DeleteGame.jsp?gameID=" + gameID + "' class='btn btn-danger'><em class='fa fa-trash'></em></a></td>");
											out.println("</tr>");
									}
								%>
								</tbody>
							</table>
                        </div>
                    </div>
                    
                    <div class="col-md-6">
                        <h2>Genres</h2>
                        <a href="AddGenre.jsp" class="pull-right add-btn"><button type="button" class="btn btn-sm btn-primary btn-create">Add Genre</button></a>
                        <div class="table-responsive">
                            <table class="table table-bordered table-hover table-striped">
                               	<thead>
                               		<tr>
                               			<th>Genre ID</th><th>Genre Title</th><th><em class="fa fa-cog"></em></th>
                               		</tr>
                               	</thead>
                               	<tbody>
                               	<%	
										PreparedStatement pstmt2 = conn.prepareStatement("SELECT * FROM genre ORDER BY GenreName");
										ResultSet rs2 = pstmt2.executeQuery();
										
										while (rs2.next()) {	
											String genreID = rs2.getString("genreID");
											String genreName = rs2.getString("genreName");
											
											out.println("<tr>");
											out.println("<td>" + genreID + "</td>");
											out.println("<td>" + genreName + "</td>");
											out.println("<td align='center'><a href='UpdateGenre.jsp?genreID=" + genreID + "' class='btn btn-default'><em class='fa fa-pencil'></em></a>");
											out.println("<a href='DeleteGenre.jsp?genreID=" + genreID + "' class='btn btn-danger'><em class='fa fa-trash'></em></a></td>");
											out.println("</tr>");
										}
                               		} catch (Exception e) {
                               			System.out.println(e);
                               		}
								%>
								</tbody>
							</table>
                        </div>
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
