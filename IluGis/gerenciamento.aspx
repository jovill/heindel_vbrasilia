<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="gerenciamento.aspx.cs" Inherits="IluGis.gerenciamento1" %>

<asp:Content ID="Content10" ContentPlaceHolderID="head" runat="server">
<title>IluGIS</title>

</asp:Content>

<asp:Content ID="ContentGerenciamento" ContentPlaceHolderID="body" runat="server">
    <form id="form1" runat="server">
        <center><h1>Dashboard</h1></center>
    <div style="display:none;">
        <!---------------------------- Titulo--------------------------------------->
        <div class="row" style="margin-bottom: 8px;">
            <h1 style="text-align: center">Relatórios</h1>
        </div>
        <!-----------------------------Fim titulo------------------------------------>

        <!----------------------relatorios---------------------------------------------->
        <div class="row" style="margin-bottom:16px">
            <div class="col-md- col-sm-3 col-md-offset-4 col-sm-offset-4">
                <asp:LinkButton runat="server" ID="btnEmitirTodosRelatorios" class="btn btn-md btn-primary btn-block" type="submit" Text="Emitir Relatório de todas localidades" title="Emitir relatório de todas as localidades"/>
            </div>
        </div>

        <div class="row"  style="margin-bottom:16px">
            <div  id="localidadeRelatorio" class=" col-md-3 col-sm-3 col-md-offset-4 col-sm-offset-4" style="margin-bottom:8px">             
                <asp:DropDownList  Style="width: 100%; height: 34px;" ID="ddllocalidadeRelatorio" class=" form-control input-sm " runat="server" title="Definir localidade" autofocus="true">
                <asp:ListItem Text ="Selecione o local" Value = "-1"></asp:ListItem>
                <asp:ListItem Text ="BARREIRO 01" Value = "BARREIRO01"></asp:ListItem>   
                <asp:ListItem Text ="BARREIRO 02" Value = "BARREIRO02"></asp:ListItem>   
                <asp:ListItem Text ="BARREIRO 03" Value = "BARREIRO03"></asp:ListItem>   
                <asp:ListItem Text ="BARREIRO 04" Value = "BARREIRO04"></asp:ListItem>   
                <asp:ListItem Text ="BARREIRO 05" Value = "BARREIRO05"></asp:ListItem>   
                <asp:ListItem Text ="CENTRO" Value = "CENTRO"></asp:ListItem>   
                <asp:ListItem Text ="CENTRO SUL 01" Value = "CENTROSUL01"></asp:ListItem>
                <asp:ListItem Text ="CENTRO SUL 02" Value = "CENTROSUL02"></asp:ListItem>  
                <asp:ListItem Text ="CENTRO SUL 03" Value = "CENTROSUL03"></asp:ListItem>                                                                       
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
            </div>
         <div class="row"  style="margin-bottom:16px">
           <div class="col-md- col-sm-3 col-md-offset-4 col-sm-offset-4">
                <asp:LinkButton runat="server" ID="btnEmitirRelatorio" class="btn btn-md btn-primary btn-block" type="submit" Text="Emitir Relatório" title="Emitir relatório"/>
            </div>
            
        </div>
        <!---------------------Fim relatorios------------------------------------------->

        <!-----------------------------usuário controle---------------------------------------------->
        <div class="row">
            <h2 style="text-align:center">Usuários</h2>
        </div>

        <!-------------------------------fim usuario controle------------------------------------------>
    </div>
    </form>
   <div>
       <table style ="width:100%">
           <tr>
               <td style ="width:30%">
                    <div id="poste" style=" height:400px;"></div>                       
               </td>
               <td style ="width:30%">
                
                    <div id="reator" style=" height:400px;"> </div>
                </td>
                 <td style ="width:40%">
                
                    <div id="viz" style=" height:400px;"> </div>
                </td>
               
           
           </tr>


           <tr>
               <td style ="width:30%">
                   <div id="braco" style=" height:400px;"></div>

               </td>
               <td style ="width:30%">
                     <div id="rele" style=" height:400px;"></div>

               </td>
               <td style ="width:40%">

                       <div id="aliment" style=" height:400px;"> </div>

               </td>
          </tr>
          
       </table>
        
        
        
       
       
   </div>
       


    

    <script>

        var listvisual = new Array();

        GetGraph();
        function GetGraph() {
            listvisual = [];
            //Relat("TIPO_BRACO", "#braco", "pie", "Tipo de Braço", false);
            Relat("TIPO_POSTE", "#poste", "pie", "Tipo de Poste", false);
            Relat("TIPO_RELE", "#rele", "pie", "Tipo de Relé", false);
            Relat("TIPO_REATOR", "#reator", "bar", "Tipo de Reator", false);
            Relat("TIPO_ALIMENTACAO", "#aliment", "bar", "Tipo de Alimentação", false);
            Relat("TIPO_LUMINARIA", "#viz", "tree_map", "Tipo de Luminária", "GRUPO_TIPO_LUMINARIA");



        }


        function Relat(campo, div, model, title, grupo) {

            var count = 0;
            var somatoria = 0;
            var campos = "";

            if (grupo) {
                $.ajax({
                    url: '<%=ResolveUrl("~/Classes/service.asmx/GetRelatorioGrupo") %>',
                    type: "POST",
                    data: "{ 'campo': '" + campo + "', 'grupo':'" + grupo + "'}",
                    contentType: "application/json; charset=utf-8",
                    dataType: "json",
                    success: function (data2) {
                        var parsed = $.parseJSON(data2.d);

                        var count = 0;
                        $.each(parsed, function (i, jsondata) {
                            if (count == 0) {
                                campos += '[{"name": "' + jsondata.name + '","value": ' + jsondata.value + ',"grupo": "' + jsondata.grupo + '"}';
                            }
                            else {
                                campos += ',{"name": "' + jsondata.name + '","value": ' + jsondata.value + ',"grupo": "' + jsondata.grupo + '"}';
                            }
                            count++;


                        })

                        campos += "]";




                        var visualization = d3plus.viz()
                          .container(div)  // container DIV to hold the visualization
                          .data($.parseJSON(campos))  // data to use with the visualization
                          .type(model)   // visualization type
                          .id(["grupo", "name"])
                          .size("value")
                          .title(title)
                         .labels({ "align": "left", "valign": "top", "resize": true })
                         .color("grupo")
                         .ui([
                        {
                            "method": "color",
                            "value": ["grupo", "name"]
                        }
                         ])
                        .legend({ "labels": true, "size": 50 })
                          .draw();

                        listvisual.push([visualization, div]);


                    },
                    failure: function (response) {
                        alert(response.d);
                    },
                    error: function (response) {
                        alert(response.d);
                    }
                });

            }
            else {
                $.ajax({
                    url: '<%=ResolveUrl("~/Classes/service.asmx/GetRelatorio") %>',
                    type: "POST",
                    data: "{ 'campo': '" + campo + "'}",
                    contentType: "application/json; charset=utf-8",
                    dataType: "json",
                    success: function (data2) {
                        var parsed = $.parseJSON(data2.d);

                        $.each(parsed, function (i, jsondata) {

                            somatoria += jsondata.value;




                        })

                        $.each(parsed, function (i, jsondata) {
                            if (count == 0) {
                                campos += '[{"name": "' + jsondata.name + '","value": ' + jsondata.value + ',"campo":"' + campo + '","percent":"' + parseInt(((jsondata.value / somatoria) * 100)) + '%" }';
                            }
                            else {
                                campos += ',{"name": "' + jsondata.name + '","value": ' + jsondata.value + ',"campo":"' + campo + '","percent":"' + parseInt(((jsondata.value / somatoria) * 100)) + '%"}';
                            }

                            count++;


                        })

                        campos += "]";



                        if (model == "pie") {
                            var visualization = d3plus.viz()
                            .container(div)  // container DIV to hold the visualization
                            .data($.parseJSON(campos))  // data to use with the visualization
                            .type(model)   // visualization type
                            .id("name")
                            .size("value")
                            .labels({ "align": "left", "valign": "top", "resize": true, "padding": "2", "value": true, "text": "percent" })
                            .color("name")
                            .legend({ "labels": true, "size": 50 })
                            .title(title)
                            .mouse({
                                "click": function (d, viz) {



                                    setTimeout(filtro("TIPO_POSTE", d.campo, d.name, "#poste", "pie", "Tipo de Poste", false), 500);
                                    setTimeout(filtro("TIPO_RELE", d.campo, d.name, "#rele", "pie", "Tipo de Relé", false), 500);
                                    setTimeout(filtro("TIPO_REATOR", d.campo, d.name, "#reator", "bar", "Tipo de Reator", false), 500);
                                    setTimeout(filtro("TIPO_ALIMENTACAO", d.campo, d.name, "#aliment", "bar", "Tipo de Alimentação", false), 500);
                                    setTimeout(filtro("TIPO_LUMINARIA", d.campo, d.name, "#viz", "tree_map", "Tipo de Luminária", "GRUPO_TIPO_LUMINARIA"), 500);
                                    setTimeout(filtro("TIPO_BRACO", d.campo, d.name, "#braco", "pie", "Tipo de Braço", false), 500);






                                }
                            })
                           .draw();


                        }
                        else {
                            var visualization = d3plus.viz()
                                  .container(div)  // container DIV to hold the visualization
                                  .data($.parseJSON(campos))  // data to use with the visualization
                                  .type(model)   // visualization type
                                  .id("name")
                                  .x("name")
                                  .y("value")
                                  .labels({ "align": "center", "valign": "top", "resize": true })
                                  .text("percent")
                                  .title(title)
                                 .mouse({
                                     "click": function (d, viz) {

                                         setTimeout(filtro("TIPO_POSTE", d.campo, d.name, "#poste", "pie", "Tipo de Poste", false), 500);
                                         setTimeout(filtro("TIPO_RELE", d.campo, d.name, "#rele", "pie", "Tipo de Relé", false), 500);
                                         setTimeout(filtro("TIPO_REATOR", d.campo, d.name, "#reator", "bar", "Tipo de Reator", false), 500);
                                         setTimeout(filtro("TIPO_ALIMENTACAO", d.campo, d.name, "#aliment", "bar", "Tipo de Alimentação", false), 500);
                                         setTimeout(filtro("TIPO_LUMINARIA", d.campo, d.name, "#viz", "tree_map", "Tipo de Luminária", "GRUPO_TIPO_LUMINARIA"), 400);
                                         setTimeout(filtro("TIPO_BRACO", d.campo, d.name, "#braco", "pie", "Tipo de Braço", false), 500);






                                     }
                                 })
                                 .draw();
                        }


                        listvisual.push([visualization, div]);




                    },
                    failure: function (response) {
                        alert(response.d);
                    },
                    error: function (response) {
                        alert(response.d);
                    }
                });

            }



        }

        function filtro(campo, filtro, value, div, model, title, grupo) {
            var count = 0;
            var somatoria = 0;
            var campos = "";
            if (grupo) {
                somatoria = 0;
                campos = "";
                count = 0;
                $.ajax({
                    url: '<%=ResolveUrl("~/Classes/service.asmx/GetRelatorioFiltroGrupo") %>',
                    type: "POST",
                    data: "{ 'campo': '" + campo + "','filtro':'" + filtro + "','value':'" + value + "','grupo':'" + grupo + "'}",
                    contentType: "application/json; charset=utf-8",
                    dataType: "json",
                    success: function (data2) {
                        var parsed = $.parseJSON(data2.d);

                        $.each(parsed, function (i, jsondata) {

                            somatoria += jsondata.value;




                        })

                        $.each(parsed, function (i, jsondata) {
                            if (count == 0) {
                                campos += '[{"name": "' + jsondata.name + '","value": ' + jsondata.value + ',"grupo":"' + jsondata.grupo + '","campo":"' + campo + '","percent":"' + parseInt(((jsondata.value / somatoria) * 100)) + '%" }';
                            }
                            else {
                                campos += ',{"name": "' + jsondata.name + '","value": ' + jsondata.value + ',"grupo":"' + jsondata.grupo + '","campo":"' + campo + '","percent":"' + parseInt(((jsondata.value / somatoria) * 100)) + '%"}';
                            }

                            count++;


                        })

                        campos += "]";




                        for (var i = 0; i < listvisual.length; i++) {
                            if (listvisual[i][1] == div) {
                                listvisual[i][0].data($.parseJSON(campos)).draw();
                            }
                        }





                    },
                    failure: function (response) {

                        alert("Falha:" + response.d);
                    },
                    error: function (response) {
                        alert("Erro:" + response.d);
                    }
                });

            }
            else {
                somatoria = 0;
                campos = "";
                $.ajax({
                    url: '<%=ResolveUrl("~/Classes/service.asmx/GetRelatorioFiltro") %>',
                    type: "POST",
                    data: "{ 'campo': '" + campo + "','filtro': '" + filtro + "','value':'" + value + "'}",
                    contentType: "application/json; charset=utf-8",
                    dataType: "json",
                    success: function (data2) {
                        var parsed = $.parseJSON(data2.d);

                        $.each(parsed, function (i, jsondata) {

                            somatoria += jsondata.value;




                        })

                        $.each(parsed, function (i, jsondata) {
                            if (count == 0) {
                                campos += '[{"name": "' + jsondata.name + '","value": ' + jsondata.value + ',"campo":"' + campo + '","percent":"' + parseInt(((jsondata.value / somatoria) * 100)) + '%" }';
                            }
                            else {
                                campos += ',{"name": "' + jsondata.name + '","value": ' + jsondata.value + ',"campo":"' + campo + '","percent":"' + parseInt(((jsondata.value / somatoria) * 100)) + '%"}';
                            }

                            count++;


                        })

                        campos += "]";



                        if (campo == "TIPO_BRACO") {

                        }

                        for (var i = 0; i < listvisual.length; i++) {
                            if (listvisual[i][1] == div) {
                                listvisual[i][0].data($.parseJSON(campos)).draw();
                            }
                        }





                    },
                    failure: function (response) {

                        alert("Falha:" + response.d);
                    },
                    error: function (response) {
                        alert("Erro:" + response.d);
                    }
                });



            }



        }
















    </script>

</asp:Content>