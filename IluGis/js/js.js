		document.write(unescape("%3Cscript src='js/jquery.js' type='text/javascript'%3E%3C/script%3E"));
        

        function isPostBack() { //function to check if page is a postback-ed one
            return document.getElementById('_ispostback').value;
        }


        var lista=[];
        var pos = -1;
        var marker1 = new Array();
        var ilum = L.layerGroup();

         

        $("#google").click(function () {
            var lat = $('#<%=txtLat.ClientID%>').val().trim();
            var lng = $('#<%=txtLng.ClientID%>').val().trim();
            if (lat != "" || lng != "") {
                window.open("http://maps.google.com/maps?q=" + lat + "," + lng);
            }
            
        });

        $("#globespotter").click(function () {// icone que habilita opções de medição

            window.open(shared + gimageID + "&Yaw=" + gyaw + "&Pitch=" + gpitch + "&HFov=" + ghfov, '_new');

        });  

     


        $("#openGlobe").click(function () {// icone que habilita opções de medição
            
           
            var lat = $('#<%=txtLat.ClientID%>').val();
            var lng = $('#<%=txtLng.ClientID%>').val();
            if(lat != "" && lng!="")
            {
                openNearestImage(lng + ',' + lat);
                $.ajax({
                    type: "POST",
                    url: '<%=ResolveUrl("~/Classes/Service.asmx/Geocode") %>',
                    data: "{ 'lat':'" + lat + "', 'lng':'" + lng + "'}",
                    contentType: "application/json; charset=utf-8",
                    dataType: "json",
                    success: function (data) {


                        var info = data.d;

                        $('#<%=txtLog.ClientID%>').val(info[1]);
                        $('#<%=txtMun.ClientID%>').val(info[3]);
                        $('#<%=txtCEP.ClientID%>').val(info[5]);


                    },
                    error: function (XHR, errStatus, errorThrown) {
                        var err = JSON.parse(XHR.responseText);
                        errorMessage = err.Message;
                        alert(errorMessage);
                    }
                });
            }        
            

        });

        $(document).ready(function () {


        $("#btnclear").click(function () {// icone que habilita opções de medição
             
            limpacampos();
           setDefault();
               

        });
        $("#infolista").click(function () {// icone que habilita opções de medição
            if ($('#<%=txtCodIluminacao.ClientID%>').val())
            {
                var result = -1;
                result = buscaBinariaSimples(lista, lista.length, $('#<%=txtCodIluminacao.ClientID%>').val());
               
                if (result != -1)
                {
                    
                    selectIluminacao(lista[result][0], lista[result][1], lista[result][2], lista[result][3], lista[result][4])
                }
                else {
                    alert("Codigo não encontrado!")
                }
               
            }
            


        });

        function  buscaBinariaSimples(v, n, x) {
                
                achou = false;
                var L = 1;
                var  R = n;
                var M= 0;
                var ultimo = n-1;
               
                while (!achou && L < R) {
                    if (x == v[0][0])
                    {
                        M = 0;
                        achou = true;
                        return M
                        break;
                    }

                    M = parseInt((L + R) / 2);
                    if (x == v[M][0]) {
                        return M;
                        achou = true;
                    } else if (x < v[M][0]) {
                        R = M
                    } else {
                        L = M + 1
                    }
                }
                return -1;
                   

            }    
/**************************************************************************************************slider**/
            $('.bxslider').bxSlider({
                mode: 'fade',
                captions: true
            });


 /**************************************************************************************************postback**/
            
            if (isPostBack().toString() == "True") {///RELOAD DA PAGINA FAZER
                $.ajax({
                    url: '<%=ResolveUrl("~/Classes/service.asmx/GetLista") %>',
                    type: "POST",
                    data: "{ 'localidade': '" + $("#<%=ddllocalidade.ClientID %>").val() + "'}",
                    contentType: "application/json; charset=utf-8",
                    dataType: "json",
                    success: function (data2) {
                        var parsed = $.parseJSON(data2.d);


                        $.each(parsed, function (i, jsondata) {
                            lista.push([
                                  jsondata.ID_ILUMINACAO_PUBLICA,
                                  jsondata.ILUID,
                                  jsondata.ILU_LAT,
                                  jsondata.ILU_LNG,
                                  jsondata.KMLID,
                                  jsondata.COD_ILUM_FK
                            ])
                        })



                    },
                    failure: function (response) {
                        alert(response.d);
                    },
                    error: function (response) {
                        alert(response.d);
                    }
                });
                selectIluminacaoRefresh($('#<%=txtCodIluminacao.ClientID%>').val(), $('#<%=hfCodilumPK.ClientID%>').val(), $('#<%=txtLat.ClientID%>').val(), $('#<%=txtLng.ClientID%>').val(), $('#<%=hfkmlID.ClientID%>').val())
                

            }
            else {
                
            }

           /*********************************************************************************************mascara*/

            $(".date").mask("00/00/0000", { clearIfNotMatch: true });
            $(".phone").mask("(00) 0000-0000", { clearIfNotMatch: true });
            $(".cepTxt").mask("00000-000", { clearIfNotMatch: true });
            $(".CNPJ").mask("00.000.000/0000-00", { clearIfNotMatch: true });
            $(".numerotxt").mask("000", { clearIfNotMatch: false });
            $(".metros").mask("00.00", { clearIfNotMatch: false });          
            $(".faturamento").maskMoney({ allowNegative: false, thousands: '.', decimal: ',', affixesStay: false });


            
            $("#<%=ddllocalidade.ClientID %>").change(function () {
                lista = [];
                $('#<%=txtCodIluminacao.ClientID%>').css("background", "#FFFFFF");
                $('#<%=txtCodIluminacao.ClientID%>').val("");               
                 if ($("#<%=ddllocalidade.ClientID %>").val() != "0")
                 {
                     pos = -1;
                     
                     
                        $.ajax({
                            url: '<%=ResolveUrl("~/Classes/service.asmx/GetLista") %>',
                            type: "POST",
                            data: "{ 'localidade': '" + $("#<%=ddllocalidade.ClientID %>").val() + "'}",
                            contentType: "application/json; charset=utf-8",
                            dataType: "json",
                            success: function (data2) {
                                var parsed = $.parseJSON(data2.d);
                                

                                $.each(parsed, function (i, jsondata) {
                                    lista.push([
                                          jsondata.ID_ILUMINACAO_PUBLICA,
                                          jsondata.ILUID,
                                          jsondata.ILU_LAT,
                                          jsondata.ILU_LNG,
                                          jsondata.KMLID,
                                          jsondata.COD_ILUM_FK
                                    ])
                                })
                                ilum.clearLayers();
                                for (var i = 0; i < lista.length; i++) {
                                    if (lista[i][4] != "" || lista[i][4] != "NULL") {
                                        var LamMarker = L.marker([lista[i][2], lista[i][3]], { id: i, icon: greenIcon }).on('click', markerOnClick).addTo(map);
                                    }
                                    else {
                                        var LamMarker = L.marker([lista[i][2], lista[i][3]], { id: i, icon: redIcon }).on('click', markerOnClick).addTo(map);
                                    }

                                    ilum.addLayer(LamMarker);

                                }
                                map.setView([-19.9646, -43.9614], 11);
                                map.addLayer(ilum);

                               
                               
                            },
                            failure: function (response) {
                                alert(response.d);
                            },
                            error: function (response) {
                                alert(response.d);
                            }
                        });
                  
                    

                 }
                
             });


            /*----------------------------------Padrão tipo de braço e projeção do braço------------*/
 
             $("#<%=ddlTipoBraco.ClientID %>").change(function () {
                
                 if ($("#<%=hfCodilumPK.ClientID %>").val() != "")
                 {                   
                     if ($("#<%=ddlTipoBraco.ClientID %>").val() == "Curto") {
                         $("#<%=txtProjBraco.ClientID %>").val("1.65");          
                     }
                    else if ($("#<%=ddlTipoBraco.ClientID %>").val() == "Medio") {
                        $("#<%=txtProjBraco.ClientID %>").val("2.92"); 
                     }
                     else if ($("#<%=ddlTipoBraco.ClientID %>").val() == "Longo") {
                         $("#<%=txtProjBraco.ClientID %>").val("5.60");
                         $("#<%=txtAltPoste.ClientID %>").val("12");
                     }
                     else
                     {
                          setDefault();
                          $("#<%=txtProjBraco.ClientID %>").val("");
                     }
 
                 } else{
                  }
             });


            /*-------------------------Padrao para o tipo e potencia de fonte luminosa--------------*/
            $("#<%=ddlTipoFonteLum.ClientID %>").change(function () {
                if ($("#<%=ddlTipoFonteLum.ClientID %>").val() == "Sodio") {
                    $("#<%=ddlPotFonteLum.ClientID %>").empty().append($("<option></option>").val("0").html("Potência da fonte luminosa (W)"));
                    $("#<%=ddlPotFonteLum.ClientID %>").append($("<option></option>").val("70").html("70W"));
                    $("#<%=ddlPotFonteLum.ClientID %>").append($("<option></option>").val("100").html("100W"));
                    $("#<%=ddlPotFonteLum.ClientID %>").append($("<option></option>").val("150").html("150W"));
                    $("#<%=ddlPotFonteLum.ClientID %>").append($("<option></option>").val("250").html("250W"));
                    $("#<%=ddlPotFonteLum.ClientID %>").append($("<option></option>").val("400").html("400W"));
                    $("#<%=ddlPotFonteLum.ClientID %>").val("0");
                } else if ($("#<%=ddlTipoFonteLum.ClientID %>").val() == "Mercurio") {
                    $("#<%=ddlPotFonteLum.ClientID %>").empty().append($("<option></option>").val("0").html("Potência da fonte luminosa (W)"));
                    $("#<%=ddlPotFonteLum.ClientID %>").append($("<option></option>").val("80").html("80W"));
                    $("#<%=ddlPotFonteLum.ClientID %>").append($("<option></option>").val("125").html("125W"));
                    $("#<%=ddlPotFonteLum.ClientID %>").append($("<option></option>").val("250").html("250W"));
                    $("#<%=ddlPotFonteLum.ClientID %>").append($("<option></option>").val("400").html("400W"));
                    $("#<%=ddlPotFonteLum.ClientID %>").val("0");
                } else if ($("#<%=ddlTipoFonteLum.ClientID %>").val() == "Metalico") {
                    $("#<%=ddlPotFonteLum.ClientID %>").empty().append($("<option></option>").val("0").html("Potência da fonte luminosa (W)"));
                    $("#<%=ddlPotFonteLum.ClientID %>").append($("<option></option>").val("35").html("35W"));
                    $("#<%=ddlPotFonteLum.ClientID %>").append($("<option></option>").val("70W").html("70W"));
                    $("#<%=ddlPotFonteLum.ClientID %>").append($("<option></option>").val("150W").html("150W"));
                    $("#<%=ddlPotFonteLum.ClientID %>").val("0");
                } else {
                    setDefault();
                }
            });

             /*-------------------------------------Tipo relé e tipo reator baseado no tipo de luminária---------------------------*/
             $("#<%=ddlTipoLum.ClientID %>").change(function () {
                 if ($("#<%=ddlTipoLum.ClientID %>").val() == "Integrada policarbonato" || $("#<%=ddlTipoLum.ClientID %>").val() == "Integrada vidro")
                 {
                     $("#<%=ddlTipoReator.ClientID %>").val("Interno");
                     $("#<%=ddlTipoRele.ClientID %>").val("Integrado na luminaria");
                 } else if ($("#<%=ddlTipoLum.ClientID %>").val() == "0") {
                     $("#<%=ddlTipoReator.ClientID %>").val("0");
                     $("#<%=ddlTipoRele.ClientID %>").val("0");
                 }
             });

            $("#<%=ddlTipoLum.ClientID %>").change(function() {
                if ($("#<%=ddlTipoLum.ClientID %>").val() == "Corpo unico aberta" || $("#<%=ddlTipoLum.ClientID %>").val() == "Corpo unico fechada com vidro" || $("#<%=ddlTipoLum.ClientID %>").val() == "Corpo unico fechada com policarbonato") {
                     $("#<%=ddlTipoReator.ClientID %>").val("Externo");
                     $("#<%=ddlTipoRele.ClientID %>").val("No poste");
                }   
            });
 
            $("#<%=ddlTipoLum.ClientID %>").change(function () {
                if ($("#<%=ddlTipoLum.ClientID %>").val() == "Petalar" || $("#<%=ddlTipoLum.ClientID %>").val() == "Outros") {
                    $("#<%=ddlTipoReator.ClientID %>").val("0");
                    $("#<%=ddlTipoRele.ClientID %>").val("0");
                }
            });

            $("#<%=ddlTipoLum.ClientID %>").change(function () {
                if ($("#<%=ddlTipoLum.ClientID %>").val() == "Decorativa esferica" || $("#<%=ddlTipoLum.ClientID %>").val() == "Decorativa semi-esférica") {
                    $("#<%=ddlTipoReator.ClientID %>").val("0");
                    $("#<%=ddlTipoRele.ClientID %>").val("Comando em grupo");
                }
            });


            /*-------------------------Padrao para Tipo de braço ou poste com tipo de alimentação-------------------------*/

            $("#<%=ddlTipoBraco.ClientID %>").change(function () {
                if ($("#<%=ddlTipoBraco.ClientID %>").val() == "Curto" || $("#<%=ddlTipoBraco.ClientID %>").val() == "Medio" || $("#<%=ddlTipoBraco.ClientID %>").val() == "Longo") {
                    $("#<%=ddlTipoAlimentacao.ClientID %>").val("Aereo");
                    $("#<%=ddlTipoPoste.ClientID %>").val("0");
                }else if ($("#<%=ddlTipoBraco.ClientID %>").val() == "0"){
                    $("#<%=ddlTipoAlimentacao.ClientID %>").val("0");
                }
            });

            $("#<%=ddlTipoBraco.ClientID %>").change(function () {
                if ($("#<%=ddlTipoBraco.ClientID %>").val() == "Especial") {
                    $("#<%=ddlTipoPoste.ClientID %>").val("Metalico");
                    $("#<%=ddlTipoAlimentacao.ClientID %>").val("Subterraneo");
                }
            });

            $("#<%=ddlTipoPoste.ClientID %>").change(function () {
                if ($("#<%=ddlTipoPoste.ClientID %>").val() == "Concreto Duplo T" || $("#<%=ddlTipoPoste.ClientID %>").val() == "Concreto circular" || $("#<%=ddlTipoPoste.ClientID %>").val() == "Madeira") {
                    $("#<%=ddlTipoAlimentacao.ClientID %>").val("Aereo");
                } else if ($("#<%=ddlTipoPoste.ClientID %>").val() == "Metalico") {
                    $("#<%=ddlTipoAlimentacao.ClientID %>").val("Subterraneo");
                } else if ($("#<%=ddlTipoPoste.ClientID %>").val() == "0") {
                    $("#<%=ddlTipoAlimentacao.ClientID %>").val("0");
                }
            });




            


            /*---------------------------------Quantidade de Luminarias e quantidade de fontes luminosas-------------------------*/

            $("#<%=ddlQtdeLum.ClientID %>").change(function () {
                if ($("#<%=ddlQtdeLum.ClientID %>").val() == "0") {
                    $("#<%=ddlQtdeFonteLum.ClientID %>").val("0");
                }else if ($("#<%=ddlQtdeLum.ClientID %>").val() == "1") {
                    $("#<%=ddlQtdeFonteLum.ClientID %>").val("1");
                }else if ($("#<%=ddlQtdeLum.ClientID %>").val() == "2") {
                    $("#<%=ddlQtdeFonteLum.ClientID %>").val("2");
                }else if ($("#<%=ddlQtdeLum.ClientID %>").val() == "3") {
                    $("#<%=ddlQtdeFonteLum.ClientID %>").val("3");
                }else if ($("#<%=ddlQtdeLum.ClientID %>").val() == "4") {
                    $("#<%=ddlQtdeFonteLum.ClientID %>").val("4");
                }else if ($("#<%=ddlQtdeLum.ClientID %>").val() == "5") {
                    $("#<%=ddlQtdeFonteLum.ClientID %>").val("5");
                }else if ($("#<%=ddlQtdeLum.ClientID %>").val() == "6") {
                    $("#<%=ddlQtdeFonteLum.ClientID %>").val("6");
                }else if ($("#<%=ddlQtdeLum.ClientID %>").val() == "7") {
                    $("#<%=ddlQtdeFonteLum.ClientID %>").val("7");
                }else if ($("#<%=ddlQtdeLum.ClientID %>").val() == "8") {
                    $("#<%=ddlQtdeFonteLum.ClientID %>").val("8");
                }else if ($("#<%=ddlQtdeLum.ClientID %>").val() == "9") {
                    $("#<%=ddlQtdeFonteLum.ClientID %>").val("9");
                } else if ($("#<%=ddlQtdeLum.ClientID %>").val() == "10") {
                    $("#<%=ddlQtdeFonteLum.ClientID %>").val("10");
                }
            });
 
            /*************************************************************************************************************botao de dados padroes*/

 
            $("#btncomuncurto").click(function () {// icone que habilita opções de medição
                setDefault();
                $("#<%=ddlTipoBraco.ClientID %>").val("Curto");
                $("#<%=txtProjBraco.ClientID %>").val("1.65");
                $("#<%=txtAltPoste.ClientID %>").val("11");
                $("#<%=ddlQtdeLum.ClientID %>").val("1");
                $("#<%=ddlTipoPoste.ClientID %>").val("Concreto Circular");
                $("#<%=ddlQtdeFonteLum.ClientID %>").val("1");
                $("#<%=ddlTipoReator.ClientID %>").val("Interno");
                $("#<%=ddlTipoAlimentacao.ClientID %>").val("Aereo");
                $("#<%=txtAltInstLum.ClientID %>").val("7");
                $("#<%=ddlTipoRele.ClientID %>").val("Integrado na luminaria");
                $("#<%=ddlIlumDest.ClientID %>").val("1");
                $("#<%=ddlTipoLum.ClientID %>").val("Integrada policarbonato");
                $("#<%=ddlTipoFonteLum.ClientID %>").val("Sodio");
                $("#<%=ddlPotFonteLum.ClientID %>").val("100");
                $("#<%=txtMun.ClientID %>").val("Belo Horizonte");
            });

                $("#btncomunmedio").click(function () {// icone que habilita opções de medição
                setDefault();
                $("#<%=ddlTipoBraco.ClientID %>").val("Medio");
                $("#<%=txtProjBraco.ClientID %>").val("2.92");
                $("#<%=txtAltPoste.ClientID %>").val("11");               
                $("#<%=ddlTipoPoste.ClientID %>").val("Concreto Circular");
                $("#<%=ddlQtdeFonteLum.ClientID %>").val("1");
                $("#<%=ddlTipoReator.ClientID %>").val("Interno");
                $("#<%=ddlTipoAlimentacao.ClientID %>").val("Aereo");
                $("#<%=txtAltInstLum.ClientID %>").val("8");
                $("#<%=ddlTipoRele.ClientID %>").val("Integrado na luminaria");
                $("#<%=ddlIlumDest.ClientID %>").val("1");
                $("#<%=ddlTipoLum.ClientID %>").val("Integrada policarbonato");
                $("#<%=ddlTipoFonteLum.ClientID %>").val("Sodio");
                $("#<%=ddlPotFonteLum.ClientID %>").val("150");
                $("#<%=ddlQtdeLum.ClientID %>").val("1");
                $("#<%=txtMun.ClientID %>").val("Belo Horizonte");
            });

                $("#btncomunlongo").click(function () {// icone que habilita opções de medição
                 setDefault();
                 $("#<%=ddlTipoBraco.ClientID %>").val("Longo");
                $("#<%=txtProjBraco.ClientID %>").val("5.6");
                $("#<%=txtAltPoste.ClientID %>").val("14");
                $("#<%=ddlQtdeLum.ClientID %>").val("1");
                $("#<%=ddlTipoPoste.ClientID %>").val("Concreto Circular");
                $("#<%=ddlQtdeFonteLum.ClientID %>").val("1");
                $("#<%=ddlTipoReator.ClientID %>").val("Interno");
                $("#<%=ddlTipoAlimentacao.ClientID %>").val("Aereo");
                $("#<%=txtAltInstLum.ClientID %>").val("12");
                $("#<%=ddlTipoRele.ClientID %>").val("Integrado na luminaria");
                $("#<%=ddlIlumDest.ClientID %>").val("1");
                $("#<%=ddlTipoLum.ClientID %>").val("Integrada policarbonato");
                $("#<%=ddlTipoFonteLum.ClientID %>").val("Sodio");
                $("#<%=ddlPotFonteLum.ClientID %>").val("400");
                $("#<%=txtMun.ClientID %>").val("Belo Horizonte");        
            });

            $("#btncomunrodovia").click(function () {// icone que habilita opções de medição
                limpa();
                setDefault();
                $("#<%=ddlTipoBraco.ClientID %>").val("Especial");                
                $("#<%=txtAltPoste.ClientID %>").val("14");
                $("#<%=ddlQtdeLum.ClientID %>").val("2");
                $("#<%=ddlTipoPoste.ClientID %>").val("Metalico");
                $("#<%=ddlQtdeFonteLum.ClientID %>").val("1");
                $("#<%=ddlTipoReator.ClientID %>").val("Interno");
                $("#<%=ddlTipoAlimentacao.ClientID %>").val("Subterraneo");
                $("#<%=txtAltInstLum.ClientID %>").val("12");
                $("#<%=ddlTipoRele.ClientID %>").val("Comando em grupo");
                $("#<%=ddlIlumDest.ClientID %>").val("1");
                $("#<%=ddlTipoLum.ClientID %>").val("Integrada vidro");
                $("#<%=ddlTipoFonteLum.ClientID %>").val("Sodio");
                $("#<%=ddlPotFonteLum.ClientID %>").val("400");
                $("#<%=txtMun.ClientID %>").val("Belo Horizonte");
                 
            });

             

 
            function setDefault()
             {
                 $("#<%=ddlTipoPoste.ClientID %>").empty().append($("<option></option>").val("0").html("Tipo Poste"));
                $("#<%=ddlTipoPoste.ClientID %>").append($("<option></option>").val("Concreto Duplo T").html("Concreto Duplo T"));
                 $("#<%=ddlTipoPoste.ClientID %>").append($("<option></option>").val("Concreto Circular").html("Concreto Circular"));
                 $("#<%=ddlTipoPoste.ClientID %>").append($("<option></option>").val("Madeira").html("Madeira"));
                 $("#<%=ddlTipoPoste.ClientID %>").append($("<option></option>").val("Metalico").html("Metálico"));
                $("#<%=ddlTipoPoste.ClientID %>").val("0");
                $("#<%=ddlPotFonteLum.ClientID %>").empty().append($("<option></option>").val("0").html("Potência da fonte luminosa (W)"));
                $("#<%=ddlPotFonteLum.ClientID %>").append($("<option></option>").val("6").html("6W"));
                $("#<%=ddlPotFonteLum.ClientID %>").append($("<option></option>").val("35").html("35W"));
                $("#<%=ddlPotFonteLum.ClientID %>").append($("<option></option>").val("40").html("40W"));
                $("#<%=ddlPotFonteLum.ClientID %>").append($("<option></option>").val("54").html("54W"));
                $("#<%=ddlPotFonteLum.ClientID %>").append($("<option></option>").val("55").html("55W"));
                $("#<%=ddlPotFonteLum.ClientID %>").append($("<option></option>").val("58").html("58W"));
                $("#<%=ddlPotFonteLum.ClientID %>").append($("<option></option>").val("70").html("70W"));
                $("#<%=ddlPotFonteLum.ClientID %>").append($("<option></option>").val("80").html("80W"));
                $("#<%=ddlPotFonteLum.ClientID %>").append($("<option></option>").val("86").html("86W"));
                $("#<%=ddlPotFonteLum.ClientID %>").append($("<option></option>").val("100").html("100W"));
                $("#<%=ddlPotFonteLum.ClientID %>").append($("<option></option>").val("125").html("125W"));
                $("#<%=ddlPotFonteLum.ClientID %>").append($("<option></option>").val("127").html("127W"));
                $("#<%=ddlPotFonteLum.ClientID %>").append($("<option></option>").val("150").html("150W"));
                $("#<%=ddlPotFonteLum.ClientID %>").append($("<option></option>").val("250").html("250W"));
                $("#<%=ddlPotFonteLum.ClientID %>").append($("<option></option>").val("350").html("350W"));
                $("#<%=ddlPotFonteLum.ClientID %>").append($("<option></option>").val("400").html("400W"));
                $("#<%=ddlPotFonteLum.ClientID %>").val("0");
             }
 
         
 
 
             /***********************************************************************************auto complete**/

            $("#<%=txtCodIluminacao.ClientID %>").autocomplete({
                source: function (request, response) {

                    $.ajax({
                        url: '<%=ResolveUrl("~/Classes/service.asmx/GetIluminacao") %>',
                        type: "POST",
                        data: "{ 'ilupk': '" + request.term + "','localidade': '"+ $('#<%=ddllocalidade.ClientID %>').val()+"'}",
                        contentType: "application/json; charset=utf-8",
                        dataType: "json",
                        success: function (data2) {

                          
                          
                            var parsed = $.parseJSON(data2.d);
                            var colunas = [];
                           
                            
                            
                            $.each(parsed, function (i, jsondata) {
                        
                                
                                colunas.push([
                                    jsondata.ID_ILUMINACAO_PUBLICA,
                                    jsondata.ILUID,
                                    jsondata.ILU_LAT,
                                    jsondata.ILU_LNG,
                                    jsondata.KMLID
                                ])
                            })

                          
                       

                            response($.map(colunas, function (item) {
                                return {
                                    label: item[0].toString(),
                                    iluPK: item[1].toString(),
                                    lat: item[2].toString(),
                                    lng: item[3].toString(),
                                    kmlPK: item[4].toString()

                                }
                            }))

                        },
                        error: function (response) {

                            alert(response.responseText);
                        },
                        failure: function (response) {

                            alert(response.responseText);
                        }
                    });
                },

                select: function (e, i) {
                  

                    selectIluminacao(i.item.label, i.item.iluPK, i.item.lat, i.item.lng, i.item.kmlPK)



                },
                minLength: 1
            });


            function selectIluminacao(codIlu, objectid, lat, lng, kmlid) {
                pos = -1;
                $('#<%=txtCodIluminacao.ClientID%>').css("background", "#FFFFFF");
                setDefault();
                limpa();
                $('#<%=hfCodilumPK.ClientID%>').val(objectid);
                $('#<%=hfkmlID.ClientID%>').val(kmlid);                  
                $("#<%=txtLat.ClientID %>").val(lat);
                $("#<%=txtLng.ClientID %>").val(lng);                
                

                getinfoilum(codIlu, objectid);              

                openNearestImage(lng + ',' + lat);
                  

                
                   
                   
            }
            function selectIluminacaoRefresh(codIlu, objectid, lat, lng, kmlid) {
                setDefault();
                limpa();
                $('#<%=hfCodilumPK.ClientID%>').val(objectid);
                $('#<%=hfkmlID.ClientID%>').val(kmlid);
                $("#<%=txtLat.ClientID %>").val(lat);
                $("#<%=txtLng.ClientID %>").val(lng);

                getinfoilum(codIlu, objectid);
                setTimeout(function () {

                    openNearestImage(lng + ',' + lat);

                }, 3500);






            }

               
                
            
            function  getRows(id) {

                $.ajax({
                    url: '<%=ResolveUrl("~/Classes/service.asmx/GetRows") %>',
                    type: "POST",
                    data: "{ 'id': '" + id + "'}",
                    contentType: "application/json; charset=utf-8",
                    dataType: "json",
                    success: function (data2) {
                        
                        numrows= data2.d;
                    },
                    failure: function (response) {
                        alert(response.d);
                    },
                    error: function (response) {
                        alert(response.d);
                    }
                });
            }


            function getinfoilum(codIlu,iluPK) {
               
                $.ajax({
                    url: '<%=ResolveUrl("~/Classes/service.asmx/GetInfo") %>',
                    type: "POST",
                    data: "{ 'ilumid': '" + iluPK + "'}",
                    contentType: "application/json; charset=utf-8",
                    dataType: "json",
                    success: function (data2) {

                        var parsed2 = $.parseJSON(data2.d);
                        var fotos = ""
                        var cont = 0;
                        var layout = "<div class='bx-wrapper' style='max-width: 100%;'><div class='bx-viewport' style='width: 100%; overflow: hidden; position: relative; height: 530px;'>" +
                                        "<ul class='bxslider' style='height: 467px; width: auto; position: relative;' >"
                        var navegacao = "";

                        $.each(parsed2, function (i, jsondata) {


                              if (jsondata.COD_ILUM_FK != "" && jsondata.COD_ILUM_FK != "NULL" && jsondata.COD_ILUM_FK != null  )
                                {
                                    
                                  selectInfoilu(jsondata.TIPO_BRACO, jsondata.PROJ_BRACO, jsondata.TIPO_LUMINARIA, jsondata.TIPO_FONTE_LUMINARIA, jsondata.POTENCIA_FONTE_LUMI, jsondata.QUANT_FONTES_LUMI, jsondata.POTENCIA_TOTAL_FONTE_LUMI, jsondata.CARGA_INST_TOTAL_UN_ILUM_PUB, jsondata.TIPO_REATOR, jsondata.TIPO_RELE, jsondata.TIPO_ALIMENTACAO, jsondata.TIPO_POSTE, jsondata.ALTURA_POSTE, jsondata.ALTURA_INST_LUMI, jsondata.MUNICIPIO, jsondata.REGIONAL, jsondata.BAIRRO, jsondata.CLASSE_ILUMI, jsondata.LOGRADOURO, jsondata.CEP,jsondata.COD_LOGRADOURO, jsondata.ILUM_DESTAQ, jsondata.NOME_LOCAL_DESTAQ, jsondata.QUANT_LUMINARIAS, jsondata.MEDICAO, jsondata.LAT, jsondata.LONG,jsondata.OBSERVACAO)
                                   $('#<%=LinkButtonCadastrar.ClientID%>').fadeOut();
                                   $('#<%=LinkButtonAlterar.ClientID%>').fadeIn(1000);
                                   $('#deletarInfo').fadeIn(1000);
                                }
                                else
                                {   
                                     
                                    $('#deletarInfo').fadeOut();
                                     $('#<%=LinkButtonAlterar.ClientID%>').fadeOut();
                                    $('#<%=LinkButtonCadastrar.ClientID%>').fadeIn(1000);
                                 }
                            
                           

                            cont = 0;
                            for (var i = jsondata.COD_SEQ_INICIAL; i <= jsondata.COD_SEQ_FINAL; i++) {
                                cont++
                                if (cont == 1) {
                                    fotos = fotos + "<li style='float: none; list-style: none; position: absolute; width: 467px; z-index: 50; display: block;'><a href='img/fotos/" + jsondata.EQUIPE + "/" + jsondata.LOCALIDADE + "/" + codIlu + "_" + cont + ".JPG' target='_blank'>" + "<img width=100% height=467px src=img/fotos/" + jsondata.EQUIPE + "/" + jsondata.LOCALIDADE + "/" + codIlu + "_" + cont + ".JPG></a></li>";

                                }
                                else {
                                    fotos = fotos + "<li style='float: none; list-style: none; position: absolute; width: 467px; z-index: 0; display: block;'><a href=' img/fotos/" + jsondata.EQUIPE + "/" + jsondata.LOCALIDADE + "/" + codIlu + "_" + cont + ".JPG' target='_blank' >" + "<img width=100% height=467px src=img/fotos/" + jsondata.EQUIPE + "/" + jsondata.LOCALIDADE + "/" + codIlu + "_" + cont + ".JPG></a></li>";
                                }
                                navegacao = navegacao + " <div class='bx-pager-item'><a href='' data-slide-index='" + (cont - 1) + "' class='bx-pager-link active'>" + cont + "</a> </div>"

                            }


                            layout = layout + fotos + "</ul></div>" +
                              "</div>";








                        });

                        ///////////////////////////////////////////////////// atualiza o slide

                        document.getElementById('sliderblx').innerHTML = layout;
                        $('.bxslider').bxSlider({
                            mode: 'fade',
                            captions: true
                        });
                        ///////////////////////////////////////////////////// atualiza o slide

                    },
                    failure: function (response) {
                        
                        alert(response.d);
                    },
                    error: function (response) {
                        
                        alert(response.d);
                    }
                });
            }


            
            /////////////////////////////////////////////////////setar dados iluminacao nos campos
           
            function selectInfoilu(tipobraco, projbraco, tipolum, tipofontelum, potfontelum, qtdefontelum, pottotfontelum, carginstotuip, tiporeator, tiporele, tipoalimentacao, tipoposte, altposte, altinstlum, municipio, regional, bairro, classeilum, logradouro, cep, codlog, ilumdest, nomelocdest, qtdelum, medicao, lat, lng, observacao) {

                if (tipobraco != "NULL" && tipobraco != undefined && tipobraco != "undefined" && tipobraco != null) {
                    $('#<%=ddlTipoBraco.ClientID%>').val(tipobraco);
                }

                if (projbraco != "NULL" && projbraco != undefined && projbraco != "undefined" && projbraco != null) {
                    $('#<%=txtProjBraco.ClientID%>').val(projbraco);
                }
                
                if (tipolum != "NULL" && tipolum != undefined && tipolum != "undefined" && tipolum != null) {
                    $('#<%=ddlTipoLum.ClientID%>').val(tipolum);
                }

                if (tipofontelum != "NULL" && tipofontelum != undefined && tipofontelum != "undefined" && tipofontelum != null) {
                    $('#<%=ddlTipoFonteLum.ClientID%>').val(tipofontelum);
                }

                if (potfontelum != "NULL" && potfontelum != undefined && potfontelum != "undefined" && potfontelum != null) {
                    $('#<%=ddlPotFonteLum.ClientID%>').val(potfontelum);
                }
               
                if (qtdefontelum != "NULL" && qtdefontelum != undefined && qtdefontelum != "undefined" && qtdefontelum != null) {
                    $('#<%=ddlQtdeFonteLum.ClientID%>').val(qtdefontelum);
                }
               
                if (pottotfontelum != "NULL" && pottotfontelum != undefined && pottotfontelum != "undefined" && pottotfontelum != null) {
                    $('#<%=txtPotTotFonteLum.ClientID%>').val(pottotfontelum);
                }

                if (carginstotuip != "NULL" && carginstotuip != undefined && carginstotuip != "undefined" && carginstotuip != null) {
                    $('#<%=txtCargInsTotUIP.ClientID%>').val(carginstotuip);
                }
               
                if (tiporeator != "NULL" && tiporeator != undefined && tiporeator != "undefined" && tiporeator != null) {
                    $('#<%=ddlTipoReator.ClientID%>').val(tiporeator);
                }

                if (tiporele != "NULL" && tiporele != undefined && tiporele != "undefined" && tiporele != null) {
                    $('#<%=ddlTipoRele.ClientID%>').val(tiporele);
                }
                
                if (tipoalimentacao != "NULL" && tipoalimentacao != undefined && tipoalimentacao != "undefined" && tipoalimentacao != null) {
                    $('#<%=ddlTipoAlimentacao.ClientID%>').val(tipoalimentacao);
                }
               
                if (tipoposte != "NULL" && tipoposte != undefined && tipoposte != "undefined" && tipoposte != null) {
                    $('#<%=ddlTipoPoste.ClientID%>').val(tipoposte);
                }
               
                if (altposte != "NULL" && altposte != undefined && altposte != "undefined" && altposte != null) {
                    $('#<%=txtAltPoste.ClientID%>').val(altposte);
                }
              
              
                if (altinstlum != "NULL" && altinstlum != undefined && altinstlum != "undefined" && altinstlum !=null) {
                    $('#<%=txtAltInstLum.ClientID%>').val(altinstlum);
                }
              
                if (municipio != "NULL" && municipio != undefined && municipio != "undefined" && municipio != null) {
                    $('#<%=txtMun.ClientID%>').val(municipio);
                }
               
                if (regional != "NULL" && regional != undefined && regional != "undefined" && regional != null) {
                    $('#<%=txtReg.ClientID%>').val(regional);
                }
              
                if (bairro != "NULL" && bairro != undefined && bairro != "undefined" && bairro != null) {
                    $('#<%=txtBair.ClientID%>').val(bairro);
                }
                if (classeilum != "NULL" && classeilum != undefined && classeilum != "undefined" && classeilum != null) {
                    $('#<%=ddlClassIlum.ClientID%>').val(classeilum);
                }
                if (logradouro != "NULL" && logradouro != undefined && logradouro != "undefined" && logradouro != null) {
                    $('#<%=txtLog.ClientID%>').val(logradouro);
                }
              
                if (cep != "NULL" && cep != undefined && cep != "undefined" && cep != null) {
                    $('#<%=txtCEP.ClientID%>').val(cep);
                }
                if (codlog != "NULL" && codlog != undefined && codlog != "undefined" && codlog != null) {
                    $('#<%=txtCodLog.ClientID%>').val(codlog);
                }
               
                if (ilumdest != "NULL" && ilumdest != undefined && ilumdest != "undefined" && ilumdest != null) {
                    $('#<%=ddlIlumDest.ClientID%>').val(ilumdest);
                }
                else
                {
                     $('#<%=ddlIlumDest.ClientID%>').val("1");
                }
                if (nomelocdest != "NULL" && nomelocdest != undefined && nomelocdest != "undefined" && nomelocdest != null) {
                    $('#<%=txtNomeLocDestaq.ClientID%>').val(nomelocdest);
                }
                if (qtdelum != "NULL" && qtdelum != undefined && qtdelum != "undefined" && qtdelum != null) {
                    $('#<%=ddlQtdeLum.ClientID%>').val(qtdelum);
                }
                if (medicao != "NULL" && medicao != undefined && medicao != "undefined" && medicao != null) {
                    $('#<%=txtMed.ClientID%>').val(medicao);
                }
                if (lat != "NULL" && lat != undefined && lat != "undefined" && lat != null) {
                    $('#<%=txtLat.ClientID%>').val(lat);
                }
                
                if (lng != "NULL" && lng != undefined && lng != "undefined" && lng != null) {
                    $('#<%=txtLng.ClientID%>').val(lng);
                }
                if (observacao != "NULL" && observacao != undefined && observacao != "undefined" && observacao != null) {
                    $('#<%=txtObservacao.ClientID%>').val(observacao);
                }
            }

            /////////////////////////////////////////////////////fim selectinfoilu
            function limpacampos() {

                $('#<%=txtCodIluminacao.ClientID%>').css("background", "#FFFFFF");
                $("#<%=txtProjBraco.ClientID %>").val("");
                $('#<%=ddlTipoBraco.ClientID%>').val("0");
                $('#<%=ddlTipoLum.ClientID%>').val("0");
                $('#<%=ddlTipoLum.ClientID%>').val("0");
                $('#<%=ddlTipoFonteLum.ClientID%>').val("0");
                $('#<%=ddlPotFonteLum.ClientID%>').val("0");
                $('#<%=ddlQtdeFonteLum.ClientID%>').val("0");
                $('#<%=txtPotTotFonteLum.ClientID%>').val("");
                $('#<%=txtCargInsTotUIP.ClientID%>').val("");
                $('#<%=ddlTipoReator.ClientID%>').val("0");
                $('#<%=ddlTipoRele.ClientID%>').val("0");
                $('#<%=ddlTipoAlimentacao.ClientID%>').val("0");
                $('#<%=ddlTipoPoste.ClientID%>').val("0");
                $('#<%=txtAltPoste.ClientID%>').val("");
                $('#<%=txtAltInstLum.ClientID%>').val("");
                $('#<%=txtReg.ClientID%>').val("");
                $('#<%=txtBair.ClientID%>').val("");
                $('#<%=ddlClassIlum.ClientID%>').val("0");
                $('#<%=txtLog.ClientID%>').val("");
                $('#<%=txtCEP.ClientID%>').val("");
                $('#<%=txtCodLog.ClientID%>').val("");
                $('#<%=txtNomeLocDestaq.ClientID%>').val("");
                $('#<%=ddlQtdeLum.ClientID%>').val("0");
                $('#<%=txtMed.ClientID%>').val("");                     
                $("#<%=txtObservacao.ClientID %>").val("");           
            }

        /////////////////////////////////////////////////////////////limpar dados
             function limpa()
             {
                 
                    $("#<%=txtProjBraco.ClientID %>").val("");
                    $('#<%=ddlTipoBraco.ClientID%>').val("0");               
                    $('#<%=ddlTipoLum.ClientID%>').val("0");    
                    $('#<%=ddlTipoLum.ClientID%>').val("0");                
                    $('#<%=ddlTipoFonteLum.ClientID%>').val("0");                              
                    $('#<%=ddlPotFonteLum.ClientID%>').val("0");
                    $('#<%=ddlQtdeFonteLum.ClientID%>').val("0");
                    $('#<%=txtPotTotFonteLum.ClientID%>').val("");
                    $('#<%=txtCargInsTotUIP.ClientID%>').val("");
                    $('#<%=ddlTipoReator.ClientID%>').val("0");
                    $('#<%=ddlTipoRele.ClientID%>').val("0");
                    $('#<%=ddlTipoAlimentacao.ClientID%>').val("0");
                    $('#<%=ddlTipoPoste.ClientID%>').val("0");
                    $('#<%=txtAltPoste.ClientID%>').val("");
                    $('#<%=txtAltInstLum.ClientID%>').val("");
                    $('#<%=txtMun.ClientID%>').val("");
                    $('#<%=txtReg.ClientID%>').val("");
                    $('#<%=txtBair.ClientID%>').val("");
                    $('#<%=ddlClassIlum.ClientID%>').val("0");
                    $('#<%=txtLog.ClientID%>').val("");
                    $('#<%=txtCEP.ClientID%>').val("");
                    $('#<%=txtCodLog.ClientID%>').val("");
                    $('#<%=ddlIlumDest.ClientID%>').val("0");
                    $('#<%=txtNomeLocDestaq.ClientID%>').val("");
                    $('#<%=ddlQtdeLum.ClientID%>').val("");
                    $('#<%=txtMed.ClientID%>').val("");
                    $('#<%=txtLat.ClientID%>').val("");             
                    $('#<%=txtLng.ClientID%>').val("");
                    $('#deletarInfo').fadeOut();
                    $('#<%=LinkButtonAlterar.ClientID%>').fadeOut();
                    $('#<%=LinkButtonCadastrar.ClientID%>').fadeIn(1000);
                    $("#<%=txtObservacao.ClientID %>").val("");
                    $('#<%=hfCodilumPK.ClientID%>').val("");
                 setTimeout(function () {

                     $('#<%=Msucesso.ClientID%>').fadeOut();
                     $('#<%=Malerta.ClientID%>').fadeOut();
                     $('#<%=Merro.ClientID%>').fadeOut();

                 }, 3000);
                     
                  

            }
          

            $(document).on('click', '#deletarInfo', function (e) {///FUNÇÃO PARA DELETAR DADOS DO POSTE
                if ($('#<%=hfPermissao.ClientID%>').val() != "2")
                {
                    if(confirm("Tem certeza que deseja excluir esses dados?"))
                    $.ajax({
                        type: "POST",
                        url: '<%=ResolveUrl("~/Classes/Service.asmx/deletePoste") %>',
                        data: "{ 'iluPK':'" + $('#<%=hfCodilumPK.ClientID%>').val() + "'}",
                        contentType: "application/json; charset=utf-8",
                        dataType: "json",
                        success: function (data) {
                            if (parseInt(data.d) > 0) {
                                alert('Informações Deletadas!')
                            }
                            else {
                                alert('Codigo não encontrado. Tente novamente!')
                            }

                        },
                        error: function (XHR, errStatus, errorThrown) {
                            var err = JSON.parse(XHR.responseText);
                            errorMessage = err.Message;
                            alert(errorMessage);
                        }
                    });

                    setTimeout(function () {
                        setDefault();
                        limpa();

                    }, 3000);

                }
                else {
                    $('#<%=Malerta.ClientID%>').empty().append("<center><strong>Requer permissão!</strong> Desculpe mas você não tem permissão para deletar essas informações.");
                    $('#<%=Malerta.ClientID%>').fadeIn();
                    setTimeout(function () {

                        $('#<%=Malerta.ClientID%>').fadeOut();

                    }, 3000);
                }
               



            });
            /////////////////////////////////////////////////////fim onclick

        });

        ///////////////////////////////////////////////////// fim document ready
       
            function next(){
                $('#<%=hfCodilumPK.ClientID%>').val("");
                $('#<%=hfkmlID.ClientID%>').val("");
                var x =$('#<%=txtCodIluminacao.ClientID%>').val();
                var n =lista.length;
                if (x != "") {
                    if (pos != -1) {
                       
                        if (pos < (n-1)) {
                           
                            $('#<%=txtCodIluminacao.ClientID%>').val(lista[(pos + 1)][0].toString())
                            pos++;
                            if (lista[pos][5] != "NULL" && lista[pos][5] != "null" && lista[pos][5] != null && lista[pos][5] != undefined) {

                                $('#<%=txtCodIluminacao.ClientID%>').css("background", "#90EE90");

                            }
                            else {
                                $('#<%=txtCodIluminacao.ClientID%>').css("background", "#FFA07A");

                            }

                        }

                    }
                    else {

                        buscaBinaria(lista, n, x, true);
                    }

                        
                }
                else {
                    pos = 0;
                    $('#<%=txtCodIluminacao.ClientID%>').val(lista[0][0].toString())
                    if (lista[0][5] != "NULL" && lista[0][5] != "null" && lista[0][5] != null && lista[0][5] != undefined) {

                        $('#<%=txtCodIluminacao.ClientID%>').css("background", "#90EE90");

                    }
                    else {
                        $('#<%=txtCodIluminacao.ClientID%>').css("background", "#FFA07A");

                    }

                }
              
        
            }
        function prev() {
                $('#<%=hfCodilumPK.ClientID%>').val("");
                $('#<%=hfkmlID.ClientID%>').val("");
                var x =$('#<%=txtCodIluminacao.ClientID%>').val();
                var n = lista.length;
                var ultimo = (n - 1);

                if (x != "") {
                    
                    if (pos != -1)
                    {
                        if (pos > 0)
                        {
                            $('#<%=txtCodIluminacao.ClientID%>').val(lista[(pos - 1)][0].toString())
                            pos--;
                            if (lista[pos][5] != "NULL" && lista[pos][5] != "null" && lista[pos][5] != null && lista[pos][5] != undefined) {

                                $('#<%=txtCodIluminacao.ClientID%>').css("background", "#90EE90");

                            }
                            else {
                                $('#<%=txtCodIluminacao.ClientID%>').css("background", "#FFA07A");

                            }
                        }
                        
                    }
                    else
                    {
                        buscaBinaria(lista, n, x, false);
                    }
                        
                }
                else {
                    pos = ultimo;
                    $('#<%=txtCodIluminacao.ClientID%>').val(lista[ultimo][0].toString())
                    if (lista[ultimo][5] != "NULL" && lista[ultimo][5] != "null" && lista[ultimo][5]!= null && lista[ultimo][5] != undefined) {

                        $('#<%=txtCodIluminacao.ClientID%>').css("background", "#90EE90");

                    }
                    else {
                        $('#<%=txtCodIluminacao.ClientID%>').css("background", "#FFA07A");

                    }

                }
            }

        function buscaBinaria(v, n, x, mod) {
                
                achou = false;
                var L = 1;
                var  R = n;
                var M= 0;
                var ultimo = n-1;
               
                while (!achou && L < R) {
                    if (x == v[0][0])
                    {
                        M = 0;
                        achou = true;                       
                        break;
                    }

                    M = parseInt((L + R) / 2);
                    if (x == v[M][0]) {
                        
                        achou = true;
                    } else if (x < v[M][0]) {
                        R = M
                    } else {
                        L = M + 1
                    }
                }
                if (achou = true) {
                    pos = M;
                    if (mod)
                    {
                        if (M < (n - 1))
                        {
                           
                            $('#<%=txtCodIluminacao.ClientID%>').val(lista[(M + 1)][0])
                            
                            if (lista[(M + 1)][5] != "NULL" && lista[(M + 1)][5] != "null" && lista[(M + 1)][5] != null && lista[(M + 1)][5] != undefined) {
                                $('#<%=txtCodIluminacao.ClientID%>').css("background-color", "#90EE90");
                         
                            }
                            else {
                                $('#<%=txtCodIluminacao.ClientID%>').css("background-color", "#FFA07A");
                          
                            }
                        }
                        
                       
                    }
                    else
                    {
                        if (M>0)
                        {
                            $('#<%=txtCodIluminacao.ClientID%>').val(lista[(M - 1)][0])
                            if (lista[(M - 1)][5] != "NULL" && lista[(M - 1)][5] != "null" && lista[(M - 1)][5] != null && lista[(M - 1)][5] != undefined) {
                                $('#<%=txtCodIluminacao.ClientID%>').css("background-color", "#90EE90");
                               
                            }
                            else {
                                $('#<%=txtCodIluminacao.ClientID%>').css("background-color", "#FFA07A");
                               
                            }
                        }
                       
                       
                    }
                   
                   
                } else {
                   
                }

            }
           

            
        /////////////////////AQUI COMEÇA O MAPA//////////////////////////////////////

      


       mapLink = '<a href="http://www.esri.com/">Esri</a>';
       wholink = 'i-cubed, USDA, USGS, AEX, GeoEye, Getmapping, Aerogrid, IGN, IGP, UPR-EGP, and the GIS User Community';

        var esri = L.tileLayer('http://server.arcgisonline.com/ArcGIS/rest/services/World_Imagery/MapServer/tile/{z}/{y}/{x}', {
            attribution: '&copy; ' + mapLink + ', ' + wholink,
            maxZoom: 22,
        })

        var grayscale = L.tileLayer('http://{s}.tile.osm.org/{z}/{x}/{y}.png', {
            attribution: '&copy; <a href="http://osm.org/copyright">OpenStreetMap</a> contributors',
            maxZoom:18
        });

        var mbAttr = 'Map data &copy; <a href="http://openstreetmap.org">OpenStreetMap</a> contributors, ' +
				'<a href="http://creativecommons.org/licenses/by-sa/2.0/">CC-BY-SA</a>, ' +
				'Imagery © <a href="http://mapbox.com">Mapbox</a>'
        var mbUrl = 'https://api.tiles.mapbox.com/v4/{id}/{z}/{x}/{y}.png?access_token=pk.eyJ1IjoibWFwYm94IiwiYSI6ImNpandmbXliNDBjZWd2M2x6bDk3c2ZtOTkifQ._QA7i5Mpkd_m30IGElHziw';


        streets = L.tileLayer(mbUrl, { id: 'mapbox.streets', attribution: mbAttr });

        var marker = L.marker([-19.951013, -44.026161]);


        var map = L.map('map', {
            layers: grayscale,
           
        }).setView([-19.9646, -43.9614], 13);


       // getPontos("TESTE");


        var url = 'http://www.aryagis.com/arcgis/services/CLI008/16008A/MapServer/WMSServer';

        
        /////////////////////////ICON

        var greenIcon = L.icon({
            iconUrl: 'lib/images/marker-icon-green.png',
            shadowUrl: 'lib/images/marker-shadow.png',

            iconSize: [20, 35], // size of the icon
            shadowSize: [25, 40], // size of the shadow
            iconAnchor: [20, 35], // point of the icon which will correspond to marker's location
            shadowAnchor: [4, 40],  // the same for the shadow
            popupAnchor: [-3, -76] // point from which the popup should open relative to the iconAnchor
        });
        var redIcon = L.icon({
            iconUrl: 'lib/images/marker-icon-red.png',
            shadowUrl: 'lib/images/marker-shadow.png',

            iconSize: [20, 35], // size of the icon
            shadowSize: [25, 40], // size of the shadow
            iconAnchor: [20, 35], // point of the icon which will correspond to marker's location
            shadowAnchor: [4, 40],  // the same for the shadow
            popupAnchor: [-3, -76] // point from which the popup should open relative to the iconAnchor
        });


        //////////////////////
      
        
        var baseMaps = {
            "OpenStreetMap": grayscale,
            "Streets": streets,
            "Esri": esri     

        };
        
       
        var overlayMaps = {
            "REMO ": ilum,
            
            
        };
        L.control.scale().addTo(map);
        L.control.layers(baseMaps, overlayMaps).addTo(map);


        ///////////////////////////////////banco

        function getPontos(prefix) {

            $.ajax({
                url: '<%=ResolveUrl("~/Classes/Service.asmx/GetIlu") %>',
                type: "POST",
                data: "{ 'prefix': '" + prefix + "'}",
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: function (data) {
                    var parsed = $.parseJSON(data.d);

                    var i = 0;
                    $.each(parsed, function (i, jsondata) {
                        if (jsondata.COD_ILUM_FK != "" || jsondata.COD_ILUM_FK != "NULL")
                        {
                            var LamMarker = L.marker([jsondata.Y, jsondata.X], { id: i,icon: greenIcon}).on('click', markerOnClick).addTo(map);
                        }
                        else
                        {
                            var LamMarker = L.marker([jsondata.Y, jsondata.X], { id: i, icon: redIcon }).on('click', markerOnClick).addTo(map);
                        }
                        i++;
                        //marker1.push(LamMarker);
                        ilum.addLayer(LamMarker);
                       
                        //tableProp += '<tr><td style="white-space: nowrap;padding-left: 10px; padding-right: 10px; border-right: 1px solid #cccccc;">' + jsondata.NOME + '</td ><td style="white-space: nowrap;padding-left: 10px; padding-right: 10px; border-right: 1px solid #cccccc; ">' + jsondata.CPF + '</td ><td style="white-space: nowrap;"><center><span style="cursor: pointer;" onClick="removeProp(' + jsondata.COD_PROPRIETARIO_PK + ',' + jsondata.COD_EMPRESA_PK + ',\'' + jsondata.CPF + '\')" class="glyphicon glyphicon-remove "></span></center></td></tr>';
                    });                   
                    map.addLayer(ilum);

                },
                error: function (XHR, errStatus, errorThrown) {
                    var err = JSON.parse(XHR.responseText);
                    errorMessage = err.Message;
                    alert(errorMessage);
                }
            });
        };

        function markerOnClick(e) {
            
            selectIluminacao(lista[this.options.id][0], lista[this.options.id][1], lista[this.options.id][2], lista[this.options.id][3], lista[this.options.id][4]);
            
            // alert("Ta vendo é por que ta funcionando." + this.options.id + " MISERAVIII " + e.latlng);
        }
        function onClick(e) {
            alert(this.getLatLng());
            
        }
        L.control.coordinates().addTo(map);
        function setDefault()
             {
                 $("#<%=ddlTipoPoste.ClientID %>").empty().append($("<option></option>").val("0").html("Tipo Poste"));
                $("#<%=ddlTipoPoste.ClientID %>").append($("<option></option>").val("Concreto Duplo T").html("Concreto Duplo T"));
                 $("#<%=ddlTipoPoste.ClientID %>").append($("<option></option>").val("Concreto Circular").html("Concreto Circular"));
                 $("#<%=ddlTipoPoste.ClientID %>").append($("<option></option>").val("Madeira").html("Madeira"));
                 $("#<%=ddlTipoPoste.ClientID %>").append($("<option></option>").val("Metalico").html("Metálico"));
                $("#<%=ddlTipoPoste.ClientID %>").val("0");
                $("#<%=ddlPotFonteLum.ClientID %>").empty().append($("<option></option>").val("0").html("Potência da fonte luminosa (W)"));
                $("#<%=ddlPotFonteLum.ClientID %>").append($("<option></option>").val("6").html("6W"));
                $("#<%=ddlPotFonteLum.ClientID %>").append($("<option></option>").val("35").html("35W"));
                $("#<%=ddlPotFonteLum.ClientID %>").append($("<option></option>").val("40").html("40W"));
                $("#<%=ddlPotFonteLum.ClientID %>").append($("<option></option>").val("54").html("54W"));
                $("#<%=ddlPotFonteLum.ClientID %>").append($("<option></option>").val("55").html("55W"));
                $("#<%=ddlPotFonteLum.ClientID %>").append($("<option></option>").val("58").html("58W"));
                $("#<%=ddlPotFonteLum.ClientID %>").append($("<option></option>").val("70").html("70W"));
                $("#<%=ddlPotFonteLum.ClientID %>").append($("<option></option>").val("80").html("80W"));
                $("#<%=ddlPotFonteLum.ClientID %>").append($("<option></option>").val("86").html("86W"));
                $("#<%=ddlPotFonteLum.ClientID %>").append($("<option></option>").val("100").html("100W"));
                $("#<%=ddlPotFonteLum.ClientID %>").append($("<option></option>").val("125").html("125W"));
                $("#<%=ddlPotFonteLum.ClientID %>").append($("<option></option>").val("127").html("127W"));
                $("#<%=ddlPotFonteLum.ClientID %>").append($("<option></option>").val("150").html("150W"));
                $("#<%=ddlPotFonteLum.ClientID %>").append($("<option></option>").val("250").html("250W"));
                $("#<%=ddlPotFonteLum.ClientID %>").append($("<option></option>").val("350").html("350W"));
                $("#<%=ddlPotFonteLum.ClientID %>").append($("<option></option>").val("400").html("400W"));
                $("#<%=ddlPotFonteLum.ClientID %>").val("0");
             }
 

        function selectIluminacao(codIlu, objectid, lat, lng, kmlid) {
          
                pos = -1;
                $('#<%=txtCodIluminacao.ClientID%>').css("background", "#FFFFFF");
           
                setDefault();
                limpa();
                $('#<%=hfCodilumPK.ClientID%>').val(objectid);
                $('#<%=hfkmlID.ClientID%>').val(kmlid);                  
                $("#<%=txtLat.ClientID %>").val(lat);
                $("#<%=txtLng.ClientID %>").val(lng);                
                

                getinfoilum(codIlu, objectid);              

                openNearestImage(lng + ',' + lat);
                  

                
                   
                   
        }
         function getinfoilum(codIlu,iluPK) {
               
                $.ajax({
                    url: '<%=ResolveUrl("~/Classes/service.asmx/GetInfo") %>',
                    type: "POST",
                    data: "{ 'ilumid': '" + iluPK + "'}",
                    contentType: "application/json; charset=utf-8",
                    dataType: "json",
                    success: function (data2) {

                        var parsed2 = $.parseJSON(data2.d);
                        var fotos = ""
                        var cont = 0;
                        var layout = "<div class='bx-wrapper' style='max-width: 100%;'><div class='bx-viewport' style='width: 100%; overflow: hidden; position: relative; height: 530px;'>" +
                                        "<ul class='bxslider' style='height: 467px; width: auto; position: relative;' >"
                        var navegacao = "";

                        $.each(parsed2, function (i, jsondata) {


                              if (jsondata.COD_ILUM_FK != "" && jsondata.COD_ILUM_FK != "NULL" && jsondata.COD_ILUM_FK != null  )
                                {
                                    
                                  selectInfoilu(jsondata.TIPO_BRACO, jsondata.PROJ_BRACO, jsondata.TIPO_LUMINARIA, jsondata.TIPO_FONTE_LUMINARIA, jsondata.POTENCIA_FONTE_LUMI, jsondata.QUANT_FONTES_LUMI, jsondata.POTENCIA_TOTAL_FONTE_LUMI, jsondata.CARGA_INST_TOTAL_UN_ILUM_PUB, jsondata.TIPO_REATOR, jsondata.TIPO_RELE, jsondata.TIPO_ALIMENTACAO, jsondata.TIPO_POSTE, jsondata.ALTURA_POSTE, jsondata.ALTURA_INST_LUMI, jsondata.MUNICIPIO, jsondata.REGIONAL, jsondata.BAIRRO, jsondata.CLASSE_ILUMI, jsondata.LOGRADOURO, jsondata.CEP,jsondata.COD_LOGRADOURO, jsondata.ILUM_DESTAQ, jsondata.NOME_LOCAL_DESTAQ, jsondata.QUANT_LUMINARIAS, jsondata.MEDICAO, jsondata.LAT, jsondata.LONG,jsondata.OBSERVACAO)
                                   $('#<%=LinkButtonCadastrar.ClientID%>').fadeOut();
                                   $('#<%=LinkButtonAlterar.ClientID%>').fadeIn(1000);
                                   $('#deletarInfo').fadeIn(1000);
                                }
                                else
                                {   
                                     
                                    $('#deletarInfo').fadeOut();
                                     $('#<%=LinkButtonAlterar.ClientID%>').fadeOut();
                                    $('#<%=LinkButtonCadastrar.ClientID%>').fadeIn(1000);
                                 }
                            
                           

                            cont = 0;
                            for (var i = jsondata.COD_SEQ_INICIAL; i <= jsondata.COD_SEQ_FINAL; i++) {
                                cont++
                                if (cont == 1) {
                                    fotos = fotos + "<li style='float: none; list-style: none; position: absolute; width: 467px; z-index: 50; display: block;'><a href='img/fotos/" + jsondata.EQUIPE + "/" + jsondata.LOCALIDADE + "/" + codIlu + "_" + cont + ".JPG' target='_blank'>" + "<img width=100% height=467px src=img/fotos/" + jsondata.EQUIPE + "/" + jsondata.LOCALIDADE + "/" + codIlu + "_" + cont + ".JPG></a></li>";

                                }
                                else {
                                    fotos = fotos + "<li style='float: none; list-style: none; position: absolute; width: 467px; z-index: 0; display: block;'><a href=' img/fotos/" + jsondata.EQUIPE + "/" + jsondata.LOCALIDADE + "/" + codIlu + "_" + cont + ".JPG' target='_blank' >" + "<img width=100% height=467px src=img/fotos/" + jsondata.EQUIPE + "/" + jsondata.LOCALIDADE + "/" + codIlu + "_" + cont + ".JPG></a></li>";
                                }
                                navegacao = navegacao + " <div class='bx-pager-item'><a href='' data-slide-index='" + (cont - 1) + "' class='bx-pager-link active'>" + cont + "</a> </div>"

                            }


                            layout = layout + fotos + "</ul></div>" +
                              "</div>";








                        });

                        ///////////////////////////////////////////////////// atualiza o slide

                        document.getElementById('sliderblx').innerHTML = layout;
                        $('.bxslider').bxSlider({
                            mode: 'fade',
                            captions: true
                        });
                        ///////////////////////////////////////////////////// atualiza o slide

                    },
                    failure: function (response) {
                        
                        alert(response.d);
                    },
                    error: function (response) {
                        
                        alert(response.d);
                    }
                });
            }


            
            /////////////////////////////////////////////////////setar dados iluminacao nos campos
           
            function selectInfoilu(tipobraco, projbraco, tipolum, tipofontelum, potfontelum, qtdefontelum, pottotfontelum, carginstotuip, tiporeator, tiporele, tipoalimentacao, tipoposte, altposte, altinstlum, municipio, regional, bairro, classeilum, logradouro, cep, codlog, ilumdest, nomelocdest, qtdelum, medicao, lat, lng, observacao) {

                if (tipobraco != "NULL" && tipobraco != undefined && tipobraco != "undefined" && tipobraco != null) {
                    $('#<%=ddlTipoBraco.ClientID%>').val(tipobraco);
                }

                if (projbraco != "NULL" && projbraco != undefined && projbraco != "undefined" && projbraco != null) {
                    $('#<%=txtProjBraco.ClientID%>').val(projbraco);
                }
                
                if (tipolum != "NULL" && tipolum != undefined && tipolum != "undefined" && tipolum != null) {
                    $('#<%=ddlTipoLum.ClientID%>').val(tipolum);
                }

                if (tipofontelum != "NULL" && tipofontelum != undefined && tipofontelum != "undefined" && tipofontelum != null) {
                    $('#<%=ddlTipoFonteLum.ClientID%>').val(tipofontelum);
                }

                if (potfontelum != "NULL" && potfontelum != undefined && potfontelum != "undefined" && potfontelum != null) {
                    $('#<%=ddlPotFonteLum.ClientID%>').val(potfontelum);
                }
               
                if (qtdefontelum != "NULL" && qtdefontelum != undefined && qtdefontelum != "undefined" && qtdefontelum != null) {
                    $('#<%=ddlQtdeFonteLum.ClientID%>').val(qtdefontelum);
                }
               
                if (pottotfontelum != "NULL" && pottotfontelum != undefined && pottotfontelum != "undefined" && pottotfontelum != null) {
                    $('#<%=txtPotTotFonteLum.ClientID%>').val(pottotfontelum);
                }

                if (carginstotuip != "NULL" && carginstotuip != undefined && carginstotuip != "undefined" && carginstotuip != null) {
                    $('#<%=txtCargInsTotUIP.ClientID%>').val(carginstotuip);
                }
               
                if (tiporeator != "NULL" && tiporeator != undefined && tiporeator != "undefined" && tiporeator != null) {
                    $('#<%=ddlTipoReator.ClientID%>').val(tiporeator);
                }

                if (tiporele != "NULL" && tiporele != undefined && tiporele != "undefined" && tiporele != null) {
                    $('#<%=ddlTipoRele.ClientID%>').val(tiporele);
                }
                
                if (tipoalimentacao != "NULL" && tipoalimentacao != undefined && tipoalimentacao != "undefined" && tipoalimentacao != null) {
                    $('#<%=ddlTipoAlimentacao.ClientID%>').val(tipoalimentacao);
                }
               
                if (tipoposte != "NULL" && tipoposte != undefined && tipoposte != "undefined" && tipoposte != null) {
                    $('#<%=ddlTipoPoste.ClientID%>').val(tipoposte);
                }
               
                if (altposte != "NULL" && altposte != undefined && altposte != "undefined" && altposte != null) {
                    $('#<%=txtAltPoste.ClientID%>').val(altposte);
                }
              
              
                if (altinstlum != "NULL" && altinstlum != undefined && altinstlum != "undefined" && altinstlum !=null) {
                    $('#<%=txtAltInstLum.ClientID%>').val(altinstlum);
                }
              
                if (municipio != "NULL" && municipio != undefined && municipio != "undefined" && municipio != null) {
                    $('#<%=txtMun.ClientID%>').val(municipio);
                }
               
                if (regional != "NULL" && regional != undefined && regional != "undefined" && regional != null) {
                    $('#<%=txtReg.ClientID%>').val(regional);
                }
              
                if (bairro != "NULL" && bairro != undefined && bairro != "undefined" && bairro != null) {
                    $('#<%=txtBair.ClientID%>').val(bairro);
                }
                if (classeilum != "NULL" && classeilum != undefined && classeilum != "undefined" && classeilum != null) {
                    $('#<%=ddlClassIlum.ClientID%>').val(classeilum);
                }
                if (logradouro != "NULL" && logradouro != undefined && logradouro != "undefined" && logradouro != null) {
                    $('#<%=txtLog.ClientID%>').val(logradouro);
                }
              
                if (cep != "NULL" && cep != undefined && cep != "undefined" && cep != null) {
                    $('#<%=txtCEP.ClientID%>').val(cep);
                }
                if (codlog != "NULL" && codlog != undefined && codlog != "undefined" && codlog != null) {
                    $('#<%=txtCodLog.ClientID%>').val(codlog);
                }
               
                if (ilumdest != "NULL" && ilumdest != undefined && ilumdest != "undefined" && ilumdest != null) {
                    $('#<%=ddlIlumDest.ClientID%>').val(ilumdest);
                }
                else
                {
                     $('#<%=ddlIlumDest.ClientID%>').val("1");
                }
                if (nomelocdest != "NULL" && nomelocdest != undefined && nomelocdest != "undefined" && nomelocdest != null) {
                    $('#<%=txtNomeLocDestaq.ClientID%>').val(nomelocdest);
                }
                if (qtdelum != "NULL" && qtdelum != undefined && qtdelum != "undefined" && qtdelum != null) {
                    $('#<%=ddlQtdeLum.ClientID%>').val(qtdelum);
                }
                if (medicao != "NULL" && medicao != undefined && medicao != "undefined" && medicao != null) {
                    $('#<%=txtMed.ClientID%>').val(medicao);
                }
                if (lat != "NULL" && lat != undefined && lat != "undefined" && lat != null) {
                    $('#<%=txtLat.ClientID%>').val(lat);
                }
                
                if (lng != "NULL" && lng != undefined && lng != "undefined" && lng != null) {
                    $('#<%=txtLng.ClientID%>').val(lng);
                }
                if (observacao != "NULL" && observacao != undefined && observacao != "undefined" && observacao != null) {
                    $('#<%=txtObservacao.ClientID%>').val(observacao);
                }
            }

            /////////////////////////////////////////////////////fim selectinfoilu
            function limpacampos() {

                $('#<%=txtCodIluminacao.ClientID%>').css("background", "#FFFFFF");
                $("#<%=txtProjBraco.ClientID %>").val("");
                $('#<%=ddlTipoBraco.ClientID%>').val("0");
                $('#<%=ddlTipoLum.ClientID%>').val("0");
                $('#<%=ddlTipoLum.ClientID%>').val("0");
                $('#<%=ddlTipoFonteLum.ClientID%>').val("0");
                $('#<%=ddlPotFonteLum.ClientID%>').val("0");
                $('#<%=ddlQtdeFonteLum.ClientID%>').val("0");
                $('#<%=txtPotTotFonteLum.ClientID%>').val("");
                $('#<%=txtCargInsTotUIP.ClientID%>').val("");
                $('#<%=ddlTipoReator.ClientID%>').val("0");
                $('#<%=ddlTipoRele.ClientID%>').val("0");
                $('#<%=ddlTipoAlimentacao.ClientID%>').val("0");
                $('#<%=ddlTipoPoste.ClientID%>').val("0");
                $('#<%=txtAltPoste.ClientID%>').val("");
                $('#<%=txtAltInstLum.ClientID%>').val("");
                $('#<%=txtReg.ClientID%>').val("");
                $('#<%=txtBair.ClientID%>').val("");
                $('#<%=ddlClassIlum.ClientID%>').val("0");
                $('#<%=txtLog.ClientID%>').val("");
                $('#<%=txtCEP.ClientID%>').val("");
                $('#<%=txtCodLog.ClientID%>').val("");
                $('#<%=txtNomeLocDestaq.ClientID%>').val("");
                $('#<%=ddlQtdeLum.ClientID%>').val("0");
                $('#<%=txtMed.ClientID%>').val("");                     
                $("#<%=txtObservacao.ClientID %>").val("");           
            }

        /////////////////////////////////////////////////////////////limpar dados
             function limpa()
             {
                 
                    $("#<%=txtProjBraco.ClientID %>").val("");
                    $('#<%=ddlTipoBraco.ClientID%>').val("0");               
                    $('#<%=ddlTipoLum.ClientID%>').val("0");    
                    $('#<%=ddlTipoLum.ClientID%>').val("0");                
                    $('#<%=ddlTipoFonteLum.ClientID%>').val("0");                              
                    $('#<%=ddlPotFonteLum.ClientID%>').val("0");
                    $('#<%=ddlQtdeFonteLum.ClientID%>').val("0");
                    $('#<%=txtPotTotFonteLum.ClientID%>').val("");
                    $('#<%=txtCargInsTotUIP.ClientID%>').val("");
                    $('#<%=ddlTipoReator.ClientID%>').val("0");
                    $('#<%=ddlTipoRele.ClientID%>').val("0");
                    $('#<%=ddlTipoAlimentacao.ClientID%>').val("0");
                    $('#<%=ddlTipoPoste.ClientID%>').val("0");
                    $('#<%=txtAltPoste.ClientID%>').val("");
                    $('#<%=txtAltInstLum.ClientID%>').val("");
                    $('#<%=txtMun.ClientID%>').val("");
                    $('#<%=txtReg.ClientID%>').val("");
                    $('#<%=txtBair.ClientID%>').val("");
                    $('#<%=ddlClassIlum.ClientID%>').val("0");
                    $('#<%=txtLog.ClientID%>').val("");
                    $('#<%=txtCEP.ClientID%>').val("");
                    $('#<%=txtCodLog.ClientID%>').val("");
                    $('#<%=ddlIlumDest.ClientID%>').val("0");
                    $('#<%=txtNomeLocDestaq.ClientID%>').val("");
                    $('#<%=ddlQtdeLum.ClientID%>').val("");
                    $('#<%=txtMed.ClientID%>').val("");
                    $('#<%=txtLat.ClientID%>').val("");             
                    $('#<%=txtLng.ClientID%>').val("");
                    $('#deletarInfo').fadeOut();
                    $('#<%=LinkButtonAlterar.ClientID%>').fadeOut();
                    $('#<%=LinkButtonCadastrar.ClientID%>').fadeIn(1000);
                    $("#<%=txtObservacao.ClientID %>").val("");
                    $('#<%=hfCodilumPK.ClientID%>').val("");
                 setTimeout(function () {

                     $('#<%=Msucesso.ClientID%>').fadeOut();
                     $('#<%=Malerta.ClientID%>').fadeOut();
                     $('#<%=Merro.ClientID%>').fadeOut();

                 }, 3000);
                     
                  

            }
