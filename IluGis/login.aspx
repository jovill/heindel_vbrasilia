<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="login.aspx.cs" Inherits="IluGis.login" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>IluGIS</title>
    <!--FONT AWESOME-->
            <link rel="stylesheet" href="font-awesome/css/font-awesome.css">
        <!--ANGULAR-->
            <script src="js/angular.js"></script>
        <!--JQUERY-->
            
            <script src="js/jquery.js" type="text/javascript"></script>
            <script src="js/jquery-ui.js" type="text/javascript"></script>
            <link href="css/jquery-ui.css" rel="Stylesheet" type="text/css" />
            <!--script src="js/jquery.maskedinput.js" type="text/javascript"></script-->
            <script src="js/jquery.maskMoney.js" type="text/javascript"></script>
            <script src="js/jQuery-Mask-Plugin-master/src/jquery.mask.js" type="text/javascript"></script>
        <!--BOOTSTRAP-->
        <!--<link href=" bootstrap/css/Menucss.css" rel="Stylesheet" type="text/css" />-->
            <script src="bootstrap/js/bootstrap-select.js" type="text/javascript"></script>
           <link href=" bootstrap/css/bootstrap.css" rel="Stylesheet" type="text/css" />
            <link href=" bootstrap/css/bootstrap-select.css" rel="Stylesheet" type="text/css" />
            <script src="bootstrap/js/bootstrap.js"></script>
        <!--LOCAL-->
            <link href="css/stylesheet.css" rel="Stylesheet" type="text/css" />
            <link href="css/masterpage.css" rel="Stylesheet" type="text/css" />
             <link href="~/Styles/Site.css" rel="stylesheet" type="text/css" />
            <link href="css/button.css" rel="stylesheet" type="text/css" />
      <style>
body {
    background-color: #27408B;
}
.form-signin
{
    max-width: 330px;
    padding: 15px;
    margin: 0 auto;
}
.form-signin .form-signin-heading, .form-signin .checkbox
{
    margin-bottom: 10px;
}
.form-signin .checkbox
{
    font-weight: normal;
}
.form-signin .form-control
{
    position: relative;
    font-size: 16px;
    height: auto;
    padding: 10px;
    -webkit-box-sizing: border-box;
    -moz-box-sizing: border-box;
    box-sizing: border-box;
}
.form-signin .form-control:focus
{
    z-index: 2;
}
.form-signin input[type="text"]
{
    margin-bottom: -1px;
    border-bottom-left-radius: 0;
    border-bottom-right-radius: 0;
}
.form-signin input[type="password"]
{
    border-top-left-radius: 0;
    border-top-right-radius: 0;
}
.account-wall
{
    margin-top: 20px;
    padding: 40px 0px 20px 0px;
    background-color: white;
    -moz-box-shadow: 0px 2px 2px rgba(0, 0, 0, 0.3);
    -webkit-box-shadow: 0px 2px 2px rgba(0, 0, 0, 0.3);
    box-shadow: 0px 2px 2px rgba(0, 0, 0, 0.3);
    padding-bottom: 15%;
}
.login-title
{
    color: #555;
    font-size: 18px;
    font-weight: 400;
    display: block;
}
.profile-img
{
    width: 96px;
    height: 96px;
    margin: 0 auto 10px;
    display: block;
    -moz-border-radius: 50%;
    -webkit-border-radius: 50%;
    border-radius: 50%;
}
.need-help
{
    margin-top: 10px;
}
.new-account
{
    display: block;
    margin-top: 10px;
}

     </style>
</head>
<body>
    
  <div class="conta iner">
    <div class="row">
        <div class="col-xs-8 col-sm-6 col-md-4 col-md-offset-4 col-sm-offset-3 col-xs-offset-2">
            <div class="account-wall">
                <img class="img-responsive" src="img/logo_arya.jpg"
                    alt="Arya Map">
                <form runat="server" class="form-signin" defaultbutton="btnEntrar">
				   <asp:TextBox runat="server" type="text" id="inputUser" class="form-control" placeholder="Nome de usuário" required autofocus></asp:TextBox>
                    <br/>
				    <asp:TextBox runat="server" id="inputPassword" type="password" class="form-control" placeholder="Senha" required></asp:TextBox>
                    <br />
                    <asp:LinkButton runat="server" id="btnEntrar"  OnClick="btnLogOn_Click" class="btn btn-md btn-primary btn-block" type="submit" Text="Entrar" />
                     
                     <asp:Label ID="Label1" runat="server" Text="" ></asp:Label> 
                </form>
            </div>
        </div>
    </div>
</div>
  
</body>
</html>
