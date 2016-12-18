using Newtonsoft.Json.Linq;
using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Net;
using System.Web;
using System.Xml;

namespace IluGis.Classes
{
    public class Geocode
    {
        private string fonte;
        validacao validar;

        public Geocode()
        {
            this.fonte = string.Empty;
        }
        public string getFonte()
        {
            return this.fonte;
        }
        public string getFonte(int fonte)
        {
            string fonteText = "";
            switch (fonte)
            {
                case 1:
                    fonteText = "Google";
                    break;
                case 2:
                    fonteText = "Nominatim";
                    break;
                case 3:
                    fonteText = "Bing";
                    break;
                case 4:
                    fonteText = "Yahoo";
                    break;
                default:
                    fonteText = "Não definido";
                    break;
            }
            return fonteText;
        }


        //função para fazer geocodereverso late long e transforma em endereco
        public string geocodeReverso(int fonte, string lat, string lng, string email)
        {
            //inicializa variavel vazia
            string url = string.Empty;
            //inicializa um conjuto de tabela
            DataSet dsResult = new DataSet();
            //chama a função que retorna a url de acordo com os parametros informados
            url = getURL(fonte, lat, lng, email);
            //chama a função para requisição da url informada e retorna um conjunto de tabela arquivo XML


            return requestURL(url);
        }

        private string getURL(int fonte, string lat, string lng, string email)
        {
            //inicializa variavel vazia
            string url = string.Empty;

            ///verificar qual fonte para definir url
            switch (fonte)
            {
                case 1:
                    //google
                    url = "http://maps.google.com/maps/api/geocode/json?latlng=" + lat + "," + lng;
                    this.fonte = "Google";
                    break;

                case 2:
                    //nominatim
                    url = "http://nominatim.openstreetmap.org/reverse?format=xml&lat=" + lat + "&lon=" + lng + "&email=" + email;
                    this.fonte = "Nominatim";

                    break;
                case 3:
                    //Bing
                    string key = "iQ598x9Ach0U3IlXHzs3~KbAwH5K6fe972oe2EEP_zg~AulzAZzOfcyXLxUTM94njWp8ZONS1LNTECMylnAmNXtRYtKkvY5RFVgwdBkAfFKt";
                    url = "http://dev.virtualearth.net/REST/v1/Locations/" + lat + "," + lng + "?o=json&key=" + key;
                    this.fonte = "Bing";

                    break;

            }

            //retorna a url de acordo com a fonte
            return url;
        }
        public string DownloadString(string url)
        {
            WebClient client = new WebClient();
            string reply = client.DownloadString(url);

            return reply;
        }
        private string requestURL(string url)
        {
            try
            {
                //inicializa um conjuto de tabela
                DataSet dsResult = new DataSet();
                ///cria um objeto para requisição com a url informada
                //WebRequest request = WebRequest.Create(url);


                XmlTextReader readerxml = new XmlTextReader(url);

                //string txtxml = DownloadString(url);
                string txtjson = DownloadString(url);





               
                ////retorna o conjunto de tabelas
                return txtjson;

            }
            catch (Exception ex)
            {
                ////inicializa um conjunto de tabela
                //DataSet dsErro = new DataSet();
                ////adiciona uma tabela vazia
                //dsErro.Tables.Add("Erro");
                ////adiciona um coluna chamada Erro
                //dsErro.Tables["Erro"].Columns.Add(new DataColumn("Erro"));
                ////adiciona uma linha  com indice 1 e a informação da excesão
                //dsErro.Tables["Erro"].Rows.Add(new object[] { 1, ex.Message }); 
                ////retornar o conjunto de tabela com erro
                return "Erro(0x00101) : " + ex.Message;

            }

        }
        public string[] resultJsonReversoGeo(string txtreturn, int fonte)
        {
            string numero = "NULL";
            string logradouro = "NULL";
            string bairro = "NULL";
            string cidade = "NULL";
            string estado = "NULL";
            string pais = "NULL";
            string cep = "NULL";
            string lat = "NULL";
            string lng = "NULL";
            string precisao = "NULL";
            string complemento = "NULL";
            string[] row = new string[12];
            dynamic json;
            string type = "";

            validar = new validacao();

            try
            {
                switch (fonte)
                {

                    case 1://GOOGLE
                        json = JValue.Parse(txtreturn);
                        if (json.status == "OK")
                        {
                            precisao = json.results[0].geometry.location_type;
                            lat = json.results[0].geometry.location.lat;
                            lng = json.results[0].geometry.location.lng;
                            for (int i = 0; i < json.results.Count; i++)
                            {
                                for (int j = 0; j < json.results[i].address_components.Count; j++)
                                {
                                    type = json.results[i].address_components[j].types[0];

                                    if (type == "premise")
                                    {
                                        complemento = json.results[i].address_components[j].long_name;
                                        complemento = "NULL";
                                    }
                                    else if (type == "street_number")
                                    {
                                        numero = json.results[i].address_components[j].long_name;
                                        if (numero.Contains("-"))
                                        {
                                            numero = validar.calcMedia(numero.Split('-')).ToString();
                                        }

                                        numero = validar.removeCaracter(numero);


                                    }
                                    else if (type == "route")
                                    {
                                        logradouro = json.results[i].address_components[j].long_name;
                                    }
                                    else if (type == "sublocality_level_1")
                                    {
                                        bairro = json.results[i].address_components[j].long_name;
                                    }
                                    else if (type == "locality")
                                    {
                                        cidade = json.results[i].address_components[j].long_name;
                                    }
                                    else if (type == "administrative_area_level_1")
                                    {
                                        estado = json.results[i].address_components[j].long_name;
                                    }
                                    else if (type == "country")
                                    {
                                        pais = json.results[i].address_components[j].long_name;
                                    }
                                    else if (type == "postal_code")
                                    {
                                        cep = json.results[i].address_components[j].long_name;
                                    }


                                }

                                if (numero != "NULL" && logradouro != "NULL" && bairro != "NULL" && cidade != "NULL" && estado != "NULL" && pais != "NULL" && cep != "NULL")//se tudo completado break
                                {
                                    break;
                                }
                                break;

                            }

                            row = new string[] { validar.formatUTF8(bairro), validar.formatUTF8(logradouro), validar.formatUTF8(numero), validar.formatUTF8(cidade), validar.formatUTF8(complemento), validar.formatUTF8(cep), validar.formatUTF8(estado), validar.formatUTF8(pais), lat, lng, "Google", precisao };
                        }
                        else//fim status
                        {
                            row = new string[] { "Erro(0x00101):", "Erro de requisição", "Messagem original:" + json.status, "", "", "", "", "", "", "", "", "" };
                        }


                        break;//fim case 1

                    case 2://nominatim
                        break;

                    case 3://bing
                        json = JValue.Parse(txtreturn);
                        //DataSet ds = new DataSet();
                        // XmlDocument docxml = new XmlDocument();
                        // docxml.LoadXml(txtreturn);        
                        // ds.ReadXml(new XmlNodeReader(docxml));
                        //if (ds.Tables["Response"].Rows[0]["StatusDescription"].ToString() == "OK")
                        //{
                        //    if (ds.Tables["Address"].Rows[0]["AddressLine"].ToString().Contains(","))
                        //    {
                        //        logradouro = ds.Tables["Address"].Rows[0]["AddressLine"].ToString().Split(',')[0];
                        //        numero = ds.Tables["Address"].Rows[0]["AddressLine"].ToString().Split(',')[1].Trim();
                        //    }
                        //    else
                        //    {
                        //        logradouro = ds.Tables["Address"].Rows[0]["AddressLine"].ToString();
                        //    }
                        //    row = new string[] { "NULL", logradouro, numero, ds.Tables["Address"].Rows[0]["Locality"].ToString(), "NULL", ds.Tables["Address"].Rows[0]["PostalCode"].ToString(), ds.Tables["Address"].Rows[0]["AdminDistrict"].ToString(),"Brasil",ds.Tables["Point"].Rows[0]["Latitude"].ToString(), ds.Tables["Point"].Rows[0]["Longitude"].ToString(), "Bing", ds.Tables["GeocodePoint"].Rows[0]["CalculationMethod"].ToString(), pk };
                        //}
                        //else
                        //{
                        //    row = new string[] { "Erro", "Não possui resultados", "", "", "", "", "", "", "", "", "", pk };
                        //}

                        if (json.statusDescription == "OK")
                        {
                            //precisao = json.results[0].geometry.location_type;
                            //lat = json.results[0].geometry.location.lat;
                            //lng = json.results[0].geometry.location.lng;


                            for (int i = 0; i < json.resourceSets.Count; i++)
                            {

                                for (int j = 0; j < json.resourceSets[i].resources.Count; j++)
                                {
                                    dynamic teste1 = json.resourceSets[i].resources[j].o.SelectToken("$.Manufacturers[?(@.Name == 'address')]");
                                    dynamic teste2 = json.resourceSets[i].resources.Children()["address"];
                                    dynamic teste3 = json.resourceSets[i].resources.SelectToken("address");
                                    dynamic teste = json.resourceSets[i].resources.Contains("address");









                                    type = json.resourceSets[i].resources[j].address.addressLine;//////address line
                                    if (type != "null" && type != "NULL" || type != "")
                                    {
                                        if (logradouro == "NULL" || numero == "NULL")
                                        {
                                            if (type.Contains(","))
                                            {
                                                logradouro = type.Split(',')[0];
                                                numero = type.Split(',')[1];
                                            }
                                            else if (type.Contains('-'))
                                            {

                                            }
                                            else
                                            {
                                                logradouro = type;
                                            }

                                        }

                                    }
                                    //////////////////////////fim addres line

                                    estado = json.resourceSets[i].resources[j].address.adminDistrict;//estado

                                    pais = json.resourceSets[i].resources[j].address.countryRegion;//pais

                                    cep = json.resourceSets[i].resources[j].address.postalCode;//cep

                                    cidade = json.resourceSets[i].resources[j].address.locality;//cidade

                                    type = json.resourceSets[i].resources[j].geocodePoints[0].type;
                                    if (type == "Point")
                                    {
                                        lat = json.resourceSets[i].resources[j].geocodePoints[0].coordinates[0];
                                        lng = json.resourceSets[i].resources[j].geocodePoints[0].coordinates[1];
                                        precisao = json.resourceSets[i].resources[j].geocodePoints[0].calculationMethod;
                                    }




                                }
                                if (numero != "NULL" && logradouro != "NULL" && bairro != "NULL" && cidade != "NULL" && estado != "NULL" && pais != "NULL" && cep != "NULL" && complemento != "NULL")//se tudo completado break
                                {
                                    break;
                                }

                            }


                            row = new string[] { validar.formatUTF8(bairro), validar.formatUTF8(logradouro), validar.formatUTF8(numero), validar.formatUTF8(cidade), validar.formatUTF8(complemento), validar.formatUTF8(cep), validar.formatUTF8(estado), validar.formatUTF8(pais), lat, lng, "Bing", precisao };

                        }
                        else//fim status
                        {
                            row = new string[] { "Erro(0x00101):", "Erro de requisição", "Messagem original:" + json.status, "", "", "", "", "", "", "", "", "" };
                        }


                        break;

                    default:

                        row = new string[] { "Erro", "Fonte não encontrada", "", "", "", "", "", "", "", "", "", };
                        break;




                }




                return row;
            }
            catch (Exception ex)
            {
                string erro = ex.Message;
                return row = new string[] { "Erro(0x00103):", "Erro de formatação", "Messagem original:" + erro, "", "", "", "", "", "", "", "", "" };

            }

        }


    }
}