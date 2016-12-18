using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace IluGis.Classes
{
    public class info_ilum
    {
        Classes.conexao conexao;
        Classes.validacao valida;

        public string cod_un_ilu_pub { get; set; }
        public string tipo_braco { get; set; }
        public string proj_braco { get; set; }
        public string tipo_luminaria { get; set; }
        public string quant_luminarias { get; set; }
        public string tipo_fonte_luminaria { get; set; }
        public string potencia_fonte_lumi { get; set; }
        public string quant_fontes_lumi { get; set; }
        public string potencia_total_fonte_lumi { get; set; }
        public string carga_inst_total_un_ilum_pub { get; set; }
        public string tipo_reator { get; set; }
        public string tipo_rele { get; set; }
        public string tipo_alimentacao { get; set; }
        public string tipo_poste { get; set; }
        public string altura_poste { get; set; }
        public string altura_inst_lumi { get; set; }
        public string lat { get; set; }
        public string lng { get; set; }
        public string municipio { get; set; }
        public string regional { get; set; }
        public string bairro { get; set; }
        public string classelumi { get; set; }
        public string logradouro { get; set; }
        public string cep { get; set; }
        public string cod_logradouro { get; set; }
        public string ilum_destaq { get; set; }
        public string nome_local_destaq { get; set; }
        public string medicao { get; set; }
        public string cod_login { get; set; }
        public string observacao { get; set; }
        public string tipo_posteacao { get; set; }
        public string dist_med_dois_postes { get; set; }
        public string largura_via { get; set; }
        public string largura_passeio { get; set; }
        public string largura_cant_central { get; set; }




        public info_ilum()
        {
            
            this.cod_un_ilu_pub = string.Empty;
            this.tipo_braco = string.Empty;
            this.proj_braco = string.Empty;
            this.tipo_luminaria = string.Empty;
            this.quant_luminarias = string.Empty;
            this.tipo_fonte_luminaria = string.Empty;
            this.potencia_fonte_lumi = string.Empty;
            this.quant_fontes_lumi = string.Empty;
            this.potencia_total_fonte_lumi = string.Empty;
            this.carga_inst_total_un_ilum_pub = string.Empty;
            this.tipo_reator = string.Empty;
            this.tipo_rele = string.Empty;
            this.tipo_alimentacao = string.Empty;
            this.tipo_poste = string.Empty;
            this.altura_poste = string.Empty;
            this.altura_inst_lumi = string.Empty;
            this.lat = string.Empty;
            this.lng = string.Empty;
            this.municipio = string.Empty;
            this.regional = string.Empty;
            this.bairro = string.Empty;
            this.classelumi = string.Empty;
            this.logradouro = string.Empty;
            this.cep = string.Empty;
            this.cod_logradouro = string.Empty;
            this.ilum_destaq = string.Empty;
            this.nome_local_destaq = string.Empty;
            this.medicao = string.Empty;
            this.cod_login = string.Empty;
            this.observacao = string.Empty;
            this.tipo_posteacao = string.Empty;
            this.dist_med_dois_postes = string.Empty;
            this.largura_via = string.Empty;
            this.largura_passeio = string.Empty;
            this.largura_cant_central = string.Empty;
        }

        public string insert()
        {

            try
            {
                conexao = new Classes.conexao();
                valida = new validacao();
                int insercao;
                string datanow = DateTime.Now.Year + "-" + DateTime.Now.Month + "-" + DateTime.Now.Day;

                string query = " INSERT INTO sde.INFO_ILUM ([COD_ILUM_FK], [TIPO_BRACO], [PROJ_BRACO], [TIPO_LUMINARIA], [QUANT_LUMINARIAS], [TIPO_FONTE_LUMINARIA], [POTENCIA_FONTE_LUMI], [QUANT_FONTES_LUMI], [POTENCIA_TOTAL_FONTE_LUMI], [CARGA_INST_TOTAL_UN_ILUM_PUB], [TIPO_REATOR], [TIPO_RELE], [TIPO_ALIMENTACAO], [TIPO_POSTE], [ALTURA_POSTE], [ALTURA_INST_LUMI], [LAT], [LONG], [MUNICIPIO], [REGIONAL], [BAIRRO], [CLASSE_ILUMI], [LOGRADOURO], [CEP], [COD_LOGRADOURO], [ILUM_DESTAQ], [NOME_LOCAL_DESTAQ], [MEDICAO],[OBSERVACAO],[CADASTRO_USER_INFO],[CADASTRO_DATA_INFO]) VALUES(" + (this.cod_un_ilu_pub) + "," + (this.tipo_braco) + "," + (this.proj_braco) + "," + (this.tipo_luminaria) + "," + (this.quant_luminarias.ToString()) + "," + (this.tipo_fonte_luminaria) + "," + (this.potencia_fonte_lumi) + "," + (this.quant_fontes_lumi.ToString()) + "," + (this.potencia_total_fonte_lumi.ToString()) + "," + (this.carga_inst_total_un_ilum_pub.ToString()) + "," + (this.tipo_reator) + "," + (this.tipo_rele) + "," + (this.tipo_alimentacao) + "," + (this.tipo_poste) + "," + (this.altura_poste.ToString()) + "," + (this.altura_inst_lumi.ToString()) + "," + (this.lat) + "," + (this.lng) + "," + (this.municipio) + "," + (this.regional) + "," + (this.bairro) + "," + (this.classelumi) + "," + (this.logradouro) + "," + (this.cep) + "," + (this.cod_logradouro.ToString()) + "," + (this.ilum_destaq.ToString()) + "," + (this.nome_local_destaq) + "," + (this.medicao.ToString()) + ","+(this.observacao)+"," + (this.cod_login.ToString()) + ",'"+datanow+"') ";
                            


                //string query = "Declare @count int SELECT @count = COUNT(*) FROM  INFO_ILUM" +
                //               " IF(@count > 0) " +
                //               " BEGIN " +
                //               " INSERT INTO INFO_ILUM ([COD_INFO_PK],[COD_ILUM_FK], [TIPO_BRACO], [PROJ_BRACO], [TIPO_LUMINARIA], [QUANT_LUMINARIAS], [TIPO_FONTE_LUMINARIA], [POTENCIA_FONTE_LUMI], [QUANT_FONTES_LUMI], [POTENCIA_TOTAL_FONTE_LUMI], [CARGA_INST_TOTAL_UN_ILUM_PUB], [TIPO_REATOR], [TIPO_RELE], [TIPO_ALIMENTACAO], [TIPO_POSTE], [ALTURA_POSTE], [ALTURA_INST_LUMI], [LAT], [LONG], [MUNICIPIO], [REGIONAL], [BAIRRO], [CLASSE_ILUMI], [LOGRADOURO], [CEP], [COD_LOGRADOURO], [ILUM_DESTAQ], [NOME_LOCAL_DESTAQ], [MEDICAO])  VALUES(((SELECT TOP 1 COD_INFO_PK FROM INFO_ILUM ORDER BY COD_INFO_PK DESC) + 1)," + (this.municipio) + "," + (this.tipo_braco) + "," + (this.proj_braco) + "," + (this.tipo_luminaria) + "," + (this.quant_luminarias.ToString()) + "," + (this.tipo_fonte_luminaria) + "," + (this.potencia_fonte_lumi) + "," + (this.quant_fontes_lumi.ToString()) + "," + (this.potencia_total_fonte_lumi.ToString()) + "," + (this.carga_inst_total_un_ilum_pub.ToString()) + "," + (this.tipo_reator) + "," + (this.tipo_rele) + "," + (this.tipo_alimentacao) + "," + (this.tipo_poste) + "," + (this.altura_poste.ToString()) + "," + (this.altura_inst_lumi.ToString()) + "," + (this.lat) + "," + (this.lng) + "," + (this.municipio) + "," + (this.regional) + "," + (this.bairro) + "," + (this.classelumi) + "," + (this.logradouro) + "," + (this.cep) + "," + (this.cod_logradouro.ToString()) + "," + (this.ilum_destaq.ToString()) + "," + (this.nome_local_destaq) + "," + (this.medicao.ToString()) + ") " +
                //               " END " +
                //               " ELSE " +
                //               " BEGIN " +
                //               " INSERT INTO INFO_ILUM ([COD_INFO_PK],[COD_ILUM_FK], [TIPO_BRACO], [PROJ_BRACO], [TIPO_LUMINARIA], [QUANT_LUMINARIAS], [TIPO_FONTE_LUMINARIA], [POTENCIA_FONTE_LUMI], [QUANT_FONTES_LUMI], [POTENCIA_TOTAL_FONTE_LUMI], [CARGA_INST_TOTAL_UN_ILUM_PUB], [TIPO_REATOR], [TIPO_RELE], [TIPO_ALIMENTACAO], [TIPO_POSTE], [ALTURA_POSTE], [ALTURA_INST_LUMI], [LAT], [LONG], [MUNICIPIO], [REGIONAL], [BAIRRO], [CLASSE_ILUMI], [LOGRADOURO], [CEP], [COD_LOGRADOURO], [ILUM_DESTAQ], [NOME_LOCAL_DESTAQ], [MEDICAO]) VALUES(1," + (this.municipio) + "," + (this.tipo_braco) + "," + (this.proj_braco) + "," + (this.tipo_luminaria) + "," + (this.quant_luminarias.ToString()) + "," + (this.tipo_fonte_luminaria) + "," + (this.potencia_fonte_lumi) + "," + (this.quant_fontes_lumi.ToString()) + "," + (this.potencia_total_fonte_lumi.ToString()) + "," + (this.carga_inst_total_un_ilum_pub.ToString()) + "," + (this.tipo_reator) + "," + (this.tipo_rele) + "," + (this.tipo_alimentacao) + "," + (this.tipo_poste) + "," + (this.altura_poste.ToString()) + "," + (this.altura_inst_lumi.ToString()) + "," + (this.lat) + "," + (this.lng) + "," + (this.municipio) + "," + (this.regional) + "," + (this.bairro) + "," + (this.classelumi) + "," + (this.logradouro) + "," + (this.cep) + "," + (this.cod_logradouro.ToString()) + "," + (this.ilum_destaq.ToString()) + "," + (this.nome_local_destaq) + "," + (this.medicao.ToString()) + ") " +
                //               " END ";

                insercao = conexao.commandExec(query);

                if (insercao > 0)
                {
                    return "Cadastro efetuado com sucesso!";
                }


                return "Nenhuma linha foi cadastrada, tente novamente.";
            }
            catch (Exception ex)
            {
                return "Erro: " + ex.Message;
                throw new System.Exception(ex.Message);
            }
        }


        public string update()
        {

            try
            {
                conexao = new Classes.conexao();
                valida = new validacao();
                string datanow = DateTime.Now.Year + "-" + DateTime.Now.Month + "-" + DateTime.Now.Day;
                string query = "UPDATE sde.INFO_ILUM SET TIPO_BRACO=" + (this.tipo_braco) + "," + "PROJ_BRACO=" + (this.proj_braco) + "," + "TIPO_LUMINARIA=" + (this.tipo_luminaria) + "," + "QUANT_LUMINARIAS=" + (this.quant_luminarias.ToString()) + "," + "TIPO_FONTE_LUMINARIA=" + (this.tipo_fonte_luminaria) + "," + "POTENCIA_FONTE_LUMI=" + (this.potencia_fonte_lumi) + "," + "QUANT_FONTES_LUMI=" + (this.quant_fontes_lumi.ToString()) + "," + "POTENCIA_TOTAL_FONTE_LUMI=" + (this.potencia_total_fonte_lumi.ToString()) + "," + "CARGA_INST_TOTAL_UN_ILUM_PUB=" + (this.carga_inst_total_un_ilum_pub.ToString()) + "," + "TIPO_REATOR=" + (this.tipo_reator) + "," + "TIPO_RELE=" + (this.tipo_rele) + "," + "TIPO_ALIMENTACAO=" + (this.tipo_alimentacao) + "," + "TIPO_POSTE=" + (this.tipo_poste) + "," + "ALTURA_POSTE=" + (this.altura_poste.ToString()) + "," + "ALTURA_INST_LUMI=" + (this.altura_inst_lumi.ToString()) + "," + "LAT=" + (this.lat) + "," + "LONG=" + (this.lng) + "," + "MUNICIPIO=" + (this.municipio) + "," + "REGIONAL=" + (this.regional) + "," + "BAIRRO=" + (this.bairro) + "," + "CLASSE_ILUMI=" + (this.classelumi) + "," + "LOGRADOURO=" + (this.logradouro) + "," + "CEP=" + (this.cep) + "," + "COD_LOGRADOURO=" + (this.cod_logradouro.ToString()) + "," + "ILUM_DESTAQ=" + (this.ilum_destaq.ToString()) + "," + "NOME_LOCAL_DESTAQ=" + (this.nome_local_destaq) + ", MEDICAO=" + (this.medicao.ToString()) +", OBSERVACAO="+(this.observacao)+", ALTERACAO_DATA_INFO='"+datanow+ "', ALTERACAO_USER_INFO= "+cod_login+"  WHERE INFO_ILUM.COD_ILUM_FK =" + (this.cod_un_ilu_pub.ToString());
                int result =conexao.commandExec(query);
                if(result>0)
                {
                    return "Alterado com sucesso";
                }
                return "Codigo não encontrado";
            }
            catch (Exception ex)
            {
                return "Erro: "+ex.Message;
                throw new System.Exception(ex.Message);
            }

        }

        public string delete()
        {
            try
            {
                conexao = new Classes.conexao();
                valida = new validacao();

                string query = "DELETE FROM INFO_ILUM WHERE COD_ILUM_FK =" + this.cod_un_ilu_pub;

                return "";
            }
            catch (Exception ex)
            {
                return "";
                throw new System.Exception(ex.Message);
            }
        }
    }
}