document.write(unescape("%3Cscript src='japi/API.js' type='text/javascript'%3E%3C/script%3E"));
document.write(unescape("%3Cscript src='japi/api-common.js' type='text/javascript'%3E%3C/script%3E"));


var codilum, projbraco, tipobraco, tipolum, tipofontelum, potfontelum, qtdefontelum, pottotfontelum, carginsttotuip, tiporeator, tiporele, tipoalimentacao, tipoposte, altposte, altinstlum, mun, reg, bair, classilum, log, cep, codlog, ilumdest, qtdelum, med, observacao, nomelocaldestaq, lat, lng, distmeddoispostes, tipoposteacao, larguravia, larguracantcentral, largurapasseio;

function codilumset(value){
	this.codilum = value;
}
function projbracoset(value){
	this.projbraco = value;
}
function tipobracoset(value){
	this.tipobraco = value;
}
function tipolumset(value){
	this.tipolum = value;
}
function tipofontelumset(value){
	this.tipofontelum = value;
}
function potfontelumset(value){
	this.potfontelum = value;
}
function qtdefontelumset(value){
	this.qtdefontelum = value;
	
}function pottotfontelumset(value){
	this.pottotfontelum = value;
}
function carginsttotuipset(value){
	this.carginsttotuip = value;
}
function tiporeatorset(value){
	this.tiporeator = value;
}
function tiporeleset(value){
	this.tiporele = value;
}
function tipoalimentacaoset(value){
	this.tipoalimentacao = value;
}
function tipoposteset(value){
	this.tipoposte = value;
}
function altposteset(value){
	this.altposte = value;
}
function altinstlumset(value){
	this.altinstlum = value;
}
function munset(value){
	this.mun = value;
}
function regset(value){
	this.reg = value;
}
function bairset(value){
	this.bair = value;
}
function classilumset(value){
	this.classilum = value;
}
function logset(value){
		this.log = value;
}
function cepset(value){
	this.cep = value;
}
function codlogset(value){
	this.codlog = value;
}
function ilumdestset(value){
	this.ilumdest = value;
}
function qtdelumset(value){
	this.qtdelum = value;
}
function medset(value){
	this.med = value;
}
function observacaoset(value){
	this.observacao = value;
}
function nomelocaldestaqset(value){
	this.nomelocaldestaq = value;
}
function latset(value){
	this.lat = value;
}
function lngset(value){
	this.lng = value;
}

function distmeddoispostesset(value){
    this.distmeddoispostes = value;
}

function tipoposteacaoset(value){
    this.tipoposteacao = value;
}

function larguraviaset(value){
    this.larguravia = value;
}

function larguracantcentralset(value){
    this.larguracantcentral = value;
}

function largurapasseioset(value) {
    this.largurapasseio = value;
}


function teste(projbraco){
	alert(projbraco.val());
	//var projecaobraco = document.getElementById();
	//projecaobraco.style.backgroundColor = "red";
}

function teste2(){
	alert('Carai');
}
function setViewThe(lat, lng) {

    google.maps.event.clearListeners(panorama, 'position_changed', change_position);
    google.maps.event.clearListeners(indicator, 'dragend', change_dragend);
    google.maps.event.clearListeners(panorama, 'pov_changed', change_pov);

    mapCtr = new google.maps.LatLng((lat * 1), (lng * 1));
    indicator.setPosition(mapCtr);
    panorama.setPosition(mapCtr);
    panorama.setPov({
        heading: bearing(mapCtr, indicator.getPosition()),
        pitch: pitch
    });


    var service = new google.maps.StreetViewService;
    
    service.getPanoramaByLocation(panorama.getPosition(), 50, function (panoData) {
        if (panoData != null) {
            var panoCenter = panoData.location.latLng;

            var heading = google.maps.geometry.spherical.computeHeading(panoCenter, mapCtr);

            var pov = panorama.getPov();
            pov.heading = heading;
            panorama.setPov(pov);


            //var marker = new google.maps.Marker({
            //    map: panorama,
            //    position: mapCtr
            //});
            // var pam = new google.maps.LatLng((panoCenter.lat())*1, (panoCenter.lng())*1);
            dist = distance(mapCtr, panoCenter)

        } else {
            // no streetview found :(
            alert('não encontrado');
        }

    });

    map.setCenter(indicator.getPosition())
    document.location.hash = mapCtr.toUrlValue() + "/" + indicator.getPosition().toUrlValue() + "/" + Math.round(dang) + "/0";

    google.maps.event.addListener(panorama, 'position_changed', change_position);
    google.maps.event.addListener(indicator, 'dragend', change_dragend);
    google.maps.event.addListener(panorama, 'pov_changed', change_pov);

}

function enable()
        {
            if (document.getElementById('linkpoint').className == "tablinks  btn disabled")
            {
                document.getElementById('playmedicao').style.backgroundColor = "#27282B";
                document.getElementById('playmedicao').style.height = "26px";
                document.getElementById('linkpoint').className = "tablinks";
                document.getElementById('linkline').className = "tablinks";
                document.getElementById('linkpoly').className = "tablinks";
            }
            else
            {
                var tabcontent = document.getElementsByClassName("tabcontent");
                for (i = 0; i < tabcontent.length; i++) {
                    tabcontent[i].style.display = "none";
                }
                document.getElementById('playmedicao').style.backgroundColor = "#555557";
                document.getElementById('linkpoint').className = "tablinks  btn disabled";
                document.getElementById('linkline').className = "tablinks  btn disabled";
                document.getElementById('linkpoly').className = "tablinks  btn disabled";
            }
            
        }
		
function travarTela(telaModeToggle) {
            if (telaModeToggle.checked) {
                $(document).bind('scroll', function () {
                    window.scroll(0, 410);
                });
            } else {
                $(document).unbind('scroll');
                $('globespotter_fotos').css({ 'overflow': 'visible' });
            }
            }

    function buscaBinariaSimples(v, n, x) {
       
        achou = false;
        var L = 1;
        var R = n;
        var M = 0;
        var ultimo = n - 1;

        while (!achou && L < R) {
        
            if (x == v[0][0]) {
                M = 0;
                achou = true;
                return M
                break;
            }

            M = parseInt((L + R) / 2);
            if (x == v[M][0]) {
                achou = true;
                return M;
            } else if (x < v[M][0]) {
                R = M
            } else {
                L = M + 1
            }
        }
        return -1;


    }

    function alterarTipoBraco(codilum, tipobraco, projbraco, tipoalimentacao, tipoposte, altposte) {
        if (codilum.val() != "")
                 {                   
	    if (tipobraco.val() == "Curto") {
	        if (tipobraco.val() != "Metalico") {
	            projbraco.val("1.16");
	            tipoalimentacao.val("Aereo");
                         }else {
	            projbraco.val("1.16");
	            tipoalimentacao.val("Aereo");
	            tipoposte.val("-1");
                         }
                     }
	    else if (tipobraco.val() == "Medio") {
	        if (tipoposte.val() != "Metalico") {
                             projbraco.val("2.92");
                             tipoalimentacao.val("Aereo");
                         }else {
                             projbraco.val("2.92");
                             tipoalimentacao.val("Aereo");
                             tipoposte.val("-1");
                         }
                     }
	    else if (tipobraco.val() == "Medio Pesado") {
	        if (tipoposte.val() != "Metalico") {
                             projbraco.val("3.85");
                             tipoalimentacao.val("Aereo");
                         }else {
                             projbraco.val("3.85");
                             tipoalimentacao.val("Aereo");
                             tipoposte.val("-1");
                         }
                     }
	    else if (tipobraco.val() == "Longo") {
	        if (tipoposte.val() != "Metalico") {
                             projbraco.val("5.60");
                             altposte.val("12");
                             tipoalimentacao.val("Aereo");
                         }else {
                             projbraco.val("5.60");
                             altposte.val("12");
                             tipoalimentacao.val("Aereo");
                             tipoposte.val("-1");
                         }
                     }
	    else if (tipobraco.val() == "Especial") {
	        tipoposte.val("Metalico");
                         tipoalimentacao.val("Subterraneo");
                         projbraco.val("");
                     }
	    else if (tipobraco.val() == "Sem braco") {
	        tipoposte.val("Metalico")
                         projbraco.val("");
                         tipoalimentacao.val("Subterraneo");
                     }
	    else if (tipobraco.val() == "-1") {
	                     tipoalimentacao.val("-1");
                         projbraco.val("");
                     }
                 }
}			

function tipoFonteLuminosa(tipofontelum, potfontelum){
	if (tipofontelum.val() == "Sodio") {
		potfontelum.empty().append($("<option></option>").val("-1").html("Potência da fonte luminosa (W)"));
		potfontelum.append($("<option></option>").val("70").html("70W"));
		potfontelum.append($("<option></option>").val("100").html("100W"));
		potfontelum.append($("<option></option>").val("150").html("150W"));
		potfontelum.append($("<option></option>").val("250").html("250W"));
		potfontelum.append($("<option></option>").val("400").html("400W"));
		potfontelum.val("-1");
	} 
	else if (tipofontelum.val() == "Mercurio") {
		potfontelum.empty().append($("<option></option>").val("-1").html("Potência da fonte luminosa (W)"));
		potfontelum.append($("<option></option>").val("80").html("80W"));
		potfontelum.append($("<option></option>").val("125").html("125W"));
		potfontelum.append($("<option></option>").val("250").html("250W"));
		potfontelum.append($("<option></option>").val("400").html("400W"));
		potfontelum.val("-1");
	}
	else if (tipofontelum.val() == "Metalico") {
		potfontelum.empty().append($("<option></option>").val("-1").html("Potência da fonte luminosa (W)"));
		potfontelum.append($("<option></option>").val("35").html("35W"));
		potfontelum.append($("<option></option>").val("70W").html("70W"));
		potfontelum.append($("<option></option>").val("150W").html("150W"));
		potfontelum.val("-1");
	} else if (tipofontelum.val() == "Led" || tipofontelum.val() == "-1") {
		potfontelum.empty().append($("<option></option>").val("-1").html("Potência da fonte luminosa (W)"));
		potfontelum.append($("<option></option>").val("6").html("6W"));
		potfontelum.append($("<option></option>").val("35").html("35W"));
		potfontelum.append($("<option></option>").val("40").html("40W"));
		potfontelum.append($("<option></option>").val("54").html("54W"));
		potfontelum.append($("<option></option>").val("55").html("55W"));
		potfontelum.append($("<option></option>").val("58").html("58W"));
		potfontelum.append($("<option></option>").val("70").html("70W"));
		potfontelum.append($("<option></option>").val("80").html("80W"));
		potfontelum.append($("<option></option>").val("86").html("86W"));
		potfontelum.append($("<option></option>").val("100").html("100W"));
		potfontelum.append($("<option></option>").val("125").html("125W"));
		potfontelum.append($("<option></option>").val("127").html("127W"));
		potfontelum.append($("<option></option>").val("150").html("150W"));
		potfontelum.append($("<option></option>").val("250").html("250W"));
		potfontelum.append($("<option></option>").val("350").html("350W"));
		potfontelum.append($("<option></option>").val("400").html("400W"));
	}
	else {
		setDefault();
	}
}



function limparCampos(codilum, projbraco, tipobraco, tipolum, tipofontelum, potfontelum, qtdefontelum, pottotfontelum, carginsttotuip, tiporeator, tiporele, tipoalimentacao, tipoposte, altposte, altinstlum, mun, reg, bair, classilum, log, cep, codlog, ilumdest, qtdelum, med, observacao, distmeddoispostes, tipoposteacao, larguravia, larguracantcentral, largurapasseio) {
	codilum.css("background", "#FFFFFF");
	projbraco.val("");
	tipobraco.val("-1");
	tipolum.val("-1");
	tipofontelum.val("-1");
	potfontelum.val("-1");
	qtdefontelum.val("-1");
	pottotfontelum.val("");
	carginsttotuip.val("");
	tiporeator.val("-1");
	tiporele.val("-1");
	tipoalimentacao.val("-1");
	tipoposte.val("-1");
	altposte.val("");
	altinstlum.val("");
	mun.val("");
	reg.val("");
	bair.val("");
	classilum.val("-1");
	log.val("");
	cep.val("");
	codlog.val("");
	ilumdest.val("");
	qtdelum.val("-1");
	med.val("");
	observacao.val("");
	distmeddoispostes.val("");
	tipoposteacao.val("-1");
	larguravia.val("");
	larguracantcentral.val("");
	largurapasseio.val("");
}

function defaultSet(tipoposte, potfontelum){
				tipoposte.empty().append($("<option></option>").val("-1").html("Tipo de poste"));
                tipoposte.append($("<option></option>").val("Concreto Duplo T").html("Concreto Duplo T"));
                tipoposte.append($("<option></option>").val("Concreto Circular").html("Concreto Circular"));
                tipoposte.append($("<option></option>").val("Madeira").html("Madeira"));
                tipoposte.append($("<option></option>").val("Metalico").html("Metálico"));
                tipoposte.val("-1");
                potfontelum.empty().append($("<option></option>").val("-1").html("Potência da fonte luminosa (W)"));
                potfontelum.append($("<option></option>").val("6").html("6W"));
                potfontelum.append($("<option></option>").val("35").html("35W"));
                potfontelum.append($("<option></option>").val("40").html("40W"));
                potfontelum.append($("<option></option>").val("54").html("54W"));
                potfontelum.append($("<option></option>").val("55").html("55W"));
                potfontelum.append($("<option></option>").val("58").html("58W"));
                potfontelum.append($("<option></option>").val("70").html("70W"));
                potfontelum.append($("<option></option>").val("80").html("80W"));
                potfontelum.append($("<option></option>").val("86").html("86W"));
                potfontelum.append($("<option></option>").val("100").html("100W"));
                potfontelum.append($("<option></option>").val("125").html("125W"));
                potfontelum.append($("<option></option>").val("127").html("127W"));
                potfontelum.append($("<option></option>").val("150").html("150W"));
                potfontelum.append($("<option></option>").val("250").html("250W"));
                potfontelum.append($("<option></option>").val("350").html("350W"));
                potfontelum.append($("<option></option>").val("400").html("400W"));
                potfontelum.val("-1");
}

function comumCurto(tipobraco, projbraco, altposte, qtdelum, tipoposte, qtdefontelum, tiporeator, tipoalimentacao, altinstlum, tiporele, ilumdest, tipolum, tipofontelum, potfontelum, mun ){
				tipobraco.val("Curto");
                projbraco.val("1.65");
                altposte.val("11");
                qtdelum.val("1");
                tipoposte.val("Concreto Circular");
                qtdefontelum.val("1");
                tiporeator.val("Interno");
                tipoalimentacao.val("Aereo");
                altinstlum.val("7");
                tiporele.val("Integrado na luminaria");
                ilumdest.val("1");
                tipolum.val("Integrada policarbonato");
                tipofontelum.val("Sodio");
                potfontelum.val("100");
                mun.val("Belo Horizonte");
}

function comumMedio(tipobraco, projbraco, altposte, qtdelum, tipoposte, qtdefontelum, tiporeator, tipoalimentacao, altinstlum, tiporele, ilumdest, tipolum, tipofontelum, potfontelum, mun ){
				tipobraco.val("Medio");
                projbraco.val("2.92");
                altposte.val("11");
                qtdelum.val("1");
                tipoposte.val("Concreto Circular");
                qtdefontelum.val("1");
                tiporeator.val("Interno");
                tipoalimentacao.val("Aereo");
                altinstlum.val("8");
                tiporele.val("Integrado na luminaria");
                ilumdest.val("1");
                tipolum.val("Integrada policarbonato");
                tipofontelum.val("Sodio");
                potfontelum.val("150");
                mun.val("Belo Horizonte");
}

function comumLongo(tipobraco, projbraco, altposte, qtdelum, tipoposte, qtdefontelum, tiporeator, tipoalimentacao, altinstlum, tiporele, ilumdest, tipolum, tipofontelum, potfontelum, mun ){
				tipobraco.val("Longo");
                projbraco.val("5.6");
                altposte.val("14");
                qtdelum.val("1");
                tipoposte.val("Concreto Circular");
                qtdefontelum.val("1");
                tiporeator.val("Interno");
                tipoalimentacao.val("Aereo");
                altinstlum.val("12");
                tiporele.val("Integrado na luminaria");
                ilumdest.val("1");
                tipolum.val("Integrada policarbonato");
                tipofontelum.val("Sodio");
                potfontelum.val("400");
                mun.val("Belo Horizonte");
}

function comumRodovia(tipobraco, altposte, qtdelum, tipoposte, qtdefontelum, tiporeator, tipoalimentacao, altinstlum, tiporele, ilumdest, tipolum, tipofontelum, potfontelum, mun ){
				tipobraco.val("Especial");
                altposte.val("14");
                qtdelum.val("2");
                tipoposte.val("Metalico");
                qtdefontelum.val("1");
                tiporeator.val("Interno");
                tipoalimentacao.val("Subterraneo");
                altinstlum.val("12");
                tiporele.val("Comando em grupo");
                ilumdest.val("1");
                tipolum.val("Integrada vidro");
                tipofontelum.val("Sodio");
                potfontelum.val("400");
                mun.val("Belo Horizonte");
}

function limpar(projbraco, tipobraco, tipolum, tipofontelum, potfontelum, qtdefontelum, pottotfontelum, carginsttotuip, tiporeator, tiporele, tipoalimentacao, tipoposte, altposte, altinstlum, mun, reg, bair, classilum, log, cep, codlog, ilumdest, nomelocaldestaq, qtdelum, med, lat, lng, deletarinfo, buttonalterar, buttoncadastrar, obs, codilumpk, distmeddoispostes, tipoposteacao, larguravia, larguracantcentral, largurapasseio, msucesso, malerta, merro){
	projbraco.val("");
	tipobraco.val("-1");               
	tipolum.val("-1");                
	tipofontelum.val("-1");                              
	potfontelum.val("-1");
	qtdefontelum.val("-1");
	pottotfontelum.val("");
	carginsttotuip.val("");
	tiporeator.val("-1");
	tiporele.val("-1");
	tipoalimentacao.val("-1");
	tipoposte.val("-1");
	altposte.val("");
	altinstlum.val("");
	mun.val("");
	reg.val("");
	bair.val("");
	classilum.val("-1");
	log.val("");
	cep.val("");
	codlog.val("");
	ilumdest.val("-1");
	nomelocaldestaq.val("");
	qtdelum.val("-1");
	med.val("");
	lat.val("");
	lng.val("");           
	deletarinfo.fadeOut();
	buttonalterar.fadeOut();
	buttoncadastrar.fadeIn(1000);
	obs.val("");
	codilumpk.val("");
	distmeddoispostes.val("");
	tipoposteacao.val("-1");
	larguravia.val("");
	larguracantcentral.val("");
	largurapasseio.val("");
 setTimeout(function () {
	 msucesso.fadeOut();
	 malerta.fadeOut();
	 merro.fadeOut();
 }, 3000);
}
   
   
 function trocarLum(qtdelum, qtdefontelum){
	  if (qtdelum.val() == "-1") {
			qtdefontelum.val("-1");
		}else if (qtdelum.val() == "1") {
			qtdefontelum.val("1");
		}else if (qtdelum.val() == "2") {
			qtdefontelum.val("2");
		}else if (qtdelum.val() == "3") {
			qtdefontelum.val("3");
		}else if (qtdelum.val() == "4") {
			qtdefontelum.val("4");
		}else if (qtdelum.val() == "5") {
			qtdefontelum.val("5");
		}else if (qtdelum.val() == "6") {
			qtdefontelum.val("6");
		}else if (qtdelum.val() == "7") {
			qtdefontelum.val("7");
		}else if (qtdelum.val() == "8") {
			qtdefontelum.val("8");
		}else if (qtdelum.val() == "9") {
			qtdefontelum.val("9");
		} else if (qtdelum.val() == "10") {
			qtdefontelum.val("10");
		}
 }
 
 function trocarPosteEAli(tipoposte, tipoalimentacao){
	 if (tipoposte.val() == "Concreto Duplo T" || tipoposte.val() == "Concreto Circular" || tipoposte.val() == "Madeira") {
		tipoalimentacao.val("Aereo");
	} else if (tipoposte.val() == "Metalico") {
		tipoalimentacao.val("Subterraneo");
	} else if (tipoposte.val() == "-1") {
		tipoalimentacao.val("-1");
	}
 }
 
 function lumReles(tipolum, tiporeator, tiporele){
	 if (tipolum.val() == "Integrada policarbonato" || tipolum.val() == "Integrada vidro"){
		 tiporeator.val("Interno");
		 tiporele.val("Integrado na luminaria");
	 } else if (tipolum.val() == "-1") {
		 tiporeator.val("-1");
		 tiporele.val("-1");
	 } else if (tipolum.val() == "Corpo unico aberta" || tipolum.val() == "Corpo unico fechada com vidro" || tipolum.val() == "Corpo unico fechada com policarbonato") {
		 tiporeator.val("Externo");
		 tiporele.val("No poste");
	} else if (tipolum.val() == "Petalar" || $("#<%=ddlTipoLum.ClientID %>").val() == "Outros") {
		tiporeator.val("-1");
		tiporele.val("-1");
	} else if (tipolum.val() == "Decorativa esferica" || tipolum.val() == "Decorativa semi-esférica") {
		tiporeator.val("-1");
		tiporele.val("Comando em grupo");
	}
 }
 

 function trocaRele(tiporele, tiporeator){
	 if (tiporele.val() != "Integrado na luminaria")
		{ 
		   if (tiporeator.val() == "Interno")
			{
				tiporeator.val("-1");
			}
		}
		else if (tiporele.val() == "Integrado na luminaria")
		{ 
		   if (tiporeator.val() == "Externo")
			{
				tiporeator.val("Interno");
		   }
		else if (tiporele.val() == "Integrado na luminaria")
		   {
			   tiporeator.val("Interno");
		   }
		}
 }
 
 function trocaReator(tiporele, tiporeator){
	 if (tiporeator.val() == "Interno")
		{
			tiporele.val("Integrado na luminaria");
		}
		else if (tiporeator.val() == "-1") {
			tiporele.val("-1");
		}
		else if (tiporeator.val() == "Externo") {
			if (tiporele.val() == "Integrado na luminaria")
			{
				tiporele.val("-1");
			}
		}
 }
 
	function selectiluinfo(tipobraco, projbraco, tipolum, tipofontelum, potfontelum, qtdefontelum, pottotfontelum, carginsttotuip, tiporeator, tiporele, tipoalimentacao, tipoposte, altposte, altinstlum, mun, reg, bair, classilum, log, cep, codlog, ilumdest, nomelocdestaq, qtdelum, med, lat, lng, observacao) {
		if (tipobraco) {
			this.tipobraco.val(tipobraco);
		}
		if (projbraco) {
			this.projbraco.val(projbraco);
		}
		if (tipolum) {
			this.tipolum.val(tipolum);
		}
		if (tipofontelum) {
			//fonteLuminosa(tipofontelum);
			this.tipofontelum.val(tipofontelum);
		}
		if (potfontelum) {
			this.potfontelum.val(potfontelum);
		}	   
		if (qtdefontelum) {
			this.qtdefontelum.val(qtdefontelum);
		}	   
		if (pottotfontelum ) {
			this.pottotfontelum.val(pottotfontelum);
		}
		if (carginsttotuip) {
			this.carginsttotuip.val(carginsttotuip);
		}  
		if (tiporeator) {
			this.tiporeator.val(tiporeator);
		}
		if (tiporele) {
			this.tiporele.val(tiporele);
		}
		if (tipoalimentacao) {
			this.tipoalimentacao.val(tipoalimentacao);
		}
		if (tipoposte) {
			this.tipoposte.val(tipoposte);
		}
		if (altposte) {
			this.altposte.val(altposte);
		}
		if (altinstlum) {
			this.altinstlum.val(altinstlum);
		}
		if (mun) {
			this.mun.val(mun);
		}
		if (reg) {
			this.reg.val(reg);
		}
		if (bair) {
			this.bair.val(bair);
		}
		if (classilum) {
			this.classilum.val(classilum);
		}
		if (log) {
			this.log.val(logradouro);
		}
		if (cep) {
			this.cep.val(cep);
		}
		if (codlog) {
			this.log.val(codlog);
		}
		if (ilumdest) {
			this.ilumdest.val(ilumdest);
		}
		else
		{
			ilumdest.val("1");
		}
		if (nomelocdestaq ) {
			this.nomelocaldestaq.val(nomelocdest);
		}
		if (qtdelum) {
			this.qtdelum.val(qtdelum);
		}
		if (med) {
			this.med.val(medicao);
		}
		if (lat) {
			this.lat.val(lat);
		}
		if (lng) {
			this.lng.val(lng);
		}
		if (observacao) {
			this.observacao.val(observacao);
		}
	}

		function chamaAjax(metodo,data,op)
		{
			
			 $.ajax({
				url: "Classes/service.asmx/" +metodo,
				type: "POST",
				data: data,
				contentType: "application/json; charset=utf-8",
				dataType: "json",
				success: function (data2) {
					 switch(op)
					 {
						 case 1:
							geocode(data2.d);
							break;
						case 2:
							getlista();
							break;
						case 3:	
							getrows();
							break;
						case 4:
							deletePoste(data2.d);
							break;
						//case 5:
							//getiluminacao(data2.d);
							//break;
						default:
							alert("ERROR");
					 }
						
				},
				failure: function (response) {
				
					alert(response.d);
				},
				error: function (response) {
				
					alert(response.d);
				}
			});
		}
		
		function geocode(info){
			log.val(info[1]);
			mun.val(info[3]);
			cep.val(info[5]);
		}
		
		function getlista(){	

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
		}
		
		function getrows(){
			numrows= data2.d;
		}
		
		function deletePoste(data){
			if (parseInt(data) > 0) {
					alert('Informações Deletadas!')
				}
				else {
					alert('Codigo não encontrado. Tente novamente!')
				}
		}
		
	
		
		function sucesso(menssagem)
		{
			this.projbraco.val(menssagem)
		}
