using PagedList;
using ShoppingCMS_V002.DBConnect;
using ShoppingCMS_V002.Models;
using ShoppingCMS_V002.Models.D_APIModels;
using ShoppingCMS_V002.ModelViews.D_APIModelViews;
using ShoppingCMS_V002.OtherClasses;
using ShoppingCMS_V002.OtherClasses.Blog;
using ShoppingCMS_V002.OtherClasses.D_APIOtherClasses;
using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using Newtonsoft.Json;
using ShoppingCMS_V002.OtherClasses.MasterChi_Fu;

namespace ShoppingCMS_V002.Controllers
{
    public class D_APIController : Controller
    {
      
        public ActionResult Index()
        {
            if (HttpContext.Request.Cookies[StaticLicense.LicName + "Factor"] != null)
            {
                string SSSession = "";
                HttpCookie cookie = HttpContext.Request.Cookies.Get(StaticLicense.LicName + "Factor");
                if (cookie != null)
                {
                    Encryption ENC = new Encryption();
                    SSSession = ENC.DecryptText(cookie.Value, "OMD_FACTOR");
                    MiniFactorModel minif = JsonConvert.DeserializeObject<MiniFactorModel>(SSSession);
                    D_APIModelFiller dmf = new D_APIModelFiller();
                    FactorPopUpModel FPM = dmf.shoppingCart(minif.Id);
                    FactorMasterModel modell = new FactorMasterModel()
                    {
                        ListOfProducts = FPM,
                        Totality = minif
                    };
                    ViewBag.factorMasterModel = modell;

                }
                else
                {
                    ViewBag.factorMasterModel = null;
                }
            }
            else
            {
                ViewBag.factorMasterModel = null;
            }


            D_APIModelFiller DMF = new D_APIModelFiller(4);
            Blog_ModelFiller BMF = new Blog_ModelFiller(4);

            var model = new MainPage_ModelView()
            {
                Cateqories= DMF.CategoriesAsTree_OneSub("MainCat", 1),
                NewProducts=DMF.ChosenProducts("New",3,"Ago"),
                Sale_Products= DMF.ChosenProducts("Sale", 3, "Ago"),
                ProductsG3=DMF.ChosenProducts("MainTag",3,"Ago",1),
                Posts=BMF.UserPostModels("همه",1,0,"","Date"),
                SelectedProducts=DMF.ProductList(15, "همه",0,1,"","Date"),
                Company_Customers=DMF.CompanyCustomers()
            };
            return View(model);
        }

        public ActionResult AboutUs()
        {
            if (HttpContext.Request.Cookies[StaticLicense.LicName + "Factor"] != null)
            {
                string SSSession = "";
                HttpCookie cookie = HttpContext.Request.Cookies.Get(StaticLicense.LicName + "Factor");
                if (cookie != null)
                {
                    Encryption ENC = new Encryption();
                    SSSession = ENC.DecryptText(cookie.Value, "OMD_FACTOR");
                    MiniFactorModel minif = JsonConvert.DeserializeObject<MiniFactorModel>(SSSession);
                    D_APIModelFiller dmf = new D_APIModelFiller();
                    FactorPopUpModel FPM = dmf.shoppingCart(minif.Id);
                    FactorMasterModel modell = new FactorMasterModel()
                    {
                        ListOfProducts = FPM,
                        Totality = minif
                    };
                    ViewBag.factorMasterModel = modell;

                }
                else
                {
                    ViewBag.factorMasterModel = null;
                }
            }
            else
            {
                ViewBag.factorMasterModel = null;
            }
            D_APIModelFiller DMF = new D_APIModelFiller();
            return View(DMF.TeamMembers());
        }

        public ActionResult Terms()
        {
            if (HttpContext.Request.Cookies[StaticLicense.LicName + "Factor"] != null)
            {
                string SSSession = "";
                HttpCookie cookie = HttpContext.Request.Cookies.Get(StaticLicense.LicName + "Factor");
                if (cookie != null)
                {
                    Encryption ENC = new Encryption();
                    SSSession = ENC.DecryptText(cookie.Value, "OMD_FACTOR");
                    MiniFactorModel minif = JsonConvert.DeserializeObject<MiniFactorModel>(SSSession);
                    D_APIModelFiller dmf = new D_APIModelFiller();
                    FactorPopUpModel FPM = dmf.shoppingCart(minif.Id);
                    FactorMasterModel modell = new FactorMasterModel()
                    {
                        ListOfProducts = FPM,
                        Totality = minif
                    };
                    ViewBag.factorMasterModel = modell;

                }
                else
                {
                    ViewBag.factorMasterModel = null;
                }
            }
            else
            {
                ViewBag.factorMasterModel = null;
            }
            return View();
        }

        public ActionResult ContactUs()
        {
            if (HttpContext.Request.Cookies[StaticLicense.LicName + "Factor"] != null)
            {
                string SSSession = "";
                HttpCookie cookie = HttpContext.Request.Cookies.Get(StaticLicense.LicName + "Factor");
                if (cookie != null)
                {
                    Encryption ENC = new Encryption();
                    SSSession = ENC.DecryptText(cookie.Value, "OMD_FACTOR");
                    MiniFactorModel minif = JsonConvert.DeserializeObject<MiniFactorModel>(SSSession);
                    D_APIModelFiller dmf = new D_APIModelFiller();
                    FactorPopUpModel FPM = dmf.shoppingCart(minif.Id);
                    FactorMasterModel modell = new FactorMasterModel()
                    {
                        ListOfProducts = FPM,
                        Totality = minif
                    };
                    ViewBag.factorMasterModel = modell;

                }
                else
                {
                    ViewBag.factorMasterModel = null;
                }
            }
            else
            {
                ViewBag.factorMasterModel = null;
            }
            return View();
        }

        public ActionResult ShoppingCartPopup(int factorId)
        {
            D_APIModelFiller DMF = new D_APIModelFiller();
            return View(DMF.shoppingCart(factorId));
        }

        public ActionResult ShoppingCart(int factorId)
        {
            if (HttpContext.Request.Cookies[StaticLicense.LicName + "Active"] != null)
            {
                string SSSession = "";
                HttpCookie cookie = HttpContext.Request.Cookies.Get(StaticLicense.LicName + "Active");
                if (cookie != null)
                {
                    Encryption ENC = new Encryption();
                    SSSession = ENC.DecryptText(cookie.Value, "OMD_Token");
                    ActivationModel act = JsonConvert.DeserializeObject<ActivationModel>(SSSession);
                    D_APIModelFiller DMF = new D_APIModelFiller();
                    ModelFiller MF = new ModelFiller();
                    var model = new ShoppingCartModelView()
                    {
                        FactorModel = DMF.shoppingCart(factorId),
                        Ostan = DMF.Ostanha(),
                        Adresses = DMF.CustomerAddresses(Convert.ToInt32(act.CustomerId)),
                        Customer=MF.customerDitail(Convert.ToInt32(act.CustomerId))
                    };
                    return View(model);
                }
                else
                {
                    return RedirectToAction("ErrorPage", "D_API");
                }
            }
            else
            {
                return RedirectToAction("ErrorPage", "D_API");
            }

        }

        public ActionResult Product_Detail(int Id)
        {
            if (HttpContext.Request.Cookies[StaticLicense.LicName + "Factor"] != null)
            {
                string SSSession = "";
                HttpCookie cookie = HttpContext.Request.Cookies.Get(StaticLicense.LicName + "Factor");
                if (cookie != null)
                {
                    Encryption ENC = new Encryption();
                    SSSession = ENC.DecryptText(cookie.Value, "OMD_FACTOR");
                    MiniFactorModel minif = JsonConvert.DeserializeObject<MiniFactorModel>(SSSession);
                    D_APIModelFiller dmf = new D_APIModelFiller();
                    FactorPopUpModel FPM = dmf.shoppingCart(minif.Id);
                    FactorMasterModel modell = new FactorMasterModel()
                    {
                        ListOfProducts = FPM,
                        Totality = minif
                    };
                    ViewBag.factorMasterModel = modell;

                }
                else
                {
                    ViewBag.factorMasterModel = null;
                }
            }
            else
            {
                ViewBag.factorMasterModel = null;
            }

            D_APIModelFiller DMF = new D_APIModelFiller();
            var model = new ProductDetail_ModelView()
            {
                ProductModel = DMF.SingleProduct(Id, "Ago"),
                Company = DMF.CompanyCustomers()
            };
            model.RelatedProducts = DMF.ProductList(15, "گروه اصلی", model.ProductModel.SubCatId, 1,"","Ago");
            return View(model);
        }

        public ActionResult Product_List(string Type,int Id=0,int Page=1,string Search="",int CustomerId=0)
        {
            if (HttpContext.Request.Cookies[StaticLicense.LicName + "Factor"] != null)
            {
                string SSSession = "";
                HttpCookie cookie = HttpContext.Request.Cookies.Get(StaticLicense.LicName + "Factor");
                if (cookie != null)
                {
                    Encryption ENC = new Encryption();
                    SSSession = ENC.DecryptText(cookie.Value, "OMD_FACTOR");
                    MiniFactorModel minif = JsonConvert.DeserializeObject<MiniFactorModel>(SSSession);
                    D_APIModelFiller dmf = new D_APIModelFiller();
                    FactorPopUpModel FPM = dmf.shoppingCart(minif.Id);
                    FactorMasterModel modell = new FactorMasterModel()
                    {
                        ListOfProducts = FPM,
                        Totality = minif
                    };
                    ViewBag.factorMasterModel = modell;

                }
                else
                {
                    ViewBag.factorMasterModel = null;
                }
            }
            else
            {
                ViewBag.factorMasterModel = null;
            }
            D_APIModelFiller DMF = new D_APIModelFiller(4);
            D_APIModelFiller DMF2 = new D_APIModelFiller();
            var model = new D_ProductList_ModelView()
            {
                Cateqories = DMF.CategoriesAsTree_OneSub("MainCat", 1),
                NewProducts = DMF.ChosenProducts("New", 3, "Ago"),
                Sale_Products = DMF.ChosenProducts("Sale", 3, "Ago"),
                ProductsG3 = DMF.ChosenProducts("MainTag", 3, "Ago", 1),
                thisPage=Page,
                Cat=Type,
                Search=Search,
                CatId=Id
            };
            
            if (Type== "پرفروش ها")
            {
                model.Products = DMF.ChosenProducts("Sale", 15, "Ago");
                model.Pages = 1;
            }
            else if(Type=="جدیدترین")
            {
                model.Products = DMF.ChosenProducts("New", 15, "Ago");
                model.Pages = 1;
            }
            else if(Type=="فروش ویژه")
            {
                model.Products = DMF.ChosenProducts("MainTag", 15, "Ago",1);
                model.Pages = 1;
            }else if(Type== "علاقه مندی ها")
            {
                model.Products = DMF2.FavoriteProducts(15, Type, Id, Page, Search, "Date",CustomerId);
                model.Pages = DMF2.ProList_Pages(Type, 15, Id, Search,CustomerId);
            }
            else
            {
                model.Products = DMF2.ProductList(15, Type, Id, Page, Search, "Date");
                model.Pages = DMF2.ProList_Pages(Type, 15, Id, Search);
            }
           



            if(Type== "گروه اصلی")
            {
                model.tags = DMF2.ProductTags("Sub", Id);
            }
            else
            {
                model.tags = DMF2.ProductTags("min", 0);
            }
            return View(model);
        }

        [HttpGet]
        public ActionResult MyAccount()
        {

            if (HttpContext.Request.Cookies[StaticLicense.LicName + "Factor"] != null)
            {
                string SSSession = "";
                HttpCookie cookie = HttpContext.Request.Cookies.Get(StaticLicense.LicName + "Factor");
                if (cookie != null)
                {
                    Encryption ENC = new Encryption();
                    SSSession = ENC.DecryptText(cookie.Value, "OMD_FACTOR");
                    MiniFactorModel minif = JsonConvert.DeserializeObject<MiniFactorModel>(SSSession);
                    D_APIModelFiller dmf = new D_APIModelFiller();
                    FactorPopUpModel FPM = dmf.shoppingCart(minif.Id);
                    FactorMasterModel modell = new FactorMasterModel()
                    {
                        ListOfProducts = FPM,
                        Totality = minif
                    };
                    ViewBag.factorMasterModel = modell;

                }
                else
                {
                    ViewBag.factorMasterModel = null;
                }
            }
            else
            {
                ViewBag.factorMasterModel = null;
            }

            if (HttpContext.Request.Cookies[StaticLicense.LicName + "Active"] != null)
            {
                string SSSession = "";
                HttpCookie cookie = HttpContext.Request.Cookies.Get(StaticLicense.LicName + "Active");
                if (cookie != null)
                {
                    return RedirectToAction("myaccount2", "D_API");
                }
                else
                {
                    return View();
                }
            }
            else
            {
                return View();
            }

        }

        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult login2(string MobileNum,string pass)
        {
            Encryption ENC = new Encryption();
            
                PDBC dbo = new PDBC("PandaMarketCMS", true);
                string query;
                query = "SELECT [id_Customer],[C_Mobile],[C_Password]FROM[PandaMarketCMS].[dbo].[tbl_Customer_Main]";
                query += $" where[C_Mobile] = N'"+MobileNum+"' AND [C_Password] = N'"+ENC.MD5Hash(pass)+"'";
                dbo.Connect();
                using (DataTable dt = dbo.Select(query))
                {
                    if (dt.Rows.Count > 0)
                    {

                        return RedirectToAction("EncryptOMD", "API_Functions",new { Token= dt.Rows[0]["id_Customer"].ToString() });
                    }
                    else
                    {
                     
                        return Content("Wrong value");

                    }
                }
            
            

        }
        /// /////////////////////{ end : login }////////////////////////

        ////////////////////////{ start : blog }////////////////////////5
        ///مثال 
        ////url = MS/blog?NamePage=post&page=1
        ////url = MS/blog?NamePage=Categories&Valuepage=اخبار پاندایی&page=1
        public ActionResult Blog(int page, string NamePage, string Valuepage)
        {
            if (HttpContext.Request.Cookies[StaticLicense.LicName + "Factor"] != null)
            {
                string SSSession = "";
                HttpCookie cookie = HttpContext.Request.Cookies.Get(StaticLicense.LicName + "Factor");
                if (cookie != null)
                {
                    Encryption ENC = new Encryption();
                    SSSession = ENC.DecryptText(cookie.Value, "OMD_FACTOR");
                    MiniFactorModel minif = JsonConvert.DeserializeObject<MiniFactorModel>(SSSession);
                    D_APIModelFiller dmf = new D_APIModelFiller();
                    FactorPopUpModel FPM = dmf.shoppingCart(minif.Id);
                    FactorMasterModel modell = new FactorMasterModel()
                    {
                        ListOfProducts = FPM,
                        Totality = minif
                    };
                    ViewBag.factorMasterModel = modell;

                }
                else
                {
                    ViewBag.factorMasterModel = null;
                }
            }
            else
            {
                ViewBag.factorMasterModel = null;
            }
            int recordsPerPage;
            string Pvp = "";
            DataClass tbt = new DataClass();
            var blog = default(IEnumerable<tbl_BLOG>);

            if (Valuepage != null)
            {
                if (NamePage == "tag" && Valuepage == "مشاهده همه")
                {
                    recordsPerPage = 100;
                    blog = tbt.BLOG_Tags(NamePage, false).ToPagedList(page, recordsPerPage);
                }
                else
                {
                    recordsPerPage = 10;
                    blog = tbt.BLOG(NamePage, Valuepage).ToPagedList(page, recordsPerPage);
                }
                Pvp = Valuepage;
            }
            else
            {
                if (NamePage == "tag" && Valuepage == "مشاهده همه")
                {
                    recordsPerPage = 100;
                    blog = tbt.BLOG_Tags(NamePage, false).ToPagedList(page, recordsPerPage);
                }
                else
                {
                    recordsPerPage = 10;
                    blog = tbt.BLOG(NamePage, Valuepage).ToPagedList(page, recordsPerPage);
                }

                Pvp = " ";
            }




            var _blogclass = new blogclass()
            {
                BLOG = blog,
                BLOG_Categories = tbt.BLOG_Categories("", false),
                BLOG_Tags = tbt.BLOG_Tags(" ", false),
                TabS1 = tbt.TabS("new"),
                TabS2 = tbt.TabS("like"),
                pages = new page()
                {
                    PnamePage = NamePage,
                    Pvaluepage = Pvp
                }

            };



            return View(_blogclass);
        }

        /// /////////////////////{ end : blog }////////////////////////
        /// 
        ////////////////////////{ start : blog_post }////////////////////////6
        ////مثال
        ////url = MS/blog_post?IdPage=1
        public ActionResult Blog_Post(string IdPage)
        {
            if (HttpContext.Request.Cookies[StaticLicense.LicName + "Factor"] != null)
            {
                string SSSession = "";
                HttpCookie cookie = HttpContext.Request.Cookies.Get(StaticLicense.LicName + "Factor");
                if (cookie != null)
                {
                    Encryption ENC = new Encryption();
                    SSSession = ENC.DecryptText(cookie.Value, "OMD_FACTOR");
                    MiniFactorModel minif = JsonConvert.DeserializeObject<MiniFactorModel>(SSSession);
                    D_APIModelFiller dmf = new D_APIModelFiller();
                    FactorPopUpModel FPM = dmf.shoppingCart(minif.Id);
                    FactorMasterModel modell = new FactorMasterModel()
                    {
                        ListOfProducts = FPM,
                        Totality = minif
                    };
                    ViewBag.factorMasterModel = modell;

                }
                else
                {
                    ViewBag.factorMasterModel = null;
                }
            }
            else
            {
                ViewBag.factorMasterModel = null;
            }
            DataClass tbt = new DataClass();

            var _blogclass = new blogclass()
            {
                BLOGPOST = tbt.BLOGPOST(IdPage),
                BLOG_Categories = tbt.BLOG_Categories("", false),
                BLOG_Tags = tbt.BLOG_Tags(" ", false),
                TabS1 = tbt.TabS("new"),
                TabS2 = tbt.TabS("like"),


            };

            return View(_blogclass);
        }

        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult comment_post(tbl_BLOG tbl)
        {

            string query_new;
            string res = " ";


            PDBC db = new PDBC("PandaMarketCMS", true);


            List<ExcParameters> paramss = new List<ExcParameters>();
            ExcParameters parameters = new ExcParameters();

            query_new = "INSERT INTO [dbo].[tbl_BLOG_Comment]([Email],[message],[Name],[PostId])VALUES(@Email ,@message ,@Name ,@PostId)";

            parameters = new ExcParameters()
            {
                _KEY = "@Email",
                _VALUE = tbl.Email
            };
            paramss.Add(parameters);
            parameters = new ExcParameters()
            {
                _KEY = "@message",
                _VALUE = tbl.message
            };
            paramss.Add(parameters);
            parameters = new ExcParameters()
            {
                _KEY = "@Name",
                _VALUE = tbl.name
            };
            paramss.Add(parameters);
            parameters = new ExcParameters()
            {
                _KEY = "@PostId",
                _VALUE = tbl.Id
            };
            paramss.Add(parameters);
            db.Connect();
            res = db.Script(query_new, paramss);
            db.DC();


            return Redirect("blog_post?IdPage=" + tbl.Id);
        }
        /// /////////////////////{ end : blog_post }////////////////////////


        public ActionResult accountinformation()
        {
            if (HttpContext.Request.Cookies[StaticLicense.LicName + "Factor"] != null)
            {
                string SSSession = "";
                HttpCookie cookie = HttpContext.Request.Cookies.Get(StaticLicense.LicName + "Factor");
                if (cookie != null)
                {
                    Encryption ENC = new Encryption();
                    SSSession = ENC.DecryptText(cookie.Value, "OMD_FACTOR");
                    MiniFactorModel minif = JsonConvert.DeserializeObject<MiniFactorModel>(SSSession);
                    D_APIModelFiller dmf = new D_APIModelFiller();
                    FactorPopUpModel FPM = dmf.shoppingCart(minif.Id);
                    FactorMasterModel modell = new FactorMasterModel()
                    {
                        ListOfProducts = FPM,
                        Totality = minif
                    };
                    ViewBag.factorMasterModel = modell;

                }
                else
                {
                    ViewBag.factorMasterModel = null;
                }
            }
            else
            {
                ViewBag.factorMasterModel = null;
            }




            if (HttpContext.Request.Cookies[StaticLicense.LicName + "Active"] != null)
            {
                string SSSession = "";
                HttpCookie cookie = HttpContext.Request.Cookies.Get(StaticLicense.LicName + "Active");
                if (cookie != null)
                {

                    Encryption ENC = new Encryption();
                    SSSession = ENC.DecryptText(cookie.Value, "OMD_Token");
                    ActivationModel act = JsonConvert.DeserializeObject<ActivationModel>(SSSession);
                    ModelFiller MF = new ModelFiller();
                    return View(MF.customerDitail(Convert.ToInt32(act.CustomerId)));
                }
                else
                {
                    return RedirectToAction("MyAccount", "D_API");
                }
            }
            else
            {
                return RedirectToAction("MyAccount", "D_API");
            }

        }


        public ActionResult myaccount2()
        {
            if (HttpContext.Request.Cookies[StaticLicense.LicName + "Factor"] != null)
            {
                string SSSession = "";
                HttpCookie cookie = HttpContext.Request.Cookies.Get(StaticLicense.LicName + "Factor");
                if (cookie != null)
                {
                    Encryption ENC = new Encryption();
                    SSSession = ENC.DecryptText(cookie.Value, "OMD_FACTOR");
                    MiniFactorModel minif = JsonConvert.DeserializeObject<MiniFactorModel>(SSSession);
                    D_APIModelFiller dmf = new D_APIModelFiller();
                    FactorPopUpModel FPM = dmf.shoppingCart(minif.Id);
                    FactorMasterModel modell = new FactorMasterModel()
                    {
                        ListOfProducts = FPM,
                        Totality = minif
                    };
                    ViewBag.factorMasterModel = modell;

                }
                else
                {
                    ViewBag.factorMasterModel = null;
                }
            }
            else
            {
                ViewBag.factorMasterModel = null;
            }

            if (HttpContext.Request.Cookies[StaticLicense.LicName + "Active"] != null)
            {
                string SSSession = "";
                HttpCookie cookie = HttpContext.Request.Cookies.Get(StaticLicense.LicName + "Active");
                if (cookie != null)
                {


                    return View();
                }
                else
                {
                    return RedirectToAction("MyAccount", "D_API");
                }
            }
            else
            {
                return RedirectToAction("MyAccount", "D_API");
            }

        }

        public ActionResult addressBook()
        {
            if (HttpContext.Request.Cookies[StaticLicense.LicName + "Factor"] != null)
            {
                string SSSession = "";
                HttpCookie cookie = HttpContext.Request.Cookies.Get(StaticLicense.LicName + "Factor");
                if (cookie != null)
                {
                    Encryption ENC = new Encryption();
                    SSSession = ENC.DecryptText(cookie.Value, "OMD_FACTOR");
                    MiniFactorModel minif = JsonConvert.DeserializeObject<MiniFactorModel>(SSSession);
                    D_APIModelFiller dmf = new D_APIModelFiller();
                    FactorPopUpModel FPM = dmf.shoppingCart(minif.Id);
                    FactorMasterModel modell = new FactorMasterModel()
                    {
                        ListOfProducts = FPM,
                        Totality = minif
                    };
                    ViewBag.factorMasterModel = modell;

                }
                else
                {
                    ViewBag.factorMasterModel = null;
                }
            }
            else
            {
                ViewBag.factorMasterModel = null;
            }


            if (HttpContext.Request.Cookies[StaticLicense.LicName + "Active"] != null)
            {
                string SSSession = "";
                HttpCookie cookie = HttpContext.Request.Cookies.Get(StaticLicense.LicName + "Active");
                if (cookie != null)
                {
                    D_APIModelFiller DMF = new D_APIModelFiller();
                    return View(DMF.Ostanha());
                }
                else
                {
                    return RedirectToAction("ErrorPage", "D_API");
                }
            }
            else
            {
                return RedirectToAction("ErrorPage", "D_API");
            }


        }

        public ActionResult ChangePass()
        {
            if (HttpContext.Request.Cookies[StaticLicense.LicName + "Factor"] != null)
            {
                string SSSession = "";
                HttpCookie cookie = HttpContext.Request.Cookies.Get(StaticLicense.LicName + "Factor");
                if (cookie != null)
                {
                    Encryption ENC = new Encryption();
                    SSSession = ENC.DecryptText(cookie.Value, "OMD_FACTOR");
                    MiniFactorModel minif = JsonConvert.DeserializeObject<MiniFactorModel>(SSSession);
                    D_APIModelFiller dmf = new D_APIModelFiller();
                    FactorPopUpModel FPM = dmf.shoppingCart(minif.Id);
                    FactorMasterModel modell = new FactorMasterModel()
                    {
                        ListOfProducts = FPM,
                        Totality = minif
                    };
                    ViewBag.factorMasterModel = modell;

                }
                else
                {
                    ViewBag.factorMasterModel = null;
                }
            }
            else
            {
                ViewBag.factorMasterModel = null;
            }


            if (HttpContext.Request.Cookies[StaticLicense.LicName + "Active"] != null)
            {
                string SSSession = "";
                HttpCookie cookie = HttpContext.Request.Cookies.Get(StaticLicense.LicName + "Active");
                if (cookie != null)
                {
                    return View();
                }
                else
                {
                    return RedirectToAction("ErrorPage", "D_API");
                }
            }
            else
            {
                return RedirectToAction("ErrorPage", "D_API");
            }
        }

        public ActionResult newsletter()
        {
            if (HttpContext.Request.Cookies[StaticLicense.LicName + "Factor"] != null)
            {
                string SSSession = "";
                HttpCookie cookie = HttpContext.Request.Cookies.Get(StaticLicense.LicName + "Factor");
                if (cookie != null)
                {
                    Encryption ENC = new Encryption();
                    SSSession = ENC.DecryptText(cookie.Value, "OMD_FACTOR");
                    MiniFactorModel minif = JsonConvert.DeserializeObject<MiniFactorModel>(SSSession);
                    D_APIModelFiller dmf = new D_APIModelFiller();
                    FactorPopUpModel FPM = dmf.shoppingCart(minif.Id);
                    FactorMasterModel modell = new FactorMasterModel()
                    {
                        ListOfProducts = FPM,
                        Totality = minif
                    };
                    ViewBag.factorMasterModel = modell;

                }
                else
                {
                    ViewBag.factorMasterModel = null;
                }
            }
            else
            {
                ViewBag.factorMasterModel = null;
            }



            if (HttpContext.Request.Cookies[StaticLicense.LicName + "Active"] != null)
            {
                string SSSession = "";
                HttpCookie cookie = HttpContext.Request.Cookies.Get(StaticLicense.LicName + "Active");
                if (cookie != null)
                {
                    Encryption ENC = new Encryption();
                    SSSession = ENC.DecryptText(cookie.Value, "OMD_Token");
                    ActivationModel act = JsonConvert.DeserializeObject<ActivationModel>(SSSession);

                    //PDBC db = new PDBC("PandaMarketCMS", true);
                    //db.Connect();
                    //DataTable dt = db.Select("" + act.CustomerId);

                    return View();
                }
                else
                {
                    return RedirectToAction("ErrorPage", "D_API");
                }
            }
            else
            {
                return RedirectToAction("ErrorPage", "D_API");
            }
        }

        public ActionResult orderHistory()
        {
            if (HttpContext.Request.Cookies[StaticLicense.LicName + "Factor"] != null)
            {
                string SSSession = "";
                HttpCookie cookie = HttpContext.Request.Cookies.Get(StaticLicense.LicName + "Factor");
                if (cookie != null)
                {
                    Encryption ENC = new Encryption();
                    SSSession = ENC.DecryptText(cookie.Value, "OMD_FACTOR");
                    MiniFactorModel minif = JsonConvert.DeserializeObject<MiniFactorModel>(SSSession);
                    D_APIModelFiller dmf = new D_APIModelFiller();
                    FactorPopUpModel FPM = dmf.shoppingCart(minif.Id);
                    FactorMasterModel modell = new FactorMasterModel()
                    {
                        ListOfProducts = FPM,
                        Totality = minif
                    };
                    ViewBag.factorMasterModel = modell;

                }
                else
                {
                    ViewBag.factorMasterModel = null;
                }
            }
            else
            {
                ViewBag.factorMasterModel = null;
            }



            if (HttpContext.Request.Cookies[StaticLicense.LicName + "Active"] != null)
            {
                string SSSession = "";
                HttpCookie cookie = HttpContext.Request.Cookies.Get(StaticLicense.LicName + "Active");
                if (cookie != null)
                {
                    Encryption ENC = new Encryption();
                    SSSession = ENC.DecryptText(cookie.Value, "OMD_Token");
                    ActivationModel act = JsonConvert.DeserializeObject<ActivationModel>(SSSession);

                    D_APIModelFiller DMF = new D_APIModelFiller();

                    return View(DMF.CustomerShops(Convert.ToInt32(act.CustomerId),3));
                }
                else
                {
                    return RedirectToAction("ErrorPage", "D_API");
                }
            }
            else
            {
                return RedirectToAction("ErrorPage", "D_API");
            }
        }

        public ActionResult Returns()
        {
            if (HttpContext.Request.Cookies[StaticLicense.LicName + "Factor"] != null)
            {
                string SSSession = "";
                HttpCookie cookie = HttpContext.Request.Cookies.Get(StaticLicense.LicName + "Factor");
                if (cookie != null)
                {
                    Encryption ENC = new Encryption();
                    SSSession = ENC.DecryptText(cookie.Value, "OMD_FACTOR");
                    MiniFactorModel minif = JsonConvert.DeserializeObject<MiniFactorModel>(SSSession);
                    D_APIModelFiller dmf = new D_APIModelFiller();
                    FactorPopUpModel FPM = dmf.shoppingCart(minif.Id);
                    FactorMasterModel modell = new FactorMasterModel()
                    {
                        ListOfProducts = FPM,
                        Totality = minif
                    };
                    ViewBag.factorMasterModel = modell;

                }
                else
                {
                    ViewBag.factorMasterModel = null;
                }
            }
            else
            {
                ViewBag.factorMasterModel = null;
            }
            //


            if (HttpContext.Request.Cookies[StaticLicense.LicName + "Active"] != null)
            {
                string SSSession = "";
                HttpCookie cookie = HttpContext.Request.Cookies.Get(StaticLicense.LicName + "Active");
                if (cookie != null)
                {
                    Encryption ENC = new Encryption();
                    SSSession = ENC.DecryptText(cookie.Value, "OMD_Token");
                    ActivationModel act = JsonConvert.DeserializeObject<ActivationModel>(SSSession);

                    D_APIModelFiller DMF = new D_APIModelFiller();

                    return View(DMF.CustomerShops(Convert.ToInt32(act.CustomerId), 0));
                }
                else
                {
                    return RedirectToAction("ErrorPage", "D_API");
                }
            }
            else
            {
                return RedirectToAction("ErrorPage", "D_API");
            }

        }

        public ActionResult reviewRating()
        {
            if (HttpContext.Request.Cookies[StaticLicense.LicName + "Factor"] != null)
            {
                string SSSession = "";
                HttpCookie cookie = HttpContext.Request.Cookies.Get(StaticLicense.LicName + "Factor");
                if (cookie != null)
                {
                    Encryption ENC = new Encryption();
                    SSSession = ENC.DecryptText(cookie.Value, "OMD_FACTOR");
                    MiniFactorModel minif = JsonConvert.DeserializeObject<MiniFactorModel>(SSSession);
                    D_APIModelFiller dmf = new D_APIModelFiller();
                    FactorPopUpModel FPM = dmf.shoppingCart(minif.Id);
                    FactorMasterModel modell = new FactorMasterModel()
                    {
                        ListOfProducts = FPM,
                        Totality = minif
                    };
                    ViewBag.factorMasterModel = modell;

                }
                else
                {
                    ViewBag.factorMasterModel = null;
                }
            }
            else
            {
                ViewBag.factorMasterModel = null;
            }


            if (HttpContext.Request.Cookies[StaticLicense.LicName + "Active"] != null)
            {
                string SSSession = "";
                HttpCookie cookie = HttpContext.Request.Cookies.Get(StaticLicense.LicName + "Active");
                if (cookie != null)
                {
                    Encryption ENC = new Encryption();
                    SSSession = ENC.DecryptText(cookie.Value, "OMD_Token");
                    ActivationModel act = JsonConvert.DeserializeObject<ActivationModel>(SSSession);

                    D_APIModelFiller DMF = new D_APIModelFiller();

                    return View(DMF.CustomerComments(Convert.ToInt32(act.CustomerId)));
                }
                else
                {
                    return RedirectToAction("ErrorPage", "D_API");
                }
            }
            else
            {
                return RedirectToAction("ErrorPage", "D_API");
            }



        }
        public ActionResult ErrorPage()
        {
            if (HttpContext.Request.Cookies[StaticLicense.LicName + "Factor"] != null)
            {
                string SSSession = "";
                HttpCookie cookie = HttpContext.Request.Cookies.Get(StaticLicense.LicName + "Factor");
                if (cookie != null)
                {
                    Encryption ENC = new Encryption();
                    SSSession = ENC.DecryptText(cookie.Value, "OMD_FACTOR");
                    MiniFactorModel minif = JsonConvert.DeserializeObject<MiniFactorModel>(SSSession);
                    D_APIModelFiller dmf = new D_APIModelFiller();
                    FactorPopUpModel FPM = dmf.shoppingCart(minif.Id);
                    FactorMasterModel modell = new FactorMasterModel()
                    {
                        ListOfProducts = FPM,
                        Totality = minif
                    };
                    ViewBag.factorMasterModel = modell;

                }
                else
                {
                    ViewBag.factorMasterModel = null;
                }
            }
            else
            {
                ViewBag.factorMasterModel = null;
            }
            return View();
        }

        public ActionResult Category()
        {
            D_APIModelFiller DMF = new D_APIModelFiller();
            return View(DMF.CategoriesAsTree_OneSub("MainCat", 1));

        }
    }
}