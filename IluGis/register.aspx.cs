using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using IluGis.Classes;

namespace IluGis
{
    public partial class Register : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            StringData webUserStringData = (StringData)Session["webuser"];

            if (Session["webuser"] != null)
            {
                if (webUserStringData.userPermission != "1")
                {
                }
                else
                {
                    Response.Redirect("~/home.aspx", true);
                }
                    


            }
            else
            {
                Response.Write("<script>alert('Faça login para ter acesso ao sistema');</script>");
                Response.Redirect("~/login.aspx", true);
            }

        }

        protected void btnCadastrarUsuario_Click(object sender, EventArgs e)
        {

            if (txtNome.Text != "")
            {
                LabelErroNome.Text = "";

                if (txtUsuario.Text != "")
                {
                    LabelErroUsuario.Text = "";

                    if (txtEmail.Text != "")
                    {
                        LabelErroEmail.Text = "";

                        if (txtSenha.Text != "")
                        {
                            LabelErroSenha.Text = "";

                            if (txtRepitaSenha.Text != "")
                            {

                                if (ddlPermissao.SelectedValue == "1" || ddlPermissao.SelectedValue == "0")
                                {
                                    
                                    if (txtRepitaSenha.Text == txtSenha.Text)
                                    {
                                        cadastro();
                                        LabelCadastro.Text = "Usuário cadastrado!";
                                        LabelCadastro.ForeColor = System.Drawing.Color.Green;
                                        

                                    }
                                    else
                                    {
                                        LabelErroRepitaSenha.Text = "Senhas diferentes";
                                        LabelErroRepitaSenha.ForeColor = System.Drawing.Color.Red;
                                    }
                                }
                                else
                                {
                                    LabelErroPermissao.Text = "Campo vazio, favor preencher!";
                                    LabelErroPermissao.ForeColor = System.Drawing.Color.Red;
                                }
                            }
                            else
                            {
                                LabelErroRepitaSenha.Text = "Campo vazio, favor preencher!";
                                LabelErroRepitaSenha.ForeColor = System.Drawing.Color.Red;

                                if (ddlPermissao.SelectedValue == "1" || ddlPermissao.SelectedValue == "0")
                                {
                                    LabelErroPermissao.Text = "Campo vazio, favor preencher!";
                                    LabelErroPermissao.ForeColor = System.Drawing.Color.Red;
                                }
                            }

                        }
                        else
                        {
                            LabelErroSenha.Text = "Campo vazio, favor preencher!";
                            LabelErroSenha.ForeColor = System.Drawing.Color.Red;
                            LabelErroRepitaSenha.Text = "";
                            if (txtRepitaSenha.Text == "")
                            {
                                LabelErroRepitaSenha.Text = "Campo vazio, favor preencher!";
                                LabelErroRepitaSenha.ForeColor = System.Drawing.Color.Red;
                            }
                            if (ddlPermissao.SelectedValue == "1" || ddlPermissao.SelectedValue == "0")
                            {
                                LabelErroPermissao.Text = "Campo vazio, favor preencher!";
                                LabelErroPermissao.ForeColor = System.Drawing.Color.Red;
                            }
                            
                        }
                    }
                    else
                    {
                        LabelErroEmail.Text = "Campo vazio, favor preencher!";
                        LabelErroEmail.ForeColor = System.Drawing.Color.Red;

                        if (txtSenha.Text == "")
                            {
                                LabelErroSenha.Text = "Campo vazio, favor preencher!";
                                LabelErroSenha.ForeColor = System.Drawing.Color.Red;
                            }

                        if (txtRepitaSenha.Text == "")
                            {
                                LabelErroRepitaSenha.Text = "Campo vazio, favor preencher!";
                                LabelErroRepitaSenha.ForeColor = System.Drawing.Color.Red;
                            }
                        if (ddlPermissao.SelectedValue == "1" || ddlPermissao.SelectedValue == "0")
                        {
                            LabelErroPermissao.Text = "Campo vazio, favor preencher!";
                            LabelErroPermissao.ForeColor = System.Drawing.Color.Red;
                        }
                    }
                }
                else
                {
                    LabelErroUsuario.Text = "Campo vazio, favor preencher!";
                    LabelErroUsuario.ForeColor = System.Drawing.Color.Red;

                    if (txtEmail.Text == "")
                    {
                        LabelErroEmail.Text = "Campo vazio, favor preencher!";
                        LabelErroEmail.ForeColor = System.Drawing.Color.Red;
                    }

                    if (txtSenha.Text == "")
                    {
                        LabelErroSenha.Text = "Campo vazio, favor preencher!";
                        LabelErroSenha.ForeColor = System.Drawing.Color.Red;
                    }

                    if (txtRepitaSenha.Text == "")
                    {
                        LabelErroRepitaSenha.Text = "Campo vazio, favor preencher!";
                        LabelErroRepitaSenha.ForeColor = System.Drawing.Color.Red;
                    }
                    if (ddlPermissao.SelectedValue == "1" || ddlPermissao.SelectedValue == "0")
                    {
                        LabelErroPermissao.Text = "Campo vazio, favor preencher!";
                        LabelErroPermissao.ForeColor = System.Drawing.Color.Red;
                    }
                }
            }
            else
            {
                LabelErroNome.Text = "Campo vazio, favor preencher!";
                LabelErroNome.ForeColor = System.Drawing.Color.Red;
                

                if (txtUsuario.Text == "")
                {
                    LabelErroUsuario.Text = "Campo vazio, favor preencher!";
                    LabelErroUsuario.ForeColor = System.Drawing.Color.Red;

                }
                    if (txtEmail.Text == "")
                    {
                        LabelErroEmail.Text = "Campo vazio, favor preencher!";
                        LabelErroEmail.ForeColor = System.Drawing.Color.Red;
                    }

                    if (txtSenha.Text == "")
                        {
                            LabelErroSenha.Text = "Campo vazio, favor preencher!";
                            LabelErroSenha.ForeColor = System.Drawing.Color.Red;
                        }

                    if (txtRepitaSenha.Text == "")
                        {
                            LabelErroRepitaSenha.Text = "Campo vazio, favor preencher!";
                            LabelErroRepitaSenha.ForeColor = System.Drawing.Color.Red;
                        }
                    if (ddlPermissao.SelectedValue == "-1")
                    {
                        LabelErroPermissao.Text = "Campo vazio, favor preencher!";
                        LabelErroPermissao.ForeColor = System.Drawing.Color.Red;
                    }

            }


            
            if (txtRepitaSenha.Text != "" && txtRepitaSenha.Text == txtSenha.Text)
            {
                LabelErroRepitaSenha.Text = "";
            }

            if (ddlPermissao.SelectedValue == "1" || ddlPermissao.SelectedValue == "0")
            {
                LabelErroPermissao.Text = "";
            }
 

        }

        public void cadastro() {

            validacao valida = new validacao();
            usuario usuario = new usuario();

            usuario.nome =  valida.prepDB(txtNome.Text);
            usuario.user = valida.prepDB(txtUsuario.Text);          
            usuario.email = valida.prepDB(txtEmail.Text);
            usuario.senha = valida.prepDB(txtSenha.Text);
            usuario.permissao = ddlPermissao.SelectedValue;
            usuario.cadastrar_usuario();

        }
    }
}