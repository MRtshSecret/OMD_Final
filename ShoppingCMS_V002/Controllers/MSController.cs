using ShoppingCMS_V002.DBConnect;
using ShoppingCMS_V002.Models;
using System;
using System.Collections.Generic;
using System.Data;
using System.IO;
using System.Linq;
using System.Text;
using System.Web;
using System.Web.Mvc;
using System.Drawing;
using System.Web.UI.WebControls;
using ShoppingCMS_V002.OtherClasses;
using ShoppingCMS_V002.ModelViews;
using Newtonsoft.Json;
using ShoppingCMS_V002.OtherClasses.MasterChi_Fu;

namespace ShoppingCMS_V002.Controllers
{
    public class MSController : Controller
    {
        /////////////////////////////{   START Index   }//////////////////////////////
        public TypeASPX model;
        public type data_type;
        List<type> list_dat = new List<type>();
        // GET: MS


        public ActionResult LoginAuth()
        {
            return View();
        }

        public ActionResult NotAccess()
        {
            string SSSession = ""; if (HttpContext.Request.Cookies["TSHPANDAControll" + StaticLicense.LicName] != null) { HttpCookie cookie = HttpContext.Request.Cookies.Get("TSHPANDAControll" + StaticLicense.LicName); if (cookie != null) { SSSession = cookie.Value; } else { SSSession = "N.A"; } } else { SSSession = "N.A"; }
            CheckAccess check = new CheckAccess(SSSession);
            if (check.HasAccess == true)
            {
                return View();
            }
            else
            {
                return RedirectToAction("LoginAuth");
            }
        }

        /////////////////////////////////////////////////////////// Index : get
        [HttpGet]
        public ActionResult Index()
        {

            string SSSession = ""; if (HttpContext.Request.Cookies["TSHPANDAControll" + StaticLicense.LicName] != null) { HttpCookie cookie = HttpContext.Request.Cookies.Get("TSHPANDAControll" + StaticLicense.LicName); if (cookie != null) { SSSession = cookie.Value; } else { SSSession = "N.A"; } } else { SSSession = "N.A"; }
            CheckAccess check = new CheckAccess(SSSession);
            ViewBag.cke = check.exs;
            if (check.HasAccess)
            {
                ViewBag.hassLogin = false;
                return View();
            }
            //else
            //{
            //    ViewBag.hassLogin = true;
            //    return View();

            //}
            else
                return RedirectToAction("NotAccess");
        }

        /////////////////////////////{   START Opinion   }//////////////////////////////
        public opinion data_op;
        List<opinion> list_op = new List<opinion>();
        [HttpGet]
        public ActionResult Opinion()
        {

            string SSSession = ""; if (HttpContext.Request.Cookies["TSHPANDAControll" + StaticLicense.LicName] != null) { HttpCookie cookie = HttpContext.Request.Cookies.Get("TSHPANDAControll" + StaticLicense.LicName); if (cookie != null) { SSSession = cookie.Value; } else { SSSession = "N.A"; } } else { SSSession = "N.A"; }
            CheckAccess check = new CheckAccess(SSSession);
            if (check.HasAccess)
            {
                return View();
            }
            else
                return RedirectToAction("NotAccess");

        }

        public ActionResult Opinion_show()
        {
            string SSSession = ""; if (HttpContext.Request.Cookies["TSHPANDAControll" + StaticLicense.LicName] != null) { HttpCookie cookie = HttpContext.Request.Cookies.Get("TSHPANDAControll" + StaticLicense.LicName); if (cookie != null) { SSSession = cookie.Value; } else { SSSession = "N.A"; } } else { SSSession = "N.A"; }
            CheckAccess check = new CheckAccess(SSSession);
            if (check.HasAccess)
            {

                PDBC db = new PDBC("PandaMarketCMS", true);
                db.Connect();
                using (DataTable dt = db.Select("SELECT [id_MProduct],[id_Customer],[id_AccByAdmin],[CreateDate],[DateAccepted],[Is_Accepted],[OpinionDescription],[Rate],[ISDELETE],[id_Opinion] FROM [dbo].[tbl_Product_Opinion]"))
                {
                    db.DC();
                    for (int i = 0; i < dt.Rows.Count; i++)
                    {
                        data_op = new opinion();
                        string str = dt.Rows[i]["ISDELETE"].ToString();
                        if (dt.Rows[i]["ISDELETE"].ToString() == "0")
                        {
                            data_op.id_Opinion = dt.Rows[i]["id_Opinion"].ToString();
                            data_op.id_MProduct = dt.Rows[i]["id_MProduct"].ToString();
                            data_op.id_Customer = dt.Rows[i]["id_Customer"].ToString();
                            data_op.CreateDate = dt.Rows[i]["CreateDate"].ToString();
                            data_op.Is_Accepted = dt.Rows[i]["Is_Accepted"].ToString();
                            data_op.OpinionDescription = dt.Rows[i]["OpinionDescription"].ToString();
                            data_op.Rate = dt.Rows[i]["Rate"].ToString();
                            list_op.Add(data_op);
                        }
                    }
                    ViewBag.opin = list_op;
                };


                return View();

            }
            else
                return RedirectToAction("NotAccess");
        }

        public ActionResult get_Opinion(string id, string value)
        {
            string SSSession = ""; if (HttpContext.Request.Cookies["TSHPANDAControll" + StaticLicense.LicName] != null) { HttpCookie cookie = HttpContext.Request.Cookies.Get("TSHPANDAControll" + StaticLicense.LicName); if (cookie != null) { SSSession = cookie.Value; } else { SSSession = "N.A"; } } else { SSSession = "N.A"; }
            CheckAccess check = new CheckAccess(SSSession);
            if (check.HasAccess)
            {

                string res = " ", query_edit;


                PDBC db = new PDBC("PandaMarketCMS", true);
                db.Connect();

                List<ExcParameters> paramss = new List<ExcParameters>();
                ExcParameters parameters = new ExcParameters();

                parameters = new ExcParameters()
                {
                    _KEY = "@id",
                    _VALUE = id
                };

                paramss.Add(parameters);

                if (value == "delete")
                {
                    query_edit = "UPDATE [dbo].[tbl_Product_Opinion] SET [ISDELETE] = @value WHERE [id_Opinion] = @id";

                    parameters = new ExcParameters()
                    {
                        _KEY = "@value",
                        _VALUE = "1"
                    };

                    paramss.Add(parameters);


                    res = db.Script(query_edit, paramss);
                    db.DC();
                }
                else if (value == "on")
                {
                    query_edit = "UPDATE [dbo].[tbl_Product_Opinion] SET [Is_Accepted] = @value ,[DateAccepted] = GETDATE() WHERE  [id_Opinion] = @id";

                    parameters = new ExcParameters()
                    {
                        _KEY = "@value",
                        _VALUE = "1"
                    };

                    paramss.Add(parameters);


                    res = db.Script(query_edit, paramss);
                    db.DC();
                }
                db.DC();
                return RedirectToAction("Opinion");
            }
            else
                return RedirectToAction("NotAccess");
        }
        ///------///////////////////////{   End Opinion   }//////////////////////////////
        ///


        /////////////////////////////{   START About   }//////////////////////////////
        public OpinionAbout data_opAb;
        List<OpinionAbout> list_opAb = new List<OpinionAbout>();

        public companies data_comp;
        List<companies> list_comp = new List<companies>();
        [HttpGet]
        public ActionResult About()
        {

            string SSSession = ""; if (HttpContext.Request.Cookies["TSHPANDAControll" + StaticLicense.LicName] != null) { HttpCookie cookie = HttpContext.Request.Cookies.Get("TSHPANDAControll" + StaticLicense.LicName); if (cookie != null) { SSSession = cookie.Value; } else { SSSession = "N.A"; } } else { SSSession = "N.A"; }
            CheckAccess check = new CheckAccess(SSSession);
            if (check.HasAccess)
            {
                return View();
            }
            else
                return RedirectToAction("NotAccess");

        }

        [HttpGet]
        public ActionResult tab_About()
        {
            string SSSession = ""; if (HttpContext.Request.Cookies["TSHPANDAControll" + StaticLicense.LicName] != null) { HttpCookie cookie = HttpContext.Request.Cookies.Get("TSHPANDAControll" + StaticLicense.LicName); if (cookie != null) { SSSession = cookie.Value; } else { SSSession = "N.A"; } } else { SSSession = "N.A"; }
            CheckAccess check = new CheckAccess(SSSession);
            if (check.HasAccess)
            {
                PDBC db = new PDBC("PandaMarketCMS", true);
                db.Connect();
                using (DataTable dt = db.Select("SELECT [Id_OpinionAbout],[Name_OpinionAbout],[OpinionAbout],[Is_delete]FROM [dbo].[OpinionAbout]"))
                {
                    for (int i = 0; i < dt.Rows.Count; i++)
                    {
                        data_opAb = new OpinionAbout();

                        if (dt.Rows[i]["Is_delete"].ToString() == "0")
                        {
                            data_opAb.Id_OpinionAbout = dt.Rows[i]["Id_OpinionAbout"].ToString();
                            data_opAb.Name_OpinionAbout = dt.Rows[i]["Name_OpinionAbout"].ToString();
                            data_opAb.Opinionabout = dt.Rows[i]["OpinionAbout"].ToString();
                            list_opAb.Add(data_opAb);
                        }
                    }
                    ViewBag.opin_ab = list_opAb;
                };


                using (DataTable dt = db.Select("SELECT [id_companies],[Image],[Name_companies],[Url],[Is_delete]FROM [dbo].[companies]"))
                {
                    for (int i = 0; i < dt.Rows.Count; i++)
                    {
                        data_comp = new companies();

                        if (dt.Rows[i]["Is_delete"].ToString() == "0")
                        {
                            data_comp.id_companies = dt.Rows[i]["id_companies"].ToString();
                            data_comp.Image = dt.Rows[i]["Image"].ToString();
                            data_comp.Name_companies = dt.Rows[i]["Name_companies"].ToString();
                            data_comp.Url = dt.Rows[i]["Url"].ToString();
                            list_comp.Add(data_comp);
                        }
                    }
                    ViewBag.comp = list_comp;
                };

                db.DC();
                return View();
            }
            else
                return RedirectToAction("NotAccess");
        }
        [HttpPost]
        public ActionResult get_About(string image, string title_one, string one, string title_two, string two)
        {

            string SSSession = ""; if (HttpContext.Request.Cookies["TSHPANDAControll" + StaticLicense.LicName] != null) { HttpCookie cookie = HttpContext.Request.Cookies.Get("TSHPANDAControll" + StaticLicense.LicName); if (cookie != null) { SSSession = cookie.Value; } else { SSSession = "N.A"; } } else { SSSession = "N.A"; }
            CheckAccess check = new CheckAccess(SSSession);
            if (check.HasAccess)
            {
                string res = " ", query;

                query = "INSERT INTO [dbo].[About]([Image],[Title_one],[Text_one],[Title_two],[Text_two])VALUES(@Image,@Title_one,@Text_one,@Title_two,@Text_two)";

                PDBC db = new PDBC("PandaMarketCMS", true);


                List<ExcParameters> paramss = new List<ExcParameters>();
                ExcParameters parameters = new ExcParameters();

                parameters = new ExcParameters()
                {
                    _KEY = "@Image",
                    _VALUE = image
                };

                paramss.Add(parameters);

                parameters = new ExcParameters()
                {
                    _KEY = "@Title_one",
                    _VALUE = title_one
                };

                paramss.Add(parameters);

                parameters = new ExcParameters()
                {
                    _KEY = "@Text_one",
                    _VALUE = one
                };

                paramss.Add(parameters);

                parameters = new ExcParameters()
                {
                    _KEY = "@Title_two",
                    _VALUE = title_two
                };

                paramss.Add(parameters);

                parameters = new ExcParameters()
                {
                    _KEY = "@Text_two",
                    _VALUE = two
                };

                paramss.Add(parameters);

                db.Connect();
                res = db.Script(query, paramss);
                db.DC();
                return Content(res);
            }
            else
                return RedirectToAction("NotAccess");
        }
        [HttpPost]
        public ActionResult up_loder()
        {
            string SSSession = ""; if (HttpContext.Request.Cookies["TSHPANDAControll" + StaticLicense.LicName] != null) { HttpCookie cookie = HttpContext.Request.Cookies.Get("TSHPANDAControll" + StaticLicense.LicName); if (cookie != null) { SSSession = cookie.Value; } else { SSSession = "N.A"; } } else { SSSession = "N.A"; }
            CheckAccess check = new CheckAccess(SSSession);
            if (check.HasAccess)
            {
                string str1 = " ";
                string Action = Request["action"];
                string data = Request["data"];
                if (Action != null || !string.IsNullOrEmpty(Action))
                {
                    if (Action == "New")
                    {
                        StringBuilder IMGS = new StringBuilder("");
                        for (int i = 0; i < Request.Files.Count; i++)
                        {

                            HttpPostedFileBase file = Request.Files[i];
                            if (file != null && file.ContentLength > 0)
                            {

                                string fname = Path.GetFileName(file.FileName);
                                string EX = Path.GetExtension(file.FileName);
                                string FileNAME = Guid.NewGuid().ToString() + "-" + fname;
                                string address = Server.MapPath("~/images/" + FileNAME);
                                string URLIMG = Statics.AppendServername("images/" + FileNAME);
                                if (Directory.Exists(Server.MapPath("~/images")))
                                {
                                    file.SaveAs(address);
                                }
                                else
                                {
                                    System.IO.Directory.CreateDirectory(Server.MapPath("~/images"));
                                    file.SaveAs(address);
                                }
                                StringBuilder str = new StringBuilder("");
                                string iiid = $"{DateTime.Now.Millisecond}{DateTime.Now.Minute}{DateTime.Now.Hour}{DateTime.Now.Second}";
                                str.Append("<div class=\"col-xl-3 col-lg-3 col-md-3\"><div class=\"kt-portlet\"><div class=\"kt-portlet__body\"><div class=\"kt-widget__files\"><div class=\"kt-widget__media\"><img class=\"kt-widget__img\" style=\"height:200px;width:200px;\" src=\"");
                                str.Append(URLIMG);
                                str.Append("\" alt=\"image\"></div><input style=\"width:50px;height:50px;background-color:transparent; border:none;\" type=\"text\" value=\"" + URLIMG + "\" id=\"");
                                str.Append($"img{iiid}");
                                str.Append($"\" readonly><button onclick=\"return copytoclipboard('{data}','");
                                str.Append($"{URLIMG}");
                                str.Append("')\" class=\"w-100 btn btn-success\">کپی کردن آدرس تصویر</button></div></div></div></div>");
                                IMGS.Append(str.ToString());


                            }

                        }
                        str1 = IMGS.ToString();
                        // Response.Write(IMGS.ToString());
                    }
                }
                return Content(str1);
            }
            else
                return RedirectToAction("NotAccess");
        }
        [HttpPost]
        public ActionResult data_switch(string _A, string _B, string _C, string data, string value, string id)
        {
            string SSSession = ""; if (HttpContext.Request.Cookies["TSHPANDAControll" + StaticLicense.LicName] != null) { HttpCookie cookie = HttpContext.Request.Cookies.Get("TSHPANDAControll" + StaticLicense.LicName); if (cookie != null) { SSSession = cookie.Value; } else { SSSession = "N.A"; } } else { SSSession = "N.A"; }
            CheckAccess check = new CheckAccess(SSSession);
            if (check.HasAccess)
            {

                string str2 = " ", query;

                PDBC db = new PDBC("PandaMarketCMS", true);

                List<ExcParameters> paramss = new List<ExcParameters>();
                ExcParameters parameters = new ExcParameters();


                db.Connect();
                if (data == "op_about")
                {
                    if (value == "new")
                    {
                        query = "INSERT INTO [OpinionAbout]([Name_OpinionAbout],[OpinionAbout],[Is_delete]) VALUES (@Name_OpinionAbout,@OpinionAbout,0)";
                        parameters = new ExcParameters()
                        {
                            _KEY = "@Name_OpinionAbout",
                            _VALUE = _A
                        };

                        paramss.Add(parameters);
                        parameters = new ExcParameters()
                        {
                            _KEY = "@OpinionAbout",
                            _VALUE = _B
                        };

                        paramss.Add(parameters);

                        str2 = db.Script(query, paramss);

                    }
                    else if (value == "delete")
                    {

                        query = "UPDATE [OpinionAbout]SET [Is_delete] = 1 WHERE [Id_OpinionAbout] = @id";


                        parameters = new ExcParameters()
                        {
                            _KEY = "@id",
                            _VALUE = id
                        };

                        paramss.Add(parameters);

                        str2 = db.Script(query, paramss);

                    }
                }
                else if (data == "comp")
                {
                    if (value == "new")
                    {
                        query = "INSERT INTO [companies]([Image],[Name_companies],[Url],[Is_delete])VALUES(@Image,@Name_companies,@Url,0)";
                        parameters = new ExcParameters()
                        {
                            _KEY = "@Name_companies",
                            _VALUE = _A
                        };

                        paramss.Add(parameters);
                        parameters = new ExcParameters()
                        {
                            _KEY = "@Url",
                            _VALUE = _B
                        };

                        paramss.Add(parameters);
                        parameters = new ExcParameters()
                        {
                            _KEY = "@Image",
                            _VALUE = _C
                        };

                        paramss.Add(parameters);
                        str2 = db.Script(query, paramss);

                    }
                    else if (value == "delete")
                    {

                        query = "UPDATE [dbo].[companies] SET [Is_delete] = 1 WHERE [id_companies] = @id";


                        parameters = new ExcParameters()
                        {
                            _KEY = "@id",
                            _VALUE = id
                        };

                        paramss.Add(parameters);

                        str2 = db.Script(query, paramss);

                    }
                }
                db.DC();
                return Content(str2);

            }
            else
                return RedirectToAction("NotAccess");

        }

        /////////////////////////////{   START Profile   }//////////////////////////////
        //// Session["id_Admin"] این حتما موقع درست کنید

        [HttpGet]
        public ActionResult Profile(int id)
        {

            Session["id_Admin"] = id;

            return View();
        }
        [HttpGet]
        public ActionResult Show_Profile()
        {
            PDBC db = new PDBC("PandaMarketCMS", true);
            db.Connect();

            var id_Admin = Session["id_Admin"];

            using (DataTable dt = db.Select($"SELECT [id_Admin],[ad_type_name],[ad_password],[ad_firstname],[ad_lastname],[ad_avatarprofile],[ad_email],[ad_phone],[ad_mobile],[ad_NickName]FROM [dbo].[tbl_ADMIN_main] inner join [dbo].[tbl_ADMIN_types] on [dbo].[tbl_ADMIN_main].ad_typeID = [dbo].[tbl_ADMIN_types].ad_typeID where [id_Admin] ={id_Admin.ToString()}"))
            {
                db.DC();
                Session["pass"] = dt.Rows[0]["ad_password"].ToString();
                profile data_pro = new profile()
                {

                    ad_avatarprofile = dt.Rows[0]["ad_avatarprofile"].ToString(),
                    ad_type_name = dt.Rows[0]["ad_type_name"].ToString(),
                    ad_firstname = dt.Rows[0]["ad_firstname"].ToString(),
                    ad_lastname = dt.Rows[0]["ad_lastname"].ToString(),
                    ad_NickName = dt.Rows[0]["ad_NickName"].ToString(),
                    ad_phone = dt.Rows[0]["ad_phone"].ToString(),
                    ad_mobile = dt.Rows[0]["ad_mobile"].ToString(),
                    ad_email = dt.Rows[0]["ad_email"].ToString()

                };

                ViewBag.Show_Pro = data_pro;
            };

            return View();
        }
        [HttpPost]
        public ActionResult get_Profile(string A, string B, string C, string D, string E, string F, string G, string value)
        {
            string str = " ", query;

            PDBC db = new PDBC("PandaMarketCMS", true);

            List<ExcParameters> paramss = new List<ExcParameters>();
            ExcParameters parameters = new ExcParameters();

            var id_Admin = Session["id_Admin"];
            var pass = Session["pass"];

            db.Connect();
            if (value == "information")
            {
                query = "UPDATE [dbo].[tbl_ADMIN_main]SET [ad_firstname] = @ad_firstname,[ad_lastname] = @ad_lastname,[ad_avatarprofile] = @ad_avatarprofile,[ad_email] = @ad_email,[ad_phone] = @ad_phone,[ad_mobile] = @ad_mobile,[ad_NickName] = @ad_NickName WHERE [id_Admin] = @id";


                parameters = new ExcParameters()
                {
                    _KEY = "@ad_firstname",
                    _VALUE = A
                };

                paramss.Add(parameters);

                parameters = new ExcParameters()
                {
                    _KEY = "@ad_lastname",
                    _VALUE = B
                };

                paramss.Add(parameters);
                parameters = new ExcParameters()
                {
                    _KEY = "@ad_NickName",
                    _VALUE = C
                };

                paramss.Add(parameters);
                parameters = new ExcParameters()
                {
                    _KEY = "@ad_phone",
                    _VALUE = D
                };

                paramss.Add(parameters);
                parameters = new ExcParameters()
                {
                    _KEY = "@ad_mobile",
                    _VALUE = E
                };

                paramss.Add(parameters);

                parameters = new ExcParameters()
                {
                    _KEY = "@ad_email",
                    _VALUE = F
                };

                paramss.Add(parameters);

                parameters = new ExcParameters()
                {
                    _KEY = "@ad_avatarprofile",
                    _VALUE = G
                };

                paramss.Add(parameters);

                parameters = new ExcParameters()
                {
                    _KEY = "@id",
                    _VALUE = id_Admin
                };

                paramss.Add(parameters);

                str = db.Script(query, paramss);
                db.DC();

            }
            else if (value == "password")
            {

                if (A == pass.ToString())
                {
                    query = "UPDATE [dbo].[tbl_ADMIN_main] SET [ad_password] = @ad_password WHERE [id_Admin] = @id";

                    parameters = new ExcParameters()
                    {
                        _KEY = "@id",
                        _VALUE = id_Admin
                    };

                    paramss.Add(parameters);


                    parameters = new ExcParameters()
                    {
                        _KEY = "@ad_password",
                        _VALUE = B
                    };

                    paramss.Add(parameters);

                    str = db.Script(query, paramss);
                    db.DC();
                }
                else
                {
                    str = "2";
                }
            }

            return Content(str);
        }

        ///------///////////////////////{   End Profile   }//////////////////////////////



        /////////////////////////////{   START Register   }//////////////////////////////
        public ADMIN_types_ruleRoute_Connection data_ADMIN;
        List<ADMIN_types_ruleRoute_Connection> list_ADMIN = new List<ADMIN_types_ruleRoute_Connection>();
        [HttpGet]
        public ActionResult Register(int id)
        {
            Session["id_Admin1"] = id;

            return View();
        }
        [HttpGet]
        public ActionResult show_user()
        {
            PDBC db = new PDBC("PandaMarketCMS", true);

            var id_Admin = Session["id_Admin1"];
            string ad_typeID = " ";

            db.Connect();
            using (DataTable dt = db.Select($"SELECT [id_Admin],[ad_typeID],[ad_typeID],[ad_password],[ad_firstname],[ad_lastname],[ad_avatarprofile],[ad_email],[ad_phone],[ad_mobile],[ad_NickName],[ad_personalColorHexa] FROM [dbo].[tbl_ADMIN_main] where [id_Admin] ={id_Admin.ToString()}"))
            {
                Session["pass"] = dt.Rows[0]["ad_password"].ToString();
                ad_typeID = dt.Rows[0]["ad_typeID"].ToString();
                ModelFiller MF = new ModelFiller();
                profile data_pro = new profile()
                {
                    ad_avatarprofile = MF.AppendServername(dt.Rows[0]["ad_avatarprofile"].ToString()),
                    ad_type_name = dt.Rows[0]["ad_typeID"].ToString(),
                    ad_firstname = dt.Rows[0]["ad_firstname"].ToString(),
                    ad_lastname = dt.Rows[0]["ad_lastname"].ToString(),
                    ad_NickName = dt.Rows[0]["ad_NickName"].ToString(),
                    ad_phone = dt.Rows[0]["ad_phone"].ToString(),
                    ad_mobile = dt.Rows[0]["ad_mobile"].ToString(),
                    ad_email = dt.Rows[0]["ad_email"].ToString(),
                    ad_personalColorHexa = dt.Rows[0]["ad_personalColorHexa"].ToString(),
                    ad_Types = MF.AdminTypes()
                };

                ViewBag.Show_Pro = data_pro;
            }
            using (DataTable dt = db.Select($"SELECT [ad_typeID],[rulerouteID],(SELECT [ruleRouteURL]FROM [PandaMarketCMS].[dbo].[tbl_ADMIN_ruleRoutes_Main]where [rulerouteID]=[PandaMarketCMS].[dbo].[tbl_ADMIN_types_ruleRoute_Connection].[rulerouteID])as[ruleRouteURL],[HasAccess]FROM [PandaMarketCMS].[dbo].[tbl_ADMIN_types_ruleRoute_Connection] where [ad_typeID] ={ad_typeID}"))
            {

                for (int i = 0; i < dt.Rows.Count; i++)
                {

                    data_ADMIN = new ADMIN_types_ruleRoute_Connection();

                    data_ADMIN.ad_typeID = dt.Rows[i]["ad_typeID"].ToString();
                    data_ADMIN.HasAccess = dt.Rows[i]["HasAccess"].ToString();
                    data_ADMIN.rulerouteID = dt.Rows[i]["rulerouteID"].ToString();
                    data_ADMIN.ruleRouteURL = dt.Rows[i]["ruleRouteURL"].ToString();

                    list_ADMIN.Add(data_ADMIN);

                }



                ViewBag.Show_ADMIN = list_ADMIN;
            }
            db.DC();



            return View();
        }
        [HttpPost]
        public ActionResult get_user(string A, string B, string C, string D, string E, string F, string G, string value)
        {
            string str = " ", query;

            PDBC db = new PDBC("PandaMarketCMS", true);

            List<ExcParameters> paramss = new List<ExcParameters>();
            ExcParameters parameters = new ExcParameters();

            var id_Admin = Session["id_Admin1"];
            var pass = Session["pass"];

            var s = G.Split(',');
            var pic = "";
            db.Connect();
            if (s.Length != 0)
            {
                DataTable piC = db.Select("SELECT [PicAddress] FROM [tbl_ADMIN_UploadStructure_ImageAddress] WHERE [PicID]=" + s[0]);
                if (piC.Rows.Count != 0)
                {
                    pic = piC.Rows[0][0].ToString();
                }
            }



            if (value == "information")
            {
                query = "UPDATE [dbo].[tbl_ADMIN_main]SET [ad_firstname] = @ad_firstname,[ad_lastname] = @ad_lastname,[ad_avatarprofile] = @ad_avatarprofile,[ad_email] = @ad_email,[ad_phone] = @ad_phone,[ad_mobile] = @ad_mobile,[ad_NickName] = @ad_NickName WHERE [id_Admin] = @id";


                parameters = new ExcParameters()
                {
                    _KEY = "@ad_firstname",
                    _VALUE = A
                };

                paramss.Add(parameters);

                parameters = new ExcParameters()
                {
                    _KEY = "@ad_lastname",
                    _VALUE = B
                };

                paramss.Add(parameters);
                parameters = new ExcParameters()
                {
                    _KEY = "@ad_NickName",
                    _VALUE = C
                };

                paramss.Add(parameters);
                parameters = new ExcParameters()
                {
                    _KEY = "@ad_phone",
                    _VALUE = D
                };

                paramss.Add(parameters);
                parameters = new ExcParameters()
                {
                    _KEY = "@ad_mobile",
                    _VALUE = E
                };

                paramss.Add(parameters);

                parameters = new ExcParameters()
                {
                    _KEY = "@ad_email",
                    _VALUE = F
                };

                paramss.Add(parameters);

                parameters = new ExcParameters()
                {
                    _KEY = "@ad_avatarprofile",
                    _VALUE = pic
                };

                paramss.Add(parameters);

                parameters = new ExcParameters()
                {
                    _KEY = "@id",
                    _VALUE = id_Admin
                };

                paramss.Add(parameters);

                str = db.Script(query, paramss);

            }
            else if (value == "password")
            {

                if (A == pass.ToString())
                {
                    query = "UPDATE [dbo].[tbl_ADMIN_main] SET [ad_password] = @ad_password WHERE [id_Admin] = @id";

                    parameters = new ExcParameters()
                    {
                        _KEY = "@id",
                        _VALUE = id_Admin
                    };

                    paramss.Add(parameters);


                    parameters = new ExcParameters()
                    {
                        _KEY = "@ad_password",
                        _VALUE = B
                    };

                    paramss.Add(parameters);

                    str = db.Script(query, paramss);
                }
                else
                {
                    str = "2";
                }
            }
            else if (value == "access")
            {
                query = "UPDATE [dbo].[tbl_ADMIN_main]SET [ad_typeID] = @ad_typeID,[ad_personalColorHexa] = @ad_personalColorHexa WHERE [id_Admin] =@id_Admin";
                parameters = new ExcParameters()
                {
                    _KEY = "@ad_typeID",
                    _VALUE = A
                };

                paramss.Add(parameters);

                parameters = new ExcParameters()
                {
                    _KEY = "@ad_personalColorHexa",
                    _VALUE = B
                };

                paramss.Add(parameters);

                parameters = new ExcParameters()
                {
                    _KEY = "@id_Admin",
                    _VALUE = id_Admin
                };

                paramss.Add(parameters);

                str = db.Script(query, paramss);
            }
            db.DC();
            return Content(str);
        }
        ///------///////////////////////{   End Register   }//////////////////////////////


        /////////////////////////////{   START Chart   }//////////////////////////////

        [HttpGet]
        public ActionResult Chart()
        {
            return View();
        }

        [HttpPost]
        public ActionResult data_Chart_one()
        {

            string[] name = new string[] { "فروردین", "اردیبهشت", "خرداد", "تیر", "مرداد", "شهریور", "مهر", "آبان", "آذر", "دی", "بهمن", "اسفند" };
            int[] X = new int[] { 15, 30, 25, 30, 25, 20, 15, 20, 25, 30, 25, 20 };
            int[] Y = new int[] { 15, 30, 25, 30, 25, 20, 15, 20, 25, 30, 25, 20 };


            string _name = "", _X = "", _Y = "";
            int count = name.Length - 1;
            for (int i = 0; i < name.Length; i++)
            {
                if (count != i)
                {
                    string output = JsonConvert.SerializeObject(name[i]);
                    _name += $"{output },";
                    _X += X[i] + ",";
                    _Y += Y[i] + ",";
                }
                else
                {
                    string output = JsonConvert.SerializeObject(name[i]);
                    _name += output;
                    _X += X[i];
                    _Y += Y[i];
                }

            }
            return Content("\"labels\": [" + _name + "],\"dataX\": [" + _X + "],\"dataY\": [" + _Y + "]");
        }

        [HttpPost]
        public ActionResult data_Chart_two()
        {

            string[] name = new string[] { "فروردین", "اردیبهشت", "خرداد", "تیر", "مرداد", "شهریور", "مهر", "آبان", "آذر", "دی", "بهمن", "اسفند" };
            int[] X = new int[] { 15, 30, 25, 30, 25, 20, 15, 20, 25, 30, 25, 20 };

            string _name = "", _X = "";
            int count = name.Length - 1;
            for (int i = 0; i < name.Length; i++)
            {
                if (count != i)
                {
                    string output = JsonConvert.SerializeObject(name[i]);
                    _name += $"{output },";
                    _X += X[i] + ",";
                }
                else
                {
                    string output = JsonConvert.SerializeObject(name[i]);
                    _name += output;
                    _X += X[i];
                }

            }
            return Content("\"labels\": [" + _name + "],\"dataX\": [" + _X + "]");
        }

        [HttpPost]
        public ActionResult data_Chart_Three()
        {

            string[] name = new string[] { "فروردین", "اردیبهشت", "خرداد", "تیر", "مرداد", "شهریور", "مهر", "آبان", "آذر", "دی", "بهمن", "اسفند" };
            int[] X = new int[] { 15, 30, 25, 30, 25, 20, 15, 20, 25, 30, 25, 20 };

            string _name = "", _X = "";
            int count = name.Length - 1;
            for (int i = 0; i < name.Length; i++)
            {
                if (count != i)
                {
                    string output = JsonConvert.SerializeObject(name[i]);
                    _name += $"{output },";
                    _X += X[i] + ",";
                }
                else
                {
                    string output = JsonConvert.SerializeObject(name[i]);
                    _name += output;
                    _X += X[i];
                }

            }
            return Content("\"labels\": [" + _name + "],\"dataX\": [" + _X + "]");
        }


        ///------///////////////////////{   End Chart   }//////////////////////////////

    }
}