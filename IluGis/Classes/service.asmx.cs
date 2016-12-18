using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.Script.Services;
using System.Web.Services;

namespace IluGis.Classes
{
    /// <summary>
    /// Summary description for service
    /// </summary>
    [WebService(Namespace = "http://tempuri.org/")]
    [WebServiceBinding(ConformsTo = WsiProfiles.BasicProfile1_1)]
    [System.ComponentModel.ToolboxItem(false)]
    // To allow this Web Service to be called from script, using ASP.NET AJAX, uncomment the following line. 
     [System.Web.Script.Services.ScriptService]
    public class service : System.Web.Services.WebService
    {
        
        SqlConnection conn = new SqlConnection();
        SqlCommand cmd = new SqlCommand();
        Geocode geo;

        [WebMethod]
        [ScriptMethod(ResponseFormat = ResponseFormat.Json)]
        public string[] Geocode(string lat, string lng)
        {
            geo = new Geocode();
           string result= geo.geocodeReverso(1, lat, lng, "ti@aryamap.com");
           string [] row= geo.resultJsonReversoGeo(result, 1);

            return row;
        }

        [WebMethod]
        [ScriptMethod(ResponseFormat = ResponseFormat.Json)]
        public string GetIlu(string prefix)
        {
            DataTable dt = new DataTable();
            using (SqlConnection conn = new SqlConnection())
            {
                conn.ConnectionString = ConfigurationManager
                    .ConnectionStrings["MyConnString"].ConnectionString;

                using (SqlCommand cmd = new SqlCommand(" SELECT TOP 100 ID_ILUMINACAO_PUBLICA,COD_ILUM_FK,LOCALIDADE,ILUM_PUB.SHAPE.STX as X,ILUM_PUB.SHAPE.STY as Y FROM sde.ILUM_PUB LEFT JOIN sde.INFO_ILUM on sde.ILUM_PUB.OBJECTID=sde.INFO_ILUM.COD_ILUM_FK INNER JOIN sde.ILUM_PUB_KML ON sde.ILUM_PUB.OBJECTID=sde.ILUM_PUB_KML.COD_ILUM_PUB_FK   INNER JOIN sde.KML_TRATADO ON KML_TRATADO.OBJECTID=sde.ILUM_PUB_KML.COD_KML_FK", conn))
                {

                    conn.Open();
                    SqlDataAdapter da = new SqlDataAdapter(cmd);
                    da.Fill(dt);
                    System.Web.Script.Serialization.JavaScriptSerializer serializer = new System.Web.Script.Serialization.JavaScriptSerializer();
                    serializer.MaxJsonLength = 2147483647;
                    serializer.RecursionLimit = 2147483647;
                    List<Dictionary<string, object>> rows = new List<Dictionary<string, object>>();
                    Dictionary<string, object> row;
                    foreach (DataRow dr in dt.Rows)
                    {
                        row = new Dictionary<string, object>();
                        foreach (DataColumn col in dt.Columns)
                        {
                            row.Add(col.ColumnName, dr[col]);
                        }
                        rows.Add(row);
                    }
                    return serializer.Serialize(rows);

                }

            }
        }

        [WebMethod]
        [ScriptMethod(ResponseFormat = ResponseFormat.Json)]
        public string GetIluminacao(string ilupk,string localidade)
        {
                DataTable dt = new DataTable();
                using (SqlConnection conn = new SqlConnection())
                {
                    conn.ConnectionString = ConfigurationManager
                        .ConnectionStrings["MyConnString"].ConnectionString;

                    using (SqlCommand cmd = new SqlCommand())
                    {


                        cmd.CommandText = "SELECT top 100  CONVERT(INTEGER,sde.ILUM_PUB.ID_ILUMINACAO_PUBLICA) as ID_ILUMINACAO_PUBLICA, sde.ILUM_PUB.OBJECTID as ILUID,ILUM_PUB.SHAPE.STX as ILU_LNG,ILUM_PUB.SHAPE.STY as ILU_LAT,sde.KML_TRATADO.OBJECTID as KMLID FROM sde.ILUM_PUB inner join sde.ILUM_PUB_KML ON sde.ILUM_PUB.OBJECTID=sde.ILUM_PUB_KML.COD_ILUM_PUB_FK INNER JOIN sde.KML_TRATADO ON sde.KML_TRATADO.OBJECTID=sde.ILUM_PUB_KML.COD_KML_FK WHERE LOCALIDADE=@localidade AND ID_ILUMINACAO_PUBLICA LIKE @idilu +'%' ORDER BY  CONVERT(INTEGER,sde.ILUM_PUB.ID_ILUMINACAO_PUBLICA) ";

                        cmd.Parameters.AddWithValue("@idilu", ilupk);
                        cmd.Parameters.AddWithValue("@localidade", localidade);
                        cmd.Connection = conn;
                        conn.Open();
                        SqlDataAdapter da = new SqlDataAdapter(cmd);
                        da.Fill(dt);
                        System.Web.Script.Serialization.JavaScriptSerializer serializer = new System.Web.Script.Serialization.JavaScriptSerializer();
                        serializer.MaxJsonLength = 2147483647;

                        List<Dictionary<string, object>> rows = new List<Dictionary<string, object>>();
                        Dictionary<string, object> row;
                        foreach (DataRow dr in dt.Rows)
                        {
                            row = new Dictionary<string, object>();
                            foreach (DataColumn col in dt.Columns)
                            {
                                row.Add(col.ColumnName, dr[col]);
                            }
                            rows.Add(row);
                        }


                        return serializer.Serialize(rows);
                        

                    }

                }

           

            
        }

        [WebMethod]
        [ScriptMethod(ResponseFormat = ResponseFormat.Json)]
        public string GetLista( string localidade)
        {
            DataTable dt = new DataTable();
            using (SqlConnection conn = new SqlConnection())
            {
                conn.ConnectionString = ConfigurationManager
                    .ConnectionStrings["MyConnString"].ConnectionString;

                using (SqlCommand cmd = new SqlCommand())
                {

                    cmd.CommandText = "SELECT  CONVERT(INTEGER,sde.ILUM_PUB.ID_ILUMINACAO_PUBLICA) as ID_ILUMINACAO_PUBLICA, sde.ILUM_PUB.OBJECTID as ILUID,ILUM_PUB.SHAPE.STX as ILU_LNG,ILUM_PUB.SHAPE.STY as ILU_LAT,sde.KML_TRATADO.OBJECTID as KMLID,COD_ILUM_FK FROM sde.ILUM_PUB inner join sde.ILUM_PUB_KML ON sde.ILUM_PUB.OBJECTID=sde.ILUM_PUB_KML.COD_ILUM_PUB_FK INNER JOIN sde.KML_TRATADO ON sde.KML_TRATADO.OBJECTID=sde.ILUM_PUB_KML.COD_KML_FK LEFT JOIN sde.INFO_ILUM ON ILUM_PUB.OBJECTID=INFO_ILUM.COD_ILUM_FK WHERE LOCALIDADE=@localidade ORDER BY  CONVERT(INTEGER,sde.ILUM_PUB.ID_ILUMINACAO_PUBLICA) ";
                    
                    cmd.Parameters.AddWithValue("@localidade", localidade);
                    cmd.Connection = conn;
                    conn.Open();
                    SqlDataAdapter da = new SqlDataAdapter(cmd);
                    da.Fill(dt);
                    System.Web.Script.Serialization.JavaScriptSerializer serializer = new System.Web.Script.Serialization.JavaScriptSerializer();
                    List<Dictionary<string, object>> rows = new List<Dictionary<string, object>>();
                    Dictionary<string, object> row;
                    foreach (DataRow dr in dt.Rows)
                    {
                        row = new Dictionary<string, object>();
                        foreach (DataColumn col in dt.Columns)
                        {
                            row.Add(col.ColumnName, dr[col]);
                        }
                        rows.Add(row);
                    }


                    return serializer.Serialize(rows);


                }

            }




        }

        [WebMethod]
        [ScriptMethod(ResponseFormat = ResponseFormat.Json)]
        public string GetTipoFonte(string campo1, string campo2)
        {
            DataTable dt = new DataTable();
            using (SqlConnection conn = new SqlConnection())
            {
                conn.ConnectionString = ConfigurationManager
                    .ConnectionStrings["MyConnString"].ConnectionString;

                using (SqlCommand cmd = new SqlCommand())
                {

                    cmd.CommandText = "SELECT " + campo1 + " as name, " + campo2+ " as skill, COUNT(@campo2) as value FROM sde.INFO_ILUM Group by " + campo2 + "," +  campo1 + " order by (" + campo1 + ") ASC";

                    cmd.Parameters.AddWithValue("@campo1", campo1);
                    cmd.Parameters.AddWithValue("@campo2", campo2);
                    cmd.Connection = conn;
                    conn.Open();
                    SqlDataAdapter da = new SqlDataAdapter(cmd);
                    da.Fill(dt);
                    System.Web.Script.Serialization.JavaScriptSerializer serializer = new System.Web.Script.Serialization.JavaScriptSerializer();
                    List<Dictionary<string, object>> rows = new List<Dictionary<string, object>>();
                    Dictionary<string, object> row;
                    foreach (DataRow dr in dt.Rows)
                    {
                        row = new Dictionary<string, object>();
                        foreach (DataColumn col in dt.Columns)
                        {
                            row.Add(col.ColumnName, dr[col]);
                        }
                        rows.Add(row);
                    }

                    return serializer.Serialize(rows);

                }
            }
        }

        [WebMethod]
        [ScriptMethod(ResponseFormat = ResponseFormat.Json)]
        public string GetKML(string kmlid)
        {
            DataTable dt = new DataTable();
            using (SqlConnection conn = new SqlConnection())
            {
                conn.ConnectionString = ConfigurationManager
                    .ConnectionStrings["MyConnString"].ConnectionString;

                using (SqlCommand cmd = new SqlCommand())
                {


                    cmd.CommandText = "SELECT  sde.KML_TRATADO.LOCALIDADE,sde.KML_TRATADO.COD_SEQ_INICIAL,sde.KML_TRATADO.COD_SEQ_FINAL, "+
                   " sde.KML_TRATADO.COD_SERIE_FOTO,sde.KML_TRATADO.EQUIPE,sde.KML_TRATADO.ID "+
                    " FROM sde.KML_TRATADO WHERE OBJECTID=@kmlid ";

                    cmd.Parameters.AddWithValue("@kmlid", kmlid);                  
                    cmd.Connection = conn;
                    conn.Open();
                    SqlDataAdapter da = new SqlDataAdapter(cmd);
                    da.Fill(dt);
                    System.Web.Script.Serialization.JavaScriptSerializer serializer = new System.Web.Script.Serialization.JavaScriptSerializer();
                    List<Dictionary<string, object>> rows = new List<Dictionary<string, object>>();
                    Dictionary<string, object> row;
                    foreach (DataRow dr in dt.Rows)
                    {
                        row = new Dictionary<string, object>();
                        foreach (DataColumn col in dt.Columns)
                        {
                            row.Add(col.ColumnName, dr[col]);
                        }
                        rows.Add(row);
                    }


                    return serializer.Serialize(rows);


                }

            }




        }
        [WebMethod]
        [ScriptMethod(ResponseFormat = ResponseFormat.Json)]
        public int deletePoste(string iluPK)
        {
            int rowsAffected = 0;
            try
            {
                using (SqlConnection conn = new SqlConnection())
                {
                    conn.ConnectionString = ConfigurationManager
                        .ConnectionStrings["MyConnString"].ConnectionString;
                    using (SqlCommand cmd = new SqlCommand())
                    {
                        cmd.CommandText = "DELETE FROM sde.INFO_ILUM WHERE COD_ILUM_FK = " + iluPK;


                        cmd.Parameters.AddWithValue("@iluPK", Convert.ToInt32(iluPK));

                        cmd.Connection = conn;
                        conn.Open();
                        rowsAffected = cmd.ExecuteNonQuery();

                        conn.Close();
                    }
                    return rowsAffected;
                }
            }
            catch (Exception e)
            {
                HttpContext.Current.Response.Write("<script>alert('" + e.Message + "')</script>");
                return 0;
            }

        }

        [WebMethod]
        [ScriptMethod(ResponseFormat = ResponseFormat.Json)]
        public int GetRows(string id)
        {
            DataTable dt = new DataTable();
            using (SqlConnection conn = new SqlConnection())
            {
                conn.ConnectionString = ConfigurationManager
                    .ConnectionStrings["MyConnString"].ConnectionString;

                using (SqlCommand cmd = new SqlCommand())
                {


                    cmd.CommandText = "SELECT COD_ILUM_FK from sde.INFO_ILUM where COD_ILUM_FK= @id ";

                    
                    cmd.Parameters.AddWithValue("@id", id);                    
                    cmd.Connection = conn;
                    conn.Open();
                    SqlDataAdapter da = new SqlDataAdapter(cmd);
                    da.Fill(dt);



                    return dt.Rows.Count;


                }

            }




        }
        [WebMethod]
        [ScriptMethod(ResponseFormat = ResponseFormat.Json)]
        public string GetRelatorio(string campo)
        {
            DataTable dt = new DataTable();
            using (SqlConnection conn = new SqlConnection())
            {
                conn.ConnectionString = ConfigurationManager
                    .ConnectionStrings["MyConnString"].ConnectionString;

                using (SqlCommand cmd = new SqlCommand())
                {

                    cmd.CommandText = "SELECT  " + campo + " as name,  COUNT(@campo) as value FROM sde.INFO_ILUM WHERE " + campo + " is not null GROUP BY " + campo;

                    cmd.Parameters.AddWithValue("@campo", campo);
                    cmd.Connection = conn;
                    conn.Open();
                    SqlDataAdapter da = new SqlDataAdapter(cmd);
                    da.Fill(dt);
                    System.Web.Script.Serialization.JavaScriptSerializer serializer = new System.Web.Script.Serialization.JavaScriptSerializer();
                    List<Dictionary<string, object>> rows = new List<Dictionary<string, object>>();
                    Dictionary<string, object> row;
                    foreach (DataRow dr in dt.Rows)
                    {
                        row = new Dictionary<string, object>();
                        foreach (DataColumn col in dt.Columns)
                        {
                            row.Add(col.ColumnName, dr[col]);
                        }
                        rows.Add(row);
                    }


                    return serializer.Serialize(rows);


                }

            }




        }
        [WebMethod]
        [ScriptMethod(ResponseFormat = ResponseFormat.Json)]
        public string GetRelatorioGrupo(string campo, string grupo)
        {
            DataTable dt = new DataTable();
            using (SqlConnection conn = new SqlConnection())
            {
                conn.ConnectionString = ConfigurationManager
                    .ConnectionStrings["MyConnString"].ConnectionString;

                using (SqlCommand cmd = new SqlCommand())
                {

                    cmd.CommandText = "SELECT  " + campo + " as name , " + grupo + " as grupo ,COUNT(@campo) as value FROM sde.INFO_ILUM WHERE " + campo + " is not null GROUP BY " + grupo + " , " + campo;

                    cmd.Parameters.AddWithValue("@campo", campo);
                    cmd.Connection = conn;
                    conn.Open();
                    SqlDataAdapter da = new SqlDataAdapter(cmd);
                    da.Fill(dt);
                    System.Web.Script.Serialization.JavaScriptSerializer serializer = new System.Web.Script.Serialization.JavaScriptSerializer();
                    List<Dictionary<string, object>> rows = new List<Dictionary<string, object>>();
                    Dictionary<string, object> row;
                    foreach (DataRow dr in dt.Rows)
                    {
                        row = new Dictionary<string, object>();
                        foreach (DataColumn col in dt.Columns)
                        {
                            row.Add(col.ColumnName, dr[col]);
                        }
                        rows.Add(row);
                    }


                    return serializer.Serialize(rows);


                }

            }




        }
        [WebMethod]
        [ScriptMethod(ResponseFormat = ResponseFormat.Json)]
        public string GetRelatorioFiltro(string campo, string filtro, string value)
        {
            DataTable dt = new DataTable();
            using (SqlConnection conn = new SqlConnection())
            {
                conn.ConnectionString = ConfigurationManager
                    .ConnectionStrings["MyConnString"].ConnectionString;

                using (SqlCommand cmd = new SqlCommand())
                {

                    cmd.CommandText = "SELECT  " + campo + " as name , COUNT(@campo) as value FROM sde.INFO_ILUM WHERE " + campo + " is not null AND " + filtro + "='" + value + "' GROUP BY " + campo;

                    cmd.Parameters.AddWithValue("@campo", campo);
                    cmd.Connection = conn;
                    conn.Open();
                    SqlDataAdapter da = new SqlDataAdapter(cmd);
                    da.Fill(dt);
                    System.Web.Script.Serialization.JavaScriptSerializer serializer = new System.Web.Script.Serialization.JavaScriptSerializer();
                    List<Dictionary<string, object>> rows = new List<Dictionary<string, object>>();
                    Dictionary<string, object> row;
                    foreach (DataRow dr in dt.Rows)
                    {
                        row = new Dictionary<string, object>();
                        foreach (DataColumn col in dt.Columns)
                        {
                            row.Add(col.ColumnName, dr[col]);
                        }
                        rows.Add(row);
                    }


                    return serializer.Serialize(rows);


                }

            }




        }
        [WebMethod]
        [ScriptMethod(ResponseFormat = ResponseFormat.Json)]
        public string GetRelatorioFiltroGrupo(string campo, string filtro, string value, string grupo)
        {
            DataTable dt = new DataTable();
            using (SqlConnection conn = new SqlConnection())
            {
                conn.ConnectionString = ConfigurationManager
                    .ConnectionStrings["MyConnString"].ConnectionString;

                using (SqlCommand cmd = new SqlCommand())
                {

                    cmd.CommandText = "SELECT  " + campo + " as name ," + grupo + " as grupo , COUNT(@campo) as value FROM sde.INFO_ILUM WHERE " + campo + " is not null AND " + filtro + "='" + value + "' GROUP BY " + campo + ", " + grupo;

                    cmd.Parameters.AddWithValue("@campo", campo);
                    cmd.Connection = conn;
                    conn.Open();
                    SqlDataAdapter da = new SqlDataAdapter(cmd);
                    da.Fill(dt);
                    System.Web.Script.Serialization.JavaScriptSerializer serializer = new System.Web.Script.Serialization.JavaScriptSerializer();
                    List<Dictionary<string, object>> rows = new List<Dictionary<string, object>>();
                    Dictionary<string, object> row;
                    foreach (DataRow dr in dt.Rows)
                    {
                        row = new Dictionary<string, object>();
                        foreach (DataColumn col in dt.Columns)
                        {
                            row.Add(col.ColumnName, dr[col]);
                        }
                        rows.Add(row);
                    }


                    return serializer.Serialize(rows);


                }

            }




        }
        [WebMethod]
        [ScriptMethod(ResponseFormat = ResponseFormat.Json)]
        public string GetInfo(string ilumid)
        {
            DataTable dt = new DataTable();
            using (SqlConnection conn = new SqlConnection())
            {
                conn.ConnectionString = ConfigurationManager
                    .ConnectionStrings["MyConnString"].ConnectionString;

                using (SqlCommand cmd = new SqlCommand())
                {


                    cmd.CommandText = "SELECT [COD_INFO_PK],[COD_ILUM_FK], [TIPO_BRACO], [PROJ_BRACO], [TIPO_LUMINARIA], [QUANT_LUMINARIAS], [TIPO_FONTE_LUMINARIA], [POTENCIA_FONTE_LUMI],"+
                   " [QUANT_FONTES_LUMI], [POTENCIA_TOTAL_FONTE_LUMI], [CARGA_INST_TOTAL_UN_ILUM_PUB], [TIPO_REATOR], [TIPO_RELE], [TIPO_ALIMENTACAO], [TIPO_POSTE], [ALTURA_POSTE], [ALTURA_INST_LUMI],"+
                   " [LAT], [LONG], [MUNICIPIO], [REGIONAL], [BAIRRO], [CLASSE_ILUMI], [LOGRADOURO], [CEP], [COD_LOGRADOURO], [ILUM_DESTAQ], [NOME_LOCAL_DESTAQ], [MEDICAO],[OBSERVACAO], "+
                   " ILUM_PUB.SHAPE.STX as ILU_LNG,ILUM_PUB.SHAPE.STY as ILU_LAT,sde.KML_TRATADO.OBJECTID as KMLID,sde.KML_TRATADO.LOCALIDADE,sde.KML_TRATADO.COD_SEQ_INICIAL,sde.KML_TRATADO.COD_SEQ_FINAL, " +
                   " sde.KML_TRATADO.COD_SERIE_FOTO,sde.KML_TRATADO.EQUIPE from sde.ILUM_PUB INNER JOIN sde.ILUM_PUB_KML ON sde.ILUM_PUB.OBJECTID=sde.ILUM_PUB_KML.COD_ILUM_PUB_FK "+
                   " INNER JOIN sde.KML_TRATADO ON KML_TRATADO.OBJECTID=sde.ILUM_PUB_KML.COD_KML_FK " + 
                   " LEFT JOIN sde.INFO_ILUM ON sde.ILUM_PUB.OBJECTID=sde.INFO_ILUM.COD_ILUM_FK where sde.ILUM_PUB.OBJECTID= @id ";

                    cmd.Parameters.AddWithValue("@id", ilumid);
                   
                    cmd.Connection = conn;
                    conn.Open();
                    SqlDataAdapter da = new SqlDataAdapter(cmd);
                    da.Fill(dt);
                    System.Web.Script.Serialization.JavaScriptSerializer serializer = new System.Web.Script.Serialization.JavaScriptSerializer();
                    List<Dictionary<string, object>> rows = new List<Dictionary<string, object>>();
                    Dictionary<string, object> row;
                    foreach (DataRow dr in dt.Rows)
                    {
                        row = new Dictionary<string, object>();
                        foreach (DataColumn col in dt.Columns)
                        {
                            row.Add(col.ColumnName, dr[col]);
                        }
                        rows.Add(row);
                    }


                    return serializer.Serialize(rows);



                    


                }

            }



        }
        [WebMethod]
        [ScriptMethod(ResponseFormat = ResponseFormat.Json)]
        public int SetHora(string prefix)
        {
            string[] prefix1 = prefix.Split('$');
            DataTable da = new DataTable();
            try
            {
                using (SqlConnection conn = new SqlConnection())
                {

                    conn.ConnectionString = ConfigurationManager
                            .ConnectionStrings["MyConnString"].ConnectionString;
                    using (SqlCommand cmd = new SqlCommand())
                    {
                        da.Clear();
                        String SAIDA = DateTime.Now.ToString();
                        String ENTRADA = prefix1[1].ToString();
                        TimeSpan resultado = Convert.ToDateTime(SAIDA).Subtract(Convert.ToDateTime(ENTRADA));
                        double CONECTADO = Convert.ToInt32(resultado.TotalSeconds);
                        double TESTECONECTADO = CONECTADO;
                        double ATIVIDADE = Convert.ToInt32(prefix1[0]);
                        if (ATIVIDADE > CONECTADO)
                        {
                            CONECTADO = ATIVIDADE;
                        }
                        double APROVEITAMENTO = (ATIVIDADE * 100) / CONECTADO;
                        string[] horaconectado = ((CONECTADO / 60) / 60).ToString().Replace(",",".").Split('.');
                        string[] minutoconectado = ((CONECTADO / 60) % 60).ToString().Replace(",", ".").Split('.');
                        string[] horaatividade = ((ATIVIDADE / 60) / 60).ToString().Replace(",", ".").Split('.');
                        string[] minutoatividade = ((ATIVIDADE / 60) % 60).ToString().Replace(",", ".").Split('.');

                        string setCONECTADO = "" + horaconectado[0] + ":" + minutoconectado[0] + ":" + Convert.ToInt32(CONECTADO % 60);
                        string setATIVIDADE = "" + horaatividade[0] + ":" + minutoatividade[0] + ":" + Convert.ToInt32(ATIVIDADE % 60);

                        if (TESTECONECTADO >= 10)
                        {
                          
                            String[] datahora = ENTRADA.Split(' ');
                            String[] data = datahora[0].Split('/');
                            String novadataENTRADA = data[2] + "-" + data[0] + "-" + data[1] + " " + datahora[1];
                            datahora = SAIDA.Split(' ');
                            data = datahora[0].Split('/');
                            String novadataSAIDA = data[2] + "-" + data[0] + "-" + data[1] + " " + datahora[1];
                           

                            cmd.CommandText = "INSERT INTO sde.TBL_CONTROLE_USUARIO([COD_LOGIN_FK],[DATAHORA_ENTRADA],[DATAHORA_SAIDA],[HORA_ATIVIDADE],[HORA_CONECTADO],[APROVEITAMENTO]) VALUES(@IDUSER,@ENTRADA,@SAIDA,@ATIVIDADE,@CONECTIVIDADE,@APROVEITAMENTO)";
                            //"select COD_CLI, COD_EMPRESA_PK, COD_ENDERECO_EMPRESA_PK, CEP, NOME, NUMERO, TIPO, COMPLEMENTO, MUN, UF, BAIRRO from ENDERECO_EMPRESA END, EMPRESA EMP, PROCESSO PRO where END.COD_EMPRESA_FK = COD_EMPRESA_PK AND COD_CLI LIKE @SearchText + '%' ;";
                            cmd.Parameters.AddWithValue("@ENTRADA", novadataENTRADA);
                            cmd.Parameters.AddWithValue("@SAIDA", novadataSAIDA);
                            cmd.Parameters.AddWithValue("@ATIVIDADE", setATIVIDADE);
                            cmd.Parameters.AddWithValue("@CONECTIVIDADE", setCONECTADO);
                            int aprov = Convert.ToInt32(APROVEITAMENTO);
                            cmd.Parameters.AddWithValue("@APROVEITAMENTO", aprov);
                            cmd.Parameters.AddWithValue("@IDUSER", prefix1[2]);
                           
                            cmd.Connection = conn;
                            conn.Open();
                            cmd.ExecuteNonQuery();




                            conn.Close();

                        }

                        return 1;



                    }



                }
            }
            catch (Exception e)
            {
                HttpContext.Current.Response.Write("<script>alert('" + e.Message + "')</script>");

                return 0;


            }

        }

    }
}
