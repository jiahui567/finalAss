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
        <link rel="preconnect" href="https://fonts.googleapis.com">
        <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
        <link href="https://fonts.googleapis.com/css2?family=Bitter:ital,wght@0,100..900;1,100..900&family=Poppins:ital,wght@0,100;0,200;0,300;0,400;0,500;0,600;0,700;0,800;0,900;1,100;1,200;1,300;1,400;1,500;1,600;1,700;1,800;1,900&display=swap" rel="stylesheet">
        <link rel="stylesheet" href="https://unicons.iconscout.com/release/v4.0.0/css/line.css">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css">

        <!-- Bootstrap CSS -->
        <link href="css/bootstrap.min.css" rel="stylesheet">
        <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css" rel="stylesheet">
        <link href="css/tiny-slider.css" rel="stylesheet">
        <link href="css/style.css" rel="stylesheet">
        <title>HAN-KEA</title>
    </head>
    <% 
        List<Products> productList = (List<Products>) session.getAttribute("productList");
        List<Category> categoryList = (List) session.getAttribute("categoryList");
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
                </div>
            </div>
        </div>
        <!-- End Hero Section -->



        <div class="untree_co-section product-section before-footer-section">
            <form method="post" action="<%= request.getContextPath()%>/Search?search=product&page=customer">
                <i class="uil uil-search"></i>
                <input style="border-radius: 50px; border-color:#55356E;" type="text" name="value" placeholder="Search here..." onchange="this.form.submit()">
            </form>

            <form action="<%= request.getContextPath()%>/Filter?action=Product&page=customer" method="post" margin="0">
                <label>Category: </label>
                <select name="Product" id="Product" onchange="this.form.submit()">
                    <option selected disabled>
                        Filter
                    </option>
                    <option value="0">
                        All
                    </option>
                    <%for(Category cat: categoryList){%>
                    <option value="<%=cat.getCategoryId()%>"> <%=cat.getCatName()%></option>
                    <%}%>
                </select>
            </form>

            <div class="container">
                <div class="row">

                    <!-- Start Column 1 -->
                    <%for(Products prod:productList){%>

                    <div class="col-12 col-md-4 col-lg-3 mb-5">
                        <a class="product-item" href="<%=request.getContextPath()%>/loadProductDetail?prodID=<%=prod.getProductId()%>">
                            <img src="data:image/jpeg;base64,<%= Base64.getEncoder().encodeToString(prod.getImage())%>" style="height:50%" class="img-fluid product-thumbnail">
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
