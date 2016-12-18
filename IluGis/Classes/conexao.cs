using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;

namespace IluGis.Classes
{
    public class conexao
    {
        SqlConnection SqlConn = new SqlConnection();
        public DataTable SqlTable = new DataTable();
        int rowInfected;
        public conexao()
        {
            SqlConn.ConnectionString = ConfigurationManager.ConnectionStrings["MyConnString"].ConnectionString;
            
        }
        public DataTable SELECT(String command)
        {
            try
            {
                SqlConn.Open();
                SqlDataAdapter da = new SqlDataAdapter(command, SqlConn);
                da.SelectCommand.CommandTimeout = 360;

                da.Fill(SqlTable);
            }
            catch (Exception ex)
            {
                HttpContext.Current.Response.Write("<script>alert('Ops, Algo deu errado! " + ex.Message + "' )</script>");
            }

            SqlConn.Close();
            return SqlTable;
        }
        public int insertReturn(String command, String chave)
        {
            DataTable dt = new DataTable();
            try
            {
                // dt.Clear();
                //dt = limpaData(dt);
                SqlConn.Open();
                SqlDataAdapter da = new SqlDataAdapter(command, SqlConn);
                da.Fill(dt);
                SqlConn.Close();
                if (dt.Rows.Count > 0)
                {
                    return (int)dt.Rows[dt.Rows.Count - 1][chave];
                }
                else
                {
                    return 0;
                }
            }

            catch (FormatException fe)
            {
                throw new System.Exception(fe.Message);
               
            }
            catch (Exception ex)
            {
                throw new System.Exception(ex.Message);
                //HttpContext.Current.Response.Write("<script>alert('Ops, Algo deu errado! " + ex.Message + "' )</script>");

            }
        }
        public int commandExec(String command)
        {
            try
            {
                this.SqlConn.Open();

                SqlCommand SqlConn = new SqlCommand(command, this.SqlConn);
                SqlConn.CommandTimeout = 360;
                rowInfected = 0;
                rowInfected = SqlConn.ExecuteNonQuery();

                return rowInfected;

            }
            catch (Exception ex)
            {
                return rowInfected;
                throw new System.Exception(ex.Message);
            }
            finally
            {

                SqlConn.Close();
            }
        }
    }
}