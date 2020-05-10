using ShoppingCMS_V002.DBConnect;
using ShoppingCMS_V002.Models;
using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;

namespace ShoppingCMS_V002.OtherClasses
{
    public class ProductGroup_ModelFiller
    {
        public string Add_Update_ProType(string Action, string Name, int id = 0)
        {
            PDBC db = new PDBC("PandaMarketCMS", true);

            List<ExcParameters> paramss = new List<ExcParameters>();
            ExcParameters parameters;

            parameters = new ExcParameters()
            {
                _KEY = "@PTname",
                _VALUE = Name
            };
            paramss.Add(parameters);

            parameters = new ExcParameters()
            {
                _KEY = "@id_P",
                _VALUE = id
            };
            paramss.Add(parameters);

            db.Connect();
            if (Action == "insert")
            {
                db.Script("INSERT INTO [tbl_Product_Type]([PTname],[ISDESABLED],[ISDelete])VALUES(@PTname,0,0)", paramss);
            }
            else if (Action == "Update")
            {
                db.Script("UPDATE [tbl_Product_Type] SET [PTname] = @PTname WHERE id_PT =@id_P", paramss);
            }
            db.DC();
            return "Success";
        }

        public string Add_Update_ProMainCat(string Action, string Name, int TypeId, int id = 0)
        {
            PDBC db = new PDBC("PandaMarketCMS", true);

            List<ExcParameters> paramss = new List<ExcParameters>();
            ExcParameters parameters = new ExcParameters();

            parameters = new ExcParameters()
            {
                _KEY = "@value",
                _VALUE = Name
            };
            paramss.Add(parameters);

            parameters = new ExcParameters()
            {
                _KEY = "@id",
                _VALUE = id
            };
            paramss.Add(parameters);

            parameters = new ExcParameters()
            {
                _KEY = "@data_typa",
                _VALUE = TypeId
            };
            paramss.Add(parameters);
            db.Connect();

            if (Action == "insert")
            {
                db.Script("INSERT INTO [tbl_Product_MainCategory]([id_PT],[MCName],[ISDESABLED],[ISDelete])VALUES (@data_typa, @value,0,0)", paramss);
            }
            else if (Action == "Update")
            {
                db.Script("UPDATE [tbl_Product_MainCategory]SET [MCName] = @value WHERE id_MC = @id", paramss);
            }
            db.DC();
            return "Success";
        }

        public string Add_Update_ProSubCat(string Action, string Name, int MainId, int id = 0)
        {
            PDBC db = new PDBC("PandaMarketCMS", true);

            List<ExcParameters> paramss = new List<ExcParameters>();
            ExcParameters parameters = new ExcParameters();

            parameters = new ExcParameters()
            {
                _KEY = "@value",
                _VALUE = Name
            };
            paramss.Add(parameters);

            parameters = new ExcParameters()
            {
                _KEY = "@id",
                _VALUE = id
            };
            paramss.Add(parameters);

            parameters = new ExcParameters()
            {
                _KEY = "@data_Sub",
                _VALUE = MainId
            };
            paramss.Add(parameters);

            db.Connect();
            if (Action == "insert")
            {
                db.Script("INSERT INTO [tbl_Product_SubCategory]([id_MC],[SCName],[ISDESABLED],[ISDelete])VALUES (@data_Sub,@value,0,0)", paramss);
            }
            else if (Action == "Update")
            {
                db.Script("UPDATE [tbl_Product_SubCategory]SET [SCName] = @value WHERE id_SC = @id ", paramss);
            }
            db.DC();
            return "Success";
        }

        public string Add_Update_ProSubCatKey(string Action, string Name, int SubId, int id = 0)
        {
             PDBC db = new PDBC("PandaMarketCMS", true);


            List<ExcParameters> paramss = new List<ExcParameters>();
            ExcParameters parameters = new ExcParameters();

            parameters = new ExcParameters()
            {
                _KEY = "@value",
                _VALUE = Name
            };
            paramss.Add(parameters);

            parameters = new ExcParameters()
            {
                _KEY = "@id",
                _VALUE = id
            };
            paramss.Add(parameters);

            parameters = new ExcParameters()
            {
                _KEY = "@data_SCK",
                _VALUE = SubId
            };
            paramss.Add(parameters);
            db.Connect();
            if (Action == "insert")
            {
                db.Script("INSERT INTO [tbl_Product_SubCategoryOptionKey]([id_SC],[SCOKName],[ISDESABLED],[ISDelete])VALUES(@data_SCK,@value,0,0)", paramss);
            }
            else if (Action == "Update")
            {
                db.Script("UPDATE [tbl_Product_SubCategoryOptionKey] SET [SCOKName] = @value WHERE id_SCOK =@id", paramss);
            }
            db.DC();
            return "Success";
        }

        public string Add_Update_ProSubCatValue(string Action, string Name, int SCKId, int id = 0)
        {
            PDBC db = new PDBC("PandaMarketCMS", true);
            

            List<ExcParameters> paramss = new List<ExcParameters>();
            ExcParameters parameters = new ExcParameters();

            parameters = new ExcParameters()
            {
                _KEY = "@value",
                _VALUE = Name
            };
            paramss.Add(parameters);

            parameters = new ExcParameters()
            {
                _KEY = "@id",
                _VALUE = id
            };
            paramss.Add(parameters);

            parameters = new ExcParameters()
            {
                _KEY = "@data_SCK",
                _VALUE = SCKId
            };
            paramss.Add(parameters);
db.Connect();
            if (Action == "insert")
            {
                db.Script("INSERT INTO [tbl_Product_SubCategoryOptionValue]VALUES(@data_SCK,@value)", paramss);
            }
            else if (Action == "Update")
            {
                db.Script("UPDATE [tbl_Product_SubCategoryOptionValue]SET [SCOVValueName] =@value WHERE id_SCOV=@id", paramss);
            }
            db.DC();
            return "Success";
        }

        public List<ProGroupModel> TypeTbl()
        {
            var res = new List<ProGroupModel>();

            PDBC db = new PDBC("PandaMarketCMS", true);
            db.Connect();
            DataTable dt = db.Select("SELECT [id_PT],[PTname],[ISDESABLED],[ISDelete]FROM [tbl_Product_Type]");
            db.DC();
            for (int i = 0; i < dt.Rows.Count; i++)
            {
                var model = new ProGroupModel()
                {
                    Num = i + 1,
                    Id = Convert.ToInt32(dt.Rows[i]["id_PT"]),
                    IsDeleted = Convert.ToInt32(dt.Rows[i]["ISDelete"]),
                    IsDisables = Convert.ToInt32(dt.Rows[i]["ISDESABLED"]),
                    Type = dt.Rows[i]["PTname"].ToString()
                };

                res.Add(model);

            }

            return res;
        }

        public List<ProGroupModel> MainCatTbl()
        {
            var res = new List<ProGroupModel>();

            PDBC db = new PDBC("PandaMarketCMS", true);
            db.Connect();
            DataTable dt = db.Select("SELECT A.[id_MC],B.PTname,A.MCName,A.ISDelete,A.ISDESABLED FROM [tbl_Product_MainCategory] as A inner join [tbl_Product_Type] as B on A.id_PT=B.id_PT");
            db.DC();
            for (int i = 0; i < dt.Rows.Count; i++)
            {
                var model = new ProGroupModel()
                {
                    Num = i + 1,
                    Id = Convert.ToInt32(dt.Rows[i]["id_MC"]),
                    IsDeleted = Convert.ToInt32(dt.Rows[i]["ISDelete"]),
                    IsDisables = Convert.ToInt32(dt.Rows[i]["ISDESABLED"]),
                    Type = dt.Rows[i]["PTname"].ToString(),
                    Main = dt.Rows[i]["MCName"].ToString()
                };

                res.Add(model);

            }

            return res;
        }

        public List<ProGroupModel> SubCatTbl()
        {
            var res = new List<ProGroupModel>();

            PDBC db = new PDBC("PandaMarketCMS", true);
            db.Connect();
            DataTable dt = db.Select("SELECT C.id_SC,B.PTname,A.MCName,C.ISDelete,C.ISDESABLED,C.SCName FROM [tbl_Product_MainCategory] as A inner join [tbl_Product_Type] as B on A.id_PT=B.id_PT inner join [tbl_Product_SubCategory] as C on A.id_MC=C.id_MC");
            db.DC();
            for (int i = 0; i < dt.Rows.Count; i++)
            {
                var model = new ProGroupModel()
                {
                    Num = i + 1,
                    Id = Convert.ToInt32(dt.Rows[i]["id_SC"]),
                    IsDeleted = Convert.ToInt32(dt.Rows[i]["ISDelete"]),
                    IsDisables = Convert.ToInt32(dt.Rows[i]["ISDESABLED"]),
                    Type = dt.Rows[i]["PTname"].ToString(),
                    Main = dt.Rows[i]["MCName"].ToString(),
                    Sub = dt.Rows[i]["SCName"].ToString()
                };

                res.Add(model);

            }

            return res;
        }

        public List<ProGroupModel> SubCatKeyTbl()
        {
            var res = new List<ProGroupModel>();

            PDBC db = new PDBC("PandaMarketCMS", true);
            db.Connect();
            DataTable dt = db.Select("SELECT D.id_SCOK,B.PTname,A.MCName,D.ISDelete,D.ISDESABLED,C.SCName,D.SCOKName FROM [tbl_Product_MainCategory] as A inner join [tbl_Product_Type] as B on A.id_PT=B.id_PT inner join [tbl_Product_SubCategory] as C on A.id_MC=C.id_MC inner join [tbl_Product_SubCategoryOptionKey] as D on C.id_SC=D.id_SC");
            db.DC();
            for (int i = 0; i < dt.Rows.Count; i++)
            {
                var model = new ProGroupModel()
                {
                    Num = i + 1,
                    Id = Convert.ToInt32(dt.Rows[i]["id_SCOK"]),
                    IsDeleted = Convert.ToInt32(dt.Rows[i]["ISDelete"]),
                    IsDisables = Convert.ToInt32(dt.Rows[i]["ISDESABLED"]),
                    Type = dt.Rows[i]["PTname"].ToString(),
                    Main = dt.Rows[i]["MCName"].ToString(),
                    Sub = dt.Rows[i]["SCName"].ToString(),
                    SubK = dt.Rows[i]["SCOKName"].ToString()
                };

                res.Add(model);

            }

            return res;
        }

        public List<ProGroupModel> SubCatvValueTbl()
        {
            var res = new List<ProGroupModel>();

            PDBC db = new PDBC("PandaMarketCMS", true);
            db.Connect();
            DataTable dt = db.Select("SELECT E.id_SCOV,B.PTname,A.MCName,C.SCName,D.SCOKName,E.SCOVValueName FROM [tbl_Product_MainCategory] as A inner join [tbl_Product_Type] as B on A.id_PT=B.id_PT inner join [tbl_Product_SubCategory] as C on A.id_MC=C.id_MC inner join [tbl_Product_SubCategoryOptionKey] as D on C.id_SC=D.id_SC inner join [tbl_Product_SubCategoryOptionValue] as E on D.id_SCOK=E.id_SCOK");
            db.DC();
            for (int i = 0; i < dt.Rows.Count; i++)
            {
                var model = new ProGroupModel()
                {
                    Num = i + 1,
                    Id = Convert.ToInt32(dt.Rows[i]["id_SCOV"]),
                    Type = dt.Rows[i]["PTname"].ToString(),
                    Main = dt.Rows[i]["MCName"].ToString(),
                    Sub = dt.Rows[i]["SCName"].ToString(),
                    SubK = dt.Rows[i]["SCOKName"].ToString(),
                    SubVal = dt.Rows[i]["SCOVValueName"].ToString()
                };

                res.Add(model);

            }

            return res;
        }

        public string Add_Update_ProTags(string Action, string Name, int SCKId, int id = 0)
        {
            PDBC db = new PDBC("PandaMarketCMS", true);

            List<ExcParameters> paramss = new List<ExcParameters>();
            ExcParameters parameters = new ExcParameters();

            parameters = new ExcParameters()
            {
                _KEY = "@value",
                _VALUE = Name
            };
            paramss.Add(parameters);

            parameters = new ExcParameters()
            {
                _KEY = "@id",
                _VALUE = id
            };
            paramss.Add(parameters);

            parameters = new ExcParameters()
            {
                _KEY = "@data_SCK",
                _VALUE = SCKId
            };
            paramss.Add(parameters);

            db.Connect();
            if (Action == "insert")
            {
                db.Script("INSERT INTO [tbl_Product_TagEnums]VALUES (@Value , @data_SCK)", paramss);
            }
            else if (Action == "Update")
            {
                db.Script("UPDATE [tbl_Product_TagEnums] SET [TE_name] = @value  WHERE id_TE=@id", paramss);
            }
            db.DC();
            return "Success";
        }

        public List<ProGroupModel> TagsTbl()
        {
            var res = new List<ProGroupModel>();

            PDBC db = new PDBC("PandaMarketCMS", true);
            db.Connect();
            DataTable dt = db.Select("SELECT D.id_TE,B.PTname,A.MCName,C.SCName,D.TE_name FROM [tbl_Product_MainCategory] as A inner join [tbl_Product_Type] as B on A.id_PT=B.id_PT inner join [tbl_Product_SubCategory] as C on A.id_MC=C.id_MC inner join [tbl_Product_TagEnums] as D on C.id_SC=D.SubCatId");
            db.DC();
            for (int i = 0; i < dt.Rows.Count; i++)
            {
                var model = new ProGroupModel()
                {
                    Num = i + 1,
                    Id = Convert.ToInt32(dt.Rows[i]["id_TE"]),
                    Type = dt.Rows[i]["PTname"].ToString(),
                    Main = dt.Rows[i]["MCName"].ToString(),
                    Sub = dt.Rows[i]["SCName"].ToString(),
                    SubK = dt.Rows[i]["TE_name"].ToString(),
                };

                res.Add(model);

            }

            return res;
        }

        public string Add_Update_MainTags(string Action, string Name, string discription, int id = 0)
        {
            PDBC db = new PDBC("PandaMarketCMS", true);

            List<ExcParameters> paramss = new List<ExcParameters>();
            ExcParameters parameters = new ExcParameters();

            parameters = new ExcParameters()
            {
                _KEY = "@value",
                _VALUE = Name
            };
            paramss.Add(parameters);

            parameters = new ExcParameters()
            {
                _KEY = "@id",
                _VALUE = id
            };
            paramss.Add(parameters);

            parameters = new ExcParameters()
            {
                _KEY = "@discription",
                _VALUE = discription
            };
            paramss.Add(parameters);
            db.Connect();

            if (Action == "insert")
            {
                db.Script("INSERT INTO [tbl_Product_MainStarTags]VALUES( @discription , @value )", paramss);
            }
            else if (Action == "Update")
            {
                db.Script("UPDATE [tbl_Product_MainStarTags] SET [MST_Description] = @discription ,[MST_Name] =@value WHERE id_MainStarTag= @id", paramss);
            }
            db.DC();
            return "Success";
        }

        public List<TableModel> MainTagsTbl()
        {
            var res = new List<TableModel>();

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

                res.Add(model);

            }

            return res;
        }

    }
}


//string SSSession = ""; if (HttpContext.Request.Cookies["TSHPANDAControll" + StaticLicense.LicName] != null) { HttpCookie cookie = HttpContext.Request.Cookies.Get("TSHPANDAControll" + StaticLicense.LicName); if (cookie != null) { SSSession = cookie.Value; } else { SSSession = "N.A"; } } else { SSSession = "N.A"; }
//CheckAccess check = new CheckAccess(SSSession);
//if (check.HasAccess)
//{
//}
//else
//    return RedirectToAction("NotAccess", "MS");




//string SSSession = ""; if (HttpContext.Request.Cookies["TSHPANDAControll" + StaticLicense.LicName] != null) { HttpCookie cookie = HttpContext.Request.Cookies.Get("TSHPANDAControll" + StaticLicense.LicName); if (cookie != null) { SSSession = cookie.Value; } else { SSSession = "N.A"; } } else { SSSession = "N.A"; }
//CheckAccess check = new CheckAccess(SSSession);
//if (check.HasAccess)
//{
//}
//else
//    return Content("NotAccess");

