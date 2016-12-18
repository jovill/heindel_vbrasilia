<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="home.aspx.cs" Inherits="IluGis.home" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <script type="text/javascript" src="AC_OETags.js" language="javascript"></script>
    <script type="text/javascript" src="japi/API.js" language="javascript"></script>
    <script type="text/javascript" src="japi/api-common.js"></script>
    <script type="text/javascript" src="swfobject.js"></script>
    <link href="js/sliderblx/jquery.bxslider.css" rel="stylesheet" />    
    <script src="js/sliderblx/jquery.bxslider.min.js"></script>
   <script src="https://cdnjs.cloudflare.com/ajax/libs/proj4js/2.3.15/proj4.js"></script>
    <link href="css/button.css" rel="stylesheet" />
    

    <!----TAB- agora foi---->
 <%--   <script type="text/javascript" src="http://ajax.googleapis.com/ajax/libs/jquery/1.4.1/jquery.min.js"></script>--%>
    <link rel="stylesheet" type="text/css" href="css/estilo.css" />
    <script type="text/javascript" src="js/abas/javascript.js"></script>


      <link href="css/theodolite.css" rel="stylesheet" />   
    <script type="text/javascript" src="http://maps.googleapis.com/maps/api/js?key=AIzaSyA_2F4f39ncWIbzriIlpHSQXe5JRpAkvEU&sensor=false&libraries=geometry"></script>
    <script type="text/javascript" src="js/javascript.js"></script>
    <style>
        /*FUNDO RGB: 424263   2A2A3F*/
        /*COLOR GLOBESPOTTER*/
        /*SELECTED  RGB:#394043 27282B*/
        /*NOSELECTED RGB:#858587 555557*/
         /*TRAÇO RGB:#959596 5F5F60*/
         /*PONTO NORMAL RGB:117119114   757772*/
         /*PONTO ESPECIAL RGB: 3274135  204A87*/
         /*GRID RGB:119119119  777777*/
        .tabcontent {
            -webkit-animation: fadeEffect 1s;
            animation: fadeEffect 1s; /* Fading effect takes 1 second */
        }

        @-webkit-keyframes fadeEffect {
            from {opacity: 0;}
            to {opacity: 1;}
        }

        @keyframes fadeEffect {
            from {opacity: 0;}
            to {opacity: 1;}
        }

        .form-control2:focus {
            border-color: red;
            outline: 0;
            -webkit-box-shadow: inset 0 1px 1px rgba(255,0,0,0.3), 0 0 8px rgba(255,0,0,0.3);
            box-shadow: inset 0 1px 1px rgba(255,0,0,0.3), 0 0 8px rgba(255,0,0,0.3);
}
    </style>

    <script type="text/javascript" src="japi/messurement.js"></script>
      <meta charset="utf-8">
      <meta name="viewport" content="width=device-width">

      <%--<!-- jQuery -->
      <script src="http://code.jquery.com/jquery-1.10.2.min.js"></script>--%>
    
      <!-- Fotorama -->
      <link href="fotorama.css" rel="stylesheet">
      <script src="fotorama.js"></script>

      <!-- Just don’t want to repeat this prefix in every img[src] -->
      <script type="text/javascript">
          var dist;
          var baseheight;
          var angle;
          var pitch;         
          var mapCtr;          
          var map;
          var panorama;
          var indicator;
          var posarr;

          function distance(p1, p2) {
              var R = 6371010;
              var dLat = (Math.PI / 180.0) * ((p2.lat() - p1.lat()));
              var dLon = (Math.PI / 180.0) * ((p2.lng() - p1.lng()));
              var lat1 = (Math.PI / 180.0) * p1.lat();
              var lat2 = (Math.PI / 180.0) * p2.lat()
              var a = Math.sin(dLat / 2) * Math.sin(dLat / 2) +
                    Math.sin(dLon / 2) * Math.sin(dLon / 2) * Math.cos(lat1) * Math.cos(lat2);
              var c = 2 * Math.atan2(Math.sqrt(a), Math.sqrt(1 - a));
              var d = R * c;
              return d;
          }
          function bearing(p1, p2) {
              var dLon = (Math.PI / 180.0) * ((p2.lng() - p1.lng()));
              var lat1 = (Math.PI / 180.0) * p1.lat();
              var lat2 = (Math.PI / 180.0) * p2.lat()
              var y = Math.sin(dLon) * Math.cos(lat2);
              var x = Math.cos(lat1) * Math.sin(lat2) - Math.sin(lat1) * Math.cos(lat2) * Math.cos(dLon);
              var brng = Math.atan2(y, x) * (180.0 / Math.PI);
              if (brng < 0) {
                  return 360 + brng
              }
              else {
                  return brng
              }
          }

          function movePoint(p1, a, d) {
              var brng = a * (Math.PI / 180.0);
              var R = 6371010;
              var lat1 = (Math.PI / 180.0) * p1.lat();
              var lon1 = (Math.PI / 180.0) * p1.lng()
              var lat2 = Math.asin(Math.sin(lat1) * Math.cos(d / R) +
                        Math.cos(lat1) * Math.sin(d / R) * Math.cos(brng));
              var lon2 = lon1 + Math.atan2(Math.sin(brng) * Math.sin(d / R) * Math.cos(lat1),
                               Math.cos(d / R) - Math.sin(lat1) * Math.sin(lat2));

              return [lat2 * (180.0 / Math.PI), lon2 * (180.0 / Math.PI)]
          }
          function calcHeight(bh, d, a) {
              return ((Math.tan((Math.PI / 180.0) * a) * d) + bh);
          }
          function change_position() {

              latD = panorama.getPosition().lat() - mapCtr.lat();
              lngD = panorama.getPosition().lng() - mapCtr.lng();
              indicator.setPosition(new google.maps.LatLng((latD + indicator.getPosition().lat()), (lngD + indicator.getPosition().lng())));
              mapCtr = new google.maps.LatLng(panorama.getPosition().lat(), panorama.getPosition().lng());

              calcAll();
              posarr.setAt(0, mapCtr);
              posarr.setAt(1, indicator.getPosition());
              document.location.hash = mapCtr.toUrlValue() + "/" + indicator.getPosition().toUrlValue() + "/" + Math.round(dang) + "/0";
          }
          function change_dragend() {

              dist = distance(indicator.getPosition(), mapCtr)
              panorama.setPov({
                  heading: bearing(mapCtr, indicator.getPosition()),
                  pitch: pitch
              });
              document.location.hash = mapCtr.toUrlValue() + "/" + indicator.getPosition().toUrlValue() + "/" + Math.round(dang) + "/0";
              calcAll();

          }
          function change_pov() {

              angle = panorama.getPov().heading;
              pitch = panorama.getPov().pitch;
              nP = movePoint(mapCtr, angle, dist);
              indicator.setPosition(new google.maps.LatLng(nP[0], nP[1]));
              posarr.setAt(1, indicator.getPosition());
              calcAll();
          }
          function calcAll() {

              a = calcHeight(baseheight, dist, pitch);
              if (angle < 0) { dang = 360 + angle }
              else { dang = angle }
              $("#distance").text((Math.round(dist * 100) / 100));
              $("#heading").text(Math.round(dang));
              $("#pitch").text(Math.round(pitch));
              $("#baseheight").text((Math.round(baseheight * 100) / 100));
              $("#estheight").text((Math.round(a * 100) / 100));
              info = document.location.href.replace("#", "") + "#" + mapCtr.toUrlValue() + "/" + indicator.getPosition().toUrlValue() + "/" + Math.round(dang) + "/0";

              $("#linkloc").val(info);

          }

          

          function initialize() {
              if (document.location.hash.length == 0) {
                  loadInfo = "37.795962,-122.394607/37.795,-122.3946/180/0".split("/");
              }
              else {
                  loadInfo = document.location.hash.replace("#", "").split("/");
              }
             
               baseheight = 0;
               angle = 1 * loadInfo[2];
               pitch = 0;
               posarr = new google.maps.MVCArray();
               mapCtr = new google.maps.LatLng((loadInfo[0].split(",")[0] * 1), (loadInfo[0].split(",")[1] * 1));
              var mapDiv = document.getElementById('map_canvas');
               map = new google.maps.Map(mapDiv, {
                  center: mapCtr,
                  zoom: 18,
                  mapTypeId: google.maps.MapTypeId.SATELLITE
              });

              var panoramaOptions = {
                  position: mapCtr,
                  pov: {
                      heading: angle,
                      pitch: pitch
                  }
              };
               panorama = new google.maps.StreetViewPanorama(document.getElementById("pano"), panoramaOptions);

              map.setStreetView(panorama);

               indicator = new google.maps.Marker({
                  map: map,
                  position: new google.maps.LatLng((loadInfo[1].split(",")[0] * 1), (loadInfo[1].split(",")[1] * 1)),
                  draggable: true
              });
              posarr.push(mapCtr);
              posarr.push(indicator.getPosition())
              dist = distance(indicator.getPosition(), mapCtr);
              var line = new google.maps.Polyline({
                  map: map,
                  path: posarr,
                  strokeColor: "#F00",
                  strokeOpacity: 0.5
              });

              line.setMap(map);

              function calcAll() {

                  a = calcHeight(baseheight, dist, pitch);
                  if (angle < 0) { dang = 360 + angle }
                  else { dang = angle }
                  $("#distance").text((Math.round(dist * 100) / 100));
                  $("#heading").text(Math.round(dang));
                  $("#pitch").text(Math.round(pitch));
                  $("#baseheight").text((Math.round(baseheight * 100) / 100));
                  $("#estheight").text((Math.round(a * 100) / 100));
                  info = document.location.href.replace("#", "") + "#" + mapCtr.toUrlValue() + "/" + indicator.getPosition().toUrlValue() + "/" + Math.round(dang) + "/0";

                  $("#linkloc").val(info);

              }

             
              google.maps.event.addListener(panorama, 'position_changed', change_position);
              google.maps.event.addListener(indicator, 'dragend', change_dragend);
              google.maps.event.addListener(panorama, 'pov_changed',change_pov);
             

            
              $("#baseset").click(function () {
                  baseheight = -1 * calcHeight(0, dist, pitch);
                  $("#baser").css("top", 200);
                  sTop = 200;
                  calcAll();
              });
              var stY;
              var sTop = 200;
              var accM = 0;
              var pDivHeight = 0;
              $("#pano").on("mousedown", function (eSt) {
                  stY = eSt.offsetY;
                  startDrag();
              });
              var startDrag = function () {
                  $("#pano").on("mousemove", function (eEn) {
                      enY = eEn.offsetY;
                      moveA = ((enY - stY) + sTop) + accM;
                      if (moveA >= 400) {
                          actualMove = 400;
                          $("#baser").css("opacity", 0.25)
                      }
                      else if (moveA <= 0) {
                          actualMove = 0;
                          $("#baser").css("opacity", 0.25)
                      }
                      else {
                          actualMove = moveA;
                          $("#baser").css("opacity", 0.75)
                      }

                      $("#baser").css("top", actualMove);


                  });
              }
              $("#pano").on("mouseup", function () {
                  sTop = moveA;
                  $("#pano").off("mousemove");
              });

              $("#linkloc").on("focus", function () {
                  $(this).select();
              });


             

          }
          
</script>
            
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="body" runat="server">

     <div class="content">
          
       <form autocomplete="off" runat="server" class="form-inline" style="width: 100%;" name="myForm" novalidate>
           <asp:HiddenField ID="hfLoginPK" runat="server" Value="" />
            <asp:HiddenField ID="hfPermissao" runat="server" Value="" />
            <asp:HiddenField ID="hfCodilumPK" runat="server" Value="" />  
            <asp:HiddenField ID="hfkmlID" runat="server" Value="" /> 
           
           
            <asp:ScriptManager ID="ScriptManager1" runat="server"/>
        <!-----------------Inicio Titulo----------------------------------------------------->
        <div class="row" style="margin-bottom:5px;">
            <div class="col-md-12 col-sm-12">
              <h4 style="text-align: center;">Sistema de Cadastro de Iluminação</h4>
            </div>
        </div>
        <!--------------------Fim titulo--------------------------------------------------------->


        <!--------------Inicio Row notificacao-------------------------------------------------------------------->	
        <div class="row" id="notificacao">
            <div runat="server" id="Msucesso" visible="false" class="alert alert-success me" >                                
            </div>
            <div runat="server" id="Malerta" visible="false" class="alert alert-warning">         
            </div>
            <div runat="server" id="Merro" visible="false" class="alert alert-danger">                
            </div>
        </div>
	
    <!------------------Inicio Primeira Row, BUSCA (lcalidade/equipe e Código do ponto de iluminação, postes padrões e globespotter com googlemaps---------------->	
    <div class="row" id="busca">
        <div  ID="localidade" class=" col-md-3 col-sm-3 col-md-offset-1 col-sm-offset-1" style="margin-bottom: 8px">             
            <asp:DropDownList  Style="width: 82%;  display:inline-block;" ID="ddllocalidade" class=" form-control input-sm " runat="server" title="Equipe"  autofocus="true">
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
            <asp:ListItem Text ="PAMPULHA 03" Value = "PAMPULHA03"></asp:ListItem> 
            <asp:ListItem Text ="VENDA NOVA 01" Value = "VENDANOVA01"></asp:ListItem> 
            <asp:ListItem Text ="VENDA NOVA 02" Value = "VENDANOVA02"></asp:ListItem>          
            </asp:DropDownList>
            <a runat="server" href="help.aspx#equipe" target="_blank"  >
            <span class="glyphicon glyphicon-question-sign" title="Ajuda" style="font-size: 18px" ></span>
            </a>
        </div>

        <div ID="codigo" class="col-md-3 col-sm-3" style="margin-bottom: 8px">
            <asp:TextBox runat="server" type="text" id="txtCodIluminacao" title="Codigo da Iluminação" class="form-control" style="width: 70%; display:inline-block;" placeholder="Codigo da Iluminação" ></asp:TextBox>
	
            <a href="javascript:prev();">
            <span class="glyphicon glyphicon-chevron-left" title="Código anterior" style="font-size: 12px"></span>
            </a>
            <a href="javascript:next();">
            <span class="glyphicon glyphicon-chevron-right" title="Código seguinte" style="font-size: 12px"></span>
            </a>
            <a id="infolista">
            <span class="glyphicon glyphicon-search" title="Buscar" style="font-size: 14px; cursor:pointer;"></span>
            </a>
          </div>

            <button style=" background-color:#9AFF9A; height: 26px;" id="google"  title="Abrir Google Maps" type="button" >
            <span class="glyphicon glyphicon-globe google" aria-hidden="true" style="font-size: 16px"></span>
            </button>   

            <button id="btnclear"  title="Limpar todos os campos" type="button" >
            <span class="glyphicon glyphicon-erase " aria-hidden="true" style="font-size: 16px"></span>
            </button>    
    
    

        <div id="padrao" class="col-md-2 col-sm-2" style="margin-bottom: 8px; display:inline-block;">
 
            <button  id="btncomuncurto"  title="Ponto mais cadastrado com braço curto" type="button" style=" background-color:#00BFFF" >
            <span class="glyphicon glyphicon-import btncomun" aria-hidden="true" style="font-size: 16px"></span>
            </button>

            <button  id="btncomunmedio"  title="Ponto mais cadastrado com Braço Médio" type="button" style=" background-color:#FFA500" >
            <span class="glyphicon glyphicon-import btncomun" aria-hidden="true" style="font-size: 16px"></span>
            </button>

            <button  id="btncomunlongo"  title="Ponto mais cadastrado com Braço Longo" type="button" style=" background-color:#FF4040">
            <span class="glyphicon glyphicon-import btncomun" aria-hidden="true" style="font-size: 16px"></span>
            </button>

            <button  id="btncomunrodovia"  title="Ponto mais cadastrado em Rodovias" type="button" style=" background-color:#EE7AE9">
            <span class="glyphicon glyphicon-import btncomun" aria-hidden="true" style="font-size: 16px"></span>
            </button>
            <a runat="server" href="help.aspx#postes_padroes" target="_blank" >
            <span class="glyphicon glyphicon-question-sign" title="Ajuda"  style="font-size: 18px"></span>
            </a>   

            </div>

    </div>


<!-----------------------Inicio da Row 1 (Tipo de braço, projeção do Braço, tipo de poste, altura poste e quantidade de luminarias)------------------->
    <div class="row" id="linha-1">

        <div ID="tipobraco" title="Tipo de braço" class="col-md-2 col-sm-2 col-md-offset-1 col-sm-offset-1" style="margin-bottom: 8px">
            <asp:DropDownList  Style="width: 82%; display:inline-block;" ID="ddlTipoBraco" class=" form-control input-sm " runat="server"  autofocus="true">
            <asp:ListItem Text ="Tipo de braço" Value = "-1"></asp:ListItem>
            <asp:ListItem Text ="Curto" Value = "Curto"></asp:ListItem>   
            <asp:ListItem Text ="Médio" Value = "Medio"></asp:ListItem>
            <asp:ListItem Text ="Médio Pesado" Value = "Medio Pesado"></asp:ListItem>      
            <asp:ListItem Text ="Longo" Value = "Longo"></asp:ListItem>   
            <asp:ListItem Text ="Especial" Value = "Especial"></asp:ListItem>
            <asp:ListItem Text ="Sem Braço" Value = "Sem braco"></asp:ListItem>                                             
            </asp:DropDownList> 
            <a runat="server" href="help.aspx#tipo_de_braco" target="_blank" >
            <span class="glyphicon glyphicon-question-sign" title="Ajuda"  style="font-size: 18px"></span>
            </a>                                     
         </div>

        <div ID="projecaobraco" class="col-md-2 col-sm-2" style="margin-bottom: 8px">
        <asp:TextBox runat="server" type="text" ID="txtProjBraco" title="Projeção de Braço (em M)" class="form-control  " style="width: 82%; display:inline-block;" placeholder="Projeção de Braço (em M)" ></asp:TextBox>
        <a runat="server" href="help.aspx#projecao_do_braco" target="_blank">
        <span class="glyphicon glyphicon-question-sign" title="Ajuda"  style="font-size: 18px"></span>
        </a>
        </div>

        <div ID="tipoposte" class="col-md-2 col-sm-2" style="margin-bottom: 8px">
        <asp:DropDownList  Style="width: 82%; display:inline-block;" ID="ddlTipoPoste" title="TIpo de Poste" class=" form-control input-sm " runat="server"  autofocus="true">
        <asp:ListItem Text ="Tipo de poste" Value = "-1"></asp:ListItem>
        <asp:ListItem Text ="Metálico" Value = "Metalico"></asp:ListItem>
        <asp:ListItem Text ="Concreto Circular" Value = "Concreto Circular"></asp:ListItem>
        <asp:ListItem Text ="Madeira" Value = "Madeira"></asp:ListItem>
        <asp:ListItem Text ="Concreto Duplo T" Value = "Concreto Duplo T"></asp:ListItem>
        </asp:DropDownList>
        <a runat="server" href="help.aspx#tipo_de_poste" target="_blank">
        <span class="glyphicon glyphicon-question-sign" title="Ajuda" style="font-size: 18px"></span>
        </a>                 
        </div>

        <div ID="alturaposte" class="col-md-2 col-sm-2" style="margin-bottom: 8px">
            <asp:TextBox runat="server" type="text" id="txtAltPoste" title="Altura do Poste" class="form-control numerotxt " style="width: 82%; display:inline-block;" placeholder="Altura do Poste"></asp:TextBox>
            <a runat="server" href="help.aspx#altura_do_poste" target="_blank" style="font-size: 18px">
            <span class="glyphicon glyphicon-question-sign" title="Ajuda" style="font-size: 18px"></span>
            </a>
        </div>
        <div ID="alturainstluminaria" class="col-md-2 col-sm-2" style="margin-bottom: 8px">
            <asp:TextBox runat="server" type="text" id="txtAltInstLum" title="Altura de instalação da Luminária" class="form-control " style="width: 82%; display:inline-block;" placeholder="Altura de instalação da LUMINÁRIA"></asp:TextBox>                
            <a runat="server" href="help.aspx#altura_da_instalacao_luminaria" target="_blank">
            <span class="glyphicon glyphicon-question-sign" title="Ajuda" style="font-size: 18px"></span>
            </a>
        </div>
    
    </div>

<!----------------------Inicio Row 2 (tipo de luminaria, tipo reator, tipo rele, quantidade fonte luminosa e tipo fonte luminosa)--------------------->
<div class="row" id="linha-2">

<div ID="tipoluminaria" class="col-md-2 col-sm-2 col-md-offset-1 col-sm-offset-1" style="margin-bottom: 8px">
<asp:DropDownList  Style="width: 82%; display:inline-block;" ID="ddlTipoLum" title="Tipo de Luminária" class=" form-control input-sm " runat="server" autofocus="true">
<asp:ListItem Text ="Tipo de luminária" Value = "-1"></asp:ListItem>   
<asp:ListItem Text ="Corpo único aberta" Value = "Corpo unico aberta"></asp:ListItem>   
<asp:ListItem Text ="Corpo único fechada com vidro" Value = "Corpo unico fechada com vidro"></asp:ListItem>   
<asp:ListItem Text ="Corpo único fechada com policarbonato" Value = "Corpo unico fechada com policarbonato"></asp:ListItem>   
<asp:ListItem Text ="Integrada vidro" Value = "Integrada vidro"></asp:ListItem>   
<asp:ListItem Text ="Integrada policarbonato" Value = "Integrada policarbonato"></asp:ListItem>
<asp:ListItem Text ="Decorativa esférica" Value = "Decorativa esferica"></asp:ListItem>
<asp:ListItem Text ="Decorativa semi-esférica" Value = "Decorativa semi-esférica"></asp:ListItem>
<asp:ListItem Text ="Petalar" Value = "Petalar"></asp:ListItem>
<asp:ListItem Text ="Outros" Value = "Outros"></asp:ListItem>                   
</asp:DropDownList>
<a runat="server" href="help.aspx#tipo_de_luminaria" target="_blank">
<span class="glyphicon glyphicon-question-sign" title="Ajuda" style="font-size: 18px"></span>
</a>                                       
</div>

<div ID="tiporele" class="col-md-2 col-sm-2" style="margin-bottom: 8px">
<asp:DropDownList  Style="width: 82%; display:inline-block;" ID="ddlTipoRele" title="Tipo de  Relé" class=" form-control input-sm " runat="server"  autofocus="true">
<asp:ListItem Text ="Tipo de relé" Value = "-1"></asp:ListItem>
<asp:ListItem Text ="Integrado na luminária" Value = "Integrado na luminaria"></asp:ListItem>   
<asp:ListItem Text ="No poste" Value = "No poste"></asp:ListItem>   
<asp:ListItem Text ="Comando em grupo" Value = "Comando em grupo"></asp:ListItem>   
<asp:ListItem Text ="Inexistente" Value = "Inexistente"></asp:ListItem>                
</asp:DropDownList>
<a runat="server" href="help.aspx#tipo_de_rele" target="_blank">
<span class="glyphicon glyphicon-question-sign" title="Ajuda" style="font-size: 18px"></span>
</a>
</div>

<div ID="tiporeator" class="col-md-2 col-sm-2" style="margin-bottom: 8px">
<asp:DropDownList  Style="width: 82%; display:inline-block;" ID="ddlTipoReator" title="Tipo de Reator" class=" form-control input-sm " runat="server"  autofocus="true">
<asp:ListItem Text ="Tipo de reator" Value = "-1"></asp:ListItem>
<asp:ListItem Text ="Interno" Value = "Interno"></asp:ListItem>   
<asp:ListItem Text ="Externo" Value = "Externo"></asp:ListItem>                                                
</asp:DropDownList>
<a runat="server" href="help.aspx#tipo_de_reator" target="_blank">
<span class="glyphicon glyphicon-question-sign" title="Ajuda" style="font-size: 18px"></span>
</a>
</div>

<div ID="qtdeluminarias" class="col-md-2 col-sm-2">
<asp:DropDownList  Style="width: 82%; display:inline-block;" ID="ddlQtdeLum" title="Quantidade de Luminárias" class=" form-control input-sm " runat="server"  autofocus="true">
<asp:ListItem Text ="Quantidade de Luminárias" Value = "-1"></asp:ListItem>
<asp:ListItem Text ="1" Value = "1"></asp:ListItem>   
<asp:ListItem Text ="2" Value = "2"></asp:ListItem>   
<asp:ListItem Text ="3" Value = "3"></asp:ListItem>   
<asp:ListItem Text ="4" Value = "4"></asp:ListItem>   
<asp:ListItem Text ="5" Value = "5"></asp:ListItem>   
<asp:ListItem Text ="6" Value = "6"></asp:ListItem>
<asp:ListItem Text ="7" Value = "7"></asp:ListItem>
<asp:ListItem Text ="8" Value = "8"></asp:ListItem>
<asp:ListItem Text ="9" Value = "9"></asp:ListItem>
<asp:ListItem Text ="10" Value = "10"></asp:ListItem>                    
</asp:DropDownList>
<a runat="server" href="help.aspx##quantidade_de_luminarias" target="_blank" style="font-size: 18px; text-align: center;">
<span class="glyphicon glyphicon-question-sign" title="Ajuda" style="font-size: 18px"></span>
</a>
</div>   

<div ID="qtdefonteluminosa" class="col-md-2 col-sm-2" style="margin-bottom: 8px">
<asp:DropDownList  Style="width: 82%; display:inline-block;" ID="ddlQtdeFonteLum" title="Quantidade de Fontes Luminosas" class=" form-control input-sm " runat="server"  autofocus="true">
<asp:ListItem Text ="Quantidade de Fontes Luminosas" Value = "-1"></asp:ListItem>
<asp:ListItem Text ="1" Value = "1"></asp:ListItem>   
<asp:ListItem Text ="2" Value = "2"></asp:ListItem>   
<asp:ListItem Text ="3" Value = "3"></asp:ListItem>   
<asp:ListItem Text ="4" Value = "4"></asp:ListItem>   
<asp:ListItem Text ="5" Value = "5"></asp:ListItem>   
<asp:ListItem Text ="6" Value = "6"></asp:ListItem>
<asp:ListItem Text ="7" Value = "7"></asp:ListItem>
<asp:ListItem Text ="8" Value = "8"></asp:ListItem>
<asp:ListItem Text ="9" Value = "9"></asp:ListItem>
<asp:ListItem Text ="10" Value = "10"></asp:ListItem>                    
</asp:DropDownList>
<a runat="server" href="help.aspx#quantidade_de_fontes_luminosas" target="_blank">
<span class="glyphicon glyphicon-question-sign" title="Ajuda" style="font-size: 18px"></span>
</a>
</div>

</div>

<!-----------------------------Inicio Row 3 (Medição, altura instalacao luminaria, classe iluminacao, potencia fonte luminosa, tipo alimentacao)---------------->
<div class="row" id="linha-3">
<div ID="tipofontlum" class="col-md-2 col-sm-2 col-md-offset-1 col-sm-offset-1" style="margin-bottom: 8px">
<asp:DropDownList  Style="width: 82%; display:inline-block;" ID="ddlTipoFonteLum" title="Tipo de Fonte Luminosa" class=" form-control input-sm " runat="server"  autofocus="true">
<asp:ListItem Text ="Tipo de Fonte Luminosa" Value = "-1"></asp:ListItem>                
<asp:ListItem Text ="Vapor Sódio" Value = "Sodio"></asp:ListItem>   
<asp:ListItem Text ="Vapor Metálico" Value = "Metalico"></asp:ListItem>   
<asp:ListItem Text ="Vapor Mercúrio" Value = "Mercurio"></asp:ListItem>
<asp:ListItem Text ="Led" Value = "Led"></asp:ListItem>                
</asp:DropDownList>
<a runat="server" href="help.aspx#tipo_de_fonte_luminaria" target="_blank">
<span class="glyphicon glyphicon-question-sign" title="Ajuda" style="font-size: 18px"></span>
</a>
</div>

<div ID="potenciafonteluminosa" class="col-md-2 col-sm-2 " style="margin-bottom: 8px">
<asp:DropDownList  Style="width: 82%; display:inline-block;" ID="ddlPotFonteLum" title="Potência da Fonte Luminosa (W)" class=" form-control input-sm " runat="server"  autofocus="true">
<asp:ListItem Text ="Potência da fonte luminosa (W)" Value = "-1"></asp:ListItem>
<asp:ListItem Text ="6W" Value = "6"></asp:ListItem> 
<asp:ListItem Text ="35W" Value = "35"></asp:ListItem>
<asp:ListItem Text ="40W" Value = "40"></asp:ListItem>
<asp:ListItem Text ="54W" Value = "54"></asp:ListItem>
<asp:ListItem Text ="55W" Value = "55"></asp:ListItem>
<asp:ListItem Text ="58W" Value = "58"></asp:ListItem>   
<asp:ListItem Text ="70W" Value = "70"></asp:ListItem>   
<asp:ListItem Text ="80W" Value = "80"></asp:ListItem>
<asp:ListItem Text ="86W" Value = "86"></asp:ListItem>   
<asp:ListItem Text ="100W" Value = "100"></asp:ListItem>   
<asp:ListItem Text ="125W" Value = "125"></asp:ListItem>
<asp:ListItem Text ="127W" Value = "127"></asp:ListItem>
<asp:ListItem Text ="150W" Value = "150"></asp:ListItem>
<asp:ListItem Text ="250W" Value = "250"></asp:ListItem>
<asp:ListItem Text ="350W" Value = "350"></asp:ListItem>
<asp:ListItem Text ="400W" Value = "400"></asp:ListItem>                                                 
</asp:DropDownList>
<a runat="server" href="help.aspx#potencia_da_fonte_luminosa" target="_blank" >
<span class="glyphicon glyphicon-question-sign" title="Ajuda" style="font-size: 18px"></span>
</a>
</div>
    
<div ID="tipoalimentacao" class="col-md-2 col-sm-2" style="margin-bottom: 8px">
<asp:DropDownList  Style="width: 82%; display:inline-block;" title="Tipo de Alimentação" ID="ddlTipoAlimentacao" class=" form-control input-sm " runat="server"  autofocus="true">
<asp:ListItem Text ="Tipo de alimentação" Value = "-1"></asp:ListItem> 
<asp:ListItem Text ="Aéreo" Value = "Aereo"></asp:ListItem>   
<asp:ListItem Text ="Subterrâneo" Value = "Subterraneo"></asp:ListItem>                     
</asp:DropDownList> 
<a runat="server" href="help.aspx#tipo_de_alimentacao" target="_blank">
<span class="glyphicon glyphicon-question-sign" title="Ajuda" style="font-size: 18px"></span>
</a>  
</div>
    
<div ID="classeilum" class="col-md-2 col-sm-2" style="margin-bottom: 8px">
<asp:DropDownList  Style="width: 82%; display:inline-block;" ID="ddlClassIlum" title="Classe de iluminação" class=" form-control input-sm " runat="server"  autofocus="true">
<asp:ListItem Text ="Classe de Iluminação" Value = "-1"></asp:ListItem>
<asp:ListItem Text ="V1" Value = "V1"></asp:ListItem>   
<asp:ListItem Text ="V2" Value = "V2"></asp:ListItem>   
<asp:ListItem Text ="V3" Value = "V3"></asp:ListItem>   
<asp:ListItem Text ="V4" Value = "V4"></asp:ListItem>
<asp:ListItem Text ="V5" Value = "V5"></asp:ListItem>
<asp:ListItem Text ="P1" Value = "P1"></asp:ListItem>
<asp:ListItem Text ="P2" Value = "P2"></asp:ListItem>
<asp:ListItem Text ="P3" Value = "P3"></asp:ListItem>
<asp:ListItem Text ="P4" Value = "P4"></asp:ListItem>             
</asp:DropDownList>
<a runat="server" href="help.aspx#classe_de_iluminacao" target="_blank"> 
<span class="glyphicon glyphicon-question-sign" title="Ajuda" style="font-size: 18px"></span>
</a>
</div>

<div ID="medicao" class="col-md-2 col-sm-2" style="margin-bottom: 8px">
<asp:TextBox runat="server" type="text" id="txtMed" title="Medição" class="form-control" style="width: 82%; display:inline-block;" placeholder="Medição"></asp:TextBox>
<a runat="server" href="help.aspx#medicao" target="_blank">
<span class="glyphicon glyphicon-question-sign" title="Ajuda" style="font-size: 18px"></span>
</a>
</div>					
</div>

<!----------------------Inicio Row 4 (Municipio, Regional, Bairro, CEP e Logradouro)----------------------------------------------------->
<div class="row" id="linha-4">

<div ID="municipio" class="col-md-2 col-sm-2 col-md-offset-1 col-sm-offset-1" style="margin-bottom: 8px">
<asp:TextBox runat="server" type="text" id="txtMun" title="Município" class="form-control" style="width: 82%" placeholder="Município">Belo Horizonte</asp:TextBox>                   
</div>

<div ID="regional" class="col-md-2 col-sm-2 " style="margin-bottom: 8px">
<asp:TextBox runat="server" type="text" id="txtReg" title="Regional" class="form-control" style="width: 82%" placeholder="Regional"></asp:TextBox>
</div>

<div ID="bairro" class="col-md-2 col-sm-2" style="margin-bottom: 8px">
<asp:TextBox runat="server" type="text" id="txtBair" title="Bairro" class="form-control" style="width: 82%" placeholder="Bairro"></asp:TextBox>
</div>

<div ID="CEP" class="col-md-2 col-sm-2" style="margin-bottom: 8px">
<asp:TextBox runat="server" type="text" id="txtCEP" title="CEP" class="form-control cepTxt" style="width: 82%" placeholder="CEP"></asp:TextBox>
</div>

<div ID="logradouro" class="col-md-2 col-sm-2" style="margin-bottom: 8px">
<asp:TextBox runat="server" type="text" id="txtLog" title="Logradouro" class="form-control" style="width: 82%" placeholder="Logradouro"></asp:TextBox>
</div>
</div>

<!------------------Inicio Row 5(Codigo logradouro, iluminacao destaque, nome local destaque, potencia total das fontes e carga instalada total UIP)-------------->
<div class="row" id="linha-5">

<div ID="codlogradouro" class="col-md-2 col-sm-2 col-md-offset-1 col-sm-offset-1" style="margin-bottom: 8px">
<asp:TextBox runat="server" type="text" id="txtCodLog" title="Código do Logradouro" class="form-control numerotxt" style="width: 82%" placeholder="Código do Logradouro"></asp:TextBox>
</div>

<div ID="ilumdestaq" class="col-md-2 col-sm-2" style="margin-bottom: 8px">
<asp:DropDownList  Style="width: 82%" id="ddlIlumDest" title="Iluminação de Destaque" class=" form-control input-sm " runat="server"  autofocus="true">
<asp:ListItem Text ="Iluminação de destaque" Value = "-1"></asp:ListItem>
<asp:ListItem Text ="Sim" Value = "2" ></asp:ListItem>
<asp:ListItem Text ="Não" Value = "1" Selected></asp:ListItem>   
</asp:DropDownList>                  
</div>

<div ID="nomelocaldestaq" class="col-md-2 col-sm-2" style="margin-bottom: 8px">
<asp:TextBox runat="server" type="text" id="txtNomeLocDestaq" title="Nome do local de destaque" class="form-control" style="width: 82%" placeholder="Nome do local de destaque"></asp:TextBox>
</div>

<div ID="potenciatotalfontesluminosas" class="col-md-2 col-sm-2" style="margin-bottom: 8px">                        
<asp:TextBox runat="server" type="text" id="txtPotTotFonteLum" title="Potência Total das Fontes Luminosas" class="form-control" style="width: 82%" placeholder="Potência Total das Fontes Luminosas"></asp:TextBox>                     
</div>

<div ID="cargainstaladatotalUIP" class="col-md-2 col-sm-2" style="margin-bottom: 8px">
<asp:TextBox runat="server" type="text" id="txtCargInsTotUIP" title="Carga Instalada Total da UIP em (kW)" class="form-control" style="width: 82%" placeholder="Carga Instalada Total da UIP em (kW)"></asp:TextBox>
</div>
</div>	


<!------------------ novos atributos Tipo de Posteação, Distância média entre dois postes, Largura da via, Largura de Canteiro Central  e Largura de Passeio------------->

<div class="row" id="linha-6">

<div ID="distmeddoispostes" class="col-md-2 col-sm-2 col-md-offset-1 col-sm-offset-1" style="margin-bottom: 8px">
<asp:TextBox runat="server" type="text" id="txtdistmeddoispostes" title="Distância média entre dois postes" class="form-control" style="width: 82%" placeholder="Distância média entre dois postes"></asp:TextBox>
</div>

<div ID="tipoposteacao" class="col-md-2 col-sm-2" style="margin-bottom: 8px">
<asp:DropDownList  Style="width: 82%" id="ddltipoposteacao" title="Tipo de Posteação" class=" form-control input-sm " runat="server"  autofocus="true">
<asp:ListItem Text ="Tipo de Posteação" Value = "-1"></asp:ListItem>
<asp:ListItem Text =" Posteação Unilateral" Value = "2" ></asp:ListItem>
<asp:ListItem Text ="Posteação Bilateral Frontal" Value = "1"></asp:ListItem>
<asp:ListItem Text ="Posteação Bilateral Alternada" Value = "1"></asp:ListItem>  
<asp:ListItem Text ="Posteação no Canteiro Central" Value = "1"></asp:ListItem>  
</asp:DropDownList>

</div>

<div ID="larguravia" class="col-md-2 col-sm-2" style="margin-bottom: 8px">
<asp:TextBox runat="server" type="text" id="txtlarguravia" title="Largura da via" class="form-control" style="width: 82%" placeholder="Largura da via"></asp:TextBox>
</div>

<div ID="larguracantcentral" class="col-md-2 col-sm-2" style="margin-bottom: 8px">                        
<asp:TextBox runat="server" type="text" id="txtlarguracantcentral" title="Largura do canteiro central" class="form-control" style="width: 82%" placeholder="Largura do canteiro central"></asp:TextBox>                     
</div>

<div ID="largurapasseio" class="col-md-2 col-sm-2" style="margin-bottom: 8px">
<asp:TextBox runat="server" type="text" id="txtlargurapasseio" title="Largura do Passeio" class="form-control" style="width: 82%" placeholder="Largura do Passeio"></asp:TextBox>
</div>
</div>	




<!---------------------------Inicio Row 7(Perda potencia total equipamentos, Tipo de circuito, material do condutor, bitola do condutor, fase do transformador)--------->
<div class="row" id="linha-7" style="display:none">

<div ID="perdapottotequiaux" class="col-md-2 col-sm-2 col-md-offset-1 col-sm-offset-1" style="margin-bottom: 8px">
<asp:TextBox runat="server" type="text" id="txtPerdaPotTotEquipAux" title="Perda da Potência Total dos equipamentos auxiliares" class="form-control " style="width: 82%" placeholder="Perda da Potência Total dos equipamentos auxiliares"></asp:TextBox>
</div>

<div ID="tipocircuito" class="col-md-2 col-sm-2" style="margin-bottom: 8px">
<asp:TextBox runat="server" type="text" id="txtTipoCircuito" title="Tipo de circuito" class="form-control " style="width: 82%" placeholder="Tipo de Circuito"></asp:TextBox>
</div>

<div ID="materialcondutor" class="col-md-2 col-sm-2" style="margin-bottom: 8px">
<asp:TextBox runat="server" type="text" id="txtMaterialCondutor" title="Material do Condutor" class="form-control " style="width: 82%" placeholder="Material do condutor"></asp:TextBox>
</div>

<div ID="bitolacondutor" class="col-md-2 col-sm-2" style="margin-bottom: 8px">
<asp:TextBox runat="server" type="text" id="txtBitolaCondutor" title="Bitola do Condutor" class="form-control " style="width: 82%" placeholder="Bitola do Condutor"></asp:TextBox>
</div>

<div ID="fasetransformador" class="col-md-2 col-sm-2" style="margin-bottom: 8px">
<asp:TextBox runat="server" type="text" id="TextBox1" title="Fase do Transformador" class="form-control " style="width: 82%" placeholder="Fase do Transformador"></asp:TextBox>
</div>
</div>

<!-------Inicio Row 8 (UTM, numero poste, precisao, poste no prumo e poste com avaria----------------------------------------------------------------------->

<div class="row" id="linha-8" style="display:none">

<div ID="potenciatransformador" class="col-md-2 col-sm-2   col-md-offset-1 col-sm-offset-1" style="margin-bottom: 8px">
<asp:TextBox runat="server" type="text" id="txtPotTrans" title="Potência do Transformador" class="form-control " style="width: 82%" placeholder="Potência do Transformador"></asp:TextBox>
</div>

<div ID="utm" class="col-md-2 col-sm-2" style="margin-bottom: 8px">
<asp:TextBox Style="width: 82%" id="txtGeoUTM" type="text" placeholder="Georeferencial UTM" class="form-control input-sm" title="Georeferencial UTM" runat="server" name="Georeferencial UTM"></asp:TextBox>
</div>

<div ID="prcisao" class="col-md-2 col-sm-2" style="margin-bottom: 8px">
<asp:TextBox runat="server" type="text" id="txtPrecisao" title="Precisão" class="form-control " style="width: 82%" placeholder="Precisão"></asp:TextBox>
</div>

<div ID="numposte" class="col-md-2 col-sm-2" style="margin-bottom: 8px">
<asp:TextBox runat="server" type="text" id="txtNumPoste" title="Número do Poste" class="form-control numerotxt" style="width: 82%" placeholder="Número do Poste"></asp:TextBox>
</div>

<div ID="posteprumo" class="col-md-2 col-sm-2" style="margin-bottom: 8px">
<asp:DropDownList  Style="width: 82%; display:inline-block;" title="Poste no Prumo" ID="ddlPostePrumo" class=" form-control input-sm " runat="server"  autofocus="true">
<asp:ListItem Text ="Poste no Prumo" Value = "-1"></asp:ListItem> 
<asp:ListItem Text ="Sim" Value = "sim"></asp:ListItem>   
<asp:ListItem Text ="Não" Value = "nao"></asp:ListItem>                     
</asp:DropDownList>
</div>
</div>

<!-------Inicio Row 9 (UTM, numero poste, precisao, poste no prumo e poste com avaria)----------------------------------------------------------------------->

<div class="row" id="linha-9" style="display:none">
    <div ID="postoavaria" class="col-md-2 col-sm-2 col-md-offset-1 col-sm-offset-1" style="margin-bottom: 8px">
            <asp:DropDownList  Style="width: 82%; display:inline-block;" title="Posto com avaria" ID="ddlPostoAvaria" class=" form-control input-sm " runat="server"  autofocus="true">
            <asp:ListItem Text ="Posto com avaria" Value = "-1"></asp:ListItem> 
            <asp:ListItem Text ="Sim" Value = "sim"></asp:ListItem>   
            <asp:ListItem Text ="Não" Value = "nao"></asp:ListItem>                     
            </asp:DropDownList>
    </div>


    <div ID="LampadaAcesaDia" class="col-md-2 col-sm-2 " style="margin-bottom: 8px">
            <asp:DropDownList  Style="width: 82%; display:inline-block;" title="Lâmpada acesa durante o dia" ID="ddlLampAcesaDia" class=" form-control input-sm " runat="server"  autofocus="true">
            <asp:ListItem Text ="Lâmpada acesa durante o dia" Value = "-1"></asp:ListItem> 
            <asp:ListItem Text ="Sim" Value = "sim"></asp:ListItem>   
            <asp:ListItem Text ="Não" Value = "nao"></asp:ListItem>                     
            </asp:DropDownList>
     </div>

     <div ID="numproximo" class="col-md-2 col-sm-2" style="margin-bottom: 8px">
            <asp:TextBox runat="server" type="text" id="txtNumeroMaisProx" title="Número mais próximo" class="form-control numerotxt" style="width: 100%" placeholder="Número mais próximo"></asp:TextBox>
     </div>

    <div ID="SituacaoLuminaria" class="col-md-2 col-sm-2" style="margin-bottom: 8px">
            <asp:DropDownList  Style="width: 82%; display:inline-block;" title="Situação da Luminária" ID="ddlSituacaoLum" class=" form-control input-sm " runat="server"  autofocus="true">
            <asp:ListItem Text ="Situação da Luminária" Value = "-1"></asp:ListItem> 
            <asp:ListItem Text ="Lente suja" Value = "lente suja"></asp:ListItem>   
            <asp:ListItem Text ="Luminária aberta" Value = "luminaria aberta"></asp:ListItem>
            <asp:ListItem Text ="Luminária sem lente" Value = "luminaria sem lente"></asp:ListItem>  
            <asp:ListItem Text ="Luminária virada para cima" Value = "luminaria virada para cima"></asp:ListItem>  
            <asp:ListItem Text ="Braço em luminária" Value = "braco sem luminaria"></asp:ListItem>  
            <asp:ListItem Text ="Luminária danificada" Value = "luminaria danificada"></asp:ListItem>                       
            </asp:DropDownList>
    </div>

    <div ID="obstrucaoilum" class="col-md-2 col-sm-2" style="margin-bottom: 8px">
        <asp:DropDownList  Style="width: 82%; display:inline-block;" title="obstrução da iluminação" ID="ddlObsIlum" class=" form-control input-sm " runat="server"  autofocus="true">
        <asp:ListItem Text ="Obstrução da iluminação" Value = "-1"></asp:ListItem> 
        <asp:ListItem Text ="Iluminação não obstruida" Value = "iluminacao nao obstruida"></asp:ListItem>   
        <asp:ListItem Text ="Obstrução parcial por arborização" Value = "obstrucao parcial pro arborizacao"></asp:ListItem>
        <asp:ListItem Text ="Obstrução total por arborização" Value = "obstrucao total por arborizacao"></asp:ListItem>                  
        </asp:DropDownList>
    </div>


</div>


<!----------------Inicio Row Geocode (Latitude, Longitude, icone e observãcao)--------------------------------->
<div class="row" id="geocode">

        <div ID="latitude" class="col-md-2 col-sm-2 col-md-offset-1 col-sm-offset-1" style="margin-bottom: 8px">
             <asp:TextBox Style="width: 82%" type="text" placeholder="Latitude" class="form-control input-sm" ID="txtLat" title="Latitude" runat="server" name="Latitude"></asp:TextBox>
        </div>

        <div ID="longitude" class="col-md-2 col-sm-2" style="margin-bottom: 8px">
                <asp:TextBox Style="width: 82%" type="text" placeholder="Longitude" class="form-control input-sm" ID="txtLng" title="Longitude" runat="server" name="Longitude"></asp:TextBox>
                <button type="button" id="openGlobe"  style="height: 29px;">
                <span class="glyphicon glyphicon-map-marker" aria-hidden="true"></span>
                </button>
         </div>

         <div ID="observacao" class="col-md-4 col-sm-4" style="margin-bottom: 8px">
            <asp:TextBox Style="width: 92%" type="text" placeholder="Observação" class="form-control input-sm" ID="txtObservacao" title="Observação" runat="server" name="Observacao"></asp:TextBox>

        </div>

        <div class="col-md-2 col-sm-2">
            <asp:LinkButton Style="width: 82%; margin-bottom: 8px;" ID="LinkButtonCadastrar" OnClick="bntCadastrar_Click" runat="server"  type="button" class="btn btn-primary btn-sm pull-left cadastrar">
            <center> Cadastrar </center>
            </asp:LinkButton>

            <asp:LinkButton Style="width: 50%; display:none; margin-bottom: 8px;" OnClick="bntAlterar_Click" ID="LinkButtonAlterar"  runat="server"  type="button" class="btn btn-primary btn-sm pull-left cadastrar">
            <center> Alterar </center>
            </asp:LinkButton>
            <button style="width:30%; display:none; float:right; margin-bottom: 8px; margin-left:3%;" id="deletarInfo"   class="btn btn-danger pull-left btn-sm btn-xl" title="Excluir Dados Iluminação" type="button" >
            <span class="glyphicon glyphicon-trash delete" aria-hidden="true"></span>
            </button>

        </div>
    </div>

 <!--------Inicio Row Globespotter e fotos--------------------------------------------------> 
                           
    <div id="globespotter_fotos" class="row" style="margin-bottom:2px; overflow:hidden;">
        <div class="col-md-5 col-md-offset-1" style=" height: 590px">
              <div id="pcont">

                  <div id="pwrap">
                     
                          <div id="pano"></div>
                          <div id="panosplit"></div>
                          <div id="panovert"></div>
                          <div id='baser'></div>
                    </div>
                    <div id="buthold">
                        <button id="baseset" type="button" class="btn btn-lg btn-primary">Marcar base</button>
                    </div>
                    <table class="table table-bordered">
              <thead>
              <tr><th>Heading</th><th>Pitch</th><th>Distance (m)</th><th>Base Height</th><th>Estimated Height (m)</th></tr>
              </thead>
              <tbody>
              <tr><td id="heading"></td><td id="pitch"></td><td id="distance"></td><td id="baseheight"></td><td id="estheight"></td></tr>
              </tbody>
              </table>
               </div>
          
            </div>

            <div class="col-md-5">
                <div id="sliderblx">

                <ul class='bxslider' style='height: 100%; width: 100%; position: absolute; padding:0;' >

                <li style='float: none; list-style: none; position: absolute; width: 467px; z-index: 0; display: block;'>
                <img src="img/logo_arya.jpg"  height="530"/>
                        
                </li>
                <li style='float: none; list-style: none; position: absolute; width: 467px; z-index: 0; display: block;'>
                <img src="img/logo_arya.jpg"  height="530"/>
                        
                </li>
                </ul>
                </div>
                     
            </div>
                               

    </div>

<!-------------------------------------Mapa----------------------------------------------->
    <div class="row" id="mapa" style="margin-top: 5px;">
        <div class="col-md-10 col-md-offset-1">
            <div id="map" style="width:100%; height:500px; margin: 0; display:none"></div>
        </div>
    </div>
     <div class="row" id="theodolite" style="margin-top: 5px;">
        <div class="col-md-10 col-md-offset-1">
             <div id="map_canvas"></div>

             
        </div>
    </div>

    <input type="hidden" id="_ispostback" value="<%=Page.IsPostBack.ToString()%>" />
    </form>
   
</div>

    
    <script>
        window.onload = initialize;
        function setValues()
        {
            codilumset($('#<%=txtCodIluminacao.ClientID%>'));
            projbracoset($('#<%=txtProjBraco.ClientID%>'));
            tipobracoset($('#<%=ddlTipoBraco.ClientID%>'));
            tipolumset($('#<%=ddlTipoLum.ClientID%>'));
            tipofontelumset($('#<%=ddlTipoFonteLum.ClientID%>'));
            potfontelumset($('#<%=ddlPotFonteLum.ClientID%>'))
            qtdefontelumset(  $('#<%=ddlQtdeFonteLum.ClientID%>'));
            pottotfontelumset( $('#<%=txtPotTotFonteLum.ClientID%>'));
            carginsttotuipset($('#<%=txtCargInsTotUIP.ClientID%>'));
            tiporeatorset($('#<%=ddlTipoReator.ClientID%>'));
            tiporeleset($('#<%=ddlTipoRele.ClientID%>'));
            tipoalimentacaoset( $('#<%=ddlTipoAlimentacao.ClientID%>'));
            tipoposteset($('#<%=ddlTipoPoste.ClientID%>'));
            altposteset($('#<%=txtAltPoste.ClientID%>'));
            altinstlumset($('#<%=txtAltInstLum.ClientID%>'));
            munset( $('#<%=txtMun.ClientID%>'));
            regset($('#<%=txtReg.ClientID%>'));
            bairset($('#<%=txtBair.ClientID%>'));
            classilumset($('#<%=ddlClassIlum.ClientID%>'));
            logset($('#<%=txtLog.ClientID%>'));
            cepset($('#<%=txtCEP.ClientID%>'));
            codlogset($('#<%=txtCodLog.ClientID%>'));
            nomelocaldestaqset($('#<%=txtNomeLocDestaq.ClientID%>'));
            ilumdestset($('#<%=ddlIlumDest.ClientID%>'));
            qtdelumset($('#<%=ddlQtdeLum.ClientID%>'));
            medset($('#<%=txtMed.ClientID%>'));
            observacaoset($('#<%=txtObservacao.ClientID%>'));
            latset($('#<%=txtLat.ClientID%>'));
            lngset($('#<%=txtLng.ClientID%>'));   
            distmeddoispostesset( $("#<%=txtdistmeddoispostes.ClientID %>"));
            tipoposteacaoset($("#<%=ddltipoposteacao.ClientID %>"));
            larguraviaset($("#<%=txtlarguravia.ClientID %>"));
            larguracantcentralset($("#<%=txtlarguracantcentral.ClientID %>"));
            largurapasseioset($("#<%=txtlargurapasseio.ClientID %>")); 
        }

        function chamarValidaForm() {
            validaForm($("#<%=txtProjBraco.ClientID %>"));
            validaForm($("#<%=txtAltInstLum.ClientID %>"));
            validaForm($("#<%=txtAltPoste.ClientID %>"));
            validaForm($("#<%=ddlTipoBraco.ClientID %>"));
        }

        function validaForm(campo){
            if (campo.val() == "") {
                campo.css("borderColor", "#ff0000");
            } else if (campo.val() == "-1") {
                campo.css("borderColor", "#ff0000");
            } else {
                campo.css("borderColor", "");
            }      
        }

        function travar() {
            travarTela(document.getElementById("telaModeToggle"));
            }

        function isPostBack() { //function to check if page is a postback-ed one
            return document.getElementById('_ispostback').value;
        }

        function abrirMedicao() {
            enable();
        }
        
        $("#google").click(function () {
            var lat = $('#<%=txtLat.ClientID%>').val().trim();
            var lng = $('#<%=txtLng.ClientID%>').val().trim();
            if (lat != "" || lng != "") {
                window.open("http://maps.google.com/maps?q=" + lat + "," + lng);
            }     
        });

        
        var lista=[];
        var pos = -1;

        $("#openGlobe").click(function () {// icone que habilita opções de medição
            
            var lat = $('#<%=txtLat.ClientID%>').val();
            var lng = $('#<%=txtLng.ClientID%>').val();
            if(lat != "" && lng!="")
            {
               

                var latlong = convertUTM(lat, lng);
              
                setValues();
                chamaAjax("Geocode", "{ 'lat':'" + lat + "', 'lng':'" + lng + "'}", 1);
            }        
        });

        $(document).ready(function () {

            $("#btnclear").click(function () {// icone que habilita opções de medição  
                limpacampos();
                setDefault();
            });
            $("#infolista").click(function () {
               
             
                    if ($('#<%=txtCodIluminacao.ClientID%>').val()) {
                        var result = -1;
                       
                        result = buscaBinariaSimples(lista, lista.length, $('#<%=txtCodIluminacao.ClientID%>').val());
                       
                        if (result != -1) {
                            //var latlong = convertUTM(lista[result][2], lista[result][3]);
                            selectIluminacao(lista[result][0], lista[result][1], lista[result][2], lista[result][3], lista[result][4])
                        }
                        else {
                            alert("Codigo não encontrado!")
                        }
                    }
                
            });
            /**************************************************************************************************slider**/
            $('.bxslider').bxSlider({
                mode: 'fade',
                captions: true
            });

            /**************************************************************************************************postback**/
            
            if (isPostBack().toString() == "True") {///RELOAD DA PAGINA FAZER
                chamaAjax("GetLista", "{ 'localidade': '" + $("#<%=ddllocalidade.ClientID %>").val() + "'}", 2);
           
               <%-- var latlong = convertUTM($('#<%=txtLat.ClientID%>').val(), $('#<%=txtLng.ClientID%>').val());--%>
  
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
                if ($("#<%=ddllocalidade.ClientID %>").val() != "-1")
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
                            var teste = "";
                    
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
                }   
            });

            function valida() {
                if ($("#<%=ddlTipoBraco.ClientID %>").val() == "1" || $("#<%=ddlTipoBraco.ClientID %>").val() == "NULL" || $("#<%=ddlTipoBraco.ClientID %>").val() == null) {
                }
            }

            /*----------------------------------Padrão tipo de braço e projeção do braço------------*/
    
            $("#<%=ddlTipoBraco.ClientID %>").change(function () {
                alterarTipoBraco($("#<%=txtCodIluminacao.ClientID %>"), $("#<%=ddlTipoBraco.ClientID %>"), $("#<%=txtProjBraco.ClientID %>"),  $("#<%=ddlTipoAlimentacao.ClientID %>"),  $("#<%=ddlTipoPoste.ClientID %>"), $("#<%=txtAltPoste.ClientID %>"));
            });

            function fonteLuminosa() {
                tipoFonteLuminosa($("#<%=ddlTipoFonteLum.ClientID %>"),$("#<%=ddlPotFonteLum.ClientID %>") );
            }


            /*-------------------------Padrao para o tipo e potencia de fonte luminosa--------------*/
            $("#<%=ddlTipoFonteLum.ClientID %>").change(function () {
                fonteLuminosa($("#<%=ddlTipoFonteLum.ClientID %>").val());
            });

            /*-------------------------------------Tipo relé e tipo reator baseado no tipo de luminária---------------------------*/
            $("#<%=ddlTipoLum.ClientID %>").change(function () {
                lumReles($("#<%=ddlTipoLum.ClientID %>"), $("#<%=ddlTipoReator.ClientID %>"), $("#<%=ddlTipoRele.ClientID %>"))
            });

            $("#<%=ddlTipoRele.ClientID %>").change(function () {
                trocaRele($("#<%=ddlTipoRele.ClientID %>"), $("#<%=ddlTipoReator.ClientID %>"))
            });

            $("#<%=ddlTipoReator.ClientID %>").change(function () {
                trocaReator($("#<%=ddlTipoRele.ClientID %>"), $("#<%=ddlTipoReator.ClientID %>"))
            });

                /*-------------------------Padrao para Tipo de braço ou poste com tipo de alimentação-------------------------*/

                $("#<%=ddlTipoPoste.ClientID %>").change(function () {
                    trocarPosteEAli($("#<%=ddlTipoPoste.ClientID %>"), $("#<%=ddlTipoAlimentacao.ClientID %>"));   
                });
      
                /*---------------------------------Quantidade de Luminarias e quantidade de fontes luminosas-------------------------*/

                $("#<%=ddlQtdeLum.ClientID %>").change(function () {
                    trocarLum($("#<%=ddlQtdeLum.ClientID %>"), $("#<%=ddlQtdeFonteLum.ClientID %>"));
                });
 
                $("#<%=ddlQtdeFonteLum.ClientID %>").change(function () {
                    if ($("#<%=ddlQtdeFonteLum.ClientID %>").val() < $("#<%=ddlQtdeLum.ClientID %>").val()) {
                        $("#<%=ddlQtdeLum.ClientID %>").val("-1");
                    }
                });

                /*************************************************************************************************************botao de dados padroes*/

                $("#btncomuncurto").click(function () {
                    setDefault();
                    comumCurto($("#<%=ddlTipoBraco.ClientID %>"), $("#<%=txtProjBraco.ClientID %>"), $("#<%=txtAltPoste.ClientID %>"), $("#<%=ddlQtdeLum.ClientID %>"), $("#<%=ddlTipoPoste.ClientID %>"), $("#<%=ddlQtdeFonteLum.ClientID %>"), $("#<%=ddlTipoReator.ClientID %>"), $("#<%=ddlTipoAlimentacao.ClientID %>"), $("#<%=txtAltInstLum.ClientID %>"), $("#<%=ddlTipoRele.ClientID %>"), $("#<%=ddlIlumDest.ClientID %>"), $("#<%=ddlTipoLum.ClientID %>"), $("#<%=ddlTipoFonteLum.ClientID %>"), $("#<%=ddlPotFonteLum.ClientID %>"), $("#<%=txtMun.ClientID %>"));           
                });

                $("#btncomunmedio").click(function () {
                    setDefault();
                    comumMedio($("#<%=ddlTipoBraco.ClientID %>"), $("#<%=txtProjBraco.ClientID %>"), $("#<%=txtAltPoste.ClientID %>"), $("#<%=ddlQtdeLum.ClientID %>"), $("#<%=ddlTipoPoste.ClientID %>"), $("#<%=ddlQtdeFonteLum.ClientID %>"), $("#<%=ddlTipoReator.ClientID %>"), $("#<%=ddlTipoAlimentacao.ClientID %>"), $("#<%=txtAltInstLum.ClientID %>"), $("#<%=ddlTipoRele.ClientID %>"), $("#<%=ddlIlumDest.ClientID %>"), $("#<%=ddlTipoLum.ClientID %>"), $("#<%=ddlTipoFonteLum.ClientID %>"), $("#<%=ddlPotFonteLum.ClientID %>"), $("#<%=txtMun.ClientID %>"));            
                });

                $("#btncomunlongo").click(function () {
                    setDefault();
                    comumLongo($("#<%=ddlTipoBraco.ClientID %>"), $("#<%=txtProjBraco.ClientID %>"), $("#<%=txtAltPoste.ClientID %>"), $("#<%=ddlQtdeLum.ClientID %>"), $("#<%=ddlTipoPoste.ClientID %>"), $("#<%=ddlQtdeFonteLum.ClientID %>"), $("#<%=ddlTipoReator.ClientID %>"), $("#<%=ddlTipoAlimentacao.ClientID %>"), $("#<%=txtAltInstLum.ClientID %>"), $("#<%=ddlTipoRele.ClientID %>"), $("#<%=ddlIlumDest.ClientID %>"), $("#<%=ddlTipoLum.ClientID %>"), $("#<%=ddlTipoFonteLum.ClientID %>"), $("#<%=ddlPotFonteLum.ClientID %>"), $("#<%=txtMun.ClientID %>"));      
                });

                $("#btncomunrodovia").click(function () {
                    limpa();
                    setDefault();
                    comumRodovia($("#<%=ddlTipoBraco.ClientID %>"), $("#<%=txtAltPoste.ClientID %>"), $("#<%=ddlQtdeLum.ClientID %>"), $("#<%=ddlTipoPoste.ClientID %>"), $("#<%=ddlQtdeFonteLum.ClientID %>"), $("#<%=ddlTipoReator.ClientID %>"), $("#<%=ddlTipoAlimentacao.ClientID %>"), $("#<%=txtAltInstLum.ClientID %>"), $("#<%=ddlTipoRele.ClientID %>"), $("#<%=ddlIlumDest.ClientID %>"), $("#<%=ddlTipoLum.ClientID %>"), $("#<%=ddlTipoFonteLum.ClientID %>"), $("#<%=ddlPotFonteLum.ClientID %>"), $("#<%=txtMun.ClientID %>"));                       
                });

                function setDefault(){
                    defaultSet($('#<%=ddlTipoPoste.ClientID %>'), $('#<%=ddlPotFonteLum.ClientID %>'));
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

                        //var latlong = convertUTM(i.item.lat, i.item.lng);
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
                   
                    var retorno = getinfoilum(codIlu, objectid);
                   
                    if (retorno) {
                      
                        setViewThe(lat, lng);
                    }
                    ////// 
                               

                  
                }

                function selectIluminacaoRefresh(codIlu, objectid, lat, lng, kmlid) {
                    setDefault();
                    limpa();
                    $('#<%=hfCodilumPK.ClientID%>').val(objectid);
                    $('#<%=hfkmlID.ClientID%>').val(kmlid);
                    $("#<%=txtLat.ClientID %>").val(lat);
                    $("#<%=txtLng.ClientID %>").val(lng);
                    
                     getinfoilum(codIlu, objectid);
                  
                }

            function getRows(id) {
                chamaAjax("GetRow", "{ 'id': '" + id + "'}", 3); 
                }


            function getinfoilum(codIlu, iluPK) {
                var result;
                $.ajax({
                        async: false,                        
                        url: '<%=ResolveUrl("~/Classes/service.asmx/GetInfo") %>',
                        type: "POST",
                        data: "{ 'ilumid': '" + iluPK + "'}",
                        contentType: "application/json; charset=utf-8",
                        dataType: "json",
                        success: function (data2) {
                            result = true;
                            var parsed2 = $.parseJSON(data2.d);
                            var fotos = ""
                            var cont = 0;
                            var layout = "<div class='bx-wrapper' style='max-width: 100%;'><div class='bx-viewport' style='width: 100%; overflow: hidden; position: relative; height: 530px;'>" +
                                            "<ul class='bxslider' style='height: 467px; width: auto; position: relative;' >"
                            var navegacao = "";

                            $.each(parsed2, function (i, jsondata) {


                                if (jsondata.COD_ILUM_FK != "" && jsondata.COD_ILUM_FK != "NULL" && jsondata.COD_ILUM_FK != null  )
                                {
                                    setValues();
                                    selectiluinfo(jsondata.TIPO_BRACO, jsondata.PROJ_BRACO, jsondata.TIPO_LUMINARIA, jsondata.TIPO_FONTE_LUMINARIA, jsondata.POTENCIA_FONTE_LUMI, jsondata.QUANT_FONTES_LUMI, jsondata.POTENCIA_TOTAL_FONTE_LUMI, jsondata.CARGA_INST_TOTAL_UN_ILUM_PUB, jsondata.TIPO_REATOR, jsondata.TIPO_RELE, jsondata.TIPO_ALIMENTACAO, jsondata.TIPO_POSTE, jsondata.ALTURA_POSTE, jsondata.ALTURA_INST_LUMI, jsondata.MUNICIPIO, jsondata.REGIONAL, jsondata.BAIRRO, jsondata.CLASSE_ILUMI, jsondata.LOGRADOURO, jsondata.CEP, jsondata.COD_LOGRADOURO, jsondata.ILUM_DESTAQ, jsondata.NOME_LOCAL_DESTAQ, jsondata.QUANT_LUMINARIAS, jsondata.MEDICAO, jsondata.LAT, jsondata.LONG, jsondata.OBSERVACAO)
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


                    return result
                }

                
                function limpacampos() {
                    limparCampos($('#<%=txtCodIluminacao.ClientID%>'), $('#<%=txtProjBraco.ClientID %>'), $('#<%=ddlTipoBraco.ClientID%>'), $('#<%=ddlTipoLum.ClientID%>'), $('#<%=ddlTipoFonteLum.ClientID%>'), $('#<%=ddlPotFonteLum.ClientID%>'), $('#<%=ddlQtdeFonteLum.ClientID%>'), $('#<%=txtPotTotFonteLum.ClientID%>'), $('#<%=txtCargInsTotUIP.ClientID%>'), $('#<%=ddlTipoReator.ClientID%>'), $('#<%=ddlTipoRele.ClientID%>'), $('#<%=ddlTipoAlimentacao.ClientID%>'), $('#<%=ddlTipoPoste.ClientID%>'), $('#<%=txtAltPoste.ClientID%>'), $('#<%=txtAltInstLum.ClientID%>'), $('#<%=txtReg.ClientID%>'), $('#<%=txtMun.ClientID%>'), $('#<%=txtBair.ClientID%>'), $('#<%=ddlClassIlum.ClientID%>'), $('#<%=txtLog.ClientID%>'), $('#<%=txtCEP.ClientID%>'), $('#<%=txtCodLog.ClientID%>'), $('#<%=txtNomeLocDestaq.ClientID%>'), $('#<%=ddlQtdeLum.ClientID%>'), $('#<%=txtMed.ClientID%>'), $("#<%=txtObservacao.ClientID %>"), $("#<%=txtdistmeddoispostes.ClientID %>"), $("#<%=ddltipoposteacao.ClientID %>"), $("#<%=txtlarguravia.ClientID %>"), $("#<%=txtlarguracantcentral.ClientID %>"), $("#<%=txtlargurapasseio.ClientID %>"));         
                }

                /////////////////////////////////////////////////////////////limpar dados
                function limpa()
                {
                    limpar($("#<%=txtProjBraco.ClientID %>"), $('#<%=ddlTipoBraco.ClientID%>'), $('#<%=ddlTipoLum.ClientID%>'), $('#<%=ddlTipoFonteLum.ClientID%>'), $('#<%=ddlPotFonteLum.ClientID%>'), $('#<%=ddlQtdeFonteLum.ClientID%>'), $('#<%=txtPotTotFonteLum.ClientID%>'), $('#<%=txtCargInsTotUIP.ClientID%>'), $('#<%=ddlTipoReator.ClientID%>'), $('#<%=ddlTipoRele.ClientID%>'), $('#<%=ddlTipoAlimentacao.ClientID%>'), $('#<%=ddlTipoPoste.ClientID%>'), $('#<%=txtAltPoste.ClientID%>'), $('#<%=txtAltInstLum.ClientID%>'), $('#<%=txtMun.ClientID%>'), $('#<%=txtReg.ClientID%>'), $('#<%=txtBair.ClientID%>'), $('#<%=ddlClassIlum.ClientID%>'), $('#<%=txtLog.ClientID%>'), $('#<%=txtCEP.ClientID%>'), $('#<%=txtCodLog.ClientID%>'), $('#<%=ddlIlumDest.ClientID%>'), $('#<%=txtNomeLocDestaq.ClientID%>'), $('#<%=ddlQtdeLum.ClientID%>'), $('#<%=txtMed.ClientID%>'), $('#<%=txtLat.ClientID%>'), $('#<%=txtLng.ClientID%>'), $('#deletarInfo'), $('#<%=LinkButtonAlterar.ClientID%>'), $('#<%=LinkButtonCadastrar.ClientID%>'), $("#<%=txtObservacao.ClientID %>"), $('#<%=hfCodilumPK.ClientID%>'), $("#<%=txtdistmeddoispostes.ClientID %>"), $("#<%=ddltipoposteacao.ClientID %>"), $("#<%=txtlarguravia.ClientID %>"), $("#<%=txtlarguracantcentral.ClientID %>"), $("#<%=txtlargurapasseio.ClientID %>"), $('#<%=Msucesso.ClientID%>'), $('#<%=Malerta.ClientID%>'), $('#<%=Merro.ClientID%>') );
                }
          
                $(document).on('click', '#deletarInfo', function (e) {///FUNÇÃO PARA DELETAR DADOS DO POSTE
                    if ($('#<%=hfPermissao.ClientID%>').val() != "1")
                    {
                        if (confirm("Tem certeza que deseja excluir esses dados?"))
                           chamaAjax("deletePoste", "{ 'iluPK':'" + $('#<%=hfCodilumPK.ClientID%>').val() + "'}", 4);

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

        var utm = 'PROJCS["SIRGAS_2000_UTM_Zone_@numfuso@hemisferio",GEOGCS["GCS_SIRGAS_2000",DATUM["D_SIRGAS_2000",SPHEROID["GRS_1980",6378137.0,298.257222101]],PRIMEM["Greenwich",0.0],UNIT["Degree",0.0174532925199433]],PROJECTION["Transverse_Mercator"],PARAMETER["False_Easting",500000.0],PARAMETER["False_Northing",10000000.0],PARAMETER["Central_Meridian",@nummc],PARAMETER["Scale_Factor",0.9996],PARAMETER["Latitude_Of_Origin",0.0],UNIT["Meter",1.0]]';
        var wgs84 = "+proj=longlat +ellps=WGS84 +datum=WGS84 +no_defs";
        function convertUTM(WGSlat, WGSlng) {

            var MC = (6 * Math.floor(WGSlng / 6)) + 3;
            var Fuso = Math.round(30 - (Math.abs(MC) / 6));
            var calcfuso;
            var checklat = WGSlat;

            if (checklat < 0) {
                calcfuso = utm.replace("@hemisferio", "S");
            }
            else {
                calcfuso = utm.replace("@hemisferio", "N");
            }
            calcfuso = calcfuso.replace("@numfuso", Fuso);
            calcfuso = calcfuso.replace("@nummc", MC);


            var latlong = proj4(wgs84, calcfuso, [WGSlng, WGSlat]);
            return latlong;

        }

        
           

            // getPontos("TESTE");


           


        
            /////////////////////////ICON


            //////////////////////
      
                

            ///////////////////////////////////banco

           


          

            
        


            /*----------------------------------Padrão tipo de braço e projeção do braço------------*/
 
       
            /*-------------------------Padrao para o tipo e potencia de fonte luminosa--------------*/
           
            /*-------------------------------------Tipo relé e tipo reator baseado no tipo de luminária---------------------------*/
        


           

           

            /*-------------------------Padrao para Tipo de braço ou poste com tipo de alimentação-------------------------*/
           

            /*---------------------------------Padrao Quantidade de Luminarias e quantidade de fontes luminosas-------------------------*/

           
           
            
            
            
            /////////////////////////////////////////////////////////////limpar dados
          
            
        </script>
    
</asp:Content>
