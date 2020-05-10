using MD.PersianDateTime;
using ShoppingCMS_V002.DBConnect;
using ShoppingCMS_V002.Models;
using System;
using System.Collections.Generic;
using System.Data;
using System.Drawing;
using System.Drawing.Drawing2D;
using System.Linq;
using System.Text;
using System.Web;

namespace ShoppingCMS_V002.OtherClasses
{
    public class ModelFiller
    {


        //public static string resizeImage(Image image, int new_height, int new_width,string imageAddress,)
        //{
        //    Bitmap new_image = new Bitmap(new_width, new_height);
        //    Graphics g = Graphics.FromImage((Image)new_image);
        //    g.InterpolationMode = InterpolationMode.High;
        //    g.DrawImage(image, 0, 0, new_width, new_height);
        //    //return new_image;
        //    return "";
        //}




        public string AppendServername(string url)
        {
            return "https://" + HttpContext.Current.Request.Url.Authority + "/" + url;
        }

        public List<ProductModel> productModels_List(string Query)
        {
              PDBC db = new PDBC("PandaMarketCMS", true);
            List<ProductModel> list = new List<ProductModel>();
            db.Connect();
            DataTable dt = db.Select(Query);
            for (int i = 0; i < dt.Rows.Count; i++)
            {
                DateTime date = Convert.ToDateTime(dt.Rows[i]["DateCreated"]);
                PersianDateTime persianDateTime = new PersianDateTime(date);
                var model = new ProductModel()
                {
                    Num = i + 1,
                    Id = Convert.ToInt32(dt.Rows[i]["id_MProduct"]),
                    Title = dt.Rows[i]["Title"].ToString(),
                    Description = dt.Rows[i]["Description"].ToString(),
                    AddBy = dt.Rows[i]["AddBy"].ToString(),
                    MainPrice = dt.Rows[i]["price"].ToString(),
                    Category = dt.Rows[i]["SubCat"].ToString() + "_" + dt.Rows[i]["MainCat"].ToString() + "_" + dt.Rows[i]["type"].ToString(),
                    Date = persianDateTime.ToString(),
                    PicPath = AppendServername(dt.Rows[i]["pic"].ToString()),
                    SubId = Convert.ToInt32(dt.Rows[i]["id_SubCategory"])
                };
                DataTable dt2 = db.Select("SELECT [PicThumbnailAddress] FROM [tbl_ADMIN_UploadStructure_ImageAddress] as A inner Join [tbl_Product_PicConnector] as B ON A.PicID=B.PicID where B.id_MProduct=" + model.Id);
                if (dt2.Rows.Count == 0)
                {
                    model.PicPath = AppendServername("/assets/NoImg.png");
                }
                else
                {
                    model.PicPath = AppendServername(dt2.Rows[0]["PicThumbnailAddress"].ToString());
                }
                if (dt.Rows[i]["IS_AVAILABEL"].ToString() == "1")
                {
                    model.disabled = false;
                }
                else
                {
                    model.disabled = true;
                }

                if (dt.Rows[i]["ISDELETE"].ToString() == "1")
                {
                    model.deleted = true;
                }
                else
                {
                    model.deleted = false;
                }
                list.Add(model);
            }
            db.DC();
            return list;
        }


        public string QueryMaker(bool SearchBox, string text = "")
        {
            StringBuilder queryBuilder = new StringBuilder();
            queryBuilder.Append(
                " SELECT[id_MProduct],[IS_AVAILABEL],[Description],[DateCreated],[Title],[id_SubCategory],[ISDELETE],(SELECT top 1 [ThumbnailPicAddress]FROM[tbl_Product_Pic]where[tbl_Product_Pic].[id_MProduct]=[tbl_Product].[id_MProduct]) as [pic],(SELECT[PricePerquantity] FROM[tlb_Product_MainProductConnector]WHERE id_MPC=idMPC_WhichTomainPrice) AS price,(SELECT[AdminName]FROM[AdminTbl]where [AdminId]=[id_CreatedByAdmin])as AddBy,(SELECT [PTname]FROM [tbl_Product_Type]where[id_PT]=[id_Type])as [type],(SELECT[SCName]FROM [tbl_Product_SubCategory]where[id_SC]=[id_SubCategory])as SubCat,(SELECT[MCName]FROM [tbl_Product_MainCategory]where[id_MC]=[id_MainCategory])as MainCat FROM [tbl_Product]");

            if (SearchBox)
            {
                queryBuilder.Append("Where Title LIKE N'%");
                queryBuilder.Append(text);
                queryBuilder.Append("%' OR Description LIKE N'%");
                queryBuilder.Append(text);
                queryBuilder.Append("%'");
            }

            queryBuilder.Append(" ORDER BY(DateCreated)DESC");
            return queryBuilder.ToString();
        }

        public List<Id_ValueModel> DropFiller(string drop, int id = 0)
        {
            string query = "";
            if (drop == "Type")
            {
                query = "SELECT [id_PT] as id ,[PTname] as [name] FROM [tbl_Product_Type] WHERE ISDelete=0 AND ISDESABLED=0";

            }
            else if (drop == "MainCat")
            {
                if (id != 0)
                {
                    query = "SELECT [id_MC] as id,[MCName] as [name] FROM[tbl_Product_MainCategory] WHERE ISDelete=0 AND ISDESABLED=0 AND id_PT=" + id;
                }
            }
            else if (drop == "SubCat")
            {
                if (id != 0)
                {
                    query = "SELECT [id_SC] as id,[SCName] as [name] FROM [tbl_Product_SubCategory]WHERE ISDelete=0 AND ISDESABLED =0 AND id_MC=" + id;
                }
            }
            else if (drop == "SubCat_Key")
            {
                if (id != 0)
                {
                    query = "SELECT [id_SCOK] as id,[SCOKName] as [name] FROM[tbl_Product_SubCategoryOptionKey]WHERE ISDelete=0 AND [ISDESABLED]=0 AND [id_SC]=" + id;
                }
            }
            else if (drop == "SubCat_Value")
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
                db.DC();


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
            else
            {
                result.Add(new Id_ValueModel { Id = 0, Value = "انتخاب کنید" });
            }

            return result;
        }

        public List<AddPro_Options> OptionsFiller(int id)
        {
            var result = new List<AddPro_Options>();
            PDBC db = new PDBC("PandaMarketCMS", true);
            db.Connect();
            DataTable dt = db.Select("SELECT [id_Op],[KeyName],[Value]FROM[tbl_Product_tblOptions] WHERE id_MProduct=" + id);
            db.DC();
            for (int i = 0; i < dt.Rows.Count; i++)
            {
                var model = new AddPro_Options()
                {
                    Id = Convert.ToInt32(dt.Rows[i]["id_Op"]),
                    Num = i + 1,
                    Key = dt.Rows[i]["KeyName"].ToString(),
                    Value = dt.Rows[i]["Value"].ToString()

                };

                result.Add(model);
            }
            return result;
        }

        public string MainProduct_Actions(string action, int id_MProduct, int Quantity, int QuantityModule, int PriceXquantity, int PricePerquantity, int PriceOff, int offTypeValue, int OffType, int id_MainStarTag, int PriceModule, int PriceShow, string describtion = " ")
        {

            List<ExcParameters> paramss = new List<ExcParameters>();
            PDBC db = new PDBC("PandaMarketCMS", true);
            var parameters = new ExcParameters()
            {
                _KEY = "@id_MProduct",
                _VALUE = id_MProduct
            };
            paramss.Add(parameters);

            parameters = new ExcParameters()
            {
                _KEY = "@Quantity",
                _VALUE = Quantity
            };
            paramss.Add(parameters);

            parameters = new ExcParameters()
            {
                _KEY = "@QuantityModule",
                _VALUE = QuantityModule
            };
            paramss.Add(parameters);

            parameters = new ExcParameters()
            {
                _KEY = "@PriceXquantity",
                _VALUE = PriceXquantity
            };
            paramss.Add(parameters);

            parameters = new ExcParameters()
            {
                _KEY = "@PricePerquantity",
                _VALUE = PricePerquantity
            };
            paramss.Add(parameters);

            parameters = new ExcParameters()
            {
                _KEY = "@PriceOff",
                _VALUE = PriceOff
            };
            paramss.Add(parameters);

            parameters = new ExcParameters()
            {
                _KEY = "@offTypeValue",
                _VALUE = offTypeValue
            };
            paramss.Add(parameters);

            parameters = new ExcParameters()
            {
                _KEY = "@OffType",
                _VALUE = OffType
            };
            paramss.Add(parameters);

            parameters = new ExcParameters()
            {
                _KEY = "@id_MainStarTag",
                _VALUE = id_MainStarTag
            };
            paramss.Add(parameters);

            parameters = new ExcParameters()
            {
                _KEY = "@PriceModule",
                _VALUE = PriceModule
            };
            paramss.Add(parameters);

            parameters = new ExcParameters()
            {
                _KEY = "@PriceShow",
                _VALUE = PriceShow
            };
            paramss.Add(parameters);

            parameters = new ExcParameters()
            {
                _KEY = "@describtion",
                _VALUE = describtion
            };
            paramss.Add(parameters);

            string query = "";

            if (action == "insert")
            {
                query = "INSERT INTO[tlb_Product_MainProductConnector] Output Inserted.id_MPC VALUES(@id_MProduct, @Quantity, @PriceXquantity, @PricePerquantity, @PriceOff, @offTypeValue, @OffType, @id_MainStarTag , 0 , 0 ,  @QuantityModule ,GetDate(), @PriceModule, @PriceShow,@describtion)";
            }
            else if (action == "update")
            {
                query = "UPDATE [tlb_Product_MainProductConnector]SET [Quantity] =  @Quantity ,[PriceXquantity] = @PriceXquantity,[PricePerquantity] =@PricePerquantity ,[PriceOff] =@PriceOff ,[offTypeValue] = @offTypeValue ,[OffType] = @PriceOff,[id_MainStarTag] = @id_MainStarTag ,[id_PQT] = @QuantityModule,[PriceModule] = @PriceModule ,[PriceShow] = @PriceShow  WHERE id_MPC=@id_MProduct";

            }
            else if (action == "delete")
            {

            }

            if (query != "")
            {
                db.Connect();
                string res = db.Script(query, paramss);
                if (action == "insert")
                {
                    db.Script("INSERT INTO [tbl_Product_PastProductHistory]VALUES(" + res + ",@PriceXquantity,@PricePerquantity,@PriceOff,@OffType,@id_MainStarTag,GETDATE(),@offTypeValue)", paramss);
                }
                else if (action == "update")
                {
                    db.Script("INSERT INTO [tbl_Product_PastProductHistory]VALUES(@id_MProduct,@PriceXquantity,@PricePerquantity,@PriceOff,@OffType,@id_MainStarTag,GETDATE(),@offTypeValue)", paramss);
                }
                db.DC();
                return res;
            }
            else
                return "0";

        }

        public string Product_Action_Step1(string Action, string id_CreatedByAdmin, string Title, string Description, string SEO_keyword, string SEO_description, string SearchGravity, int IsAd, int id_pr = 0)
        {
            List<ExcParameters> paramss = new List<ExcParameters>();
            PDBC db = new PDBC("PandaMarketCMS", true);
            var parameters = new ExcParameters()
            {
                _KEY = "@id_CreatedByAdmin",
                _VALUE = id_CreatedByAdmin
            };
            paramss.Add(parameters);

            parameters = new ExcParameters()
            {
                _KEY = "@Title",
                _VALUE = Title
            };
            paramss.Add(parameters);

            parameters = new ExcParameters()
            {
                _KEY = "@Description",
                _VALUE = Description
            };
            paramss.Add(parameters);

            parameters = new ExcParameters()
            {
                _KEY = "@SEO_keyword",
                _VALUE = SEO_keyword
            };
            paramss.Add(parameters);

            parameters = new ExcParameters()
            {
                _KEY = "@SEO_description",
                _VALUE = SEO_description
            };
            paramss.Add(parameters);

            parameters = new ExcParameters()
            {
                _KEY = "@SearchGravity",
                _VALUE = SearchGravity
            };
            paramss.Add(parameters);

            parameters = new ExcParameters()
            {
                _KEY = "@IsAd",
                _VALUE = IsAd
            };
            paramss.Add(parameters);

            string query = "";

            //id_CreatedByAdmin, string Title, string Description, string SEO_keyword, string SEO_description, string SearchGravity, int IsAd

            if (Action.Equals("insert"))
            {
                query = "INSERT INTO[tbl_Product] Output Inserted.id_MProduct VALUES(1, @id_CreatedByAdmin , 0 , 0 , 0 , 0 , 0 ,@Description,GETDATE(), @Title , @SEO_description , @SEO_keyword , @IsAd , @SearchGravity , 0 , 0)";
            }
            else if (Action == "update")
            {
                query = "UPDATE [tbl_Product] SET [Description] = @Description ,[Title] = @Title,[Seo_Description] = @SEO_description,[Seo_KeyWords] = @SEO_keyword ,[IS_AD] = @IsAd ,[Search_Gravity] = @SearchGravity WHERE id_MProduct=" + id_pr;
            }
            else if (Action == "delete")
            {

            }

            if (query != "")
            {
                db.Connect();
                string result =  db.Script(query, paramss);
                db.DC();
                return result;
            }
            else
                return "0";
        }

        public string Product_Action_Step2(string Type, string Main, string Sub, string SubKey, int id)
        {
            List<ExcParameters> paramss = new List<ExcParameters>();
            PDBC db = new PDBC("PandaMarketCMS", true);
            
            var parameters = new ExcParameters()
            {
                _KEY = "@id_Type",
                _VALUE = Type
            };
            paramss.Add(parameters);

            parameters = new ExcParameters()
            {
                _KEY = "@id_MainCategory",
                _VALUE = Main
            };
            paramss.Add(parameters);

            parameters = new ExcParameters()
            {
                _KEY = "@id_SubCategory",
                _VALUE = Sub
            };
            paramss.Add(parameters);

            parameters = new ExcParameters()
            {
                _KEY = "@id_MProduct",
                _VALUE = id
            };
            paramss.Add(parameters);

            string query = "UPDATE [tbl_Product]SET [id_Type] =@id_Type ,[id_MainCategory] =@id_MainCategory ,[id_SubCategory] =@id_SubCategory WHERE [id_MProduct]=@id_MProduct";
            db.Connect();
            var subk = SubKey.Split(',');
            for (int i = 0; i < subk.Length; i++)
            {
                db.Script("INSERT INTO [tbl_Product_ConnectorSCOK_Product]([id_MProduct],[id_SCOK])VALUES(" + id + "," + subk[i] + ")");
            }
            string results = db.Script(query, paramss);
            db.DC();
            return results;
        }

        public List<Id_ValueModel> TagsModel_Filler(int id)
        {
            var result = new List<Id_ValueModel>();
            PDBC db = new PDBC("PandaMarketCMS", true);
            db.Connect();

            DataTable dt = db.Select("SELECT [id_TE],[TE_name]FROM [tbl_Product_TagEnums] WHERE SubCatId=" + id);
            db.DC();
            for (int i = 0; i < dt.Rows.Count; i++)
            {
                var model = new Id_ValueModel()
                {
                    Id = Convert.ToInt32(dt.Rows[i]["id_TE"]),
                    Value = dt.Rows[i]["TE_name"].ToString()
                };

                result.Add(model);
            }

            return result;
        }

        public List<Id_ValueModel> MainTagsModel_Filler()
        {
            var result = new List<Id_ValueModel>();
            PDBC db = new PDBC("PandaMarketCMS", true);
            db.Connect();

            DataTable dt = db.Select("SELECT [id_MainStarTag],[MST_Name] FROM [tbl_Product_MainStarTags]");
            db.DC();
            for (int i = 0; i < dt.Rows.Count; i++)
            {
                var model = new Id_ValueModel()
                {
                    Id = Convert.ToInt32(dt.Rows[i]["id_MainStarTag"]),
                    Value = dt.Rows[i]["MST_Name"].ToString()
                };

                result.Add(model);
            }

            return result;
        }

        public List<Id_ValueModel> OffTypeModel_Filler()
        {
            var result = new List<Id_ValueModel>();
            PDBC db = new PDBC("PandaMarketCMS", true);
            db.Connect();

            DataTable dt = db.Select("SELECT [OffType],[OffType_Symbol]FROM .[tbl_Product_OffType]");
            db.DC();
            for (int i = 0; i < dt.Rows.Count; i++)
            {
                var model = new Id_ValueModel()
                {
                    Id = Convert.ToInt32(dt.Rows[i]["OffType"]),
                    Value = dt.Rows[i]["OffType_Symbol"].ToString()
                };

                result.Add(model);
            }

            return result;
        }

        public List<Id_ValueModel> PQTModel_Filler()
        {
            var result = new List<Id_ValueModel>();
            PDBC db = new PDBC("PandaMarketCMS", true);
            db.Connect();

            DataTable dt = db.Select("SELECT[id_PQT],[PQT_Demansion] FROM[tbl_Product_ProductQuantityType] order by([PQT_Demansion])");
            db.DC();
            for (int i = 0; i < dt.Rows.Count; i++)
            {
                var model = new Id_ValueModel()
                {
                    Id = Convert.ToInt32(dt.Rows[i]["id_PQT"]),
                    Value = dt.Rows[i]["PQT_Demansion"].ToString()
                };

                result.Add(model);
            }

            return result;
        }

        public List<Id_ValueModel> MoneyTypeModel_Filler()
        {
            var result = new List<Id_ValueModel>();
            PDBC db = new PDBC("PandaMarketCMS", true);
            db.Connect();

            DataTable dt = db.Select("SELECT [MoneyId],[MoneyTypeName] FROM [tbl_Product_MoneyType]");
            db.DC();
            for (int i = 0; i < dt.Rows.Count; i++)
            {
                var model = new Id_ValueModel()
                {
                    Id = Convert.ToInt32(dt.Rows[i]["MoneyId"]),
                    Value = dt.Rows[i]["MoneyTypeName"].ToString()
                };

                result.Add(model);
            }

            return result;
        }

        public List<Id_ValueModel> PriceShowModel_Filler()
        {
            var result = new List<Id_ValueModel>();
            PDBC db = new PDBC("PandaMarketCMS", true);
            db.Connect();
            DataTable dt = db.Select("SELECT [PriceShowId],[PriceShowformat] FROM [tbl_Product_PriceShow]");
            db.DC();
            for (int i = 0; i < dt.Rows.Count; i++)
            {
                var model = new Id_ValueModel()
                {
                    Id = Convert.ToInt32(dt.Rows[i]["PriceShowId"]),
                    Value = dt.Rows[i]["PriceShowformat"].ToString()
                };

                result.Add(model);
            }

            return result;
        }

        public List<PricingModel> pricingModelfiller(int id)
        {
            var result = new List<PricingModel>();
            PDBC db = new PDBC("PandaMarketCMS", true);
            db.Connect();

            DataTable dt = db.Select("SELECT [id_MPC],[Quantity],[PriceXquantity],[PricePerquantity],[PriceOff],[offTypeValue],[OffType],[id_MainStarTag],[ISDELETE],[id_PQT],[PriceModule],[PriceShow],[describtion]FROM[tlb_Product_MainProductConnector] Where [id_MProduct]=" + id);

            for (int i = 0; i < dt.Rows.Count; i++)
            {
                var model = new PricingModel()
                {
                    Id = Convert.ToInt32(dt.Rows[i]["id_MPC"]),
                    MainTagId = Convert.ToInt32(dt.Rows[i]["id_MainStarTag"]),
                    OffType = Convert.ToInt32(dt.Rows[i]["OffType"]),
                    OffVal = long.Parse(dt.Rows[i]["offTypeValue"].ToString()),
                    PerQuantity = long.Parse(dt.Rows[i]["PricePerquantity"].ToString()),
                    PriceOff = long.Parse(dt.Rows[i]["PriceOff"].ToString()),
                    PriceModule = Convert.ToInt32(dt.Rows[i]["PriceModule"]),
                    PriceShow = Convert.ToInt32(dt.Rows[i]["PriceShow"]),
                    Quantity = Convert.ToInt32(dt.Rows[i]["Quantity"]),
                    QuantityType = Convert.ToInt32(dt.Rows[i]["id_PQT"])

                };
                if (dt.Rows[i]["ISDELETE"].ToString() == "1")
                {
                    model.IsDeleted = true;
                }
                else
                {
                    model.IsDeleted = false;
                }
                List<string> attr = new List<string>();
                string s = "";
                DataTable dt1 = db.Select("SELECT B.SCOVValueName FROM [tbl_Product_connectorToMPC_SCOV] as A inner join [tbl_Product_SubCategoryOptionValue] as B On A.id_SCOV=B.id_SCOV WHERE A.id_MPC=" + model.Id + " Group By(B.SCOVValueName)");
                if (dt1.Rows.Count > 0)
                {
                    for (int j = 0; j < dt1.Rows.Count; j++)
                    {
                        attr.Add(dt1.Rows[j]["SCOVValueName"].ToString());
                        s += dt1.Rows[j]["SCOVValueName"].ToString() + " , ";
                    }
                }
                else
                {
                    attr.Add("ندارد");
                }

                model.Attributes = attr;
                model.Description = s;

                List<int> tags = new List<int>();

                DataTable dt2 = db.Select("SELECT [id_TE] FROM [tbl_Product_tagConnector] WHERE id_MPC=" + model.Id);

                if (dt1.Rows.Count > 0)
                {
                    for (int j = 0; j < dt2.Rows.Count; j++)
                    {

                        tags.Add(Convert.ToInt32(dt2.Rows[j]["id_TE"]));

                    }

                }
                else
                {
                    tags.Add(0);
                }
                model.Tags = tags;

                result.Add(model);
            }
            db.DC();
            return result;

        }

        public List<TableModel> SCVModel(int id)
        {
            var result = new List<TableModel>();
            PDBC db = new PDBC("PandaMarketCMS", true);
            db.Connect();
            DataTable dt;
            if (id == 0)
            {
                dt = db.Select("SELECT A.id_SCOV, A.SCOVValueName , B.SCOKName FROM [tbl_Product_SubCategoryOptionValue]as A inner join [tbl_Product_SubCategoryOptionKey] as B On A.id_SCOK=B.id_SCOK Where B.ISDelete=0 AND B.ISDESABLED=0");

            }
            else
            {
                dt = db.Select("SELECT A.id_SCOV, A.SCOVValueName , B.SCOKName FROM [tbl_Product_SubCategoryOptionValue]as A inner join [tbl_Product_SubCategoryOptionKey] as B On A.id_SCOK=B.id_SCOK Where B.ISDelete=0 AND B.ISDESABLED=0 AND A.id_SCOK=" + id);
            }
            db.DC();
            for (int i = 0; i < dt.Rows.Count; i++)
            {
                var model = new TableModel()
                {
                    Num = i + 1,
                    Id = Convert.ToInt32(dt.Rows[i]["id_SCOV"]),
                    Group1 = dt.Rows[i]["SCOVValueName"].ToString(),
                    Group2 = dt.Rows[i]["SCOKName"].ToString()
                };

                result.Add(model);
            }
            return result;
        }

        public List<TableModel> Tags(int SubId)
        {
            var result = new List<TableModel>();
            PDBC db = new PDBC("PandaMarketCMS", true);
            db.Connect();
            DataTable dt;
            if (SubId == 0)
            {
                dt = db.Select("SELECT [id_TE],[TE_name],B.SCName FROM [tbl_Product_TagEnums] as A inner join [tbl_Product_SubCategory] as B On A.SubCatId=B.id_SC WHERE B.ISDelete=0 AND B.ISDESABLED=0 ");

            }
            else
            {
                dt = db.Select("SELECT [id_TE],[TE_name],B.SCName FROM [tbl_Product_TagEnums] as A inner join [tbl_Product_SubCategory] as B On A.SubCatId=B.id_SC WHERE B.ISDelete=0 AND B.ISDESABLED=0 AND A.SubCatId=" + SubId);
            }
            db.DC();
            for (int i = 0; i < dt.Rows.Count; i++)
            {
                var model = new TableModel()
                {
                    Num = i + 1,
                    Id = Convert.ToInt32(dt.Rows[i]["id_TE"]),
                    Group1 = dt.Rows[i]["TE_name"].ToString(),
                    Group2 = dt.Rows[i]["SCName"].ToString()
                };

                result.Add(model);
            }
            return result;
        }

        public List<TableModel> MainTags()
        {
            var result = new List<TableModel>();
            PDBC db = new PDBC("PandaMarketCMS", true);
            db.Connect();

            DataTable dt = db.Select("SELECT [id_MainStarTag],[MST_Description],[MST_Name] FROM [tbl_Product_MainStarTags]");
            db.DC();

            for (int i = 0; i < dt.Rows.Count; i++)
            {
                var model = new TableModel()
                {
                    Num = i + 1,
                    Id = Convert.ToInt32(dt.Rows[i]["id_MainStarTag"]),
                    Group1 = dt.Rows[i]["MST_Name"].ToString(),
                    Group2 = dt.Rows[i]["MST_Description"].ToString()
                };

                result.Add(model);
            }
            return result;
        }

        public List<TreeModel> CatTreeModelFiller()
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
            db.DC();
            return result;
        }

        public UpdateProModel UpdateProFiller(int id)
        {

            PDBC db = new PDBC("PandaMarketCMS", true);
            db.Connect();
            DataTable dt = db.Select("SELECT [id_MProduct],[Description],[Title],[Seo_Description],[Seo_KeyWords],[IS_AD],[Search_Gravity] FROM [tbl_Product] where id_MProduct=" + id);
            var res = new UpdateProModel()
            {
                Id = Convert.ToInt32(dt.Rows[0]["id_MProduct"]),
                Title = dt.Rows[0]["Title"].ToString(),
                Description = dt.Rows[0]["Description"].ToString(),
                SEO_keyword = dt.Rows[0]["Seo_KeyWords"].ToString(),
                SEO_Description = dt.Rows[0]["Seo_Description"].ToString(),
                SearchGravity = Convert.ToInt32(dt.Rows[0]["Search_Gravity"]),
                IsAd = dt.Rows[0]["IS_AD"].ToString()
            };
            DataTable dt2 = db.Select("SELECT [PicID] FROM [tbl_Product_PicConnector] where id_MProduct=" + id);
            db.DC();
            string s = "";
            for (int i = 0; i < dt2.Rows.Count; i++)
            {
                s += dt2.Rows[i]["PicID"] + ",";
            }

            res.Pics = s;
            return res;
        }

        public List<AdminTypeRoutesModel> AdminTypeFiller()
        {
            var result = new List<AdminTypeRoutesModel>();
            PDBC db = new PDBC("PandaMarketCMS", true);
            db.Connect();

            DataTable dt = db.Select("SELECT [CatId],[R_CatName] FROM [tbl_ADMIN_ruleRoutes_Category]");
            for (int i = 0; i < dt.Rows.Count; i++)
            {
                DataTable dt2 = db.Select("SELECT [rulerouteID],[ruleRouteURL],[ruleRouteName] FROM [tbl_ADMIN_ruleRoutes_Main] where ruleRouteCatId=" + dt.Rows[i]["CatId"]);
                var MList = new List<RouteModel>();
                for (int j = 0; j < dt2.Rows.Count; j++)
                {
                    var model = new RouteModel()
                    {
                        RouteId = Convert.ToInt32(dt2.Rows[j]["rulerouteID"]),
                        RouteName = dt2.Rows[j]["ruleRouteName"].ToString(),
                        RouteUrl = dt2.Rows[j]["ruleRouteURL"].ToString()
                    };
                    MList.Add(model);
                }

                var modelRes = new AdminTypeRoutesModel()
                {
                    CatId = Convert.ToInt32(dt.Rows[i]["CatId"]),
                    CatName = dt.Rows[i]["R_CatName"].ToString(),
                    RouteList = MList
                };

                result.Add(modelRes);
            }
            db.DC();

            return result;
        }

        public List<AdminTypeRoutesModel> Modal_admin_Type(int id)
        {
            var res = new List<AdminTypeRoutesModel>();

            PDBC db = new PDBC("PandaMarketCMS", true);
            db.Connect();
            DataTable dt = db.Select("SELECT [CatId],[R_CatName] FROM [tbl_ADMIN_ruleRoutes_Category]");
            for (int i = 0; i < dt.Rows.Count; i++)
            {
                DataTable dt2 = db.Select("SELECT A.[rulerouteID],[ruleRouteURL],[ruleRouteName] FROM [tbl_ADMIN_ruleRoutes_Main] as A inner join [tbl_ADMIN_types_ruleRoute_Connection] as B on A.rulerouteID=B.rulerouteID where ruleRouteCatId=" + dt.Rows[i]["CatId"] + " and B.HasAccess=1 and B.ad_typeID=" + id);
                var MList = new List<RouteModel>();
                for (int j = 0; j < dt2.Rows.Count; j++)
                {
                    var model = new RouteModel()
                    {
                        RouteId = Convert.ToInt32(dt2.Rows[j]["rulerouteID"]),
                        RouteName = dt2.Rows[j]["ruleRouteName"].ToString(),
                        RouteUrl = dt2.Rows[j]["ruleRouteURL"].ToString()
                    };
                    MList.Add(model);
                }

                var modelRes = new AdminTypeRoutesModel()
                {
                    CatId = Convert.ToInt32(dt.Rows[i]["CatId"]),
                    CatName = dt.Rows[i]["R_CatName"].ToString(),
                    RouteList = MList
                };
                if (MList.Count != 0)
                {
                    res.Add(modelRes);
                }

            }
            db.DC();
            return res;
        }

        public List<AdminTypeTbl_Model> AdminTypeTbl()
        {
            var res = new List<AdminTypeTbl_Model>();

            PDBC db = new PDBC("PandaMarketCMS", true);
            db.Connect();
            DataTable dt1 = db.Select("SELECT [ad_typeID],[ad_type_name] FROM [tbl_ADMIN_types]");

            for (int i = 0; i < dt1.Rows.Count; i++)
            {
                DataTable dt2 = db.Select("SELECT [rulerouteID]FROM [tbl_ADMIN_types_ruleRoute_Connection] where HasAccess=1 and [ad_typeID]=" + dt1.Rows[i]["ad_typeID"]);
                StringBuilder s = new StringBuilder();
                for (int j = 0; j < dt2.Rows.Count; j++)
                {
                    s.Append(dt2.Rows[j]["rulerouteID"]);
                    s.Append(",");
                }

                var model = new AdminTypeTbl_Model()
                {
                    TypeId = Convert.ToInt32(dt1.Rows[i]["ad_typeID"]),
                    AT_Name = dt1.Rows[i]["ad_type_name"].ToString(),
                    EditString = s.ToString(),
                    Num = i + 1
                };
                res.Add(model);
            }

            db.DC();
            return res;
        }

        public string Add_Update_AdType_(string ActToDo, string Ad_Name, string Routes, int id = 0)
        {
            PDBC db = new PDBC("PandaMarketCMS", true);
            db.Connect();

            if (ActToDo == "insert")
            {
                string Ad_id_ = db.Script("INSERT INTO [tbl_ADMIN_types] output inserted.ad_typeID VALUES(N'" + Ad_Name + "')");
                var ids = Routes.Split(',');
                for (int i = 0; i < ids.Length; i++)
                {
                    db.Script("INSERT INTO [tbl_ADMIN_types_ruleRoute_Connection] VALUES(" + Ad_id_ + "," + ids[i] + ",1)");
                }
                db.DC();

            }
            else if (ActToDo == "update")
            {
                db.Script("UPDATE[tbl_ADMIN_types] SET [ad_type_name] =N'" + Ad_Name + "' WHERE ad_typeID=" + id);
                db.Script("DELETE FROM [tbl_ADMIN_types_ruleRoute_Connection] WHERE ad_typeID=" + id);
                var ids = Routes.Split(',');
                for (int i = 0; i < ids.Length; i++)
                {
                    db.Script("INSERT INTO [tbl_ADMIN_types_ruleRoute_Connection] VALUES(" + id + "," + ids[i] + ",1)");
                }
                db.DC();
            }
            return "success";
        }

        public List<Id_ValueModel> AdminTypes()
        {
            var res = new List<Id_ValueModel>();
            PDBC db = new PDBC("PandaMarketCMS", true);
            db.Connect();

            DataTable dt = db.Select("SELECT [ad_typeID],[ad_type_name] FROM [tbl_ADMIN_types]");
            db.DC();
            for (int i = 0; i < dt.Rows.Count; i++)
            {
                var model = new Id_ValueModel()
                {
                    Id = Convert.ToInt32(dt.Rows[i]["ad_typeID"]),
                    Value = dt.Rows[i]["ad_type_name"].ToString()
                };
                res.Add(model);
            }

            return res;
        }

        public List<AdminModel> Admins()
        {
            var res = new List<AdminModel>();
            PDBC db = new PDBC("PandaMarketCMS", true);
            db.Connect();
            DataTable dt = db.Select("SELECT [id_Admin] ,(SELECT top 1 [ad_type_name] FROM [tbl_ADMIN_types] where ad_typeID=[ad_typeID]) as AdType ,[ad_firstname]+' '+[ad_lastname] as [name],[ad_avatarprofile],[ad_email],[ad_mobile],[ad_isActive],[ad_isDelete],[ad_lastseen] FROM [tbl_ADMIN_main]");
            db.DC();
            for (int i = 0; i < dt.Rows.Count; i++)
            {

                var model = new AdminModel()
                {
                    Id = Convert.ToInt32(dt.Rows[i]["id_Admin"]),
                    AdminType = dt.Rows[i]["AdType"].ToString(),
                    Email = dt.Rows[i]["ad_email"].ToString(),
                    IsActive = Convert.ToInt32(dt.Rows[i]["ad_isActive"]),
                    IsDeleted = Convert.ToInt32(dt.Rows[i]["ad_isDelete"]),
                    Name = dt.Rows[i]["name"].ToString(),
                    Phone = dt.Rows[i]["ad_mobile"].ToString(),
                    Pic = AppendServername(dt.Rows[i]["ad_avatarprofile"].ToString())
                };

                if (dt.Rows[i]["ad_lastseen"].ToString() != "")
                {
                    DateTime date = Convert.ToDateTime(dt.Rows[i]["ad_lastseen"]);
                    PersianDateTime persianDateTime = new PersianDateTime(date);
                    PersianDateTime PerNow = new PersianDateTime(DateTime.Now);
                    var dateTest = PerNow.Subtract(persianDateTime);
                    if (dateTest.Days < 1)
                    {
                        if (dateTest.Hours < 1)
                        {
                            model.LastSeen = dateTest.Minutes.ToString();
                            model.LastSeenQuantity = 1;
                        }
                        else
                        {
                            model.LastSeen = dateTest.Hours.ToString();
                            model.LastSeenQuantity = 2;
                        }
                    }
                    else
                    {
                        model.LastSeen = dateTest.Days.ToString();
                        model.LastSeenQuantity = 3;
                    }
                }
                else
                {
                    model.LastSeen = "";
                    model.LastSeenQuantity = 0;
                }

                res.Add(model);
            }

            return res;
        }

        public List<FactorModel> FactorTableFiller(string act)
        {
            var res = new List<FactorModel>();
            PDBC db = new PDBC("PandaMarketCMS", true);
            string query = "";
            if (act == "all")
            {
                query = "SELECT [Factor_Id],(SELECT [C_FirstName]+' '+[C_LastNAme] FROM [tbl_Customer_Main] WHERE id_Customer=[Customer_Id])as CustomerName ,[date],[toality],[deposit_price],(SELECT COUNT(*) FROM [tbl_FACTOR_Items] WHERE FactorId=[Factor_Id])as number,(SELECT top 1 [MoneyTypeName] FROM [tbl_Product_MoneyType] as A inner join [tlb_Product_MainProductConnector]as B on A.MoneyId=B.[PriceModule] inner join [tbl_FACTOR_Items] as C on B.id_MPC=C.Pro_Id WHERE C.FactorId=[Factor_Id])AS priceQuantity ,[Done] ,[IsDeleted]  FROM [tbl_FACTOR_Main]";
            }
            else if (act == "!Done")
            {
                query = "SELECT [Factor_Id],(SELECT [C_FirstName]+' '+[C_LastNAme] FROM [tbl_Customer_Main] WHERE id_Customer=[Customer_Id])as CustomerName ,[date],[toality],[deposit_price],(SELECT COUNT(*) FROM [tbl_FACTOR_Items] WHERE FactorId=[Factor_Id])as number,(SELECT top 1 [MoneyTypeName] FROM [tbl_Product_MoneyType] as A inner join [tlb_Product_MainProductConnector]as B on A.MoneyId=B.[PriceModule] inner join [tbl_FACTOR_Items] as C on B.id_MPC=C.Pro_Id WHERE C.FactorId=[Factor_Id])AS priceQuantity ,[Done] ,[IsDeleted]  FROM [tbl_FACTOR_Main] where [Done]=0 ";
            }


            db.Connect();

            DataTable dt = db.Select(query);
            db.DC();
            for (int i = 0; i < dt.Rows.Count; i++)
            {
                DateTime date = Convert.ToDateTime(dt.Rows[i]["date"]);
                PersianDateTime persianDateTime = new PersianDateTime(date);
                var model = new FactorModel()
                {
                    Id = Convert.ToInt32(dt.Rows[i]["Factor_Id"]),
                    totality = dt.Rows[i]["toality"].ToString(),
                    CustomerName = dt.Rows[i]["CustomerName"].ToString(),
                    deposit = dt.Rows[i]["deposit_price"].ToString(),
                    ItmNumbers = Convert.ToInt32(dt.Rows[i]["number"]),
                    priceQuantity = dt.Rows[i]["priceQuantity"].ToString(),
                    Date = persianDateTime.ToShortDateTimeString(),
                    status = Convert.ToInt32(dt.Rows[i]["Done"]),
                    IsDeleted = Convert.ToInt32(dt.Rows[i]["IsDeleted"])
                };

                res.Add(model);
            }

            return res;
        }

        public FactorDetailModel FactorDetailePage(int id)
        {

            PDBC db = new PDBC("PandaMarketCMS", true);
            db.Connect();

            DataTable dt = db.Select("SELECT [Factor_Id],[Customer_Id],(SELECT top 1 [Ostan_name] +N' ، ' + [Shahr_Name] FROM [tbl_Enum_Shahr] where ID_Shahr=B.ID_Shahr)+N' ، ' +B.C_FullAddress as Adddress,C.C_FirstName +' '+C.C_LastNAme as C_Name,C.C_Mobile,[date],[Off_Code],[toality],(SELECT top 1 [MoneyTypeName] FROM [tbl_Product_MoneyType] as D inner join [tlb_Product_MainProductConnector]as E on D.MoneyId=E.[PriceModule] inner join [tbl_FACTOR_Items] as F on E.id_MPC=F.Pro_Id WHERE F.FactorId=[Factor_Id])AS priceQuantity ,[deposit_price] FROM [tbl_FACTOR_Main] as A inner join [tbl_Customer_Address] as B on A.AddressId=B.id_CAddress inner join [tbl_Customer_Main] as C on A.Customer_Id=C.id_Customer where Factor_Id=" + id);

            DataTable ItemsDt = db.Select("SELECT [ItemId],[Pro_Id],[number],[OffTypeValue], B.OffType, B.PriceXquantity, B.PriceOff,(SELECT [Title] FROM [tbl_Product] as A inner join [tlb_Product_MainProductConnector] as B on A.id_MProduct=B.id_MProduct where B.id_MPC=Pro_Id) as ProTitle FROM [tbl_FACTOR_Items] as A inner join [tbl_Product_PastProductHistory] as B on A.PriceDateId=B.id_PPH where A.FactorId=" + id);
            var items = new List<FactorItemModel>();
            for (int i = 0; i < ItemsDt.Rows.Count; i++)
            {
                var model = new FactorItemModel()
                {
                    Id = Convert.ToInt32(ItemsDt.Rows[i]["ItemId"]),
                    Num = i + 1,
                    offType = Convert.ToInt32(ItemsDt.Rows[i]["OffType"]),
                    perPrice = long.Parse(ItemsDt.Rows[i]["PriceXquantity"].ToString()),
                    Numbers = Convert.ToInt32(ItemsDt.Rows[i]["number"]),
                    OffValue = long.Parse(ItemsDt.Rows[i]["OffTypeValue"].ToString()),
                    Title = ItemsDt.Rows[i]["ProTitle"].ToString(),
                    perPrice_off = long.Parse(ItemsDt.Rows[i]["PriceOff"].ToString())
                };

                model.allPrice = model.Numbers * model.perPrice;
                model.allPrice_Off = model.Numbers * model.perPrice_off;

                DataTable dt2 = db.Select("SELECT B.SCOVValueName FROM [tbl_Product_connectorToMPC_SCOV] as A inner join [tbl_Product_SubCategoryOptionValue] as B on A.id_SCOV=B.id_SCOV WHERE A.id_MPC=" + ItemsDt.Rows[i]["Pro_Id"]);
                string s = "";
                for (int j = 0; j < dt2.Rows.Count; j++)
                {
                    s += dt2.Rows[j]["SCOVValueName"];
                    if (j != dt2.Rows.Count - 1)
                    {
                        s += ",";
                    }
                }
                model.Discription = s;

                items.Add(model);
            }
            db.DC();
            FactorDetailModel res;
            if (dt.Rows.Count != 0)
            {
                DateTime date = Convert.ToDateTime(dt.Rows[0]["date"]);
                PersianDateTime persianDateTime = new PersianDateTime(date);
                res = new FactorDetailModel()
                {
                    Id = Convert.ToInt32(dt.Rows[0]["Factor_Id"]),
                    CustomerAddress = dt.Rows[0]["Adddress"].ToString(),
                    CustomerName = dt.Rows[0]["C_Name"].ToString(),
                    CustomerPhoneNumber = dt.Rows[0]["C_Mobile"].ToString(),
                    deposit = long.Parse(dt.Rows[0]["deposit_price"].ToString()),
                    OffCode = dt.Rows[0]["Off_Code"].ToString(),
                    priceQuantity = dt.Rows[0]["priceQuantity"].ToString(),
                    ProductItems = items,
                    totality = long.Parse(dt.Rows[0]["toality"].ToString()),
                    Date = persianDateTime.ToShortDateString()
                };

            }
            else
            {
                res = new FactorDetailModel();
            }
            return res;
        }

        public List<TableModel> Pro_SaleList(string GP, int Id)
        {
            PDBC db = new PDBC("PandaMarketCMS", true);
            db.Connect();
            var res = new List<TableModel>();
            if (GP == "همه")
            {
                DataTable dt = db.Select("SELECT (SELECT Top 1 SUM((SELECT Top 1 SUM((SELECT top 1 [PriceOff] FROM [tbl_Product_PastProductHistory] where id_MPC=[Pro_Id])* number) Over(Order by Done) FROM [tbl_FACTOR_Items] as A inner join [tbl_FACTOR_Main] as B on A.FactorId=B.Factor_Id where B.Done=1 AND A.Pro_Id= D.id_MPC))over (Order by D.id_MPC) as [All] FROM [tbl_Product] as C inner join [tlb_Product_MainProductConnector] as D on C.id_MProduct=D.id_MProduct where C.id_MProduct=main.[id_MProduct] order by ([All])DESC) as [All],[Title],[Description],[id_MProduct] FROM [tbl_Product] As main order by ([All])DESC");

                for (int i = 0; i < dt.Rows.Count; i++)
                {
                    var model = new TableModel()
                    {
                        Id = Convert.ToInt32(dt.Rows[i]["id_MProduct"]),
                        Group3 = dt.Rows[i]["All"].ToString(),
                        Group1 = dt.Rows[i]["Title"].ToString(),
                        Group2 = dt.Rows[i]["Description"].ToString(),
                        Num = 1
                    };
                    res.Add(model);
                }



            }
            else
            {
                DataTable dt = db.Select("SELECT id_MPC, (SELECT Top 1 SUM((SELECT top 1 [PriceOff] FROM [tbl_Product_PastProductHistory] where id_MPC=[Pro_Id])* number) Over(Order by Done) FROM [tbl_FACTOR_Items] as A inner join [tbl_FACTOR_Main] as B on A.FactorId=B.Factor_Id where B.Done=1 AND A.Pro_Id= id_MPC) as [All] FROM [tlb_Product_MainProductConnector] where id_MProduct=" + Id + " order by ([All])DESC");

                DataTable dt3 = db.Select("SELECT [Title] FROM [tbl_Product] WHERE [id_MProduct]=" + Id);
                for (int i = 0; i < dt.Rows.Count; i++)
                {
                    DataTable dt2 = db.Select("SELECT B.SCOVValueName FROM [tbl_Product_connectorToMPC_SCOV] as A inner join [tbl_Product_SubCategoryOptionValue] as B on A.id_SCOV=B.id_SCOV WHERE A.id_MPC=" + dt.Rows[i]["id_MPC"]);

                    string s = "";
                    for (int j = 0; j < dt2.Rows.Count; j++)
                    {
                        s += dt2.Rows[j]["SCOVValueName"];
                        if (j != dt2.Rows.Count - 1)
                        {
                            s += ",";
                        }
                    }

                    var model = new TableModel()
                    {
                        Id = Convert.ToInt32(dt.Rows[i]["id_MPC"]),
                        Group3 = dt.Rows[i]["All"].ToString(),
                        Group1 = dt3.Rows[0]["Title"].ToString(),
                        Group2 = s
                    };
                    res.Add(model);
                }

            }
            db.DC();
            return res;
        }

        public List<CustomerModel> Customers()
        {
            PDBC db = new PDBC("PandaMarketCMS", true);
            var res = new List<CustomerModel>();

            db.Connect();
            DataTable dt = db.Select("SELECT [id_Customer],[C_Mobile],[C_FirstName] +' '+[C_LastNAme] as C_Name,[C_Description],[C_ISActivate] FROM [tbl_Customer_Main]");
            db.DC();
            for (int i = 0; i < dt.Rows.Count; i++)
            {
                var model = new CustomerModel()
                {
                    Id = Convert.ToInt32(dt.Rows[i]["id_Customer"]),
                    Name = dt.Rows[i]["C_Name"].ToString(),
                    Discription = dt.Rows[i]["C_Description"].ToString(),
                    Phone = dt.Rows[i]["C_Mobile"].ToString(),
                    IsActive = Convert.ToInt32(dt.Rows[i]["C_ISActivate"])
                };
                res.Add(model);
            }

            return res;
        }

        public CustomerDitaile customerDitail(int id)
        {
            PDBC db = new PDBC("PandaMarketCMS", true);
            var AddresList = new List<AddressModel>();
            db.Connect();
            DataTable dt1 = db.Select("SELECT DISTINCT  B.Ostan_name +' , '+B.Shahr_Name as city ,[C_AddressHint],[C_FullAddress] FROM [tbl_Customer_Address] as A inner join [tbl_Enum_Shahr] as B on A.ID_Shahr=B.ID_Shahr where A.id_Customer=" + id);

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

            DataTable dt = db.Select("SELECT [id_Customer],[C_regDate],[C_Mobile],[C_FirstName],[C_LastNAme],[C_Description] FROM [tbl_Customer_Main]where id_Customer=" + id);
            db.DC();
            var res = new CustomerDitaile();

            if (dt.Rows.Count != 0)
            {
                DateTime date = Convert.ToDateTime(dt.Rows[0]["C_regDate"]);
                PersianDateTime persianDateTime = new PersianDateTime(date);
                res.Id = Convert.ToInt32(dt.Rows[0]["id_Customer"]);
                res.Name = dt.Rows[0]["C_FirstName"].ToString();
                res.Familly = dt.Rows[0]["C_LastNAme"].ToString();
                res.Discription = dt.Rows[0]["C_Description"].ToString();
                res.PhoneNum = dt.Rows[0]["C_Mobile"].ToString();
                res.registerDate = persianDateTime.ToShortDateString();
                res.Addresses = AddresList;
            }


            return res;
        }

        public List<TableModel> Customer_Buy()
        {
            PDBC db = new PDBC("PandaMarketCMS", true);
            var res = new List<TableModel>();

            db.Connect();
            DataTable dt = db.Select("SELECT DISTINCT Customer_Id,(SELECT [C_FirstName]+' '+[C_LastNAme] FROM [tbl_Customer_Main] where id_Customer=[Customer_Id]) as C_Name ,SUM([deposit_price]) OVER (PARTITION BY [Customer_Id]) as Price FROM [tbl_FACTOR_Main] where Done=1 order by(Price)DESC");
            db.DC();
            for (int i = 0; i < dt.Rows.Count; i++)
            {
                var model = new TableModel()
                {
                    Id = Convert.ToInt32(dt.Rows[i]["Customer_Id"]),
                    Group1 = dt.Rows[i]["C_Name"].ToString(),
                    Group2 = dt.Rows[i]["Price"].ToString()
                };

                res.Add(model);
            }

            return res;
        }
    }
}