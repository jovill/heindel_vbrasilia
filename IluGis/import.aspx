<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="import.aspx.cs" Inherits="IluGis.import" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
     <script src="js/bootstrap.file-input.js" type="text/javascript"></script> 
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="body" runat="server">


    <form autocomplete="off" runat="server" class="form-inline" style="width: 100%;" name="myForm" novalidate>
        <asp:HiddenField ID="hfLoginPK" runat="server" Value="" />
         <asp:HiddenField ID="hfPermissao" runat="server" Value="" />   
       <div class="row">
            <div runat="server" id="Msucesso" visible="false" class="alert alert-success me" >
                                  
            </div>
           <div runat="server" id="Malerta" visible="false" class="alert alert-warning">
                
            </div>

            <div runat="server" id="Merro" visible="false" class="alert alert-danger">
                
            </div>
       </div>
        <br />
        <div class="row" style="display:block;">     
                        
                 <div class="col-md-4"></div>
                 <div class="col-md-4">                    
                        <h4>
                            <label style="font-size: 1.4em; " class = "glyphicon glyphicon-download-alt" rel="tooltip" title=""></label>
                            <span style="color:#333333; position:relative; top:-5px;">
                                Importar arquivo KML
                            </span>
                        </h4>
                 </div>
                 <div class="col-md-4"></div>

                </div>
        <br />
        <div class="row" style="margin-bottom:8px;">
                     
               <div class="col-md-4"></div>
                 
                 
                        <div class="col-md-2">
                            <asp:DropDownList  Style="width: 100%" ID="ddlEquipe" class=" form-control input-sm " runat="server" title="Equipe"  autofocus="true">
                                <asp:ListItem Text ="Selecione a Equipe" Value = "-1"></asp:ListItem>
                                <asp:ListItem Text ="Equipe1" Value = "E1"></asp:ListItem>
                                <asp:ListItem Text ="Equipe2" Value = "E2"></asp:ListItem>
                                 <asp:ListItem Text ="Equipe3" Value = "E3"></asp:ListItem>
                                <asp:ListItem Text ="Equipe4" Value = "E4"></asp:ListItem>    
                                             
                             </asp:DropDownList>
                          </div>
                          <div class="col-md-2">
                              <asp:DropDownList  Style="width: 100%" ID="ddllocal" class=" form-control input-sm " runat="server" title="Equipe"  autofocus="true">
                                <asp:ListItem Text ="Selecione o local" Value = "-1"></asp:ListItem>
                                <asp:ListItem Text ="BARREIRO 01" Value = "BARREIRO01"></asp:ListItem>   
                                 <asp:ListItem Text ="BARREIRO 02" Value = "BARREIRO02"></asp:ListItem>   
                                 <asp:ListItem Text ="BARREIRO 03" Value = "BARREIRO03"></asp:ListItem>   
                                 <asp:ListItem Text ="BARREIRO 04" Value = "BARREIRO04"></asp:ListItem>   
                                 <asp:ListItem Text ="BARREIRO 05" Value = "BARREIRO05"></asp:ListItem>   
                                 <asp:ListItem Text ="CENTRO" Value = "CENTRO"></asp:ListItem>   
                                 <asp:ListItem Text ="CENTRO SUL 03" Value = "CENTROSUL03"></asp:ListItem>   
                                 <asp:ListItem Text ="CENTRO-SUL 01" Value = "CENTROSUL01"></asp:ListItem>   
                                 <asp:ListItem Text ="CENTRO-SUL 02" Value = "CENTROSUL02"></asp:ListItem>   
                                 <asp:ListItem Text ="LESTE 01" Value = "LESTE01"></asp:ListItem>   
                                 <asp:ListItem Text ="LESTE 02" Value = "LESTE02"></asp:ListItem>   
                                 <asp:ListItem Text ="NORDESTE 01" Value = "NORDESTE01"></asp:ListItem>     
                                 <asp:ListItem Text ="NORDESTE 02" Value = "NORDESTE02"></asp:ListItem>   
                                 <asp:ListItem Text ="NOROESTE 01" Value = "NOROESTE01"></asp:ListItem>   
                                 <asp:ListItem Text ="NOROESTE 02" Value = "NOROESTE02"></asp:ListItem>   
                                 <asp:ListItem Text ="NOROESTE 03" Value = "NOROESTE03"></asp:ListItem>   
                                 <asp:ListItem Text ="NORTE 01" Value = "NORTE01"></asp:ListItem>   
                                 <asp:ListItem Text ="NORTE 02" Value = "NORTE02"></asp:ListItem>   
                                 <asp:ListItem Text ="OESTE 01" Value = "OESTE01"></asp:ListItem>   
                                 <asp:ListItem Text ="OESTE 02" Value = "OESTE02"></asp:ListItem>   
                                 <asp:ListItem Text ="OESTE 03" Value = "OESTE03"></asp:ListItem>   
                                 <asp:ListItem Text ="OESTE 04" Value = "OESTE04"></asp:ListItem>   
                                 <asp:ListItem Text ="PAMPULHA 01" Value = "PAMPULHA01"></asp:ListItem>
                                <asp:ListItem Text ="PAMPULHA 02" Value = "PAMPULHA02"></asp:ListItem> 
                                <asp:ListItem Text ="PAMPULHA 02" Value = "PAMPULHA02"></asp:ListItem> 
                                <asp:ListItem Text ="VENDA NOVA 01" Value = "VENDANOVA01"></asp:ListItem> 
                                <asp:ListItem Text ="VENDA NOVA 02" Value = "VENDANOVA02"></asp:ListItem>  
                                             
                             </asp:DropDownList>

                            </div>                   

                <div class="col-md-4"></div>
            </div>
             

            
            <div class="row" style="display:block; margin-bottom:5px;">
                                     
                <div class="col-md-4"></div>
                <div class="col-md-4">                        
                            <span class="btn btn-default btn-file" style="width:100%; text-align:left; margin-bottom:5px;"> Selecione(.xlsx) <input type="file"  id="File1" name="File1"  runat="server" />
                            </span>                    
                </div>

                <div class="col-md-4"></div>

            </div>
            <div class="row" style=" display:block; margin-bottom:5px;">
                     
                <div class="col-md-4"></div>
                <div class="col-md-4">                     
                        <asp:LinkButton  runat="server"  OnClick="FindCoordinates_Click1"   ID="LinkButton4"   class="btn btn-primary btn-sm pull-right">Importar</asp:LinkButton>

                </div>
                <div class="col-md-4"></div>

            </div>
      </form>

    <script>
      
            $('input[type=file]').bootstrapFileInput();
            $(document).ready(function () {

                $(".date").mask("00/00/0000", { clearIfNotMatch: true });



            });

    </script>
</asp:Content>
