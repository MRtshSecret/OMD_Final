using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using Newtonsoft.Json;
using ShoppingCMS_V002.DBConnect;
using ShoppingCMS_V002.Models.Admin;
using ShoppingCMS_V002.Models.ResponseModelsStruct;

namespace ShoppingCMS_V002.OtherClasses
{
    public class CheckAccess
    {
        public bool HasAccess { get; set; }
        public string exs = "Logged In";
        public string AdminId { get; set; }
        public CheckAccess(string sessionss)
        {
            //HasAccess = true;
            //===================================================== coockie check
            if (sessionss == "N.A")
            {
                HasAccess = false;
            }
            else
            {
                Encryption enc = new Encryption();
                string dec = enc.DecryptText(sessionss, "P@nd@Te@m");
                MainAdminView Obj = JsonConvert.DeserializeObject<MainAdminView>(dec);
                AdminId = Obj.id_Admin;
                if (AdminId == "0")
                {
                    HasAccess = true;
                }
                else
                {


                    PDBC db = new PDBC("PandaMarketCMS", true);
                    db.Connect();
                    using (DataTable dt = db.Select("SELECT Count(*) as [RN] FROM [tbl_ADMIN_main] WHERE [id_Admin]  = " + Obj.id_Admin))
                    {

                        if (dt.Rows[0][0].ToString() == "1")
                        {
                            HasAccess = true;
                        }
                        else
                        {
                            HasAccess = false;
                        }
                    }
                    //HasAccess = true;
                }
            }


            //====================================================sessioncheck
            //try
            //{
            //    if (!string.IsNullOrEmpty(HttpContext.Current.Session["login"].ToString()))
            //    {
            //        exs += "HttpContext.Current.Session[\"login\"] != null \n";
            //        if (HttpContext.Current.Session["login"].ToString() == "1")
            //        {
            //            HttpContext.Current.Session["login"] = "1";
            //            exs += "HttpContext.Current.Session[\"login\"] == 1 \n";
            //            HasAccess = true;

            //        }
            //        else
            //        {
            //            HasAccess = false;
            //            exs += "HttpContext.Current.Session[\"login\"] != 1 \n";
            //        }
            //    }
            //    else
            //    {

            //        HasAccess = false;
            //        exs += "HttpContext.Current.Session[\"login\"] == null \n";
            //    }
            //}
            //catch (Exception e)
            //{
            //    HasAccess = false;
            //    exs += "\n" + e.ToString();
            //}

        }
    }
}