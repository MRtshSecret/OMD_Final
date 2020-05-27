using ShoppingCMS_V002.DBConnect;
using ShoppingCMS_V002.ModelViews;
using ShoppingCMS_V002.OtherClasses;
using ShoppingCMS_V002.OtherClasses.Blog;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using ShoppingCMS_V002.Models.Blog;
using ShoppingCMS_V002.OtherClasses.MasterChi_Fu;

namespace ShoppingCMS_V002.Controllers
{
    public class BlogMainController : Controller
    {
        public ActionResult NewBlogPost()
        {
             string SSSession = ""; if (HttpContext.Request.Cookies["TSHPANDAControll"+ StaticLicense.LicName] != null)  { HttpCookie cookie = HttpContext.Request.Cookies.Get("TSHPANDAControll"+ StaticLicense.LicName); if (cookie != null) { SSSession = cookie.Value; } else { SSSession = "N.A"; } } else { SSSession = "N.A"; } CheckAccess check = new CheckAccess(SSSession);
            if (check.HasAccess)
            {
                //ControllerContext.ParentActionViewContext.ViewBag.PageTitle = "";
                Blog_ModelFiller BMF = new Blog_ModelFiller();
                var Model = new Blog_Post_insert_Model()
                {
                    
                    Category = BMF.BCategory_Filler(),
                    Groups = BMF.Groups_Filler(),
                    Type= BMF.B_Types_Filler(),
                    PostData = new PostModel()
                    {
                        Id = 0,
                        AdminPic = "",
                        Category = "",
                        ImagePath = "",
                        InGroup = "",
                        title = "",
                         text_min = "",
                         text = "",
                         tags = "",date = "",by = "",Tags = new List<string>(),Comments__ = 0,IsDeleted = 0,IsDisabled = 0,IsImportant = 0,SearchGravity = 0
                    }
                    
                };



                return View(Model);
            }
            else
                return RedirectToAction("NotAccess", "MS");

        }

        [HttpPost]
        public ActionResult Add_Edit_Post(string ActTodo, int WrittenBy_AdminId, string Title, string Text_min, string Text, int weight, int Cat_Id, int IsImportant, int GroupId, string Pictures, string Blog_Tags,int TypeId, int id_pr = 0)
        {
            string SSSession = ""; if (HttpContext.Request.Cookies["TSHPANDAControll" + StaticLicense.LicName] != null) { HttpCookie cookie = HttpContext.Request.Cookies.Get("TSHPANDAControll" + StaticLicense.LicName); if (cookie != null) { SSSession = cookie.Value; } else { SSSession = "N.A"; } } else { SSSession = "N.A"; }
            CheckAccess check = new CheckAccess(SSSession);
            if (check.HasAccess)
            {
                Blog_ModelFiller BMF = new Blog_ModelFiller();

                return Content(BMF.Post_Action(ActTodo, WrittenBy_AdminId, Title, Text_min, Text, weight, Cat_Id, IsImportant, GroupId, Pictures, Blog_Tags,TypeId, id_pr));
            }
            else
                return RedirectToAction("NotAccess", "MS");
        }

        [HttpPost]
        public ActionResult TagFiller(int CatId)
        {
            string SSSession = ""; if (HttpContext.Request.Cookies["TSHPANDAControll" + StaticLicense.LicName] != null) { HttpCookie cookie = HttpContext.Request.Cookies.Get("TSHPANDAControll" + StaticLicense.LicName); if (cookie != null) { SSSession = cookie.Value; } else { SSSession = "N.A"; } } else { SSSession = "N.A"; }
            CheckAccess check = new CheckAccess(SSSession);
            if (check.HasAccess)
            {
                Blog_ModelFiller BMF = new Blog_ModelFiller();
                var model = BMF.B_Tags_Filler(CatId);
                return Json(model);
            }
            else
                return RedirectToAction("NotAccess", "MS");
        }
        public ActionResult Add_Update_Category(string ActToDo,string Cat_Name,int id=0)
        {
            string SSSession = ""; if (HttpContext.Request.Cookies["TSHPANDAControll" + StaticLicense.LicName] != null) { HttpCookie cookie = HttpContext.Request.Cookies.Get("TSHPANDAControll" + StaticLicense.LicName); if (cookie != null) { SSSession = cookie.Value; } else { SSSession = "N.A"; } } else { SSSession = "N.A"; }
            CheckAccess check = new CheckAccess(SSSession);
            if (check.HasAccess)
            {
                Blog_ModelFiller BMF = new Blog_ModelFiller();
                // var model = BMF.B_Tags_Filler(CatId);
                return Content(BMF.Add_Update_Category(ActToDo,Cat_Name,id));
                //return Content("hello");
            }
            else
                return RedirectToAction("NotAccess", "MS");
        }

        public ActionResult Add_Blog_Category()
        {
             string SSSession = ""; if (HttpContext.Request.Cookies["TSHPANDAControll"+ StaticLicense.LicName] != null)  { HttpCookie cookie = HttpContext.Request.Cookies.Get("TSHPANDAControll"+ StaticLicense.LicName); if (cookie != null) { SSSession = cookie.Value; } else { SSSession = "N.A"; } } else { SSSession = "N.A"; } CheckAccess check = new CheckAccess(SSSession);
            if (check.HasAccess)
            {
                return View();
            }
            else
                return RedirectToAction("NotAccess", "MS");
        }

        public ActionResult Add_Update_Group(string ActToDo, string G_Name,string G_Token, int id = 0)
        {
            string SSSession = ""; if (HttpContext.Request.Cookies["TSHPANDAControll" + StaticLicense.LicName] != null) { HttpCookie cookie = HttpContext.Request.Cookies.Get("TSHPANDAControll" + StaticLicense.LicName); if (cookie != null) { SSSession = cookie.Value; } else { SSSession = "N.A"; } } else { SSSession = "N.A"; }
            CheckAccess check = new CheckAccess(SSSession);
            if (check.HasAccess)
            {
                Blog_ModelFiller BMF = new Blog_ModelFiller();
                // var model = BMF.B_Tags_Filler(CatId);
                return Content(BMF.Add_Update_Group(ActToDo, G_Name,G_Token, id));
                //return Content("hello");
            }
            else
                return RedirectToAction("NotAccess", "MS");
        }

        public ActionResult Add_Blog_Group()
        {
             string SSSession = ""; if (HttpContext.Request.Cookies["TSHPANDAControll"+ StaticLicense.LicName] != null)  { HttpCookie cookie = HttpContext.Request.Cookies.Get("TSHPANDAControll"+ StaticLicense.LicName); if (cookie != null) { SSSession = cookie.Value; } else { SSSession = "N.A"; } } else { SSSession = "N.A"; } CheckAccess check = new CheckAccess(SSSession);
            if (check.HasAccess)
            {
                return View();
            }
            else
                return RedirectToAction("NotAccess", "MS");
        }

        public ActionResult Add_Update_Tags(string ActToDo, string T_Name,int CatId, int id = 0)
        {
            string SSSession = ""; if (HttpContext.Request.Cookies["TSHPANDAControll" + StaticLicense.LicName] != null) { HttpCookie cookie = HttpContext.Request.Cookies.Get("TSHPANDAControll" + StaticLicense.LicName); if (cookie != null) { SSSession = cookie.Value; } else { SSSession = "N.A"; } } else { SSSession = "N.A"; }
            CheckAccess check = new CheckAccess(SSSession);
            if (check.HasAccess)
            {
                Blog_ModelFiller BMF = new Blog_ModelFiller();
                // var model = BMF.B_Tags_Filler(CatId);
                return Content(BMF.Add_Update_Tag(ActToDo, T_Name, CatId, id));
                //return Content("hello");
            }
            else
                return RedirectToAction("NotAccess", "MS");
        }

        public ActionResult Add_Blog_Tags()
        {
             string SSSession = ""; if (HttpContext.Request.Cookies["TSHPANDAControll"+ StaticLicense.LicName] != null)  { HttpCookie cookie = HttpContext.Request.Cookies.Get("TSHPANDAControll"+ StaticLicense.LicName); if (cookie != null) { SSSession = cookie.Value; } else { SSSession = "N.A"; } } else { SSSession = "N.A"; } CheckAccess check = new CheckAccess(SSSession);
            if (check.HasAccess)
            {
                Blog_ModelFiller BMF = new Blog_ModelFiller();
                return View(BMF.BCategory_Filler());
            }
            else
                return RedirectToAction("NotAccess", "MS");
        }

        public ActionResult Blog_catTable()
        {
             string SSSession = ""; if (HttpContext.Request.Cookies["TSHPANDAControll"+ StaticLicense.LicName] != null)  { HttpCookie cookie = HttpContext.Request.Cookies.Get("TSHPANDAControll"+ StaticLicense.LicName); if (cookie != null) { SSSession = cookie.Value; } else { SSSession = "N.A"; } } else { SSSession = "N.A"; } CheckAccess check = new CheckAccess(SSSession);
            if (check.HasAccess)
            {
                Blog_ModelFiller BMF = new Blog_ModelFiller();
                return View(BMF.Blog_CategoryTable());
            }
            else
                return RedirectToAction("NotAccess", "MS");
        }

        public ActionResult BlogCat_Actions(string ActToDo, int id)
        {
             string SSSession = ""; if (HttpContext.Request.Cookies["TSHPANDAControll"+ StaticLicense.LicName] != null)  { HttpCookie cookie = HttpContext.Request.Cookies.Get("TSHPANDAControll"+ StaticLicense.LicName); if (cookie != null) { SSSession = cookie.Value; } else { SSSession = "N.A"; } } else { SSSession = "N.A"; } CheckAccess check = new CheckAccess(SSSession);
            if (check.HasAccess)
            {
                PDBC db = new PDBC("PandaMarketCMS", true);
                db.Connect();
                if (ActToDo == "Delete")
                {
                    db.Script("UPDATE [tbl_BLOG_Categories] SET [Is_Deleted] = 1 WHERE Id=" + id);
                    db.Script("UPDATE [tbl_BLOG_Tags] SET [Is_Deleted] = 1 WHERE CtegoryId=" + id);
                }
                else if (ActToDo == "Active")
                {
                    db.Script("UPDATE [tbl_BLOG_Categories] SET[Is_Disabled] = 0 WHERE Id=" + id);
                    db.Script("UPDATE [tbl_BLOG_Tags] SET [Is_Disabled] = 0 WHERE CtegoryId=" + id);
                }
                else if (ActToDo == "DeActive")
                {
                    db.Script("UPDATE [tbl_BLOG_Categories] SET[Is_Disabled] = 1 WHERE Id=" + id);
                    db.Script("UPDATE [tbl_BLOG_Tags] SET [Is_Disabled] = 1 WHERE CtegoryId=" + id);
                }
                db.DC();
                return Content("Success");
            }
            else
                return RedirectToAction("NotAccess", "MS");
        }

        public ActionResult Blog_GroupTable()
        {
             string SSSession = ""; if (HttpContext.Request.Cookies["TSHPANDAControll"+ StaticLicense.LicName] != null)  { HttpCookie cookie = HttpContext.Request.Cookies.Get("TSHPANDAControll"+ StaticLicense.LicName); if (cookie != null) { SSSession = cookie.Value; } else { SSSession = "N.A"; } } else { SSSession = "N.A"; } CheckAccess check = new CheckAccess(SSSession);
            if (check.HasAccess)
            {
                Blog_ModelFiller BMF = new Blog_ModelFiller();
                return View(BMF.Blog_GroupTable());
            }
            else
                return RedirectToAction("NotAccess", "MS");
        }

        public ActionResult BlogGroup_Actions(string ActToDo, int id)
        {
             string SSSession = ""; if (HttpContext.Request.Cookies["TSHPANDAControll"+ StaticLicense.LicName] != null)  { HttpCookie cookie = HttpContext.Request.Cookies.Get("TSHPANDAControll"+ StaticLicense.LicName); if (cookie != null) { SSSession = cookie.Value; } else { SSSession = "N.A"; } } else { SSSession = "N.A"; } CheckAccess check = new CheckAccess(SSSession);
            if (check.HasAccess)
            {
                PDBC db = new PDBC("PandaMarketCMS", true);
                db.Connect();
                if (ActToDo == "Delete")
                {
                    db.Script("UPDATE [tbl_BLOG_Groups] SET [Is_Deleted] = 1 WHERE G_Id=" + id);
                }
                else if (ActToDo == "Active")
                {
                    db.Script("UPDATE [tbl_BLOG_Groups] SET[Is_Disabled] = 0 WHERE G_Id=" + id);
                }
                else if (ActToDo == "DeActive")
                {
                    db.Script("UPDATE [tbl_BLOG_Groups] SET[Is_Disabled] = 1 WHERE G_Id=" + id);
                }
                db.DC();
                return Content("Success");
            }
            else
                return RedirectToAction("NotAccess", "MS");
        }

        public ActionResult Blog_TagTable()
        {
             string SSSession = ""; if (HttpContext.Request.Cookies["TSHPANDAControll"+ StaticLicense.LicName] != null)  { HttpCookie cookie = HttpContext.Request.Cookies.Get("TSHPANDAControll"+ StaticLicense.LicName); if (cookie != null) { SSSession = cookie.Value; } else { SSSession = "N.A"; } } else { SSSession = "N.A"; } CheckAccess check = new CheckAccess(SSSession);
            if (check.HasAccess)
            {
                Blog_ModelFiller BMF = new Blog_ModelFiller();
                return View(BMF.Blog_TagTable());
            }
            else
                return RedirectToAction("NotAccess", "MS");
        }

        public ActionResult BlogTag_Actions(string ActToDo, int id)
        {
             string SSSession = ""; if (HttpContext.Request.Cookies["TSHPANDAControll"+ StaticLicense.LicName] != null)  { HttpCookie cookie = HttpContext.Request.Cookies.Get("TSHPANDAControll"+ StaticLicense.LicName); if (cookie != null) { SSSession = cookie.Value; } else { SSSession = "N.A"; } } else { SSSession = "N.A"; } CheckAccess check = new CheckAccess(SSSession);
            if (check.HasAccess)
            {
                PDBC db = new PDBC("PandaMarketCMS", true);
                db.Connect();
                if (ActToDo == "Delete")
                {
                    db.Script("UPDATE [tbl_BLOG_Tags] SET [Is_Deleted] = 1 WHERE Id=" + id);
                }
                else if (ActToDo == "Active")
                {
                    db.Script("UPDATE [tbl_BLOG_Tags] SET[Is_Disabled] = 0 WHERE Id=" + id);
                }
                else if (ActToDo == "DeActive")
                {
                    db.Script("UPDATE [tbl_BLOG_Tags] SET[Is_Disabled] = 1 WHERE Id=" + id);
                }
                db.DC();
                return Content("Success");
            }
            else
                return RedirectToAction("NotAccess", "MS");
        }

        public ActionResult PostTable()
        {
             string SSSession = ""; if (HttpContext.Request.Cookies["TSHPANDAControll"+ StaticLicense.LicName] != null)  { HttpCookie cookie = HttpContext.Request.Cookies.Get("TSHPANDAControll"+ StaticLicense.LicName); if (cookie != null) { SSSession = cookie.Value; } else { SSSession = "N.A"; } } else { SSSession = "N.A"; } CheckAccess check = new CheckAccess(SSSession);
            if (check.HasAccess)
            {
                Blog_ModelFiller BMF = new Blog_ModelFiller();
                return View(BMF.Posttable());
            }
            else
                return RedirectToAction("NotAccess", "MS");
             
           
        }

        public ActionResult Post_Actions(string ActToDo, int id)
        {
             string SSSession = ""; if (HttpContext.Request.Cookies["TSHPANDAControll"+ StaticLicense.LicName] != null)  { HttpCookie cookie = HttpContext.Request.Cookies.Get("TSHPANDAControll"+ StaticLicense.LicName); if (cookie != null) { SSSession = cookie.Value; } else { SSSession = "N.A"; } } else { SSSession = "N.A"; } CheckAccess check = new CheckAccess(SSSession);
            if (check.HasAccess)
            {
                PDBC db = new PDBC("PandaMarketCMS", true);
                db.Connect();
                if (ActToDo == "Delete")
                {
                    db.Script("UPDATE [tbl_BLOG_Post] SET [Is_Deleted] = 1 WHERE Id=" + id);
                }
                else if (ActToDo == "Active")
                {
                    db.Script("UPDATE [tbl_BLOG_Post] SET[Is_Disabled] = 0 WHERE Id=" + id);
                }
                else if (ActToDo == "DeActive")
                {
                    db.Script("UPDATE [tbl_BLOG_Post] SET[Is_Disabled] = 1 WHERE Id=" + id);
                }
                db.DC();
                return Content("Success");
            }
            else
                return RedirectToAction("NotAccess", "MS");
        }

        public ActionResult EditPost(int Post_id)
        {
            string SSSession = ""; if (HttpContext.Request.Cookies["TSHPANDAControll"+ StaticLicense.LicName] != null) { HttpCookie cookie = HttpContext.Request.Cookies.Get("TSHPANDAControll"+ StaticLicense.LicName); if (cookie != null) { SSSession = cookie.Value; } else { SSSession = "N.A"; } } else { SSSession = "N.A"; }
            CheckAccess check = new CheckAccess(SSSession);
            if (check.HasAccess)
            {
                //ControllerContext.ParentActionViewContext.ViewBag.PageTitle = "";
                Blog_ModelFiller BMF = new Blog_ModelFiller();
                var Model = new Blog_Post_insert_Model()
                {
                   
                    Category = BMF.BCategory_Filler(),
                    Groups = BMF.Groups_Filler(),
                    Type = BMF.B_Types_Filler(),
                    PostData= BMF.EditModelFiller(Post_id)

            };
                Model.Tags = BMF.B_Tags_Filler(Convert.ToInt32(Model.PostData.Category));

                return View(Model);
            }
            else
                return RedirectToAction("NotAccess", "MS");

        }

    }
}