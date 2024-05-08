<!DOCTYPE html>
<html lang="en" dir="ltr">
  <head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>HAN-KEA</title> 
    <link rel="stylesheet" href="style.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.2/css/all.min.css"/>
  </head>
  <body>
    <div class="container">
        <div class="wrapper">
            <div class="title"><span>Login Form</span></div>
            <form action= "<%= request.getContextPath()%>/login" method="POST">
                <% if(request.getAttribute("loginStatus")== "failed"){%>
                <p style="color: red;">Wrong Username or Password</p>
                <%}%>
                <div class="row">
                    <i class="fas fa-user"></i>
                    <input type="text" placeholder="Username" name="username" required >
                </div>
                
                <div class="row">
                    <i class="fas fa-lock"></i>
                    <input type="password" placeholder="Password" name="password" required>
                </div>
                <div class="pass"><a href="forgotPassword.jsp">Forgot password?</a></div>
                <div class="row button">
                    <input type="submit" value="Login">
                </div>
                <div class="signup-link">Not a member? <a href="Customer/signup.jsp">Signup now</a></div>
                <div style="color:#000000;border-top:1px solid;border-right-style:0px;margin-top:5px;margin-bottom:5px;width:100%;color:lightgrey"/>
                <div style="text-align: center;margin-top: 5px;font-size: 17px;"><a style="text-decoration: none;color:#A155B9" href="Customer/home.jsp">Login As Guest</a></div>
            </form>
        </div>
    </div>
  </body>
</html>


<style>
*{
  margin: 0;
  padding: 0;
  box-sizing: border-box;
  font-family: sans-serif;
}
body{
  background: #C499F3 ;
  overflow: hidden;
}
::selection{
  background: rgba(26,188,156,0.3);
}
.container{
  max-width: 440px;
  padding: 0 20px;
  margin: 170px auto;
}
.wrapper{
  width: 100%;
  background: #fff;
  border-radius: 5px;
  box-shadow: 0px 4px 10px 1px rgba(0,0,0,0.1);
}
.wrapper .title{
  height: 90px;
  background: #A155B9 ;
  border-radius: 5px 5px 0 0;
  color: #fff;
  font-size: 30px;
  font-weight: 600;
  display: flex;
  align-items: center;
  justify-content: center;
}
.wrapper form{
  padding: 30px 25px 25px 25px;
}
.wrapper form .row{
  height: 45px;
  margin-bottom: 15px;
  position: relative;
}
.wrapper form .row input{
  height: 100%;
  width: 100%;
  outline: none;
  padding-left: 60px;
  border-radius: 5px;
  border: 1px solid lightgrey;
  font-size: 16px;
  transition: all 0.3s ease;
}
form .row input:focus{
  border-color: #16a085;
  box-shadow: inset 0px 0px 2px 2px rgba(26,188,156,0.25);
}
form .row input::placeholder{
  color: #999;
}
.wrapper form .row i{
  position: absolute;
  width: 47px;
  height: 100%;
  color: #fff;
  font-size: 18px;
  background: #A155B9;
  border: 1px solid #16a085;
  border-radius: 5px 0 0 5px;
  display: flex;
  align-items: center;
  justify-content: center;
}
.wrapper form .pass{
  margin: -8px 0 20px 0;
}
.wrapper form .pass a{
  color: #A155B9;
  font-size: 17px;
  text-decoration: none;
}
.wrapper form .pass a:hover{
  text-decoration: underline;
}
.wrapper form .button input{
  color: #fff;
  font-size: 20px;
  font-weight: 500;
  padding-left: 0px;
  background: #A155B9;
  border: 1px solid #16a085;
  cursor: pointer;
}
form .button input:hover{
  background: #5D3587;
}
.wrapper form .signup-link{
  text-align: center;
  margin-top: 20px;
  font-size: 17px;
}
.wrapper form .signup-link a{
  color: #A155B9;
  text-decoration: none;
}
form .signup-link a:hover{
  text-decoration: underline;
}      
</style>