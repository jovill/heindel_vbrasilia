using IluGis.Classes;
using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace IluGis
{
    public partial class login : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }
        protected void btnLogOn_Click(object sender, EventArgs e)
        {
            StringData webUserStringData = find(this.inputUser.Text, this.inputPassword.Text);
            if (webUserStringData == null)
            {
                //msg = "Username and password not found.";
                //this.lblMsg.CssClass = "negative";
                Label1.Text = "Senha ou Usuário incorretos";
                Label1.ForeColor = System.Drawing.Color.Red;
                this.inputUser.Text = "";
                this.inputPassword.Text = "";

            }
            else
            {
              
                Session.Add("webuser", webUserStringData);
                Session["Permissao"] = webUserStringData.userPermission.ToString();
                Session["Entrada"] = DateTime.Now.ToString();
                Session["Tempo"] = Convert.ToInt32(0);
                Session["IDUSER"] = webUserStringData.userID;
                Session["User"] = webUserStringData.user;
                Session["password"] = webUserStringData.userPw;
                Label1.Text = "";
                Response.Redirect("~/home.aspx");
                
            }
        }
        public StringData find(String user, String pwd)
        {
            StringData foundWebUser = new StringData();

            using (SqlConnection conn = new SqlConnection())
            {

                conn.ConnectionString = ConfigurationManager.ConnectionStrings["MyConnString"].ConnectionString;

                using (SqlCommand cmd = new SqlCommand())
                {

                    String strQuery = "select USERNAME, COD_LOGIN_PK, PASSWORD, NOME_COMPLETO, TIPO_PERMISSAO from TBL_USUARIO where " +
                    "USERNAME = @user AND PASSWORD = @pwd";//SUBSTRING(sys.fn_sqlvarbasetostr(HASHBYTES('MD5', '" + pwd + "')),3,999)
                    //"select COD_CLI, COD_EMPRESA_PK, COD_ENDERECO_EMPRESA_PK, CEP, NOME, NUMERO, TIPO, COMPLEMENTO, MUN, UF, BAIRRO from ENDERECO_EMPRESA END, EMPRESA EMP, PROCESSO PRO where END.COD_EMPRESA_FK = COD_EMPRESA_PK AND COD_CLI LIKE @SearchText + '%' ;";
                    cmd.CommandType = CommandType.Text;
                    cmd.Parameters.AddWithValue("@user", user);
                    cmd.Parameters.AddWithValue("@pwd", pwd); //nao aceita substring
                    cmd.CommandText = strQuery;
                    cmd.Connection = conn;
                    conn.Open();
                    SqlDataReader sdr = cmd.ExecuteReader();

                    if (sdr.Read())
                    {
                        //foundWebUser.userRole = (sdr["USERNAME"]).ToString();
                        foundWebUser.userID = (sdr["COD_LOGIN_PK"]).ToString();
                        foundWebUser.user = (sdr["USERNAME"]).ToString();
                        foundWebUser.userPw = (sdr["PASSWORD"]).ToString();
                        foundWebUser.userName = (sdr["NOME_COMPLETO"]).ToString();
                        foundWebUser.userPermission = (sdr["TIPO_PERMISSAO"]).ToString();                    
                        conn.Close();

                        return foundWebUser;
                    }
                    else
                    {
                        conn.Close();
                        return null; // this is our way of saying we did not find a web_user record
                    }

                }

            }

        }
    }
}