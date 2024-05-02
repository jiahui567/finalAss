<%@page import="entity.*" %>
<%@page import="java.util.*"%>
<html lang="en">
<head>
  <meta charset="utf-8">
  <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
  <meta name="author" content="Untree.co">
  <link rel="shortcut icon" href="favicon.png">

  <meta name="description" content="" />
  <meta name="keywords" content="bootstrap, bootstrap4" />

		<!-- Bootstrap CSS -->
		<link href="css/bootstrap.min.css" rel="stylesheet">
		<link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css" rel="stylesheet">
		<link href="css/tiny-slider.css" rel="stylesheet">
		<link href="css/style.css" rel="stylesheet">
		<title>HAN-KEA</title>
	</head>
        <% 
            List<Products> productList = (List<Products>) session.getAttribute("productList");
        %>
	<body>

		<!-- Start Header/Navigation -->
                <%@include file="nav_bar.jsp" %>
		<!-- End Header/Navigation -->

		<!-- Start Hero Section -->
			<div class="hero">
				<div class="container">
					<div class="row justify-content-between">
						<div class="col-lg-5">
							<div class="intro-excerpt">
								<h1>Shop</h1>
							</div>
						</div>
						<div class="col-lg-7">
							
						</div>
					</div>
				</div>
			</div>
		<!-- End Hero Section -->

		

		<div class="untree_co-section product-section before-footer-section">
		    <div class="container">
		      	<div class="row">

		      		<!-- Start Column 1 -->
                                <%for(Products prod:productList){%>
                                
					<div class="col-12 col-md-4 col-lg-3 mb-5">
                                            <a class="product-item" href="<%=request.getContextPath()%>/loadProductDetail?prodID=<%=prod.getProductId()%>">
							<img src="data:image/jpeg;base64,<%= Base64.getEncoder().encodeToString(prod.getImage())%>" class="img-fluid product-thumbnail">
							<h3 class="product-title"><%=prod.getProductName()%></h3>
							<strong class="product-price">RM <%=prod.getPrice()%></strong>
							<span class="icon-cross">
								<img src="images/cross.svg" class="img-fluid">
							</span>
						</a>
					</div> 
                                        <%}%>
					
					<!-- End Column 4 -->

		      	</div>
		    </div>
		</div>


		<!-- Start Footer Section -->
                <%@include file="footer.jsp" %>
		<!-- End Footer Section -->	


		<script src="js/bootstrap.bundle.min.js"></script>
		<script src="js/tiny-slider.js"></script>
		<script src="js/custom.js"></script>
	</body>

</html>
