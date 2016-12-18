<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="help.aspx.cs" Inherits="IluGis.help" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
 </asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="body" runat="server"> 
    <form id="form1" runat="server">
        <div>
        <h1 style="text-align: center; float:none; height: 50px;">Ajuda
            <img style="width: 40px;" src="img/help.png" />
        </h1>
        
        </div>
    <div class="col-md-10 col-md-offset-1 col-sm-offset-1 col-xs-offset-1">
        <div class="row">
            <img style="width: 960px;" class="img-responsive" src="img/help/ajuda.jpg" />
        </div>      
        <div class="row" id="equipe">
        <h2>
            <a name="equipe">Equipe</a>
        </h2>
            <img style="width: 960px;" class="img-responsive" src="img/help/equipe.jpg" />
        </div>

        <div class="row" id="postes_padroes">
        <h2>
            <a name="postes_padroes">Postes Padrões</a>
        </h2>
           <p>Esses botões facilitam no preenchimento dos campos. Eles contêm cada um, padrões de postes que foram mais cadastrados no sistema. Clique em um deles e os campos do formulário serão preenchidos automaticamente. Caso haja alguma diferença entre o poste padrão e o que você está cadastrando basta alterar manualmente. <br />Padrões:<br />Braço Curto<br />Braço Médio<br />Braço Longo<br />Poste em Rodovias</p>
           <img class="img-responsive" src="img/help/postes_padroes.jpg" />
        </div>

        <div class="row" id="codigo_iluminacao">
        <h2>
            <a name="codigo_iluminacao">Código de Iluminação</a>
        </h2>
            <img class="img-responsive" src="img/help/cod_ilum.jpg" /> 
        </div>

        <div class="row" id="tipo_braco">
        <h2>
            <a name="tipo_de_braco">Tipo de braço</a>          
        </h2>
            <p>Braço Curto: 1.65m<br />Braço Médio: 2.9m a 3.8m<br />Braço Longo: 5.6m</p>
            <img class="img-responsive" src="img/help/braco_poste.jpg" />
            </div>

         <div class="row" id="projecao_braco">
        <h2>
            <a name="projecao_do_braco">Projeção de braço (em m)</a>          
        </h2>
            <p>É a distância em metros do braço, que vai desde o ponto onde está fixado no poste até até o ponto de ligação com a luminária.</p>
            <img style="float: left;" class="img-responsive" src="img/help/projecao_braco.png" />
        </div>

        <div class="row" id="tipo_poste">
        <h2>
            <a name="tipo_de_poste">Tipo de poste</a>
        </h2>
            <img style="float: left;" class="img-responsive" src="img/help/tipo_postes.jpg" />
        </div>

         <div class="row" id="altura_poste">
        <h2>
            <a name="altura_do_poste">Altura do poste</a>            
        </h2>
            <p>A altura do poste é dada do ponto de encaixe do poste com o sorte ou braço, até o seu final que se encontrada engastado (debaixo do solo) ou flangeado (preso em um bloco de concreto ou metal).</p>
            <img style="float: left;" class="img-responsive" src="img/help/altura_poste.jpg" />
        </div>

        <div class="row" id="quantidade_luminarias">
        <h2>
            <a name="quantidade_de_luminarias">Quantidade de luminárias</a>
        </h2>
            <p>Representa a quantidade de luminárias existentes naquele poste, lembrando que é diferente de fontes luminosas (lâmpadas), ou seja, uma luminária pode ter várias fontes luminosas dentro dela.</p>
            <img style="float: left;" class="img-responsive" src="img/help/qtde_luminarias.jpg" />
        </div>

        <div class="row" id="tipo_luminaria">
        <h2>
            <a name="tipo_de_luminaria">Tipo de luminária</a>
        </h2>
            <img style="width: 960px;" class="img-responsive" src="img/help/tipo_luminaria_1.jpg" />
            <br /><img style="width: 960px;" class="img-responsive" src="img/help/tipo_luminaria_2.jpg" /><br />
            <img style="width: 960px;" class="img-responsive" src="img/help/tipo_luminaria_3.jpg" />
        </div>

        <div class="row" id="tipo_rele">
        <h2>
            <a name="tipo_de_rele">Tipo de relé</a>
        </h2>
            <p>Relés fotoelétricos são destinados ao acionamento das fontes luminosas, vem em duas cores, azul (relé eletronico) e branco (relé convencional).<br /> Mas para nós só é importante identificar os tipos deles, que são: <br /><br />No poste<br />Comando em grupo<br />Integrado na luminária<br />Inexistente</p>
            <img style="float: left;" class="img-responsive" src="img/help/tipo_de_rele.jpg" />
        </div>

        <div class="row" id="tipo_reator">
        <h2>
            <a name="tipo_de_reator">Tipo de reator</a>
        </h2>
            <p>Reatores servem para controlar a corrente </p>
            <img style="float: left;" class="img-responsive" src="img/help/tipo_reator.jpg" />
        </div>

        <div class="row" id="quantidade_fontes_luminosas">
        <h2>
            <a name="quantidade_de_fontes_luminosas">Quantidade de fontes luminosas</a>      
        </h2>
            <p>A quantidade de fontes luminosas refere a quantidade de lâmpadas que o ponto de iluminação possui. Não confuda fontes luminosas com luminária, pois em uma luminária pode haver mais de uma fonte luminosa.</p>
        </div>        
        
        <div class="row" id="tipo_fonte_luminosa">
        <h2>
            <a name="tipo_de_fonte_luminaria">Tipo de fonte luminosa</a>         
        </h2>
            <p>Os tipos de fontes luminosas são:<br /><br />Vapor de sódio (o mais comum)<br />Vapor Metálico<br />Vapor de Mercúrio<br />Led</p>
            <img class="img-responsive" src="img/help/tipo_fonte_luminosa.jpg" />
        </div>

        <div class="row" id="potencia_fonte_luminosa">
        <h2>
            <a name="potencia_da_fonte_luminosa">Potência da fonte luminosa</a>
        </h2>
            <p>A potência está ligada com o consumo da lâmpada. Na luminária a potência vem descrita com a cor da fonte luminosa (amarela = sódio, verde = mercurio e branca = metálica).<br />Veja alguns exemplos de como a apotência aparece na luminária: <br /><br /> 4 = 40W<br />7 = 70W<br />8 = 80W<br />10 = 100W<br />15 = 150W<br />25 = 250W<br />35 = 350W<br />40 = 400W<br />125W<br />54W<br />55W<br />127W<br />58W<br />86W<br />6W<br /></p>
        </div>

        <div class="row" id="tipo_alimentacao">
        <h2>
            <a name="tipo_de_alimentacao">Tipo de alimentação</a>       
        </h2>
            <p>São dois os tipos de alimentação: Aérea: encontrada em bairros, a fiação fica exposta ao ar livre. <br />Subterrânea: Encontrada em centros e rodovias.</p>           
            <img style="float: left;" class="img-responsive" src="img/help/aerea_sub.jpg" />
        </div>

        <div class="row" id="altura_instalacao_luminaria">
        <h2>
            <a name="altura_da_instalacao_luminaria">Altura da instalaçao luminária</a>
        </h2>
            <p>A altura da instalação luminária é dada da luminária ao solo.</p>
            <img style="float: left;" class="img-responsive" src="img/help/altura_luminarias.jpg" />
        </div>

       <div class="row" id="classe_iluminacao">
         <h2>
            <a name="classe_de_iluminacao">Classe de iluminação</a>
         </h2>
            <p style="text-align: left;">As recomendações estão entre as classes V1 a V5 para veículos e P1 a P4 para pedestres. As classes são selecionadas de acordo com a função da via, da densidade de tráfego, da complexidade do tráfego, da separação do tráfego e da existência de facilidades para o controle do tráfego, como os sinais de trânsito – ABNT NBR 5101:2012.</p>       
            <img class="img-responsive" src="img/help/classe-Iluminacao.jpg" />
       </div>

        <div class="row" id="medicao">
        <h2>
            <a name="medicao">Medição</a>
        </h2>
            <br /><br /><br />
        </div>      
    </div>
    </form>
 </asp:Content>