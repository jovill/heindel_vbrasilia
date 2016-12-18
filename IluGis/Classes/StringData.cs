using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace IluGis.Classes
{
    public class StringData
    {
        public String userRole = "";
        public String userID = "";
        public String user = "";
        public String userPw = "";
        public String userName = "";
        public String userPermission = "";
       

        public String recordStatus = "";

        public String toJson()
        {
            String json = "({ " +
                " userID: '" + this.userID
                + "', userName: '" + this.userName + "'"            
                + "', userPw: '" + this.userPw
                + "',  userRole: '" + this.userRole   
                + "', userPermission: '" + this.userPermission + "'"
          
                + " })";
            return json;
        }

    }
}