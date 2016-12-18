<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="register.aspx.cs" Inherits="IluGis.Register" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <title>IluGIS</title>

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
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="body" runat="server">
    
  <div class="conta iner">
    <div class="row">
        
        <div class="col-xs-8 col-sm-6 col-md-4 col-md-offset-4 col-sm-offset-3 col-xs-offset-2">
            <div class="account-wall">
                <img class="img-responsive" src="img/logo_arya.jpg"
                    alt="Arya Map">
                <div>
                    <h2 style="text-align: center;">Cadastrar Usuário</h2>
                </div>
                <form runat="server" class="form" defaultbutton="btnCadastrarUsuario">
				    <asp:TextBox runat="server" ID="txtNome" type="text" class="form-control input-sm" style="padding-left: 5px; padding-top: 5px;" title = "Informe o nome completo" placeholder="Informe o nome completo"  ></asp:TextBox> 
                    <asp:Label ID="LabelErroNome" runat="server" Text="" ></asp:Label> 
                    <br />
                    <asp:TextBox runat="server" ID="txtUsuario" type="text" class="form-control input-sm" title="Informe o nome de usuário" placeholder="Informe o nome de usuário"  ></asp:TextBox>
                    <asp:Label ID="LabelErroUsuario" runat="server" Text="" ></asp:Label>
                    <br/>
                    <asp:TextBox runat="server" ID="txtEmail" type="email" class="form-control input-sm" title="Informe o Email" placeholder="Informe o Email"  ></asp:TextBox>
                    <asp:Label ID="LabelErroEmail" runat="server" Text="" ></asp:Label>
                    <br/>
                    <asp:TextBox runat="server" ID="txtSenha" type="password" class="form-control input-sm" title = "Informe a senha" placeholder="Informe a senha"></asp:TextBox>
                    <asp:Label ID="LabelErroSenha" runat="server" Text="" ></asp:Label>
                    <br/>
                    <asp:TextBox runat="server" ID="txtRepitaSenha" type="password" class="form-control input-sm" title="Repita a senha" placeholder="Repita a senha"></asp:TextBox>
                    <asp:Label ID="LabelErroRepitaSenha" runat="server" Text="" ></asp:Label> 
                    <br />
                            <asp:DropDownList ID="ddlPermissao"  class=" form-control input-sm " runat="server"  autofocus="true">
                                <asp:ListItem Text ="Selecione o tipo de permissão" Value = "-1"></asp:ListItem>
                                 <asp:ListItem Text ="Adminstrador" Value = "0"></asp:ListItem>
                                 <asp:ListItem Text ="Usuário" Value = "1"></asp:ListItem>
                            </asp:DropDownList>
                    <asp:Label ID="LabelErroPermissao" runat="server" Text="" ></asp:Label> 
                    <br />
                    <asp:LinkButton runat="server" ID="btnCadastrarUsuario" OnClick="btnCadastrarUsuario_Click" class="btn btn-md btn-primary btn-block" type="submit" Text="Cadastrar" />
                    <asp:Label ID="LabelCadastro" runat="server" Text="" ></asp:Label> 
                    
                     
                     <asp:Label ID="Label1" runat="server" Text="" ></asp:Label> 
                </form>
            </div>
        </div>
    </div>
</div>

    
  
</asp:Content>
