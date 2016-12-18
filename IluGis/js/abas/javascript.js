function openmedicao(evt, id) {
    // Declare all variables
   
    var i, tabcontent, tablinks;

    // Get all elements with class="tabcontent" and hide them
    tabcontent = document.getElementsByClassName("tabcontent");
    for (i = 0; i < tabcontent.length; i++) {
        tabcontent[i].style.display = "none";
    }

    // Get all elements with class="tablinks" and remove the class "active"
    tablinks = document.getElementsByClassName("tablinks");
    for (i = 0; i < tablinks.length; i++) {
        tablinks[i].className = tablinks[i].className.replace(" active", "");
    }

    // Show the current tab, and add an "active" class to the link that opened the tab
    document.getElementById('featuregeo').style.display = "block";
    evt.currentTarget.className += " active";
   
    if (id == '1') {//1 ponto
        
        $("#featuregeo").show(1000)

        $("#btnplus").attr("onclick", "createPointMeasurement();")
        $("#divPoliInfo").hide(1000);
        $("#divLinhaInfo").hide(1000);
        $("#divPontoInfo").show(1000);

        closeMeasurement();
        populateList(1);
    }
    else if (id == '2')// 2 linha
    {
       
        $("#featuregeo").show(1000)
        $("#btnplus").attr("onclick", " createLineMeasurement();")
        $("#divPontoInfo").hide(1000);
        $("#divPoliInfo").hide(1000);
        $("#divLinhaInfo").show(1000);
        closeMeasurement();
        populateList(2);
    }
    else if (id == '3')// 3 poligono
    {
        

        $("#featuregeo").show(1000)
        $("#btnplus").attr("onclick", "createSurfaceMeasurement();")
        $("#divPontoInfo").hide(1000);
        $("#divLinhaInfo").hide(1000);
        $("#divPoliInfo").show(1000);
        closeMeasurement();
        populateList(3);
    }
}