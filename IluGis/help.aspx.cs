using IluGis.Classes;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace IluGis
{
    public partial class help : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            StringData webUserStringData = (StringData)Session["webuser"];

            if (Session["webuser"] != null)
            {

                

            }
            else
            {
                Response.Write("<script>alert('Faça login para ter acesso ao sistema');</script>");
                Response.Redirect("~/login.aspx", true);
            }

        }
    }
}