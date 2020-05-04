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
    public class ProductGroupController : Controller
    {

        public ActionResult AddType()
        {
            string SSSession = ""; if (HttpContext.Request.Cookies["TSHPANDAControll" + StaticLicense.LicName] != null) { HttpCookie cookie = HttpContext.Request.Cookies.Get("TSHPANDAControll" + StaticLicense.LicName); if (cookie != null) { SSSession = cookie.Value; } else { SSSession = "N.A"; } } else { SSSession = "N.A"; }
            CheckAccess check = new CheckAccess(SSSession);
            if (check.HasAccess)
            {

                return View();
            }
            else
                return RedirectToAction("NotAccess", "MS");

        }

        public ActionResult TypeTbl()
        {
            string SSSession = ""; if (HttpContext.Request.Cookies["TSHPANDAControll" + StaticLicense.LicName] != null) { HttpCookie cookie = HttpContext.Request.Cookies.Get("TSHPANDAControll" + StaticLicense.LicName); if (cookie != null) { SSSession = cookie.Value; } else { SSSession = "N.A"; } } else { SSSession = "N.A"; }
            CheckAccess check = new CheckAccess(SSSession);
            if (check.HasAccess)
            {
                ProductGroup_ModelFiller MF = new ProductGroup_ModelFiller();
                return View(MF.TypeTbl());

            }
            else
                return RedirectToAction("NotAccess", "MS");
        }

        [HttpPost]
        public ActionResult Add_Update_Type(string ActToDo, string Cat_Name, int id = 0)
        { 
            string SSSession = ""; if (HttpContext.Request.Cookies["TSHPANDAControll" + StaticLicense.LicName] != null) { HttpCookie cookie = HttpContext.Request.Cookies.Get("TSHPANDAControll" + StaticLicense.LicName); if (cookie != null) { SSSession = cookie.Value; } else { SSSession = "N.A"; } } else { SSSession = "N.A"; }
            CheckAccess check = new CheckAccess(SSSession);
            if (check.HasAccess)
            {
                ProductGroup_ModelFiller MF = new ProductGroup_ModelFiller();
                return Content(MF.Add_Update_ProType(ActToDo, Cat_Name, id));
            }
            else
                return Content("NotAccess");
        }

        public ActionResult Type_Actions(string ActToDo, int id)
        {
            string SSSession = ""; if (HttpContext.Request.Cookies["TSHPANDAControll" + StaticLicense.LicName] != null) { HttpCookie cookie = HttpContext.Request.Cookies.Get("TSHPANDAControll" + StaticLicense.LicName); if (cookie != null) { SSSession = cookie.Value; } else { SSSession = "N.A"; } } else { SSSession = "N.A"; }
            CheckAccess check = new CheckAccess(SSSession);
            if (check.HasAccess)
            {
                PDBC db = new PDBC("PandaMarketCMS", true);
            db.Connect();
            if (ActToDo == "Delete")
            {

                db.Script("UPDATE [tbl_Product_Type] SET [ISDelete] = 1 ,[DateDeleted] = GETDATE() WHERE id_PT = " + id);
                db.Script("UPDATE [tbl_Product]SET[ISDELETE] = 1 WHERE [id_Type]=" + id);
                db.Script("UPDATE P SET P.ISDelete=1,P.DateDeleted= GETDATE() FROM[tbl_Product_SubCategory] AS P inner Join [tbl_Product_MainCategory] As M On P.id_MC=M.id_MC where M.id_PT=" + id);
                db.Script("UPDATE [tbl_Product_MainCategory] SET ISDelete = 1 , DateDeleted= GETDATE() WHERE id_PT=" + id);
                db.Script("UPDATE R SET R.ISDelete=1,R.DateDeleted= GETDATE() FROM[tbl_Product_SubCategoryOptionKey]AS R inner Join [tbl_Product_SubCategory] AS P On R.id_SC=P.id_SC inner Join [tbl_Product_MainCategory] As M On P.id_MC=M.id_MC where M.id_PT=" + id);

            }
            else if (ActToDo == "DeActive")
            {

                db.Script("UPDATE[tbl_Product_Type] SET [ISDESABLED] = 1 ,[DateDesabled] = GETDATE()  WHERE id_PT = " + id);
                db.Script("UPDATE [tbl_Product]SET[IS_AVAILABEL] = 0 WHERE [id_Type]=" + id);
                db.Script("UPDATE P SET P.ISDESABLED=1,P.DateDesabled= GETDATE() FROM[tbl_Product_SubCategory] AS P inner Join [tbl_Product_MainCategory] As M On P.id_MC=M.id_MC where M.id_PT=" + id);
                db.Script("UPDATE [tbl_Product_MainCategory] SET ISDESABLED = 1 , DateDesabled= GETDATE() WHERE id_PT=" + id);
                db.Script("UPDATE R SET R.ISDESABLED=1,R.DateDesabled= GETDATE() FROM[tbl_Product_SubCategoryOptionKey]AS R inner Join [tbl_Product_SubCategory] AS P On R.id_SC=P.id_SC inner Join [tbl_Product_MainCategory] As M On P.id_MC=M.id_MC where M.id_PT=" + id);
            }
            else if (ActToDo == "Active")
            {


                db.Script("UPDATE[tbl_Product_Type] SET [ISDESABLED] = 0 ,[DateDesabled] = GETDATE() WHERE id_PT =" + id);
                db.Script("UPDATE [tbl_Product]SET[IS_AVAILABEL] = 1 WHERE [id_Type]=" + id);
                db.Script("UPDATE P SET P.ISDESABLED=0 FROM[tbl_Product_SubCategory] AS P inner Join [tbl_Product_MainCategory] As M On P.id_MC=M.id_MC where M.id_PT=" + id);
                db.Script("UPDATE [tbl_Product_MainCategory] SET ISDESABLED = 0 WHERE id_PT=" + id);
                db.Script("UPDATE R SET R.ISDESABLED=0 FROM[tbl_Product_SubCategoryOptionKey]AS R inner Join [tbl_Product_SubCategory] AS P On R.id_SC=P.id_SC inner Join [tbl_Product_MainCategory] As M On P.id_MC=M.id_MC where M.id_PT=" + id);
            }
            return Content("Success");
            }
            else
                return Content("NotAccess");
        }

        public ActionResult AddMainCat()
        {
            string SSSession = ""; if (HttpContext.Request.Cookies["TSHPANDAControll" + StaticLicense.LicName] != null) { HttpCookie cookie = HttpContext.Request.Cookies.Get("TSHPANDAControll" + StaticLicense.LicName); if (cookie != null) { SSSession = cookie.Value; } else { SSSession = "N.A"; } } else { SSSession = "N.A"; }
            CheckAccess check = new CheckAccess(SSSession);
            if (check.HasAccess)
            {
                ModelFiller MF = new ModelFiller();
                return View(MF.DropFiller("Type"));
            }
            else
                return RedirectToAction("NotAccess", "MS");

        }

        public ActionResult MainCatTbl()
        {
            string SSSession = ""; if (HttpContext.Request.Cookies["TSHPANDAControll" + StaticLicense.LicName] != null) { HttpCookie cookie = HttpContext.Request.Cookies.Get("TSHPANDAControll" + StaticLicense.LicName); if (cookie != null) { SSSession = cookie.Value; } else { SSSession = "N.A"; } } else { SSSession = "N.A"; }
            CheckAccess check = new CheckAccess(SSSession);
            if (check.HasAccess)
            {
                ProductGroup_ModelFiller MF = new ProductGroup_ModelFiller();
                return View(MF.MainCatTbl());
            }
            else
                return RedirectToAction("NotAccess", "MS");

        }

        [HttpPost]
        public ActionResult Add_Update_MainCat(string ActToDo, string Cat_Name, int CatId = 0, int id = 0)
        {
            string SSSession = ""; if (HttpContext.Request.Cookies["TSHPANDAControll" + StaticLicense.LicName] != null) { HttpCookie cookie = HttpContext.Request.Cookies.Get("TSHPANDAControll" + StaticLicense.LicName); if (cookie != null) { SSSession = cookie.Value; } else { SSSession = "N.A"; } } else { SSSession = "N.A"; }
            CheckAccess check = new CheckAccess(SSSession);
            if (check.HasAccess)
            {
                ProductGroup_ModelFiller MF = new ProductGroup_ModelFiller();
            return Content(MF.Add_Update_ProMainCat(ActToDo, Cat_Name, CatId, id));
            }
            else
                return Content("NotAccess");
        }

        public ActionResult Main_Actions(string ActToDo, int id)
        {
            string SSSession = ""; if (HttpContext.Request.Cookies["TSHPANDAControll" + StaticLicense.LicName] != null) { HttpCookie cookie = HttpContext.Request.Cookies.Get("TSHPANDAControll" + StaticLicense.LicName); if (cookie != null) { SSSession = cookie.Value; } else { SSSession = "N.A"; } } else { SSSession = "N.A"; }
            CheckAccess check = new CheckAccess(SSSession);
            if (check.HasAccess)
            {
                PDBC db = new PDBC("PandaMarketCMS", true);
                db.Connect();
            if (ActToDo == "Delete")
            {
                db.Script("UPDATE [tbl_Product_MainCategory] SET [ISDelete] =1 , [DateDeleted] = GETDATE()  WHERE id_MC =" + id);

                db.Script("UPDATE [tbl_Product]SET[ISDELETE] = 1 WHERE [id_MainCategory]=" + id);
                db.Script("UPDATE[tbl_Product_SubCategory] SET[ISDelete] = 1,[DateDeleted] = GETDATE() WHERE [id_MC]=" + id);
                db.Script("UPDATE R SET R.ISDelete=1,R.DateDeleted= GETDATE() FROM[tbl_Product_SubCategoryOptionKey]AS R inner Join [tbl_Product_SubCategory] AS P On R.id_SC=P.id_SC where P.id_MC=" + id);
            }
            else if (ActToDo == "Active")
            {
                db.Script("UPDATE [tbl_Product_MainCategory] SET [ISDESABLED] = 0 , [DateDesabled] = GETDATE() WHERE id_MC=" + id);
                db.Script("UPDATE [tbl_Product]SET[IS_AVAILABEL] = 1 WHERE [id_MainCategory]=" + id);
                db.Script("UPDATE[tbl_Product_SubCategory] SET[ISDESABLED] = 0 WHERE [id_MC]=" + id);
                db.Script("UPDATE R SET R.DateDesabled=0 FROM[tbl_Product_SubCategoryOptionKey]AS R inner Join [tbl_Product_SubCategory] AS P On R.id_SC=P.id_SC where P.id_MC=" + id);
            }
            else if (ActToDo == "DeActive")
            {
                db.Script("UPDATE [tbl_Product_MainCategory] SET [ISDESABLED] = 1 , [DateDesabled] = GETDATE() WHERE id_MC=" + id);
                db.Script("UPDATE [tbl_Product]SET[IS_AVAILABEL] = 0 WHERE [id_MainCategory]=" + id);
                db.Script("UPDATE[tbl_Product_SubCategory] SET[ISDESABLED] = 1,[DateDesabled] = GETDATE() WHERE [id_MC]=" + id);
                db.Script("UPDATE R SET R.ISDESABLED=1,R.DateDesabled= GETDATE() FROM[tbl_Product_SubCategoryOptionKey]AS R inner Join [tbl_Product_SubCategory] AS P On R.id_SC=P.id_SC where P.id_MC=" + id);
            }
            return Content("Success");
            }
            else
                return Content("NotAccess");
        }

        public ActionResult AddSubCat()
        {
            string SSSession = ""; if (HttpContext.Request.Cookies["TSHPANDAControll" + StaticLicense.LicName] != null) { HttpCookie cookie = HttpContext.Request.Cookies.Get("TSHPANDAControll" + StaticLicense.LicName); if (cookie != null) { SSSession = cookie.Value; } else { SSSession = "N.A"; } } else { SSSession = "N.A"; }
            CheckAccess check = new CheckAccess(SSSession);
            if (check.HasAccess)
            {
                ModelFiller MF = new ModelFiller();
                return View(MF.DropFiller("Type"));
            }
            else
                return RedirectToAction("NotAccess", "MS");


        }

        public ActionResult SubCatTbl()
        {
            string SSSession = ""; if (HttpContext.Request.Cookies["TSHPANDAControll" + StaticLicense.LicName] != null) { HttpCookie cookie = HttpContext.Request.Cookies.Get("TSHPANDAControll" + StaticLicense.LicName); if (cookie != null) { SSSession = cookie.Value; } else { SSSession = "N.A"; } } else { SSSession = "N.A"; }
            CheckAccess check = new CheckAccess(SSSession);
            if (check.HasAccess)
            {
                ProductGroup_ModelFiller MF = new ProductGroup_ModelFiller();
                return View(MF.SubCatTbl());
            }
            else
                return RedirectToAction("NotAccess", "MS");

        }

        [HttpPost]
        public ActionResult Add_Update_SubCat(string ActToDo, string Cat_Name, int CatId = 0, int id = 0)
        {
            string SSSession = ""; if (HttpContext.Request.Cookies["TSHPANDAControll" + StaticLicense.LicName] != null) { HttpCookie cookie = HttpContext.Request.Cookies.Get("TSHPANDAControll" + StaticLicense.LicName); if (cookie != null) { SSSession = cookie.Value; } else { SSSession = "N.A"; } } else { SSSession = "N.A"; }
            CheckAccess check = new CheckAccess(SSSession);
            if (check.HasAccess)
            {
                ProductGroup_ModelFiller MF = new ProductGroup_ModelFiller();
            return Content(MF.Add_Update_ProSubCat(ActToDo, Cat_Name, CatId, id));
            }
            else
                return Content("NotAccess");
        }
        public ActionResult Sub_Actions(string ActToDo, int id)
        {
            string SSSession = ""; if (HttpContext.Request.Cookies["TSHPANDAControll" + StaticLicense.LicName] != null) { HttpCookie cookie = HttpContext.Request.Cookies.Get("TSHPANDAControll" + StaticLicense.LicName); if (cookie != null) { SSSession = cookie.Value; } else { SSSession = "N.A"; } } else { SSSession = "N.A"; }
            CheckAccess check = new CheckAccess(SSSession);
            if (check.HasAccess)
            {
                PDBC db = new PDBC("PandaMarketCMS", true);
            db.Connect();
            if (ActToDo == "Delete")
            {
                db.Script("UPDATE [tbl_Product_SubCategory] SET [ISDelete] = 1 , [DateDeleted] = GETDATE()  WHERE id_SC= " + id);
                db.Script("UPDATE [tbl_Product]SET[ISDELETE] = 1 WHERE [id_SubCategory]=" + id);
                db.Script("UPDATE[tbl_Product_SubCategoryOptionKey] SET [ISDelete] =1,[DateDeleted] = GETDATE() WHERE id_SC=" + id);
            }
            else if (ActToDo == "Active")
            {
                db.Script("UPDATE [tbl_Product_SubCategory] SET [ISDESABLED] = 0 , [DateDesabled] = GETDATE() WHERE id_SC=" + id);
                db.Script("UPDATE [tbl_Product]SET[IS_AVAILABEL] = 1 WHERE [id_SubCategory]=" + id);
                db.Script("UPDATE[tbl_Product_SubCategoryOptionKey] SET [ISDESABLED] =0 WHERE id_SC=" + id);
            }
            else if (ActToDo == "DeActive")
            {
                db.Script("UPDATE [tbl_Product_SubCategory] SET [ISDESABLED] =1 , [DateDesabled] = GETDATE() WHERE id_SC=" + id);
                db.Script("UPDATE [tbl_Product]SET[IS_AVAILABEL] = 0 WHERE [id_SubCategory]=" + id);
                db.Script("UPDATE[tbl_Product_SubCategoryOptionKey] SET [ISDESABLED] =1,[DateDesabled] = GETDATE() WHERE id_SC=" + id);
            }
            return Content("Success");
            }
            else
                return Content("NotAccess");
        }

        public ActionResult AddSubCatKey()
        {
            string SSSession = ""; if (HttpContext.Request.Cookies["TSHPANDAControll" + StaticLicense.LicName] != null) { HttpCookie cookie = HttpContext.Request.Cookies.Get("TSHPANDAControll" + StaticLicense.LicName); if (cookie != null) { SSSession = cookie.Value; } else { SSSession = "N.A"; } } else { SSSession = "N.A"; }
            CheckAccess check = new CheckAccess(SSSession);
            if (check.HasAccess)
            {
                ModelFiller MF = new ModelFiller();
                return View(MF.DropFiller("Type"));
            }
            else
                return RedirectToAction("NotAccess", "MS");

        }

        public ActionResult SubCatKeyTbl()
        {
            string SSSession = ""; if (HttpContext.Request.Cookies["TSHPANDAControll" + StaticLicense.LicName] != null) { HttpCookie cookie = HttpContext.Request.Cookies.Get("TSHPANDAControll" + StaticLicense.LicName); if (cookie != null) { SSSession = cookie.Value; } else { SSSession = "N.A"; } } else { SSSession = "N.A"; }
            CheckAccess check = new CheckAccess(SSSession);
            if (check.HasAccess)
            {
                ProductGroup_ModelFiller MF = new ProductGroup_ModelFiller();
                return View(MF.SubCatKeyTbl());
            }
            else
                return RedirectToAction("NotAccess", "MS");

        }

        [HttpPost]
        public ActionResult Add_Update_SubCatKey(string ActToDo, string Cat_Name, int CatId = 0, int id = 0)
        {
            string SSSession = ""; if (HttpContext.Request.Cookies["TSHPANDAControll" + StaticLicense.LicName] != null) { HttpCookie cookie = HttpContext.Request.Cookies.Get("TSHPANDAControll" + StaticLicense.LicName); if (cookie != null) { SSSession = cookie.Value; } else { SSSession = "N.A"; } } else { SSSession = "N.A"; }
            CheckAccess check = new CheckAccess(SSSession);
            if (check.HasAccess)
            {
                ProductGroup_ModelFiller MF = new ProductGroup_ModelFiller();
            return Content(MF.Add_Update_ProSubCatKey(ActToDo, Cat_Name, CatId, id));
            }
            else
                return Content("NotAccess");
        }

        public ActionResult SubKey_Actions(string ActToDo, int id)
        {
            string SSSession = ""; if (HttpContext.Request.Cookies["TSHPANDAControll" + StaticLicense.LicName] != null) { HttpCookie cookie = HttpContext.Request.Cookies.Get("TSHPANDAControll" + StaticLicense.LicName); if (cookie != null) { SSSession = cookie.Value; } else { SSSession = "N.A"; } } else { SSSession = "N.A"; }
            CheckAccess check = new CheckAccess(SSSession);
            if (check.HasAccess)
            {
                PDBC db = new PDBC("PandaMarketCMS", true);
            db.Connect();
            if (ActToDo == "Delete")
            {
                db.Script("UPDATE[tbl_Product_SubCategoryOptionKey] SET [ISDelete] = 1, [DateDeleted] = GETDATE()  WHERE id_SCOK =" + id);
                db.Script("DELETE FROM [tbl_Product_SubCategoryOptionValue] WHERE id_SCOK=" + id);
            }
            else if (ActToDo == "Active")
            {
                db.Script("UPDATE [tbl_Product_SubCategoryOptionKey] SET [ISDESABLED] = 0, [DateDesabled] = GETDATE() WHERE id_SCOK=" + id);
            }
            else if (ActToDo == "DeActive")
            {
                db.Script("UPDATE [tbl_Product_SubCategoryOptionKey] SET [ISDESABLED] = 1 , [DateDesabled] = GETDATE() WHERE id_SCOK=" + id);
            }
            return Content("Success");
            }
            else
                return Content("NotAccess");
        }

        public ActionResult AddSubCatValue()
        {

            string SSSession = ""; if (HttpContext.Request.Cookies["TSHPANDAControll" + StaticLicense.LicName] != null) { HttpCookie cookie = HttpContext.Request.Cookies.Get("TSHPANDAControll" + StaticLicense.LicName); if (cookie != null) { SSSession = cookie.Value; } else { SSSession = "N.A"; } } else { SSSession = "N.A"; }
            CheckAccess check = new CheckAccess(SSSession);
            if (check.HasAccess)
            {
                ModelFiller MF = new ModelFiller();
                return View(MF.DropFiller("Type"));
            }
            else
                return RedirectToAction("NotAccess", "MS");

        }

        public ActionResult SubCatValueTbl()
        {
            string SSSession = ""; if (HttpContext.Request.Cookies["TSHPANDAControll" + StaticLicense.LicName] != null) { HttpCookie cookie = HttpContext.Request.Cookies.Get("TSHPANDAControll" + StaticLicense.LicName); if (cookie != null) { SSSession = cookie.Value; } else { SSSession = "N.A"; } } else { SSSession = "N.A"; }
            CheckAccess check = new CheckAccess(SSSession);
            if (check.HasAccess)
            {
                ProductGroup_ModelFiller MF = new ProductGroup_ModelFiller();
                return View(MF.SubCatvValueTbl());
            }
            else
                return RedirectToAction("NotAccess", "MS");

        }

        [HttpPost]
        public ActionResult Add_Update_SubCatValue(string ActToDo, string Cat_Name, int CatId = 0, int id = 0)
        {
            string SSSession = ""; if (HttpContext.Request.Cookies["TSHPANDAControll" + StaticLicense.LicName] != null) { HttpCookie cookie = HttpContext.Request.Cookies.Get("TSHPANDAControll" + StaticLicense.LicName); if (cookie != null) { SSSession = cookie.Value; } else { SSSession = "N.A"; } } else { SSSession = "N.A"; }
            CheckAccess check = new CheckAccess(SSSession);
            if (check.HasAccess)
            {
                ProductGroup_ModelFiller MF = new ProductGroup_ModelFiller();
            return Content(MF.Add_Update_ProSubCatValue(ActToDo, Cat_Name, CatId, id));
            }
            else
                return Content("NotAccess");
        }

        public ActionResult SubValue_Actions(string ActToDo, int id)
        {
            string SSSession = ""; if (HttpContext.Request.Cookies["TSHPANDAControll" + StaticLicense.LicName] != null) { HttpCookie cookie = HttpContext.Request.Cookies.Get("TSHPANDAControll" + StaticLicense.LicName); if (cookie != null) { SSSession = cookie.Value; } else { SSSession = "N.A"; } } else { SSSession = "N.A"; }
            CheckAccess check = new CheckAccess(SSSession);
            if (check.HasAccess)
            {
                PDBC db = new PDBC("PandaMarketCMS", true);
            db.Connect();
            if (ActToDo == "Delete")
            {
                db.Script("DELETE FROM [tbl_Product_SubCategoryOptionValue] WHERE id_SCOV=" + id);
            }

            return Content("Success");
            }
            else
                return Content("NotAccess");
        }

        public ActionResult AddProductTag()
        {
            string SSSession = ""; if (HttpContext.Request.Cookies["TSHPANDAControll" + StaticLicense.LicName] != null) { HttpCookie cookie = HttpContext.Request.Cookies.Get("TSHPANDAControll" + StaticLicense.LicName); if (cookie != null) { SSSession = cookie.Value; } else { SSSession = "N.A"; } } else { SSSession = "N.A"; }
            CheckAccess check = new CheckAccess(SSSession);
            if (check.HasAccess)
            {

                ModelFiller MF = new ModelFiller();
                return View(MF.DropFiller("Type"));
            }
            else
                return RedirectToAction("NotAccess", "MS");

        }

        public ActionResult ProTagsTbl()
        {
            string SSSession = ""; if (HttpContext.Request.Cookies["TSHPANDAControll" + StaticLicense.LicName] != null) { HttpCookie cookie = HttpContext.Request.Cookies.Get("TSHPANDAControll" + StaticLicense.LicName); if (cookie != null) { SSSession = cookie.Value; } else { SSSession = "N.A"; } } else { SSSession = "N.A"; }
            CheckAccess check = new CheckAccess(SSSession);
            if (check.HasAccess)
            {
                ProductGroup_ModelFiller MF = new ProductGroup_ModelFiller();
                return View(MF.TagsTbl());
            }
            else
                return RedirectToAction("NotAccess", "MS");


        }

        [HttpPost]
        public ActionResult Add_Update_Tag(string ActToDo, string Cat_Name, int CatId = 0, int id = 0)
        {
            string SSSession = ""; if (HttpContext.Request.Cookies["TSHPANDAControll" + StaticLicense.LicName] != null) { HttpCookie cookie = HttpContext.Request.Cookies.Get("TSHPANDAControll" + StaticLicense.LicName); if (cookie != null) { SSSession = cookie.Value; } else { SSSession = "N.A"; } } else { SSSession = "N.A"; }
            CheckAccess check = new CheckAccess(SSSession);
            if (check.HasAccess)
            {
                ProductGroup_ModelFiller MF = new ProductGroup_ModelFiller();
            return Content(MF.Add_Update_ProTags(ActToDo, Cat_Name, CatId, id));
            }
            else
                return Content("NotAccess");
        }
        public ActionResult ProductTag_Actions(string ActToDo, int id)
        {
            string SSSession = ""; if (HttpContext.Request.Cookies["TSHPANDAControll" + StaticLicense.LicName] != null) { HttpCookie cookie = HttpContext.Request.Cookies.Get("TSHPANDAControll" + StaticLicense.LicName); if (cookie != null) { SSSession = cookie.Value; } else { SSSession = "N.A"; } } else { SSSession = "N.A"; }
            CheckAccess check = new CheckAccess(SSSession);
            if (check.HasAccess)
            {
                PDBC db = new PDBC("PandaMarketCMS", true);
            db.Connect();
            if (ActToDo == "Delete")
            {
                db.Script("DELETE FROM [tbl_Product_tagConnector] WHERE id_TE=" + id);
                db.Script("DELETE FROM [tbl_Product_TagEnums] WHERE id_TE=" + id);
            }

            return Content("Success");
            }
            else
                return Content("NotAccess");
        }

        public ActionResult AddMainTag()
        {
            string SSSession = ""; if (HttpContext.Request.Cookies["TSHPANDAControll" + StaticLicense.LicName] != null) { HttpCookie cookie = HttpContext.Request.Cookies.Get("TSHPANDAControll" + StaticLicense.LicName); if (cookie != null) { SSSession = cookie.Value; } else { SSSession = "N.A"; } } else { SSSession = "N.A"; }
            CheckAccess check = new CheckAccess(SSSession);
            if (check.HasAccess)
            {
                return View();
            }
            else
                return RedirectToAction("NotAccess", "MS");

        }
        public ActionResult MainTagsTbl()
        {
            string SSSession = ""; if (HttpContext.Request.Cookies["TSHPANDAControll" + StaticLicense.LicName] != null) { HttpCookie cookie = HttpContext.Request.Cookies.Get("TSHPANDAControll" + StaticLicense.LicName); if (cookie != null) { SSSession = cookie.Value; } else { SSSession = "N.A"; } } else { SSSession = "N.A"; }
            CheckAccess check = new CheckAccess(SSSession);
            if (check.HasAccess)
            {

                ProductGroup_ModelFiller MF = new ProductGroup_ModelFiller();
                return View(MF.MainTagsTbl());
            }
            else
                return RedirectToAction("NotAccess", "MS");

        }

        [HttpPost]
        public ActionResult Add_Update_MainTag(string ActToDo, string Cat_Name, string Discription, int id = 0)
        {
            string SSSession = ""; if (HttpContext.Request.Cookies["TSHPANDAControll" + StaticLicense.LicName] != null) { HttpCookie cookie = HttpContext.Request.Cookies.Get("TSHPANDAControll" + StaticLicense.LicName); if (cookie != null) { SSSession = cookie.Value; } else { SSSession = "N.A"; } } else { SSSession = "N.A"; }
            CheckAccess check = new CheckAccess(SSSession);
            if (check.HasAccess)
            {
                ProductGroup_ModelFiller MF = new ProductGroup_ModelFiller();
            return Content(MF.Add_Update_MainTags(ActToDo, Cat_Name, Discription, id));
            }
            else
                return Content("NotAccess");
        }
        public ActionResult MainTag_Actions(string ActToDo, int id)
        {
            string SSSession = ""; if (HttpContext.Request.Cookies["TSHPANDAControll" + StaticLicense.LicName] != null) { HttpCookie cookie = HttpContext.Request.Cookies.Get("TSHPANDAControll" + StaticLicense.LicName); if (cookie != null) { SSSession = cookie.Value; } else { SSSession = "N.A"; } } else { SSSession = "N.A"; }
            CheckAccess check = new CheckAccess(SSSession);
            if (check.HasAccess)
            {
                PDBC db = new PDBC("PandaMarketCMS", true);
            db.Connect();
            if (ActToDo == "Delete")
            {
                db.Script("DELETE FROM [tbl_Product_MainStarTags]WHERE id_MainStarTag=" + id);
            }

            return Content("Success");
            }
            else
                return Content("NotAccess");
        }


    }
}