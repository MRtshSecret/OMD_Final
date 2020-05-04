using MD.PersianDateTime;
using ShoppingCMS_V002.DBConnect;
using ShoppingCMS_V002.Models;
using ShoppingCMS_V002.Models.Blog;
using ShoppingCMS_V002.Models.D_APIModels;
using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Text;
using System.Web;

namespace ShoppingCMS_V002.OtherClasses.D_APIOtherClasses
{
    public class D_APIModelFiller
    {
        private int Top = 0;
        public D_APIModelFiller()
        {

        }

        public D_APIModelFiller(int top)
        {
            Top = top;
        }
        public string AppendServername(string url)
        {
            return "https://" + HttpContext.Current.Request.Url.Authority + "/" + url;
        }

        /// <summary>
        ///  زمان را به صورت رشته دریافت میکند و به صورت های مختلف تاریخ شمسی تبدیل میکند
        /// </summary>
        /// <param name="date_">زمان به صورت رشته</param>
        /// <param name="DateType">
        /// Date : تاریخ 
        /// Time : زمان
        /// DateTime : تاریخ و زمان به طور کامل
        /// Ago : چند دقیقه ، ساعت یا روز پیش
        /// </param>
        /// <returns>تاریخ تبدیل شده به صورت رشته</returns>
        public string DateReturner(string date_, string DateType)
        {
            DateTime date = Convert.ToDateTime(date_);
            PersianDateTime persianDateTime = new PersianDateTime(date);

            if (DateType == "Date")
            {
                return persianDateTime.ToLongDateString();
            }
            else if (DateType == "Time")
            {
                return persianDateTime.ToLongTimeString();
            }
            else if (DateType == "DateTime")
            {
                return persianDateTime.ToLongDateTimeString();
            }
            else if (DateType == "Ago")
            {
                string LastSeen = "";
                PersianDateTime PerNow = new PersianDateTime(DateTime.Now);
                var dateTest = PerNow.Subtract(persianDateTime);
                if (dateTest.Days < 1)
                {
                    if (dateTest.Hours < 1)
                    {
                        LastSeen = dateTest.Minutes + " دقیقه ی پیش";

                    }
                    else
                    {
                        LastSeen = dateTest.Hours + "ساعت پیش";
                    }
                }
                else
                {
                    LastSeen = dateTest.Days + "روز پیش";
                }
                return LastSeen;

            }
            else
            {
                return "";
            }
        }
        /// <summary>
        /// زمان را به صورت تاریخ وزمان دریافت میکند و به صورت های مختلف تاریخ شمسی تبدیل میکند
        /// </summary>
        /// <param name="date_">زمان</param>
        /// <param name="DateType">
        /// Date : تاریخ 
        /// Time : زمان
        /// DateTime : تاریخ و زمان به طور کامل
        /// Ago : چند دقیقه ، ساعت یا روز پیش
        /// </param>
        /// <returns>تاریخ تبدیل شده به صورت رشته</returns>
        public string DateReturner(DateTime date_, string DateType)
        {
            
            PersianDateTime persianDateTime = new PersianDateTime(date_);

            if (DateType == "Date")
            {
                return persianDateTime.ToLongDateString();
            }
            else if (DateType == "Time")
            {
                return persianDateTime.ToLongTimeString();
            }
            else if (DateType == "DateTime")
            {
                return persianDateTime.ToLongDateTimeString();
            }
            else if (DateType == "Ago")
            {
                string LastSeen = "";
                PersianDateTime PerNow = new PersianDateTime(DateTime.Now);
                var dateTest = PerNow.Subtract(persianDateTime);
                if (dateTest.Days < 1)
                {
                    if (dateTest.Hours < 1)
                    {
                        LastSeen = dateTest.Minutes + " دقیقه ی پیش";

                    }
                    else
                    {
                        LastSeen = dateTest.Hours + "ساعت پیش";
                    }
                }
                else
                {
                    LastSeen = dateTest.Days + "روز پیش";
                }
                return LastSeen;

            }
            else
            {
                return "";
            }
        }

        public List<Id_ValueModel> ProductTags(string type,int id)
        {
            var res = new List<Id_ValueModel>();
            PDBC db = new PDBC("PandaMarketCMS", true);
            db.Connect();
            string query = "";

            if(type=="min")
            {
                query = "SELECT top 10 A.[id_TE],A.[TE_name] FROM [tbl_Product_TagEnums] as A inner join [tbl_Product_SubCategory] as B on A.SubCatId=B.id_SC  where B.ISDelete=0 AND B.ISDESABLED=0 order by (SELECT Count(*) FROM [tbl_Product_tagConnector] where id_TE=A.id_TE)DESC";
            }else
            {
                if(id==0)
                {
                    query = "SELECT [id_TE],[TE_name] FROM [tbl_Product_TagEnums] as A inner join [tbl_Product_SubCategory] as B on A.SubCatId=B.id_SC where B.ISDelete=0 AND B.ISDESABLED=0";
                }
                else
                {
                    query = "SELECT top 10 A.[id_TE],A.[TE_name] FROM [tbl_Product_TagEnums] as A inner join [tbl_Product_SubCategory] as B on A.SubCatId=B.id_SC  where B.ISDelete=0 AND B.ISDESABLED=0 AND A.SubCatId=" + id;
                }
            }


            DataTable dt = db.Select(query);

            for (int i = 0; i < dt.Rows.Count; i++)
            {
                var model = new Id_ValueModel()
                {
                    Id=Convert.ToInt32(dt.Rows[i]["id_TE"]),
                    Value= dt.Rows[i]["TE_name"].ToString()
                };
                res.Add(model);
            }

            return res;
        }

        public List<Id_ValueModel> Categories(string CatName, int id = 0)
        {
            string query = "";
            if (CatName == "Type")
            {
                query = "SELECT [id_PT] as id ,[PTname] as [name] FROM [tbl_Product_Type] WHERE ISDelete=0 AND ISDESABLED=0";

            }
            else if (CatName == "MainCat")
            {
                if (id != 0)
                {
                    query = "SELECT [id_MC] as id,[MCName] as [name] FROM[tbl_Product_MainCategory] WHERE ISDelete=0 AND ISDESABLED=0 AND id_PT=" + id;
                }
            }
            else if (CatName == "SubCat")
            {
                if (id != 0)
                {
                    query = "SELECT [id_SC] as id,[SCName] as [name] FROM [tbl_Product_SubCategory]WHERE ISDelete=0 AND ISDESABLED =0 AND id_MC=" + id;
                }
            }
            else if (CatName == "SubCat_Key")
            {
                if (id != 0)
                {
                    query = "SELECT [id_SCOK] as id,[SCOKName] as [name] FROM[tbl_Product_SubCategoryOptionKey]WHERE ISDelete=0 AND [ISDESABLED]=0 AND [id_SC]=" + id;
                }
            }
            else if (CatName == "SubCat_Value")
            {
                if (id != 0)
                {
                    query = "SELECT [id_SCOV] as id,[SCOVValueName] as [name] FROM[tbl_Product_SubCategoryOptionValue]WHERE[id_SCOK] = " + id;
                }
            }
            List<Id_ValueModel> result = new List<Id_ValueModel>();
            if (!query.Equals(""))
            {
                PDBC db = new PDBC("PandaMarketCMS", true);
                db.Connect();

                DataTable dt = db.Select(query);



                for (int i = 0; i < dt.Rows.Count; i++)
                {
                    var maodel = new Id_ValueModel()
                    {
                        Id = Convert.ToInt32(dt.Rows[i]["id"]),
                        Value = dt.Rows[i]["name"].ToString()
                    };
                    result.Add(maodel);
                }
            }

            return result;
        }

        public List<TreeModel> CategoriesAsTree_OneSub(string CatName, int id = 0)
        {
            var res = new List<TreeModel>();
            PDBC db = new PDBC("PandaMarketCMS", true);
            db.Connect();
            string query1 = "";
            string query2 = "";
            if(CatName == "Type")
            {
                query1 = "SELECT [id_PT] as Id,[PTname] as [Name] FROM [tbl_Product_Type] where ISDelete=0 AND ISDESABLED=0";
                query2 = "SELECT [id_MC] as Id,[MCName] as [Name] FROM [tbl_Product_MainCategory] where ISDelete=0 AND ISDESABLED=0 AND id_PT=";
            }
            else if (CatName == "MainCat")
            {
                query1 = "SELECT [id_MC] as Id,[MCName] as [Name] FROM [tbl_Product_MainCategory] where ISDelete=0 AND ISDESABLED=0 AND id_PT="+id;
                query2 = "SELECT [id_SC] as Id,[SCName] as [Name] FROM [tbl_Product_SubCategory]  where ISDelete=0 AND ISDESABLED=0 AND id_MC=";
            }
            else if (CatName == "SubCat")
            {
                query1 = "SELECT [id_SC] as Id,[SCName] as [Name] FROM [tbl_Product_SubCategory]  where ISDelete=0 AND ISDESABLED=0 AND id_MC="+id;
                query2 = "SELECT [id_SCOK] as Id,[SCOKName] as [Name] FROM [tbl_Product_SubCategoryOptionKey] where ISDelete=0 AND ISDESABLED=0 AND id_SC=";
            }

            DataTable dt = db.Select(query1);
            for (int i = 0; i < dt.Rows.Count; i++)
            {
                var SupModel = new TreeModel()
                {
                    Id = Convert.ToInt32(dt.Rows[i]["Id"]),
                    NameSub = dt.Rows[i]["Name"].ToString()
                };
                DataTable dt2 = db.Select(query2 + SupModel.Id);
                var Subs = new List<TreeModel>();
                for (int j = 0; j < dt2.Rows.Count; j++)
                {
                    var SubModel = new TreeModel()
                    {
                        Id = Convert.ToInt32(dt.Rows[j]["Id"]),
                        NameSub = dt.Rows[j]["Name"].ToString()
                    };
                    Subs.Add(SubModel);
                }
                SupModel.Subs = Subs;
                res.Add(SupModel);
            }


                return res;
        }

        public List<TreeModel> CategoriesAsTree_All()
        {
            var result = new List<TreeModel>();
            PDBC db = new PDBC("PandaMarketCMS", true);
            db.Connect();

            DataTable Type = db.Select("SELECT [id_PT],[PTname],[ISDESABLED]FROM[tbl_Product_Type] where ISDelete=0");

            for (int i = 0; i < Type.Rows.Count; i++)
            {
                var MainCat = new List<TreeModel>();
                DataTable Mains = db.Select("SELECT [id_MC],[MCName],[ISDESABLED]FROM [tbl_Product_MainCategory] WHERE ISDelete=0 AND id_PT=" + Type.Rows[i]["id_PT"]);
                for (int j = 0; j < Mains.Rows.Count; j++)
                {
                    var SubCat = new List<TreeModel>();
                    DataTable Subs = db.Select("SELECT [id_SC],[SCName],[ISDESABLED] FROM [tbl_Product_SubCategory] WHERE ISDelete=0 AND id_MC=" + Mains.Rows[j]["id_MC"]);
                    for (int k = 0; k < Subs.Rows.Count; k++)
                    {
                        var SubCatKey = new List<TreeModel>();
                        DataTable SubsK = db.Select("SELECT [id_SCOK],[SCOKName],[ISDESABLED] FROM [tbl_Product_SubCategoryOptionKey] where ISDelete=0 AND id_SC=" + Subs.Rows[k]["id_SC"]);
                        for (int k1 = 0; k1 < SubsK.Rows.Count; k1++)
                        {
                            var SubCatKeyVal = new List<TreeModel>();
                            DataTable SubsKV = db.Select("SELECT [id_SCOV],[SCOVValueName] FROM [tbl_Product_SubCategoryOptionValue] where id_SCOK=" + SubsK.Rows[k1]["id_SCOK"]);
                            for (int k2 = 0; k2 < SubsKV.Rows.Count; k2++)
                            {
                                var M5 = new TreeModel()
                                {
                                    Id = Convert.ToInt32(SubsKV.Rows[k2]["id_SCOV"]),
                                    NameSub = SubsKV.Rows[k2]["SCOVValueName"].ToString(),
                                    IsActive = true
                                };
                                SubCatKeyVal.Add(M5);
                            }
                            var M4 = new TreeModel()
                            {
                                Id = Convert.ToInt32(SubsK.Rows[k1]["id_SCOK"]),
                                NameSub = SubsK.Rows[k1]["SCOKName"].ToString(),
                                Subs = SubCatKeyVal
                            };
                            if (SubsK.Rows[k1]["ISDESABLED"].ToString() == "1")
                            {
                                M4.IsActive = false;
                            }
                            else
                            {
                                M4.IsActive = true;
                            }
                            SubCatKey.Add(M4);
                        }
                        var M3 = new TreeModel()
                        {
                            Id = Convert.ToInt32(Subs.Rows[k]["id_SC"]),
                            NameSub = Subs.Rows[k]["SCName"].ToString(),
                            Subs = SubCatKey
                        };
                        if (Subs.Rows[k]["ISDESABLED"].ToString() == "1")
                        {
                            M3.IsActive = false;
                        }
                        else
                        {
                            M3.IsActive = true;
                        }
                        SubCat.Add(M3);

                    }
                    var M2 = new TreeModel()
                    {
                        Id = Convert.ToInt32(Mains.Rows[j]["id_MC"]),
                        NameSub = Mains.Rows[j]["MCName"].ToString(),
                        Subs = SubCat
                    };
                    if (Mains.Rows[j]["ISDESABLED"].ToString() == "1")
                    {
                        M2.IsActive = false;
                    }
                    else
                    {
                        M2.IsActive = true;
                    }
                    MainCat.Add(M2);

                }
                var M1 = new TreeModel()
                {
                    Id = Convert.ToInt32(Type.Rows[i]["id_PT"]),
                    NameSub = Type.Rows[i]["PTname"].ToString(),
                    Subs = MainCat
                };
                if (Type.Rows[i]["ISDESABLED"].ToString() == "1")
                {
                    M1.IsActive = false;
                }
                else
                {
                    M1.IsActive = true;
                }
                result.Add(M1);
            }

            return result;
        }

        public List<MiniProductModel> ChosenProducts(string Type,int numbers,string DateType,int MainTagId = 0)
        {
            var res = new List<MiniProductModel>();
            PDBC db = new PDBC("PandaMarketCMS", true);
            db.Connect();

            string query = "";

            if (Type == "Sale")
            {
                query = "SELECT top "+numbers+ " main.[id_MProduct],[Description],[Title],main.DateCreated,(SELECT top 1 [PicAddress] FROM [tbl_ADMIN_UploadStructure_ImageAddress] as A inner join [tbl_Product_PicConnector] as B on A.PicID=B.PicID where B.id_MProduct=main.id_MProduct) as pic ,(SELECT top 1 [PriceXquantity] FROM [tlb_Product_MainProductConnector] where id_MProduct= main.id_MProduct) as [PriceXquantity],(SELECT top 1 [PriceOff] FROM [tlb_Product_MainProductConnector] where id_MProduct=main.id_MProduct) as [PriceOff],(SELECT top 1 [OffType] FROM [tlb_Product_MainProductConnector] where id_MProduct=main.id_MProduct) as [OffType] ,(SELECT top 1 [MoneyTypeName]FROM [tbl_Product_MoneyType] as A inner join [tlb_Product_MainProductConnector] as B on A.MoneyId=B.PriceModule WHERE B.id_MProduct=main.id_MProduct) as priceQ FROM [tbl_Product] as main inner join [tlb_Product_MainProductConnector] as MPC on main.id_MProduct=MPC.id_MProduct where main.IS_AVAILABEL=1 AND main.ISDELETE=0 order by(SELECT Sum([number]) as sale FROM[tbl_FACTOR_Items] as A1 inner join [tlb_Product_MainProductConnector] as B1 on A1.Pro_Id=B1.id_MPC where B1.id_MProduct=main.id_MProduct)DESC ";
            }else if(Type=="New")
            {
                query = "SELECT top "+numbers+ " main.[id_MProduct],[Description],[Title],main.DateCreated,(SELECT top 1 [PicAddress] FROM [tbl_ADMIN_UploadStructure_ImageAddress] as A inner join [tbl_Product_PicConnector] as B on A.PicID=B.PicID where B.id_MProduct=main.id_MProduct) as pic ,(SELECT top 1 [PriceXquantity] FROM [tlb_Product_MainProductConnector] where id_MProduct= main.id_MProduct) as [PriceXquantity],(SELECT top 1 [PriceOff] FROM [tlb_Product_MainProductConnector] where id_MProduct=main.id_MProduct) as [PriceOff],(SELECT top 1 [OffType] FROM [tlb_Product_MainProductConnector] where id_MProduct=main.id_MProduct) as [OffType] ,(SELECT top 1 [MoneyTypeName]FROM [tbl_Product_MoneyType] as A inner join [tlb_Product_MainProductConnector] as B on A.MoneyId=B.PriceModule WHERE B.id_MProduct=main.id_MProduct) as priceQ FROM [tbl_Product] as main inner join [tlb_Product_MainProductConnector] as MPC on main.id_MProduct=MPC.id_MProduct where main.IS_AVAILABEL=1 AND main.ISDELETE=0 order by(DateCreated)DESC ";
            }else if(Type=="MainTag")
            {
                query = "SELECT distinct top " + numbers + " main.[id_MProduct],[Description],[Title],main.DateCreated,(SELECT top 1 [PicAddress] FROM [tbl_ADMIN_UploadStructure_ImageAddress] as A inner join [tbl_Product_PicConnector] as B on A.PicID=B.PicID where B.id_MProduct=main.id_MProduct) as pic ,(SELECT top 1 [PriceXquantity] FROM [tlb_Product_MainProductConnector] where id_MProduct= main.id_MProduct) as [PriceXquantity],(SELECT top 1 [PriceOff] FROM [tlb_Product_MainProductConnector] where id_MProduct=main.id_MProduct) as [PriceOff],(SELECT top 1 [OffType] FROM [tlb_Product_MainProductConnector] where id_MProduct=main.id_MProduct) as [OffType] ,(SELECT top 1 [MoneyTypeName]FROM [tbl_Product_MoneyType] as A inner join [tlb_Product_MainProductConnector] as B on A.MoneyId=B.PriceModule WHERE B.id_MProduct=main.id_MProduct) as priceQ FROM [tbl_Product] as main inner join [tlb_Product_MainProductConnector] as MPC on main.id_MProduct=MPC.id_MProduct where main.IS_AVAILABEL=1 AND main.ISDELETE=0 AND MPC.id_MainStarTag=" + MainTagId + " order by(DateCreated)DESC ";
            }

            DataTable dt = db.Select(query);
            for (int i = 0; i < dt.Rows.Count; i++)
            {
                DateTime date = Convert.ToDateTime(dt.Rows[i]["DateCreated"]);
                PersianDateTime persianDateTime = new PersianDateTime(date);
                var model = new MiniProductModel()
                {
                    Id = Convert.ToInt32(dt.Rows[i]["id_MProduct"]),
                    Title = dt.Rows[i]["Title"].ToString(),
                    Discription = dt.Rows[i]["Description"].ToString(),
                    PicPath = dt.Rows[i]["pic"].ToString(),
                    OffPrice = dt.Rows[i]["PriceOff"].ToString(),
                    date=DateReturner(dt.Rows[i]["DateCreated"].ToString(),DateType),
                    MoneyQ = dt.Rows[i]["priceQ"].ToString()
                };

                if(dt.Rows[i]["PriceOff"].ToString()=="1")
                {
                    model.Price = "";
                }else
                {
                    model.Price = dt.Rows[i]["PriceXquantity"].ToString();
                }

                res.Add(model);

            }


            return res;
        }

        public List<Company_Customers_Model> CompanyCustomers()
        {
            var res = new List<Company_Customers_Model>();
            PDBC db = new PDBC("PandaMarketCMS", true);
            db.Connect();

            DataTable dt = db.Select("SELECT [Id],[name],[Job],[message],[star],[ImagePath]FROM [tbl_BLOG_CustomersMessge]");
            for (int i = 0; i < dt.Rows.Count; i++)
            {
                var model = new Company_Customers_Model()
                {
                    Id= Convert.ToInt32(dt.Rows[i]["Id"]),
                    Name= dt.Rows[i]["name"].ToString(),
                    Job = dt.Rows[i]["Job"].ToString(),
                    Message = dt.Rows[i]["message"].ToString(),
                    ImagePath = AppendServername(dt.Rows[i]["ImagePath"].ToString()),
                    stars = Convert.ToInt32(dt.Rows[i]["star"])
                };
            }

            return res;
        }

        public List<MiniProductModel> ProductList(int ProductsInAPage, string Type, int Id,int page,string search,string DateType)
        {
            var res = new List<MiniProductModel>();
            PDBC db = new PDBC("PandaMarketCMS", true);
            db.Connect();
            var Query = ProList_QueryMaker(Type, ProductsInAPage, Id, search, page);
            DataTable dt = db.Select(Query);
            for (int i = 0; i < dt.Rows.Count; i++)
            {
                var model = new MiniProductModel()
                {
                    Id = Convert.ToInt32(dt.Rows[i]["id_MProduct"]),
                    Title = dt.Rows[i]["Title"].ToString(),
                    Discription = dt.Rows[i]["Description"].ToString(),
                    PicPath = dt.Rows[i]["pic"].ToString(),
                    OffPrice = dt.Rows[i]["PriceOff"].ToString(),
                    date = DateReturner(dt.Rows[i]["DateCreated"].ToString(), DateType),
                    MoneyQ = dt.Rows[i]["priceQ"].ToString()
                };

                if (dt.Rows[i]["PriceOff"].ToString() == "1")
                {
                    model.Price = "";
                }
                else
                {
                    model.Price = dt.Rows[i]["PriceXquantity"].ToString();
                }

                res.Add(model);


            }
            return res;

        }

        public string ProList_QueryMaker(string Type,int ProductsInAPage,int Id,string search,int page)
        {
            StringBuilder query = new StringBuilder();
            PDBC db = new PDBC("PandaMarketCMS", true);
            db.Connect();
            int num = ProList_Pages(Type, ProductsInAPage,Id,search);


            if (Top!=0)
            {
                query.Append("select TOP(");
                query.Append(Top);
                query.Append(") * from(SELECT NTILE(");
            }
            else
            {
                query.Append("select * from(SELECT NTILE(");
            }

            query.Append(num);
            query.Append(")over(order by(main.DateCreated)DESC)as tile,main.Search_Gravity,main.[id_MProduct],[Description],[Title],main.DateCreated,(SELECT top 1 [PicAddress] FROM [tbl_ADMIN_UploadStructure_ImageAddress] as A inner join [tbl_Product_PicConnector] as B on A.PicID=B.PicID where B.id_MProduct=main.id_MProduct) as pic ,(SELECT top 1 [PriceXquantity] FROM [tlb_Product_MainProductConnector] where id_MProduct= main.id_MProduct) as [PriceXquantity],(SELECT top 1 [PriceOff] FROM [tlb_Product_MainProductConnector] where id_MProduct=main.id_MProduct) as [PriceOff],(SELECT top 1 [OffType] FROM [tlb_Product_MainProductConnector] where id_MProduct=main.id_MProduct) as [OffType] ,(SELECT top 1 [MoneyTypeName]FROM [tbl_Product_MoneyType] as A inner join [tlb_Product_MainProductConnector] as B on A.MoneyId=B.PriceModule WHERE B.id_MProduct=main.id_MProduct) as priceQ FROM [tbl_Product] as main inner join [tlb_Product_MainProductConnector] as MPC on main.id_MProduct=MPC.id_MProduct where main.IS_AVAILABEL=1 AND main.ISDELETE=0 ");
            if (Type == "همه")
            {
                query.Append(")b where b.tile=");
                query.Append(page);
            }
            else if (Type == "سردسته")
            {
                query.Append("AND main.id_Type=");
                query.Append(Id);
                query.Append(" )b where b.tile=");
                query.Append(page);
            }
            else if (Type == "دسته بندی اصلی")
            {
                query.Append("AND main.id_MainCategory=");
                query.Append(Id);
                query.Append(" )b where b.tile=");
                query.Append(page);
            }
            else if (Type == "گروه اصلی")
            {
                query.Append("AND main.id_SubCategory=");
                query.Append(Id);
                query.Append(" )b where b.tile=");
                query.Append(page);
            }
            else if (Type == "برچسب")
            {
              query.Append(" AND main.id_MProduct IN(SELECT distinct B.id_MProduct FROM [tbl_Product_tagConnector] as A inner join [tlb_Product_MainProductConnector] as B on A.id_MPC=B.id_MPC where A.id_TE=");
                query.Append(Id);
                query.Append("))b where b.tile=");
                query.Append(page);
            }
            else if (Type == "جست و جو")
            {
                query.Append(" AND Title LIKE N'%");
                query.Append(search);
                query.Append("%' OR [Description] LIKE N'%");
                query.Append(search);
                query.Append("%' )b where b.tile=");
                query.Append(page);
                query.Append("order by (b.Search_Gravity)DESC");
            }

            return query.ToString();
        }

        public int ProList_Pages(string Type, int ProductsInAPage, int Id, string search)
        {
            PDBC db = new PDBC("PandaMarketCMS", true);
            db.Connect();
            int num = 1;
            if (Type == "همه")
            {
                num = Convert.ToInt32(db.Select("SELECT COUNT(*) FROM [tbl_Product] WHERE IS_AVAILABEL=1 AND ISDELETE=0").Rows[0][0]);
            }
            else if (Type == "سردسته")
            {
                num = Convert.ToInt32(db.Select("SELECT COUNT(*) FROM [tbl_Product] WHERE IS_AVAILABEL=1 AND ISDELETE=0 AND id_Type=" + Id).Rows[0][0]);
            }
            else if (Type == "دسته بندی اصلی")
            {
                num = Convert.ToInt32(db.Select("SELECT COUNT(*) FROM [tbl_Product] WHERE IS_AVAILABEL=1 AND ISDELETE=0 AND id_MainCategory=" + Id).Rows[0][0]);
            }
            else if (Type == "گروه اصلی")
            {
                num = Convert.ToInt32(db.Select("SELECT COUNT(*) FROM [tbl_Product] WHERE [IS_AVAILABEL] = 1 AND [ISDELETE] = 0 AND [id_SubCategory] = " + Id).Rows[0][0]);
            }
            else if (Type == "برچسب")
            {
                num = Convert.ToInt32(db.Select("SELECT COUNT(*) FROM [tbl_Product] WHERE IS_AVAILABEL=1 AND ISDELETE=0 AND id_MProduct IN(SELECT distinct B.id_MProduct FROM [tbl_Product_tagConnector] as A inner join [tlb_Product_MainProductConnector] as B on A.id_MPC=B.id_MPC where A.id_TE=" + Id + ")").Rows[0][0]);
            }
            else if (Type == "جست و جو")
            {
                num = Convert.ToInt32(db.Select("SELECT COUNT(*) FROM [tbl_Product] WHERE IS_AVAILABEL=1 AND ISDELETE=0 AND Title LIKE N'%" + search + "%' OR [Description] LIKE N'%" + search + "%'").Rows[0][0]);
            }


            if (num % ProductsInAPage == 0)
            {
                num = (num / ProductsInAPage);
            }
            else
            {
                num = (num / ProductsInAPage) + 1;
            }

            return num;

        }

        public FactorPopUpModel shoppingCart(int id,string DateType= "DateTime")
        {
            PDBC db = new PDBC("PandaMarketCMS", true);
            db.Connect();
            DataTable dt = db.Select("SELECT B.id_MPC,[ItemId],B.PricePerquantity,B.PriceXquantity,B.Quantity,B.PriceOff,(B.PriceOff*A.number) as total,[number],C.Title ,(SELECT top 1 B1.PicAddress FROM [tbl_Product_PicConnector] as A1 inner join [tbl_ADMIN_UploadStructure_ImageAddress] as B1 on A1.PicId=B1.PicID where A1.id_MProduct=C.id_MProduct)as Pic FROM [tbl_FACTOR_Items] as A inner join [tlb_Product_MainProductConnector] as B on A.Pro_Id=B.id_MPC inner join [tbl_Product] as C on B.id_MProduct=C.id_MProduct where A.FactorId=" + id);

            var items = new List<ShoppingCart_item>();
            for (int i = 0; i < dt.Rows.Count; i++)
            {
                DataTable SCOV = db.Select("SELECT B.SCOVValueName FROM [tbl_Product_connectorToMPC_SCOV] as A inner join [tbl_Product_SubCategoryOptionValue] as B on A.id_SCOV=B.id_SCOV where A.id_MPC=" + dt.Rows[i]["id_MPC"]);
                var s = "(";
                for (int j = 0; j < SCOV.Rows.Count; j++)
                {
                    s += SCOV.Rows[j]["SCOVValueName"];
                    if (j == SCOV.Rows.Count - 1)
                    {
                        s += ")";
                    }
                    else
                    {
                        s += ",";
                    }
                }

                var model = new ShoppingCart_item()
                {
                    Num=i+1,
                    Id = Convert.ToInt32(dt.Rows[i]["ItemId"]),
                    number = Convert.ToInt32(dt.Rows[i]["number"]),
                    ImagePath = AppendServername(dt.Rows[i]["Pic"].ToString()),
                    total =long.Parse(dt.Rows[i]["total"].ToString()),
                    property = s,
                    Title = dt.Rows[i]["Title"].ToString(),
                    PriceOff = long.Parse(dt.Rows[i]["PriceOff"].ToString()),
                    PricePerQ = long.Parse(dt.Rows[i]["PricePerquantity"].ToString()),
                    PriceXQ = long.Parse(dt.Rows[i]["PriceXquantity"].ToString()),
                    Quantity= Convert.ToInt32(dt.Rows[i]["Quantity"])
                };
                items.Add(model);
            }

            DataTable Factor = db.Select("SELECT [Factor_Id],[AddressId],[date],[Off_Code],[toality],[deposit_price],[IsDeleted],[Done],[PaymentSerial],[PaymentToken],(SELECT top 1 [MoneyTypeName] FROM [tbl_Product_MoneyType] as D inner join [tlb_Product_MainProductConnector]as E on D.MoneyId=E.[PriceModule] inner join [tbl_FACTOR_Items] as F on E.id_MPC=F.Pro_Id WHERE F.FactorId=[Factor_Id])AS priceQuantity FROM [tbl_FACTOR_Main] where Factor_Id=" + id);
            var res = new FactorPopUpModel();
            if (Factor.Rows.Count != 0)
            {
                var Address = new AddressModel();
                DataTable dt1 = db.Select("SELECT DISTINCT  B.Ostan_name +' , '+B.Shahr_Name as city ,[C_AddressHint],[C_FullAddress] FROM [tbl_Customer_Address] as A inner join [tbl_Enum_Shahr] as B on A.ID_Shahr=B.ID_Shahr where A.id_CAddress=" + Factor.Rows[0]["AddressId"]);
                if (dt1.Rows.Count != 0)
                {

                    Address.City = dt1.Rows[0]["city"].ToString();
                    Address.FullAddress = dt1.Rows[0]["C_FullAddress"].ToString();
                    Address.HintAddress = dt1.Rows[0]["C_AddressHint"].ToString();
                }


                res.Id = Convert.ToInt32(Factor.Rows[0]["Factor_Id"]);
                res.Date = DateReturner(Factor.Rows[0]["date"].ToString(), DateType);
                res.PaymentSerial = Factor.Rows[0]["PaymentSerial"].ToString();
                res.PaymentToken = Factor.Rows[0]["PaymentToken"].ToString();
                res.totality = Factor.Rows[0]["toality"].ToString();
                res.Deposit = Factor.Rows[0]["deposit_price"].ToString();
                res.Address = Address;
                res.deleted = Convert.ToInt32(Factor.Rows[0]["IsDeleted"]);
                res.Done = Convert.ToInt32(Factor.Rows[0]["Done"]);
                res.Off_Code = Factor.Rows[0]["Off_Code"].ToString();
                res.MoneyQuantity = Factor.Rows[0]["priceQuantity"].ToString();
                res.items = items;
                res.itemNumbers = items.Count();

            }
            return res;
        }

        public List<tbl_BLOG_TeamMembers> TeamMembers()
        {
            PDBC db = new PDBC("PandaMarketCMS", true);
            db.Connect();

            List<tbl_BLOG_TeamMembers> TeamMembers = new List<tbl_BLOG_TeamMembers>();


            using (DataTable dt = db.Select("SELECT [Id],[Name],[Job],[Tozihat],[github],[Linkedin],[Instagram],[ImagePath],[ImageValue]FROM [tbl_BLOG_TeamMembers]"))
            {

                for (int i = 0; i < dt.Rows.Count; i++)
                {

                    tbl_BLOG_TeamMembers tbt = new tbl_BLOG_TeamMembers();

                    tbt.Id = dt.Rows[i]["Id"].ToString();
                    tbt.Name = dt.Rows[i]["Name"].ToString();
                    tbt.Job = dt.Rows[i]["Job"].ToString();
                    tbt.ImagePath = dt.Rows[i]["ImagePath"].ToString();
                    tbt.ImageValue = dt.Rows[i]["ImageValue"].ToString();
                    TeamMembers.Add(tbt);

                }

            }


            return TeamMembers;
        }

        public List<FactorPopUpModel> Customers_Factors(string Type,int Id, string DateType)
        {
            var res = new List<FactorPopUpModel>();
            PDBC db = new PDBC("PandaMarketCMS", true);
            db.Connect();
            string Query = "SELECT [Factor_Id],[AddressId],[date],[Off_Code],[toality],[deposit_price],[IsDeleted],[Done],[PaymentSerial],[PaymentToken],(SELECT top 1 [MoneyTypeName] FROM [tbl_Product_MoneyType] as D inner join [tlb_Product_MainProductConnector]as E on D.MoneyId=E.[PriceModule] inner join [tbl_FACTOR_Items] as F on E.id_MPC=F.Pro_Id WHERE F.FactorId=[Factor_Id])AS priceQuantity FROM [tbl_FACTOR_Main] where [Customer_Id]=" + Id;

            if(Type=="همه")
            {
                Query += " ORDER BY([date])DESC ORDER BY([date])DESC";
            }else if(Type =="تکمیل شده")
            {
                Query += " AND Done=1 ORDER BY([date])DESC";
            }
            else if(Type=="تکمیل نشده")
            {
                Query += " AND Done=0 ORDER BY([date])DESC";
            }

            DataTable dt = db.Select(Query);

            for (int i = 0; i < dt.Rows.Count; i++)
            {
                var Address = new AddressModel();
                DataTable dt1 = db.Select("SELECT DISTINCT  B.Ostan_name +' , '+B.Shahr_Name as city ,[C_AddressHint],[C_FullAddress] FROM [tbl_Customer_Address] as A inner join [tbl_Enum_Shahr] as B on A.ID_Shahr=B.ID_Shahr where A.id_CAddress=" + dt.Rows[i]["AddressId"]);
                if (dt1.Rows.Count != 0)
                {

                    Address.City = dt1.Rows[0]["city"].ToString();
                    Address.FullAddress = dt1.Rows[0]["C_FullAddress"].ToString();
                    Address.HintAddress = dt1.Rows[0]["C_AddressHint"].ToString();
                }

                var Model = new FactorPopUpModel()
                {
                    Id=Convert.ToInt32(dt.Rows[i]["Factor_Id"]),
                    Date=DateReturner(dt.Rows[i]["date"].ToString(),DateType),
                    PaymentSerial= dt.Rows[i]["PaymentSerial"].ToString(),
                    PaymentToken= dt.Rows[i]["PaymentToken"].ToString(),
                    totality= dt.Rows[i]["toality"].ToString(),
                    Deposit = dt.Rows[i]["deposit_price"].ToString(),
                    Address =Address,
                    deleted= Convert.ToInt32(dt.Rows[i]["IsDeleted"]),
                    Done= Convert.ToInt32(dt.Rows[i]["Done"]),
                    Off_Code = dt.Rows[i]["Off_Code"].ToString(),
                    MoneyQuantity= dt.Rows[i]["priceQuantity"].ToString()
                };
                res.Add(Model);
            }


            return res;
        }

        public List<AddressModel> CustomerAddresses(int CustomerId)
        {
            PDBC db = new PDBC("PandaMarketCMS", true);
            db.Connect();
            var AddresList = new List<AddressModel>();
            DataTable dt1 = db.Select("SELECT DISTINCT  B.Ostan_name +' , '+B.Shahr_Name as city ,[C_AddressHint],[C_FullAddress] FROM [tbl_Customer_Address] as A inner join [tbl_Enum_Shahr] as B on A.ID_Shahr=B.ID_Shahr where A.id_Customer=" + CustomerId);
            for (int i = 0; i < dt1.Rows.Count; i++)
            {
                var model = new AddressModel()
                {

                    City = dt1.Rows[i]["city"].ToString(),
                    FullAddress = dt1.Rows[i]["C_FullAddress"].ToString(),
                    HintAddress = dt1.Rows[i]["C_AddressHint"].ToString()
                };
                AddresList.Add(model);
            }

            return AddresList;
        }

        public List<Id_ValueModel> Ostanha()
        {
            var res = new List<Id_ValueModel>();
            PDBC db = new PDBC("PandaMarketCMS", true);
            db.Connect();

            DataTable dt = db.Select("SELECT DISTINCT [Shahr_OstanConnection],[Ostan_name]FROM [tbl_Enum_Shahr] ORDER BY([Ostan_name])");
            for (int i = 0; i < dt.Rows.Count; i++)
            {
                var Model = new Id_ValueModel()
                {
                    Id = Convert.ToInt32(dt.Rows[i]["Shahr_OstanConnection"]),
                    Value = dt.Rows[i]["Ostan_name"].ToString()
                };
                res.Add(Model);
            }
            return res;
        }

        public List<Id_ValueModel> City(int OstanId)
        {
            var res = new List<Id_ValueModel>();
            PDBC db = new PDBC("PandaMarketCMS", true);
            db.Connect();

            DataTable dt = db.Select("SELECT DISTINCT [ID_Shahr],[Shahr_Name] FROM [tbl_Enum_Shahr] where Shahr_OstanConnection="+OstanId+" order by([Shahr_Name])");
            for (int i = 0; i < dt.Rows.Count; i++)
            {
                var Model = new Id_ValueModel()
                {
                    Id = Convert.ToInt32(dt.Rows[i]["ID_Shahr"]),
                    Value = dt.Rows[i]["Shahr_Name"].ToString()
                };
                res.Add(Model);
            }
            return res;
        }

        public Product_DesignerModel SingleProduct(int Id ,string DateType)
        {
            var res = new Product_DesignerModel();
            PDBC db = new PDBC("PandaMarketCMS", true);
            db.Connect();

            DataTable dt = db.Select("SELECT [id_MProduct],(SELECT [PTname] FROM [tbl_Product_Type] where id_PT=[id_Type])as [Type],(SELECT[MCName]FROM [tbl_Product_MainCategory] WHERE id_MC=[id_MainCategory]) AS MainCat,(SELECT [SCName] FROM [tbl_Product_SubCategory] where id_SC=[id_SubCategory]) As SubCat,[id_SubCategory],[Description],[DateCreated],[Title],[Seo_Description],[Seo_KeyWords]FROM [tbl_Product] WHERE id_MProduct=" + Id);
            if(dt.Rows.Count!=0)
            {
                res.Id = Convert.ToInt32(dt.Rows[0]["id_MProduct"]);
                res.Type = dt.Rows[0]["Type"].ToString();
                res.MainCat = dt.Rows[0]["MainCat"].ToString();
                res.SubCat = dt.Rows[0]["SubCat"].ToString();
                res.SEO_Keyword = dt.Rows[0]["Seo_KeyWords"].ToString();
                res.SEO_Discription = dt.Rows[0]["Seo_Description"].ToString();
                res.Title = dt.Rows[0]["Title"].ToString();
                res.Discription = dt.Rows[0]["Description"].ToString();
                res.SubCatId = Convert.ToInt32(dt.Rows[0]["id_SubCategory"]);
                
                

                DataTable Pictures = db.Select("SELECT B.PicAddress FROM [tbl_Product_PicConnector] as A inner join [tbl_ADMIN_UploadStructure_ImageAddress] as B on A.PicID=B.PicID where A.id_MProduct="+res.Id);
                var pic = new List<string>();
                for (int i = 0; i < Pictures.Rows.Count; i++)
                {
                    pic.Add(Pictures.Rows[i]["PicAddress"].ToString());
                }
                res.Pictures = pic;

                DataTable opt = db.Select("SELECT [KeyName],[Value] FROM [tbl_Product_tblOptions] where id_MProduct="+res.Id);
                var options = new List<OptionModel>();
                for (int i = 0; i < opt.Rows.Count; i++)
                {
                    var model = new OptionModel()
                    {
                        Key=opt.Rows[i]["KeyName"].ToString(),
                        Value = opt.Rows[i]["Value"].ToString()
                    };
                    options.Add(model);
                }
                res.Options = options;

                DataTable mpc_options = db.Select("SELECT A.[id_SCOK],B.SCOKName FROM [tbl_Product_ConnectorSCOK_Product] as A inner join [tbl_Product_SubCategoryOptionKey] as B on A.id_SCOK=B.id_SCOK where A.id_MProduct=" + res.Id);
                var MPC_options = new List<TreeModel>();
                for (int i = 0; i < mpc_options.Rows.Count; i++)
                {
                    var model = new TreeModel()
                    {
                     Id=Convert.ToInt32(mpc_options.Rows[i]["id_SCOK"]),
                     NameSub= mpc_options.Rows[i]["SCOKName"].ToString()
                    };

                    DataTable subs = db.Select("SELECT distinct B.SCOVValueName,A.[id_SCOV] FROM [tbl_Product_connectorToMPC_SCOV] as A inner join [tbl_Product_SubCategoryOptionValue] as B on A.id_SCOV=B.id_SCOV inner join [tlb_Product_MainProductConnector] as C on A.id_MPC=C.id_MPC where C.id_MProduct=" + res.Id + " AND B.id_SCOK=" + model.Id);
                    var MPC_options_sub = new List<TreeModel>();
                    for (int j = 0; j <subs.Rows.Count; j++)
                    {
                        var model2 = new TreeModel()
                        {
                            Id = Convert.ToInt32(subs.Rows[i]["id_SCOV"]),
                            NameSub = subs.Rows[i]["SCOVValueName"].ToString()
                        };
                        MPC_options_sub.Add(model2);
                    }

                    model.Subs = MPC_options_sub;

                    MPC_options.Add(model);
                }
                res.MPC_Options = MPC_options;

                DataTable Money = db.Select("SELECT Top 1 [id_MPC],(SELECT [PQT_Demansion] FROM [tbl_Product_ProductQuantityType] where id_PQT=[Quantity]) as Quantity,[PriceXquantity],[PriceOff],(SELECT [MoneyTypeName]FROM [tbl_Product_MoneyType]where [MoneyId]=[PriceModule])as PriceQuantity FROM [tlb_Product_MainProductConnector] where id_MProduct=" + res.Id);

                if(Money.Rows.Count!=0)
                {
                    res.Price = Money.Rows[0]["PriceXquantity"].ToString();
                    res.PriceOff = Money.Rows[0]["PriceOff"].ToString();
                    res.PriceQuantity = Money.Rows[0]["PriceQuantity"].ToString();
                    res.Quantity = Money.Rows[0]["Quantity"].ToString();
                    res.Tags = MPC_Tags(Convert.ToInt32(Money.Rows[0]["id_MPC"]));
                }



                DataTable Comments = db.Select("SELECT [CommentId],[Email],[Name],[ImagePath],[Message],[date] FROM [tbl_Product_Comment] where [ProductId]=" + res.Id);
                var Com = new List<CommentsModel>();
                for (int i = 0; i < Comments.Rows.Count; i++)
                {
                    var Rep = new List<CommentsModel>();
                    DataTable rep = db.Select("SELECT [RepId],[Email],[Name],[ImagePath],[Message],[date] FROM [tbl_Product_Reply] where[CommentId]=" + Comments.Rows[i]["CommentId"]);
                    for (int j = 0; j < rep.Rows.Count; j++)
                    {
                        var Rmodel = new CommentsModel()
                        {
                            Id = Convert.ToInt32(rep.Rows[j]["RepId"]),
                            Email = rep.Rows[j]["Email"].ToString(),
                            ImagePath = AppendServername(rep.Rows[j]["ImagePath"].ToString()),
                            Message = rep.Rows[j]["Message"].ToString(),
                            Name = rep.Rows[j]["Name"].ToString(),
                            Date = DateReturner(rep.Rows[j]["date"].ToString(), DateType)
                        };
                        Rep.Add(Rmodel);
                    }

                    var model = new CommentsModel()
                    {
                        Id = Convert.ToInt32(Comments.Rows[i]["CommentId"]),
                        Email = Comments.Rows[i]["Email"].ToString(),
                        ImagePath = AppendServername(Comments.Rows[i]["ImagePath"].ToString()),
                        Message = Comments.Rows[i]["Message"].ToString(),
                        Name = Comments.Rows[i]["Name"].ToString(),
                        Date = DateReturner(Comments.Rows[i]["date"].ToString(), DateType),
                        Reply = Rep
                    };
                    Com.Add(model);
                }

                res.Comments = Com;


            }


            return res;
        }


        public List<Id_ValueModel> MPC_Tags(int id_MPC)
        {
            var res = new List<Id_ValueModel>();
            PDBC db = new PDBC("PandaMarketCMS", true);
            db.Connect();


            DataTable dt = db.Select("SELECT A.[id_TE],[TE_name]FROM [tbl_Product_TagEnums] as A inner join [tbl_Product_tagConnector] as B on A.id_TE=B.id_TE where B.id_MPC="+id_MPC);

            for (int i = 0; i < dt.Rows.Count; i++)
            {
                var model = new Id_ValueModel()
                {
                    Id = Convert.ToInt32(dt.Rows[i]["id_TE"]),
                    Value = dt.Rows[i]["TE_name"].ToString()
                };
                res.Add(model);
            }

            return res;
        }
    }
}