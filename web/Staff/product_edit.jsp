<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="entity.*" %>
<%@page import="java.util.*"%>

<!DOCTYPE html>
<html>
    <head>

        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <!----======== CSS ======== -->
        <link rel="stylesheet" href="new.css">

        <!----===== Iconscout CSS ===== -->
        <link rel="stylesheet" href="https://unicons.iconscout.com/release/v4.0.0/css/line.css">

        <title>Edit Staff</title>
    </head>
    
    <% List<Category> categoryList = (List) session.getAttribute("categoryList");%>
    <body>
        <%int productId =  Integer.parseInt(request.getParameter("productId"));%>
        <%String productName = (String) request.getParameter("productName");%>
        <%double price = Double.parseDouble(request.getParameter("price"));%>
        <%int STOCK_COUNT = Integer.parseInt(request.getParameter("STOCK_COUNT"));%>
        <%String description = (String) request.getParameter("description");%>
        <%int category = Integer.parseInt(request.getParameter("category"));%>
        <%@ include file="adminNavBar.jsp" %>
        <form action="<%= request.getContextPath()%>/ProductCRUD?action=edit" method="post">
            <div style=" padding-left: 300px; padding-top: 20px;" >
                <div class="formbold-input-flex">
                    <div class="formbold-input-flex-left">
                        <label class="formbold-form-label">Product Name : </label>
                        <input class="formbold-form-input" type="text" name="productName" value="<%=productName%>" size="40" placeholder="Enter your Product Name"/><br />
                    </div>
                    <div class="formbold-input-flex-right">
                        <label class="formbold-form-label">Price:</label>
                        <input class="formbold-form-input" type="text" name="price" value="<%=price%>" size="40" placeholder="Enter your price"/><br />
                    </div>
                </div>
                <div class="formbold-input-flex">
                    <div class="formbold-input-flex-left">
                        <label class="formbold-form-label">Stock Count : </label>
                        <input class="formbold-form-input" type="number" name="STOCK_COUNT" value="<%=STOCK_COUNT%>" placeholder="Enter the Stock"/><br />
                    </div>
                    <div class="formbold-input-flex-right">   
                        <label class="formbold-form-label">Description:</label>
                        <input class="formbold-form-input" type="text" name="description" value="<%=description%>" size="40" placeholder="Enter the Description"/><br />
                        <input type="hidden" name="productId" value="<%= productId%>"/>
                    </div>
                </div>
                <div>
                    <div class="formbold-input-flex-left">
                        <label class="formbold-form-label">Category : </label>
                        <select name="category" id="category" >
                            
                            <%for(Category cat: categoryList){%>
                            <%if(category == cat.getCategoryId()){%>
                            <option value="<%=cat.getCategoryId()%>" selected>
                                <%=cat.getCatName()%>
                            </option>
                            <%} else {%>
                            <option value="<%=cat.getCategoryId()%>"> <%=cat.getCatName()%></option>
                            <%}}%>
                          
                            
                        </select>
                    </div>
                </div>
            </div>

            <div style="display: flex;flex-direction: row;margin-top:20px;justify-content: space-evenly ">
                <input type="submit" value="Submit"/>
            </div>

        </form>
        <hr style="margin:50px;">
        <div style=" padding-left: 300px; padding-top: 20px;">
        <h1>Add Image Here</h1>
        <form action="<%= request.getContextPath()%>/ProductCRUD?action=addImage" method="post" enctype="multipart/form-data">
            <input type="hidden" name="productId" value="<%= productId%>"/>
            <div id="imageField">
            <input onchange="addOneInput(this)" type="file" name="AddImageList"> 
            </div>
            <input type="submit" name="AddImage">
        </form>     
        </div>
    </body>
</html>
<style>
    body{
        min-height: 100vh;
        background-color: var(--primary-color);
    }
    form  {
        /*     display: table;*/
        /*        padding-left: 300px;*/
        padding-top: 40px;
        margin-left: 200px;
    }
    .formbold-input-flex-left{
        margin-left:200px;
    }
    .formbold-input-flex-right{
        margin-right:200px;
    }
    .formbold-input-flex {
        display: flex;
        gap: 20px;
        margin-bottom: 15px;
    }
    .formbold-input-flex > div {
        width: 50%;
    }
    .formbold-form-input {
        text-align: center;
        width: 100%;
        padding: 13px 22px;
        border-radius: 5px;
        border: 1px solid #dde3ec;
        background: #ffffff;
        font-weight: 500;
        font-size: 16px;
        color: #536387;
        outline: none;
        resize: none;
    }
    .formbold-form-label {
        color: #536387;
        font-size: 14px;
        line-height: 24px;
        display: block;
        margin-bottom: 10px;
    }
    .formbold-btn {
        font-size: 16px;
        border-radius: 5px;
        padding: 14px 25px;
        border: none;
        font-weight: 500;
        cursor: pointer;
        margin-top: 25px;
        margin-left: 500px;
    }
    .formbold-btn:hover {
        box-shadow: 0px 3px 8px rgba(0, 0, 0, 0.05);
    }
    .formbold-form-title {
        margin-bottom: 30px;
    }
    .formbold-form-title h2 {
        font-weight: 600;
        font-size: 28px;
        line-height: 34px;
        color: #07074d;
    }
</style>

<script>
    const body = document.querySelector("body"),
            modeToggle = body.querySelector(".mode-toggle");
    sidebar = body.querySelector("nav");
    sidebarToggle = body.querySelector(".sidebar-toggle");

    let getMode = localStorage.getItem("mode");
    if (getMode && getMode === "dark") {
        body.classList.toggle("dark");
    }

    let getStatus = localStorage.getItem("status");
    if (getStatus && getStatus === "close") {
        sidebar.classList.toggle("close");
    }

    modeToggle.addEventListener("click", () => {
        body.classList.toggle("dark");
        if (body.classList.contains("dark")) {
            localStorage.setItem("mode", "dark");
        } else {
            localStorage.setItem("mode", "light");
        }
    });

    sidebarToggle.addEventListener("click", () => {
        sidebar.classList.toggle("close");
        if (sidebar.classList.contains("close")) {
            localStorage.setItem("status", "close");
        } else {
            localStorage.setItem("status", "open");
        }
    });
    
    
    function addOneInput(input){
        const imageField = document.getElementById("imageField");
        const input2 = `<input onchange="addOneInput(this)" type="file" name="AddImageList">`;
        if(input.files.length > 0){
            imageField.insertAdjacentHTML('beforeend', input2);
        }
        
        
    }
</script>