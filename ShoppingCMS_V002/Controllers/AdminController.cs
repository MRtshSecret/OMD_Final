using ShoppingCMS_V002.DBConnect;
using ShoppingCMS_V002.OtherClasses;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using ShoppingCMS_V002.OtherClasses.MasterChi_Fu;
using System.Data;

namespace ShoppingCMS_V002.Controllers
{
    public class AdminController : Controller
    {
        // GET: Admin
        public ActionResult AddAdminType()
        {
            string SSSession = ""; if (HttpContext.Request.Cookies["TSHPANDAControll" + StaticLicense.LicName] != null) { HttpCookie cookie = HttpContext.Request.Cookies.Get("TSHPANDAControll" + StaticLicense.LicName); if (cookie != null) { SSSession = cookie.Value; } else { SSSession = "N.A"; } } else { SSSession = "N.A"; }
            CheckAccess check = new CheckAccess(SSSession);
            if (check.HasAccess)
            {
                ModelFiller MF = new ModelFiller();

                return View(MF.AdminTypeFiller());
            }
            else
                return RedirectToAction("NotAccess", "MS");
        }

        public ActionResult ModalTree(int id = 0)
        {
            string SSSession = ""; if (HttpContext.Request.Cookies["TSHPANDAControll" + StaticLicense.LicName] != null) { HttpCookie cookie = HttpContext.Request.Cookies.Get("TSHPANDAControll" + StaticLicense.LicName); if (cookie != null) { SSSession = cookie.Value; } else { SSSession = "N.A"; } } else { SSSession = "N.A"; }
            CheckAccess check = new CheckAccess(SSSession);
            if (check.HasAccess)
            {
                ModelFiller MF = new ModelFiller();

                return View(MF.Modal_admin_Type(id));
            }
            else
                return RedirectToAction("NotAccess", "MS");
        }

        public ActionResult AdminTbl()
        {
            string SSSession = ""; if (HttpContext.Request.Cookies["TSHPANDAControll" + StaticLicense.LicName] != null) { HttpCookie cookie = HttpContext.Request.Cookies.Get("TSHPANDAControll" + StaticLicense.LicName); if (cookie != null) { SSSession = cookie.Value; } else { SSSession = "N.A"; } } else { SSSession = "N.A"; }
            CheckAccess check = new CheckAccess(SSSession);
            if (check.HasAccess)
            {
                ModelFiller MF = new ModelFiller();

                return View(MF.AdminTypeTbl());
            }
            else
                return RedirectToAction("NotAccess", "MS");
        }

        public ActionResult Add_Update_AdminType(string ActToDo, string Ad_Name, string Routes, int id = 0)
        {
            string SSSession = ""; if (HttpContext.Request.Cookies["TSHPANDAControll" + StaticLicense.LicName] != null) { HttpCookie cookie = HttpContext.Request.Cookies.Get("TSHPANDAControll" + StaticLicense.LicName); if (cookie != null) { SSSession = cookie.Value; } else { SSSession = "N.A"; } } else { SSSession = "N.A"; }
            CheckAccess check = new CheckAccess(SSSession);
            if (check.HasAccess)
            {
                ModelFiller MF = new ModelFiller();

                return Content(MF.Add_Update_AdType_(ActToDo, Ad_Name, Routes, id));
            }
            else
                return RedirectToAction("NotAccess", "MS");
        }

        public ActionResult Add_Admin()
        {
            string SSSession = ""; if (HttpContext.Request.Cookies["TSHPANDAControll" + StaticLicense.LicName] != null) { HttpCookie cookie = HttpContext.Request.Cookies.Get("TSHPANDAControll" + StaticLicense.LicName); if (cookie != null) { SSSession = cookie.Value; } else { SSSession = "N.A"; } } else { SSSession = "N.A"; }
            CheckAccess check = new CheckAccess(SSSession);
            if (check.HasAccess)
            {
                ModelFiller MF = new ModelFiller();
                return View(MF.AdminTypes());
            }
            else
                return RedirectToAction("NotAccess", "MS");


        }

        public ActionResult Save_admin(string name, string last, string nick, string phone, string mobile, string email, string image, string Uname, string pass1, string acc)
        {
            string SSSession = ""; if (HttpContext.Request.Cookies["TSHPANDAControll" + StaticLicense.LicName] != null) { HttpCookie cookie = HttpContext.Request.Cookies.Get("TSHPANDAControll" + StaticLicense.LicName); if (cookie != null) { SSSession = cookie.Value; } else { SSSession = "N.A"; } } else { SSSession = "N.A"; }
            CheckAccess check = new CheckAccess(SSSession);
            if (check.HasAccess)
            {
                PDBC db = new PDBC("PandaMarketCMS", true);
                var s = image.Split(',');
                var pic = "";
                if (s.Length != 0)
                {
                    db.Connect();
                    DataTable piC = db.Select("SELECT [PicAddress] FROM [tbl_ADMIN_UploadStructure_ImageAddress] WHERE [PicID]=" + s[0]);
                    if (piC.Rows.Count != 0)
                    {
                        pic = piC.Rows[0][0].ToString();
                    }
                }
                Encryption ENC = new Encryption();
                string aaa = db.Script("INSERT INTO [tbl_ADMIN_main]VALUES(" + acc + ",N'" + Uname + "',N'" + ENC.MD5Hash(pass1) + "',N'" + name + "',N'" + last + "',N'" + pic + "',N'" + email + "',N'" + phone + "',N'" + mobile + "',0,1,0,GetDate(),GetDate(),Null,GETDATE(),Null,0,N'" + nick + "')");
                db.DC();
                return Content("Success");
            }
            else
                return RedirectToAction("NotAccess", "MS");
        }

        public ActionResult ShowAdmins()
        {
            string SSSession = ""; if (HttpContext.Request.Cookies["TSHPANDAControll" + StaticLicense.LicName] != null) { HttpCookie cookie = HttpContext.Request.Cookies.Get("TSHPANDAControll" + StaticLicense.LicName); if (cookie != null) { SSSession = cookie.Value; } else { SSSession = "N.A"; } } else { SSSession = "N.A"; }
            CheckAccess check = new CheckAccess(SSSession);
            if (check.HasAccess)
            {

                ModelFiller MF = new ModelFiller();
            return View(MF.Admins());
            }
            else
                return RedirectToAction("NotAccess", "MS");
        }

        public ActionResult Admin_Actions(string ActToDo, int id)
        {
            string SSSession = ""; if (HttpContext.Request.Cookies["TSHPANDAControll" + StaticLicense.LicName] != null) { HttpCookie cookie = HttpContext.Request.Cookies.Get("TSHPANDAControll" + StaticLicense.LicName); if (cookie != null) { SSSession = cookie.Value; } else { SSSession = "N.A"; } } else { SSSession = "N.A"; }
            CheckAccess check = new CheckAccess(SSSession);
            if (check.HasAccess)
            {
                PDBC db = new PDBC("PandaMarketCMS", true);
                db.Connect();
                if (ActToDo == "Delete")
                {
                    db.Script("UPDATE [tbl_ADMIN_main] SET [ad_isDelete] = 1 WHERE id_Admin=" + id);
                }
                else if (ActToDo == "Active")
                {
                    db.Script("UPDATE [tbl_ADMIN_main] SET [ad_isActive] = 1 WHERE id_Admin=" + id);
                }
                else if (ActToDo == "DeActive")
                {
                    db.Script("UPDATE [tbl_ADMIN_main] SET [ad_isActive] = 0 WHERE id_Admin=" + id);
                }
                db.DC();
                return Content("Success");
            }
            else
                return RedirectToAction("NotAccess", "MS");
        }

    }
}