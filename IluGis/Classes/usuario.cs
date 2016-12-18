using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace IluGis.Classes
{
    public class usuario
    {
        Classes.conexao conexao;

            public string nome { get; set; }
            public string user { get; set; }
            public string senha { get; set; }
            public string email { get; set; }
            public string permissao { get; set; }

        public usuario() {

            this.nome = string.Empty;
            this.user = string.Empty;
            this.senha = string.Empty;            
            this.email = string.Empty;
            this.permissao = string.Empty;
        }

        public string cadastrar_usuario()
        {
            try {
                conexao = new conexao();

                string query = "INSERT INTO TBL_USUARIO ([NOME_COMPLETO], [USERNAME], [PASSWORD], [EMAIL], [TIPO_PERMISSAO]) VALUES(" + (this.nome) + "," + (this.user) + "," + (this.senha) + "," + (this.email) + "," + (this.permissao) + ")";

                int result = conexao.commandExec(query);

                if (result > 0)
                {
                    return "usuario cadastrado com sucesso!";
                }


                return "usuário não cadastrado, tente novamente.";
            }
            catch (Exception ex) {
                return "Erro: " + ex.Message;
                throw new System.Exception(ex.Message);
            }
            
        }

    }
}