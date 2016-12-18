   
var start_x;
var start_y;
var openmode = 0;
var imagecount;
var api=null;

var shared = "https://globespotter.cyclomedia.com/application/?ImageId=";
var gimageID = "";
var gyaw = "";
var gpitch = "";
var ghfov = "";
var measurementList;
// list component for level 2
//var measurementPointList = document.getElementsBy.getElementById("measurementPointList");
// list component for level 3
var observationList = document.getElementById("observationList");

// ids for level 1
var measurementIDs = [];
// ids for level 2
var measurementPointIDs = [];
// ids for level 3
var observationImageIDs = [];




function hst_apiReady(readyState)
{

    //alert("API is ready for use.");
    
    openinicial();
    measurementList = document.getElementById("measurementList");
    
	    
      
    //openImage(globaID)


}
function openinicial() {


    if (apiReady) {
        openNearestImage("610909.67,7789634.28")
    }

}
function returnURL()
{
    var url = shared + gimageID + "&Yaw=" + gyaw + "&Pitch=" + gpitch + "&HFov=" + ghfov;
    
    return url;
}

function apiReady()//verifica se API esta inicializada
{
    var ready = false;
    api = document.getElementById("japi");
    if (api != null)
    {
        ready = api && api.getAPIReadyState();

        if (!ready) {
            alert("API not ready.");
        }
    }
   
   

    return ready;
}
function getURL()//captura as coordenadas da URL passadas via GET
{
    var x;
    var y;
    var query = window.location.search.substring(1);
    var vars = query.split("&");
    for (var i=0;i<vars.length;i++) {
        var pair = vars[i].split("=");
        if(pair[0] == 'x')
        {
            x= pair[1];
        }
        else if(pair[0] == 'y')
        {
            y= pair[1];
        }
    }
               
    return x+','+y;       
}
function openNearestImage(value) {//função abrir imagem aparti de uma coordenada
    if (apiReady()) {
        var query = value; //coordenadas
        var maxLocations = 1;

        if (!query || query == "") {
            alert("aInvalid input.");
        }
        else {
            try {
                api.openNearestImage(query, maxLocations);
                
            }
            catch (error) {
                alert("Error while opening an image: " + error);
            }
        }
    }
}

function openImage(value) {//função abrir imagem aparti do ID da imagem
    if (apiReady()) {
        var query = value;

        if (!query || query == "") {
            alert("Invalid input.");
        }
        else {
            var viewerParams = new ViewerParameters(110, 4, 100);

            try {

                api.setCloseViewerEnabled(true);
                api.setActiveViewerReplaceMode(true); // parametro para abrir a cyclorama na mesma viewer
                api.setViewerToolBarVisible(true);
                api.setViewerTitleBarVisible(true);
                api.openImage(query, viewerParams);
      
            }
            catch (error) {
                alert("Error while opening an image: " + error);
            }
        }
    }
}
function hst_openNearestImageResult(request, opened, imageID, position) {//função é chamda após abrir uma imagem atravez de coordenadas openNerestImage()
    gimageID = imageID;

}


function hst_viewChanged(viewerID, yaw, pitch, hFov) {//atualizar angulo toda vez que movimenta a view

    gyaw = yaw;
    gpitch = pitch;
    ghfov = hFov;



}
/******inicio função para enviar angulo ao mapa************************************************************************/ 

//$(document).ready(function () {
//    var lastyaw = 0;
    
//    $("#flashDiv").mouseup(function () {

        
//        if (!((lastyaw-22) <= gyaw && (lastyaw + 22) >= gyaw)) {
//            //window.opener.updateGlobespotterAngle(gyaw);
//            lastyaw = gyaw;
//        }
//        /****************************************************************************fim função para enviar angulo ao mapa**/ 


//    });

//    //    $(window).on("load", function () {
//    //        //openNearestImage(getURL());
//    //    });

//});

function hst_viewClicked(viewerID, c0, c1) {
   
}




function selectMeasurement() {
    if (apiReady()) {
        var entityID = measurementIDs[measurementList.selectedIndex];
        api.setFocusEntity(entityID);
    }
}
function createPointMeasurement() {//cria feição ponto
    clearData(); //limpa dados dos compenetes na div de informação
    if (apiReady()) {
        var entityID = api.addPointMeasurement("Point measurement");

        api.openMeasurement(entityID);

        // create first (and only) point
        api.addMeasurementPoint(entityID);

        api.setFocusEntity(entityID);
        iniciarmedicao();
        populateList(1);
        
       
    }
}
function createLineMeasurement() {//cria feição de linha
    clearData(); //limpa dados dos compenetes na div de informação
    if (apiReady()) {
        
        var entityID = api.addLineMeasurement("Line measurement");

        api.openMeasurement(entityID);

        api.setFocusEntity(entityID);
       
        iniciarmedicao();
       
        populateList(2);
        
        if (!api.getMeasurementSeriesModeEnabled()) {
            api.setMeasurementSeriesModeEnabled(true);
            //document.getElementById("seriesModeToggle").checked = api.getMeasurementSeriesModeEnabled();
        }
    }
}
function createSurfaceMeasurement() {//cria feição poligono
    clearData(); //limpa dados dos compenetes na div de informação
    if (apiReady()) {
        var entityID = api.addSurfaceMeasurement("Surface measurement");

        api.openMeasurement(entityID);

        api.setFocusEntity(entityID);
        iniciarmedicao()
        populateList(3);
        if (!api.getMeasurementSeriesModeEnabled()) {
            api.setMeasurementSeriesModeEnabled(true);
            //document.getElementById("seriesModeToggle").checked = api.getMeasurementSeriesModeEnabled();
        }
       
    }
}
function updateMeasurementIDs(value) {//atualiza lista de IDs
    var i;
    var measurementData;

    for (i = measurementList.options.length - 1; i >= 0; i--) {//limpa todos os valores da lista 
        measurementList.remove(i);
    }
   
    for (i = 0; i < measurementIDs.length; i++) {
        measurementData = api.getEntityData(measurementIDs[i]);
        if (value == 1) {
            if (measurementData.type == "pointMeasurement") {
                var t = measurementIDs[i];
                measurementList.options[measurementList.options.length] = new Option(t, t);
            }
        }
        if (value == 2) {
            if (measurementData.type == "lineMeasurement") {
                var t = measurementIDs[i];
                measurementList.options[measurementList.options.length] = new Option(t, t);
            }
        }
        if (value == 3) {
            if (measurementData.type == "surfaceMeasurement") {
                var t = measurementIDs[i];
                measurementList.options[measurementList.options.length] = new Option(t, t);
            }
        }
        if (value == 4) {
            
            var t = measurementIDs[i];
            measurementList.options[measurementList.options.length] = new Option(t, t);
            
        }
       

    }
    if (api.getFocusEntity() != -1) {
        var i;
            
        for (i = 0; i < measurementList.options.length; i++) {

            if (api.getFocusEntity() == measurementList.options[i].value) {
                if (measurementList.options.length > i) {
                    measurementList.selectedIndex = i;
                    break;
                }
            }
            else {

                measurementList.selectedIndex = measurementList.options.length - 1;
            }

        }



    }
                     
}
function removeMeasurement(botao) {//função para deletar a feição selecionada no select
    clearData(); //limpa dados dos compenetes na div de informação
    if (apiReady()) {
        if (measurementList.selectedIndex != -1) {
            var entityID = measurementList.options[measurementList.selectedIndex].value;
            api.cancelMeasurement(entityID);
            if (botao.id == "removePonto") {
                populateList(1); //atualiza select as feição existentes de acordo com o parametro informado
            }
            else if (botao.id == "removeLinha") {
                populateList(1); //atualiza select as feição existentes de acordo com o parametro informado
            }
            else if (botao.id == "removePoli") {
                populateList(1); //atualiza select as feição existentes de acordo com o parametro informado
            }
            else {
                populateList(4);
            }
            
            
        }
        else {
            alert("Não possui medição selecionada!");
        }
    }
}
function removeAllMeasurement() {
    if (confirm("Deseja apagar todas as medições?")) {
        clearData(); //limpa dados dos compenetes na div de informação
        var measurementIDs = api.getMeasurementIDs();
        var entityID;
        if (apiReady()) {
            if (measurementIDs.length>0) {
                for (var i = 0; i < measurementIDs.length; i++) {
                    entityID = measurementIDs[i];
                    api.cancelMeasurement(entityID);
                    populateList(4); //atualiza select as feição existentes
                }
               

            }
            else {
                alert("Não possui medição selecionada!");
            }
        }

    }

}
function closeMeasurement() {//função para fechar a feição selecionada no select
    clearData();//limpa dados dos compenetes na div de informação
    if (apiReady()) {
        if (measurementList.selectedIndex != -1) {//verifica se o select tem algum item selecionado
            var entityID = measurementList.options[measurementList.selectedIndex].value;// captura o id da medição

            if (!api.closeMeasurement(entityID)) {
                //alert("Measurement could not be closed!");
            }
            
            
        }
        else {
            //alert("Não possui medição selecionada!");
        }
    }
}
function openMeasurement() {//função para abrir a feição selecionada no select
    clearData(); //limpa dados dos compenetes na div de informação
    if (apiReady()) {
        if (measurementList.selectedIndex != -1) {
            var entityID = measurementList.options[measurementList.selectedIndex].value;
           
            if (!api.openMeasurement(entityID)) {
                alert("Selecione uma medição!");
            }
            else {
                getMeasurementData(); //seta as informações da medição na div informação
                //getconfianca(entityID); //seta confiança da medição selecionada
            }
        }
        else {
            alert("Não possui medição selecionada!");
        }
    }
}
function clearData() {//limpa componetes da div informação

    
}
function getMeasurementData() {//função seta as informações da medição na div informação
    if (apiReady()) {
        
    }
}
function toggleVerticalHeight() {
    if (apiReady()) {
        if (measurementList.selectedIndex != -1) {
            var teste;
            var entityID = measurementList.options[measurementList.selectedIndex].value;
            teste = !api.getMeasurementVerticalHeightEnabled(entityID)
            api.setMeasurementVerticalHeightEnabled(entityID, !api.getMeasurementVerticalHeightEnabled(entityID));
            teste = api.getMeasurementVerticalHeightEnabled(entityID)
            if (api.getMeasurementVerticalHeightEnabled(entityID)) {
                api.getMeasurementVerticalHeightLevel(entityID);
            }
        }
    }
}
function toggleSeriesMode() {//habilita/desabilita modo de medição em serie
    if (apiReady()) {
        api.setMeasurementSeriesModeEnabled(!api.getMeasurementSeriesModeEnabled());
    }
}
function toggleDirection() {
    if (apiReady()) {
        if (measurementList.selectedIndex != -1) {
            var entityID = measurementList.options[measurementList.selectedIndex].value;
            api.setMeasurementDirectionEnabled(entityID, !api.getMeasurementDirectionEnabled(entityID));

        }
    }
}
function setMeasurementDirection() {
    if (apiReady()) {
        if (measurementList.selectedIndex != -1) {
            var entityID = measurementList.options[measurementList.selectedIndex].value;
            api.setMeasurementDirection(entityID, directionText.value);
        }
    }
}
function toggleSmartClickMode() {//habilita/desabilita click inteligente
    if (apiReady()) {
        api.setMeasurementSmartClickModeEnabled(!api.getMeasurementSmartClickModeEnabled());
    }
}

function addMeasurementPoint() {
    if (apiReady()) {
        if (measurementList.selectedIndex != -1) {
            var entityID = measurementList.options[measurementList.selectedIndex].value;

            var pointID = api.addMeasurementPoint(entityID);
            if (pointID == -1) {
                alert("Measurement point could not be added!");
            }
        }
        else {
            alert("No measurement selected!");
        }
    }
}
function removeMeasurementPoint() {
    if (apiReady()) {

        if (measurementList.selectedIndex != -1 && measurementPointList.selectedIndex != -1) {
            var entityID = measurementList.options[measurementList.selectedIndex].value;
            var pointID = measurementPointList.options[measurementPointList.selectedIndex].value;

            if (api.removeMeasurementPoint(entityID, pointID)) {
                measurementPointIDs.splice(measurementPointIDs.indexOf(pointID), 1);
                updateMeasurementPointIDs();
            }
            else {
                alert("Measurement point could not be removed!");
            }

        }
        else {
            alert("No measurement or no measurement point selected!");
        }
    }
}
function openMeasurementPoint() {
    if (apiReady()) {
        if (measurementList.selectedIndex != -1 && measurementPointList.selectedIndex != -1) {
            var entityID = measurementList.options[measurementList.selectedIndex].value;
            var pointID = measurementPointList.options[measurementPointList.selectedIndex].value;
            if (!api.openMeasurementPoint(entityID, pointID)) {
                alert("Measurement point could not be opened!")
            }
        }
        else {
            alert("No measurement or no measurement point selected!");
        }
    }
}
function closeMeasurementPoint() {
    if (apiReady()) {
        if (measurementList.selectedIndex != -1 && measurementPointList.selectedIndex != -1) {
            var entityID = measurementList.options[measurementList.selectedIndex].value;
            var pointID = measurementPointList.options[measurementPointList.selectedIndex].value;
            if (!api.closeMeasurementPoint(entityID, pointID)) {
                alert("Measurement point could not be closed!")
            }

        }
        else {
            alert("No measurement or no measurement point selected!");
        }
    }
}








function hst_viewLoaded()
{
    //alert ("preview");
}





function ViewerParameters(yaw, pitch, hFov, dateFrom, dateTo)
{
    this.yaw = yaw;
    this.pitch = pitch;
    this.hfov = hFov;
    this.datefrom = dateFrom;
    this.dateto = dateTo;
}

function hst_mapInitialized()
{



    // perform any pending searches
    switch (openmode)
    {
        case 3:
            var coord = (start_x + ' '+ start_y);
            document.getElementById("japi").openNearestImage(coord , imagecount);//, -1);
            break;
    }

    document.getElementById("japi").zoomMapToFeatureLevel();

    // enable oblique mode
    document.getElementById("japi").setObliqueModeEnabled(true);
    document.getElementById("japi").setDividerDrag(true);
    document.getElementById("japi").setDividerPosition(0.50);
    document.getElementById("japi").setShowMap(true);
}


function Extent
(
	xmin,
	ymin,
	xmax,
	ymax
)
{
    this.xmin = xmin;
    this.ymin = ymin;
    this.xmax = xmax;
    this.ymax = ymax;
}
function OSM
(
	url,
	maxExtent,
	maxResolution,
	maxZoomLevel,
	featureZoomLevel
)
{
    this.url = url;
    this.maxExtent = maxExtent;
    this.maxResolution = maxResolution;
    this.maxZoomLevel = maxZoomLevel;
    this.featureZoomLevel = featureZoomLevel;

}




function start()
{
    //bepaal openmode


    var obliek =  gup( 'obliek' );
    var address =  gup( 'address' );
    var imgID =  gup( 'imageid' );
    var posx =  gup( 'posx' );
    if (imgID > " ")
    {
        openmode = (1);
    }
    else if (address > " ")
    {
        openmode = (2);
    }

    else if (posx > 0)
    {
        openmode = (3);
    }


    var jaar = gup( 'year' );
    if (jaar > 0)
    {
        jaarbegin =( jaar + "-01-01");
        jaareind = (jaar + "-12-31");
        document.getElementById("japi").setUseDateRange(true);
        document.getElementById("japi").setDateFrom(jaarbegin);
        document.getElementById("japi").setDateTo(jaareind);
        var viewerParams = new ViewerParameters(0, 0.0, 90.0);
    }

    //bepaal aantal te openen cyclorama's

    var cyc = gup( 'cyclo' );
    //alert (cyc);
    imagecount =1
    if ( !cyc)
    {
        imagecount= 1;
    }
    else
    {
        imagecount = cyc
    }


    switch (openmode)
    {
        case 1:

            document.getElementById("japi").openImage(imgID, viewerParams);//, -1);

            break;
        case 2:

            address = decodeURI(address);

            document.getElementById("japi").openNearestImage(address,imagecount);//, -1);

            break;
        case 3:
            start_x =  gup( 'posx' );
            start_y =  gup( 'posy' );

            if( obliek == 0 )
            {
                var coord = (start_x + ' '+  start_y);
                //alert (coord);
                document.getElementById("japi").openNearestImage(coord , imagecount);//, -1);
            }
            else
            {
                // wait until map is ready
            }
            break;
    }

    if (obliek > 0 )
    {

        var extent = new Extent(-23500, 289000, 316500, 629000);
        var osm = new OSM
            (
                "https://atlas.cyclomedia.com/openstreetmap/",
                extent,
                1328.125,
                12,
                11
              );

        document.getElementById("japi").setBaseLayer ("OSM", 3, "EPSG:28992", osm);
        document.getElementById("japi").setMapEnabled(true);
        //document.getElementById("japi").setMapCenter( 202995, 503658 );


    }

}

// Settings
function toggleAngles() {
    if (apiReady()) {
        api.setMeasurementAnglesVisible(!api.getMeasurementAnglesVisible());
    }
}

function toggleArea() {
    if (apiReady()) {
        api.setMeasurementAreaVisible(!api.getMeasurementAreaVisible());
    }
}

function toggleDistances() {
    if (apiReady()) {
        api.setMeasurementDistancesVisible(!api.getMeasurementDistancesVisible());
    }
}

function toggleSlopes() {
    if (apiReady()) {
        api.setMeasurementSlopesVisible(!api.getMeasurementSlopesVisible());
    }
}

function toggleHideOverlaysWhenMeasuring() {
    if (apiReady()) {
        api.setHideOverlaysWhenMeasuring(!api.getHideOverlaysWhenMeasuring());
    }
}

function toggleDistancesBetween() {
    if (apiReady()) {
        api.setMeasurementDistancesBetweenMeasurementsEnabled(!api.getMeasurementDistancesBetweenMeasurementsEnabled());
    }
}


function populateList(value) {
    if (apiReady()) {
        // Initialize measurementIDs and populate GUI component
        measurementIDs = api.getMeasurementIDs();
       
        updateMeasurementIDs(value);

      

    }


}
                         
function iniciarmedicao() {
    if (apiReady()) {
        // Apply current values to checkboxes                               
                                 
                                                                
        ////document.getElementById("distancesToggle").checked = api.getMeasurementDistancesVisible();
        //document.getElementById("anglesToggle").checked = api.getMeasurementAnglesVisible();
        //document.getElementById("slopesToggle").checked = api.getMeasurementSlopesVisible();
        //document.getElementById("areaToggle").checked = api.getMeasurementAreaVisible();
        //document.getElementById("hideToggle").checked = api.getHideOverlaysWhenMeasuring();
        document.getElementById("smartClickModeToggle").checked = api.getMeasurementSmartClickModeEnabled();
        //document.getElementById("distancesBetweenToggle").checked = api.getMeasurementDistancesBetweenMeasurementsEnabled();
        populateList(4);
                                
                                 
                                 

                                 
    }

}






