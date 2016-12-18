using IluGis.Classes;
using Kml2Sql.Mapping;
using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.IO;
using System.Linq;
using System.Text;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Xml;

namespace IluGis
{
    public partial class import : System.Web.UI.Page
    {
        FileStream fileStream;
        Classes.conexao conexao = new Classes.conexao();
        Classes.validacao valida;
        string tabela = "sde.KML_TRATADO";
        string colunas = "([OBJECTID],[NAME],[ID],[SHAPE],[ARQUIVO_IMPORTADO],[DATA_IMPORTACAO],[FK_USUARIO],[EQUIPE],[DATA_LEVANTAMENTO])";
        string colunas1 = "([OBJECTID],[COD_SEQ_INICIAL],[ID],[SHAPE],[ARQUIVO_UTILIZADO],[DATA_IMPORTACAO],[FK_USUARIO],[EQUIPE],[LOCALIDADE],[COD_SEQ_FINAL],[COD_SERIE_FOTO])";
        string pk = "OBJECTID";
        string datanow = DateTime.Now.Year + "-" + DateTime.Now.Month + "-" + DateTime.Now.Day;
        int resultado = 0;
        string serie="" ;
        string ini="" ;
        string fim= "";
        protected void Page_Load(object sender, EventArgs e)
        {


            StringData webUserStringData = (StringData)Session["webuser"];

            if (Session["webuser"] != null)
            {
                Response.Cache.SetExpires(DateTime.UtcNow.AddMinutes(-1));
                Response.Cache.SetCacheability(HttpCacheability.NoCache);
                Response.Cache.SetNoStore();


                hfPermissao.Value = webUserStringData.userPermission;
                hfLoginPK.Value = webUserStringData.userID;



            }
            else
            {
                Response.Write("<script>alert('Faça login para ter acesso ao sistema');</script>");
                Response.Redirect("~/login.aspx", true);
            }

        }



        public string importKML(string path, int codUser,string filename)
        {
            try
            {
                valida = new Classes.validacao();




                
                fileStream = File.Open(path, FileMode.Open);
                var mapper = new Kml2SqlMapper(fileStream);
                var sb = new StringBuilder();
                sb.Clear();
                var lista = mapper.GetMapFeatures().ToList();
                int arquafet = 0;
                sb.Append(" Declare @count int ");
                for (int i = 0; i < lista.Count(); i++)
                {
                    if (lista[i].ShapeType.ToString() == "Point" && lista[i].Name.ToString() != "Untitled Placemark" && lista[i].Name.ToString()!="")
                    {
                        arquafet++;
                        string lat = lista[i].Coordinates[0].Latitude.ToString().Replace(",", ".");
                        string lng = lista[i].Coordinates[0].Longitude.ToString().Replace(",", ".");

                        if (lista[i].Name.Contains('-') && lista[i].Name.Contains('.'))
                        {
                            serie = lista[i].Name.Split('-')[0];
                            if(lista[i].Name.Split('-')[1].Contains("."))
                            {
                                ini = lista[i].Name.Split('-')[1].Split('.')[0];
                                fim = lista[i].Name.Split('-')[1].Split('.')[1];
                            }
                            else
                            {
                                ini = lista[i].Name.Split('-')[1];
                                fim = lista[i].Name.Split('-')[1];

                            }

                        }
                        else if(lista[i].Name.Contains('.'))
                        {
                            ini = lista[i].Name.Split('.')[0];
                            fim = lista[i].Name.Split('.')[1];
                        }
                        else if(lista[i].Name.Contains('-'))
                        {
                            serie = lista[i].Name.Split('-')[0];
                            ini = lista[i].Name.Split('-')[1];
                            fim = lista[i].Name.Split('-')[1];
                        }

                        else
                        {
                            ini = lista[i].Name;
                            fim = lista[i].Name;
                        }
                        
                       
                       //ini = lista[i].Name.Split('-')[0];
                       //fim = lista[i].Name.Split('-')[1];


                        string shape = "geometry::STGeomFromText('POINT(" + lng + " " + lat + ")',4326)";
                        sb.Append(" SELECT @count = COUNT(*) FROM " + tabela +
                            " IF(@count > 0) " +
                            " BEGIN " +
                            " INSERT INTO " + tabela + " " + colunas1 + "  VALUES(((SELECT TOP 1 " + pk + " FROM " + tabela + " ORDER BY " + pk + " DESC) + 1),'" + ini + "'," + valida.prepDB(lista[i].Id.ToString()) + "," + shape + "," + valida.prepDB(filename) + ",'" + datanow + "'," + valida.prepDB(codUser.ToString()) + "," + valida.prepDB(ddlEquipe.Text) + "," + valida.validaData(ddllocal.Text) + ",'" + fim + "','" + serie + "') " +
                            " END " +
                            " ELSE " +
                            " BEGIN " +
                            " INSERT INTO " + tabela + " " + colunas1 + " VALUES(1,'" + ini + "'," + valida.prepDB(lista[i].Id.ToString()) + "," + shape + "," + valida.prepDB(filename) + ",'" + datanow + "'," + valida.prepDB(codUser.ToString()) + "," + valida.prepDB(ddlEquipe.Text) + "," + valida.validaData(ddllocal.Text) + ",'" + fim + "','" + serie + "')" +
                            " END ");

                    }


                }

                conexao.commandExec(sb.ToString());
                
               fileStream.Close();
               fileStream.Dispose();
               

                return "" + lista.Count() + "," + arquafet;

            }catch(Exception ex)
            {
                fileStream.Close();
                fileStream.Dispose();
                return "Erro : " + ex.Message;

            }
           

        }
        protected void FindCoordinates_Click1(object sender, EventArgs e)
        {
            string fn = System.IO.Path.GetFileName(File1.PostedFile.FileName);
            string SaveLocation;
            string url = string.Empty;
            string erro = "";
            DataTable dt = new DataTable();
            string result = "";
            int numpontos;
            int arqafet;
             try
                {           
                   

                    if (ddlEquipe.SelectedIndex != -1)
                    {
                        if (ddllocal.SelectedIndex != -1)
                        {
                            if ((File1.PostedFile != null) && (File1.PostedFile.ContentLength > 0))
                            {
                                if (!Directory.Exists(Server.MapPath("KML")))
                                {
                                    Directory.CreateDirectory(Server.MapPath("KML"));
                                }
                                if (!Directory.Exists(Server.MapPath("KML\\" + ddlEquipe.Text)))
                                {
                                    Directory.CreateDirectory(Server.MapPath("KML\\" + ddlEquipe.Text));
                                }
                                if (!Directory.Exists(Server.MapPath("KML\\" + ddlEquipe.Text + "\\" + ddllocal.Text)))
                                {
                                    Directory.CreateDirectory(Server.MapPath("KML\\" + ddlEquipe.Text + "\\" + ddllocal.Text));
                                }
                                SaveLocation = Server.MapPath("KML\\" + ddlEquipe.Text + "\\" + ddllocal.Text + "\\" + fn);

                                if (!File.Exists(SaveLocation))
                                {
                                    File1.PostedFile.SaveAs(SaveLocation);
                                }
                                result = importKML(SaveLocation, Convert.ToInt32(Session["IDUSER"]), fn);


                                if (!result.Contains("Erro"))
                                {
                                    numpontos = Convert.ToInt32(result.Split(',')[0]);
                                    arqafet = Convert.ToInt32(result.Split(',')[1]);
                                    Msucesso.Visible = true;
                                    Msucesso.InnerHtml = "<center><strong>Importado com Sucesso!</strong> Numero total de pontos: " + numpontos + " e Numero total de arquivos importado: " + arqafet + " .</center>";
                                }
                                else
                                {
                                    Merro.Visible = true;
                                    Merro.InnerHtml = "<center><strong>Erro de importação!</strong> Messagem original: " + result;
                                }
                            }
                            else
                            {
                                Malerta.Visible = true;
                                Malerta.InnerHtml = "<center><strong>Preencher todos os campos!</strong> Selecione um arquivo KML ";
                            }


                        }
                        else
                        {
                            Malerta.Visible = true;
                            Malerta.InnerHtml = "<center><strong>Preencher todos os campos!</strong> Campo de Localidade é obrigatório ";
                        }
                    }
                    else{
                        Malerta.Visible = true;
                        Malerta.InnerHtml = "<center><strong>Preencher todos os campos!</strong> Campo de Equipe é obrigatório ";
                    }
                    


                  }
                  catch (Exception ex)
                  { 
                      erro = erro + "---------"+ ex.Message;
                      Merro.Visible = true;
                      Merro.InnerHtml = "<center><strong>Erro de importação!</strong> Messagem original: " + erro;

                  }




        }
        public DataSet ImportXML(string xml)
        {
            
            DataSet ds = new DataSet();
            XmlDocument docxml = new XmlDocument();
            docxml.LoadXml(xml);        
            ds.ReadXml(new XmlNodeReader(docxml));


            return ds;
        }
    }
}