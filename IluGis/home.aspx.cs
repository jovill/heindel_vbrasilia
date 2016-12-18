using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using IluGis.Classes;

namespace IluGis
{
    public partial class home : System.Web.UI.Page
    {

        validacao valida;
        protected void Page_Load(object sender, EventArgs e)
        {
            StringData webUserStringData = (StringData)Session["webuser"];

            if (Session["webuser"] != null)
            {
               
                hfPermissao.Value = webUserStringData.userPermission;
                hfLoginPK.Value = webUserStringData.userID;

                
            }
            else
            {
                Response.Write("<script>alert('Faça login para ter acesso ao sistema');</script>");
                Response.Redirect("~/login.aspx", true);
            }


        }
        protected void bntAlterar_Click(object sender, EventArgs e)
        {
            if (ddllocalidade.SelectedIndex != -1 && txtCodIluminacao.Text != "")
            {
                update();
            }
            else
            {
                Malerta.Visible = true;
                Malerta.InnerHtml = "<center><strong> Favor selecionar um ponto de iluminação cadastrado. </strong>";
            }

        }
        public void update()
        {
            valida = new validacao();

            info_ilum ilum = new info_ilum();

            ilum.cod_un_ilu_pub = valida.prepDB(hfCodilumPK.Value);
            ilum.tipo_braco = valida.prepDB(ddlTipoBraco.SelectedValue);
            ilum.proj_braco = valida.prepDB(txtProjBraco.Text.Replace(",", "."));
            ilum.tipo_luminaria = valida.prepDB(ddlTipoLum.SelectedValue);
            ilum.quant_luminarias = valida.prepDB(ddlQtdeLum.Text);
            ilum.tipo_fonte_luminaria = valida.prepDB(ddlTipoFonteLum.SelectedValue);
            ilum.potencia_fonte_lumi = valida.prepDB(ddlPotFonteLum.SelectedValue);
            ilum.quant_fontes_lumi = valida.prepDB(ddlQtdeFonteLum.SelectedValue);
            ilum.potencia_total_fonte_lumi = valida.prepDB(txtPotTotFonteLum.Text);
            ilum.carga_inst_total_un_ilum_pub = valida.prepDB(txtCargInsTotUIP.Text);
            ilum.tipo_reator = valida.prepDB(ddlTipoReator.SelectedValue);
            ilum.tipo_rele = valida.prepDB(ddlTipoRele.SelectedValue);
            ilum.tipo_alimentacao = valida.prepDB(ddlTipoAlimentacao.SelectedValue);
            ilum.tipo_poste = valida.prepDB(ddlTipoPoste.SelectedValue);
            ilum.altura_poste = valida.prepDB(txtAltPoste.Text.Replace(",", "."));
            ilum.altura_inst_lumi = valida.prepDB(txtAltInstLum.Text.Replace(",", "."));
            ilum.lat = valida.prepDB(txtLat.Text);
            ilum.lng = valida.prepDB(txtLng.Text);
            ilum.municipio = valida.prepDB(txtMun.Text);
            ilum.regional = valida.prepDB(txtReg.Text);
            ilum.bairro = valida.prepDB(txtBair.Text);
            ilum.classelumi = valida.prepDB(ddlClassIlum.SelectedValue);
            ilum.logradouro = valida.prepDB(txtLog.Text);
            ilum.cep = valida.prepDB(txtCEP.Text);
            ilum.cod_logradouro = valida.prepDB(txtCodLog.Text);
            ilum.ilum_destaq = valida.prepDB(ddlIlumDest.SelectedValue);
            ilum.nome_local_destaq = valida.prepDB(txtNomeLocDestaq.Text);
            ilum.medicao = valida.prepDB(txtMed.Text.Replace(",", "."));
            ilum.cod_login = hfLoginPK.Value;
            ilum.observacao = valida.prepDB(txtObservacao.Text);

            string menssagem = ilum.update();

            if (menssagem.Contains("sucesso"))
            {
                Msucesso.Visible = true;
                Msucesso.InnerHtml = "<center><strong> " + menssagem + " </strong>";
            }
            else
            {
                Merro.Visible = true;
                Merro.InnerHtml = "<center><strong> " + menssagem + " </strong>";
            }


        }



        protected void bntCadastrar_Click(object sender, EventArgs e)
        {
            if(ddllocalidade.SelectedIndex!=-1 && txtCodIluminacao.Text!="" && hfCodilumPK.Value!="")
            {
                cadastro();
            }
            else
            {
                Malerta.Visible = true;
                Malerta.InnerHtml = "<center><strong> Favor selecionar um ponto de iluminação cadastrado. </strong>";
            }
            
        }

        public void cadastro()
        {
            valida = new validacao();

            info_ilum ilum = new info_ilum();
            
            ilum.cod_un_ilu_pub = valida.prepDB(hfCodilumPK.Value);
            ilum.tipo_braco = valida.prepDB(ddlTipoBraco.SelectedValue);
            ilum.proj_braco = valida.prepDB(txtProjBraco.Text);
            ilum.tipo_luminaria = valida.prepDB(ddlTipoLum.SelectedValue);
            ilum.quant_luminarias = valida.prepDB(ddlQtdeLum.Text);
            ilum.tipo_fonte_luminaria = valida.prepDB(ddlTipoFonteLum.SelectedValue);
            ilum.potencia_fonte_lumi = valida.prepDB(ddlPotFonteLum.SelectedValue);
            ilum.quant_fontes_lumi = valida.prepDB(ddlQtdeFonteLum.SelectedValue);
            ilum.potencia_total_fonte_lumi = valida.prepDB(txtPotTotFonteLum.Text);
            ilum.carga_inst_total_un_ilum_pub = valida.prepDB(txtCargInsTotUIP.Text);
            ilum.tipo_reator = valida.prepDB(ddlTipoReator.SelectedValue);
            ilum.tipo_rele = valida.prepDB(ddlTipoRele.SelectedValue);
            ilum.tipo_alimentacao = valida.prepDB(ddlTipoAlimentacao.SelectedValue);
            ilum.tipo_poste = valida.prepDB(ddlTipoPoste.SelectedValue);
            ilum.altura_poste = valida.prepDB(txtAltPoste.Text);
            ilum.altura_inst_lumi = valida.prepDB(txtAltInstLum.Text);
            ilum.lat = valida.prepDB(txtLat.Text);
            ilum.lng = valida.prepDB(txtLng.Text);
            ilum.municipio = valida.prepDB(txtMun.Text);
            ilum.regional = valida.prepDB(txtReg.Text);
            ilum.bairro = valida.prepDB(txtBair.Text);
            ilum.classelumi = valida.prepDB(ddlClassIlum.SelectedValue);
            ilum.logradouro = valida.prepDB(txtLog.Text);
            ilum.cep = valida.prepDB(txtCEP.Text);
            ilum.cod_logradouro = valida.prepDB(txtCodLog.Text);
            ilum.ilum_destaq = valida.prepDB(ddlIlumDest.SelectedValue);
            ilum.nome_local_destaq = valida.prepDB(txtNomeLocDestaq.Text);
            ilum.medicao = valida.prepDB(txtMed.Text);
            ilum.cod_login = hfLoginPK.Value;
            ilum.observacao = valida.prepDB(txtObservacao.Text);
            string menssagem =ilum.insert();

            if(menssagem.Contains("sucesso"))
            {
                Msucesso.Visible = true;
                Msucesso.InnerHtml = "<center><strong> "+menssagem+" </strong>";
            }
            else
            {
                Merro.Visible = true;
                Merro.InnerHtml = "<center><strong> " + menssagem + " </strong>";
            }


        }

    }
}