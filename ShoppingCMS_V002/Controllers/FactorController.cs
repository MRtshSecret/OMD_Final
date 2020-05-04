using ShoppingCMS_V002.DBConnect;
using ShoppingCMS_V002.OtherClasses;
using ShoppingCMS_V002.OtherClasses.MasterChi_Fu;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;

namespace ShoppingCMS_V002.Controllers
{
    public class FactorController : Controller
    {
        // GET: Factor
        public ActionResult FactorTable(string act="all")
        {
            string SSSession = ""; if (HttpContext.Request.Cookies["TSHPANDAControll" + StaticLicense.LicName] != null) { HttpCookie cookie = HttpContext.Request.Cookies.Get("TSHPANDAControll" + StaticLicense.LicName); if (cookie != null) { SSSession = cookie.Value; } else { SSSession = "N.A"; } } else { SSSession = "N.A"; }
            CheckAccess check = new CheckAccess(SSSession);
            if (check.HasAccess)
            {

            ModelFiller MF = new ModelFiller();
            return View(MF.FactorTableFiller(act));
            }
            else
                return RedirectToAction("NotAccess", "MS");

        }

        public ActionResult Factor_Actions(string ActToDo, int id)
        {
            string SSSession = ""; if (HttpContext.Request.Cookies["TSHPANDAControll" + StaticLicense.LicName] != null) { HttpCookie cookie = HttpContext.Request.Cookies.Get("TSHPANDAControll" + StaticLicense.LicName); if (cookie != null) { SSSession = cookie.Value; } else { SSSession = "N.A"; } } else { SSSession = "N.A"; }
            CheckAccess check = new CheckAccess(SSSession);
            if (check.HasAccess)
            {
                PDBC db = new PDBC("PandaMarketCMS", true);
                db.Connect();
                if (ActToDo == "Delete")
                {
                ///userType --> 1=Admin  ,0=user
                    db.Script("UPDATE [dbo].[tbl_FACTOR_Main] SET [IsDeleted] = 1 ,[delete_by_Id] = 1 ,[delete_UserType] = 2 WHERE Factor_Id=" + id);
                }
                
                return Content("Success");
            }
            else
                return Content("NotAccess");
        }

        public ActionResult FactorView(int Id)
        {
            string SSSession = ""; if (HttpContext.Request.Cookies["TSHPANDAControll" + StaticLicense.LicName] != null) { HttpCookie cookie = HttpContext.Request.Cookies.Get("TSHPANDAControll" + StaticLicense.LicName); if (cookie != null) { SSSession = cookie.Value; } else { SSSession = "N.A"; } } else { SSSession = "N.A"; }
            CheckAccess check = new CheckAccess(SSSession);
            if (check.HasAccess)
            {

            ModelFiller MF = new ModelFiller();
            return View(MF.FactorDetailePage(Id));
            }
            else
                return RedirectToAction("NotAccess", "MS");

        }

        public ActionResult ProductSaleList(string Gp="همه", int Id=0)
        {
            string SSSession = ""; if (HttpContext.Request.Cookies["TSHPANDAControll" + StaticLicense.LicName] != null) { HttpCookie cookie = HttpContext.Request.Cookies.Get("TSHPANDAControll" + StaticLicense.LicName); if (cookie != null) { SSSession = cookie.Value; } else { SSSession = "N.A"; } } else { SSSession = "N.A"; }
            CheckAccess check = new CheckAccess(SSSession);
            if (check.HasAccess)
            {
            ModelFiller MF = new ModelFiller();
            return View(MF.Pro_SaleList(Gp,Id));
            }
            else
                return RedirectToAction("NotAccess", "MS");

        }

        public ActionResult Customers()
        {
            string SSSession = ""; if (HttpContext.Request.Cookies["TSHPANDAControll" + StaticLicense.LicName] != null) { HttpCookie cookie = HttpContext.Request.Cookies.Get("TSHPANDAControll" + StaticLicense.LicName); if (cookie != null) { SSSession = cookie.Value; } else { SSSession = "N.A"; } } else { SSSession = "N.A"; }
            CheckAccess check = new CheckAccess(SSSession);
            if (check.HasAccess)
            {
            ModelFiller MF = new ModelFiller();
            return View(MF.Customers());
            }
            else
                return RedirectToAction("NotAccess", "MS");

        }

        [HttpPost]
        public ActionResult User_Actions(string ActToDo, int id)
        {
            string SSSession = ""; if (HttpContext.Request.Cookies["TSHPANDAControll"] != null) { HttpCookie cookie = HttpContext.Request.Cookies.Get("TSHPANDAControll"); if (cookie != null) { SSSession = cookie.Value; } else { SSSession = "N.A"; } } else { SSSession = "N.A"; }
            CheckAccess check = new CheckAccess(SSSession);
            if (check.HasAccess)
            {
                PDBC db = new PDBC("PandaMarketCMS", true);
                db.Connect();
            if (ActToDo == "Active")
            {
                db.Script("UPDATE [tbl_Customer_Main] SET [C_ISActivate] = 1 WHERE id_Customer=" + id);
            }
            else if (ActToDo == "DeActive")
            {
                db.Script("UPDATE [tbl_Customer_Main] SET [C_ISActivate] = 0 WHERE id_Customer=" + id);
            }
            return Content("Success");
            }
            else
                return Content("NotAccess");
        }

        public ActionResult Customer_Profile(int Id)
        {
            string SSSession = ""; if (HttpContext.Request.Cookies["TSHPANDAControll" + StaticLicense.LicName] != null) { HttpCookie cookie = HttpContext.Request.Cookies.Get("TSHPANDAControll" + StaticLicense.LicName); if (cookie != null) { SSSession = cookie.Value; } else { SSSession = "N.A"; } } else { SSSession = "N.A"; }
            CheckAccess check = new CheckAccess(SSSession);
            if (check.HasAccess)
            {
            ModelFiller MF = new ModelFiller();
            return View(MF.customerDitail(Id));
            }
            else
                return RedirectToAction("NotAccess", "MS");

        }

        public ActionResult Customers_Buy() 
        {
            string SSSession = ""; if (HttpContext.Request.Cookies["TSHPANDAControll" + StaticLicense.LicName] != null) { HttpCookie cookie = HttpContext.Request.Cookies.Get("TSHPANDAControll" + StaticLicense.LicName); if (cookie != null) { SSSession = cookie.Value; } else { SSSession = "N.A"; } } else { SSSession = "N.A"; }
            CheckAccess check = new CheckAccess(SSSession);
            if (check.HasAccess)
            {
            ModelFiller MF = new ModelFiller();
            return View(MF.Customer_Buy());

            }
            else
                return RedirectToAction("NotAccess", "MS");
        }

    }
}