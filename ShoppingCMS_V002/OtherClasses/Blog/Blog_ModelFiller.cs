using MD.PersianDateTime;
using ShoppingCMS_V002.DBConnect;
using ShoppingCMS_V002.Models;
using ShoppingCMS_V002.Models.Blog;
using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Text;
using System.Web;

namespace ShoppingCMS_V002.OtherClasses.Blog
{
    public class Blog_ModelFiller
    {
        private int TopSelector = 0;
        public Blog_ModelFiller()
        {
            TopSelector = 0;
        }

        public Blog_ModelFiller(int top)
        {
            TopSelector = top;
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
        public static string AppendServername(string url)
        {
            return "https://" + HttpContext.Current.Request.Url.Authority + "/" + url;
        }
        public List<Id_ValueModel> Groups_Filler()
        {
            PDBC db = new PDBC("PandaMarketCMS", true);
            db.Connect();
            var res = new List<Id_ValueModel>();

            DataTable dt = db.Select("SELECT [G_Id],[name] FROM [tbl_BLOG_Groups] WHERE Is_Disabled=0 AND Is_Deleted=0");
            for (int i = 0; i < dt.Rows.Count; i++)
            {
                var model = new Id_ValueModel()
                {
                    Id = Convert.ToInt32(dt.Rows[i]["G_Id"]),
                    Value = dt.Rows[i]["name"].ToString()
                };
                res.Add(model);
            }

            return res;
        }

        public List<Id_ValueModel> B_Types_Filler()
        {
            PDBC db = new PDBC("PandaMarketCMS", true);
            db.Connect();
            var res = new List<Id_ValueModel>();

            DataTable dt = db.Select("SELECT [B_TypeId],[B_TypeToken] FROM [tbl_BLOG_PostType]");
            for (int i = 0; i < dt.Rows.Count; i++)
            {
                var model = new Id_ValueModel()
                {
                    Id = Convert.ToInt32(dt.Rows[i]["B_TypeId"]),
                    Value = dt.Rows[i]["B_TypeToken"].ToString()
                };
                res.Add(model);
            }

            return res;
        }

        public List<Id_ValueModel> BCategory_Filler()
        {
            PDBC db = new PDBC("PandaMarketCMS", true);
            db.Connect();
            var res = new List<Id_ValueModel>();

            DataTable dt = db.Select("SELECT [Id],[name] FROM [tbl_BLOG_Categories] WHERE [Is_Disabled]=0 AND [Is_Deleted]=0");
            for (int i = 0; i < dt.Rows.Count; i++)
            {
                var model = new Id_ValueModel()
                {
                    Id = Convert.ToInt32(dt.Rows[i]["Id"]),
                    Value = dt.Rows[i]["name"].ToString()
                };
                res.Add(model);
            }

            return res;
        }

        public List<Id_ValueModel> B_Tags_Filler(int CatId)
        {
            PDBC db = new PDBC("PandaMarketCMS", true);
            db.Connect();
            var res = new List<Id_ValueModel>();

            DataTable dt = db.Select("SELECT [Id],[name] FROM [tbl_BLOG_Tags] WHERE [Is_Disabled]=0 AND [Is_Deleted]=0 AND [CtegoryId]=" + CatId);
            for (int i = 0; i < dt.Rows.Count; i++)
            {
                var model = new Id_ValueModel()
                {
                    Id = Convert.ToInt32(dt.Rows[i]["Id"]),
                    Value = dt.Rows[i]["name"].ToString()
                };
                res.Add(model);
            }

            return res;
        }
        public List<Id_ValueModel> Post_Tags(int PostId)
        {
            PDBC db = new PDBC("PandaMarketCMS", true);
            db.Connect();
            var res = new List<Id_ValueModel>();

            DataTable dt = db.Select("SELECT [Id],[Name] FROM [tbl_BLOG_Tags] as A inner join [tbl_BLOG_TagConnector] as B on A.Id=B.Tag_Id Where [Is_Disabled]=0 AND [Is_Deleted]=0 AND B.Post_Id=" + PostId);
            for (int i = 0; i < dt.Rows.Count; i++)
            {
                var model = new Id_ValueModel()
                {
                    Id = Convert.ToInt32(dt.Rows[i]["Id"]),
                    Value = dt.Rows[i]["Name"].ToString()
                };
                res.Add(model);
            }

            return res;
        }

        public string Post_Action(string Action, int WrittenBy_AdminId, string Title, string Text_min, string Text, int weight, int Cat_Id, int IsImportant, int GroupId, string Pictures, string Blog_Tags, int TypeId, int id_pr = 0)
        {
            List<ExcParameters> paramss = new List<ExcParameters>();
            PDBC db = new PDBC("PandaMarketCMS", true);
            db.Connect();
            var parameters = new ExcParameters()
            {
                _KEY = "@Title",
                _VALUE = Title
            };
            paramss.Add(parameters);

            parameters = new ExcParameters()
            {
                _KEY = "@Text_min",
                _VALUE = Text_min
            };
            paramss.Add(parameters);

            parameters = new ExcParameters()
            {
                _KEY = "@Text",
                _VALUE = Text
            };
            paramss.Add(parameters);

            parameters = new ExcParameters()
            {
                _KEY = "@WrittenBy_AdminId",
                _VALUE = WrittenBy_AdminId
            };
            paramss.Add(parameters);

            parameters = new ExcParameters()
            {
                _KEY = "@weight",
                _VALUE = weight
            };
            paramss.Add(parameters);

            parameters = new ExcParameters()
            {
                _KEY = "@IsImportant",
                _VALUE = IsImportant
            };
            paramss.Add(parameters);

            parameters = new ExcParameters()
            {
                _KEY = "@Cat_Id",
                _VALUE = Cat_Id
            };
            paramss.Add(parameters);

            parameters = new ExcParameters()
            {
                _KEY = "@GroupId",
                _VALUE = GroupId
            };
            paramss.Add(parameters);

            parameters = new ExcParameters()
            {
                _KEY = "@TypeId",
                _VALUE = TypeId
            };
            paramss.Add(parameters);
            string query = "";

            if (Action.Equals("insert"))
            {
                query = "INSERT INTO [tbl_BLOG_Post] output inserted.Id VALUES(@Title, @Text_min ,@Text, @WrittenBy_AdminId, GETDATE(), @weight, @IsImportant, 0, 1, @Cat_Id, @GroupId,@TypeId)";
            }
            else if (Action == "update")
            {
                query = "UPDATE [tbl_BLOG_Post] SET [Title] = @Title ,[Text_min] = @Text_min ,[Text] = @Text ,[weight] = @weight ,[IsImportant] = @IsImportant ,[Cat_Id] = @Cat_Id ,[GroupId] = @GroupId , [TypeId]=@TypeId WHERE Id=" + id_pr;
            }

            string id = "0";

            if (query != "")
            {
                id = db.Script(query, paramss);
            }

            if (id != "0" && Action.Equals("insert"))
            {
                var Post_picturse = Pictures.Split(',');
                for (int i = 0; i < Post_picturse.Length; i++)
                {
                    db.Script("INSERT INTO [tbl_BLOG_Pic_Connector]VALUES(" + id + "," + Post_picturse[i] + ")");
                }

                var Tags = Blog_Tags.Split(',');
                for (int j = 0; j < Tags.Length; j++)
                {
                    db.Script("INSERT INTO [tbl_BLOG_TagConnector] VALUES(" + id + "," + Tags[j] + ")");
                }
            }
            else if (Action == "update")
            {
                db.Script("DELETE FROM [tbl_BLOG_Pic_Connector] WHERE PostId=" + id_pr);
                var Post_picturse = Pictures.Split(',');
                for (int i = 0; i < Post_picturse.Length; i++)
                {
                    db.Script("INSERT INTO [tbl_BLOG_Pic_Connector]VALUES(" + id_pr + "," + Post_picturse[i] + ")");
                }

                db.Script("DELETE FROM [tbl_BLOG_TagConnector] WHERE Post_Id=" + id_pr);//delete 
                var Tags = Blog_Tags.Split(',');
                for (int j = 0; j < Tags.Length; j++)
                {
                    db.Script("INSERT INTO [tbl_BLOG_TagConnector] VALUES(" + id_pr + "," + Tags[j] + ")");
                }
            }


            return "Success";
        }

        public PostModel EditModelFiller(int id)
        {
            var res = new PostModel();
            PDBC db = new PDBC("PandaMarketCMS", true);
            db.Connect();

            DataTable dt = db.Select("SELECT [Id],[Title],[Text_min],[Text],[weight],[IsImportant],[Cat_Id],[GroupId] FROM [tbl_BLOG_Post] where Id=" + id);
            if (dt.Rows.Count != 0)
            {
                res.Id = Convert.ToInt32(dt.Rows[0]["Id"]);
                res.title = dt.Rows[0]["Title"].ToString();
                res.text_min = dt.Rows[0]["Text_min"].ToString();
                res.text = dt.Rows[0]["Text"].ToString();
                res.IsImportant = Convert.ToInt32(dt.Rows[0]["IsImportant"]);
                res.SearchGravity = Convert.ToInt32(dt.Rows[0]["weight"]);
                res.Category = dt.Rows[0]["Cat_Id"].ToString();
                res.InGroup = dt.Rows[0]["GroupId"].ToString();


                DataTable dt2 = db.Select("SELECT[PicId]FROM [tbl_BLOG_Pic_Connector] where [PostId]=" + res.Id);
                StringBuilder s = new StringBuilder();
                for (int i = 0; i < dt2.Rows.Count; i++)
                {
                    s.Append(dt2.Rows[i]["PicId"]);
                    s.Append(",");
                }
                res.ImagePath = s.ToString();

                DataTable dt3 = db.Select("SELECT [Tag_Id] FROM [tbl_BLOG_TagConnector]where[Post_Id]=" + res.Id);
                StringBuilder Tag = new StringBuilder();
                for (int i = 0; i < dt3.Rows.Count; i++)
                {
                    Tag.Append(dt3.Rows[i]["Tag_Id"]);
                    Tag.Append(",");
                }
                res.tags = Tag.ToString();
            }

            return res;
        }

        public string Add_Update_Category(string Action, string Name, int id = 0)
        {
            PDBC db = new PDBC("PandaMarketCMS", true);
            db.Connect();

            if (Action == "insert")
            {
                db.Script("INSERT INTO [tbl_BLOG_Categories] VALUES (N'" + Name + "',0,0)");
            }
            else if (Action == "Update")
            {
                db.Script("UPDATE [tbl_BLOG_Categories] SET [name] =N'" + Name + "' WHERE Id=" + id);
            }

            return "Success";
        }

        public string Add_Update_Group(string Action, string Name, string Token, int id = 0)
        {
            PDBC db = new PDBC("PandaMarketCMS", true);
            db.Connect();
            string resultPost = "";
            if (string.IsNullOrEmpty(Token))
            {
                return "پرکردن فیلد توکن اجباری میباشد";
            }
            if (string.IsNullOrEmpty(Name))
            {
                return "پرکردن فیلد نام گروه اجباری میباشد";
            }
            List<ExcParameters> paramss = new List<ExcParameters>();
            if (Action == "insert")
            {
                ExcParameters par = new ExcParameters()
                {
                    _KEY = "@Tok",
                    _VALUE = Token
                };
                paramss.Add(par);
                using (DataTable dt = db.Select("SELECT COUNT(*) FROM [tbl_BLOG_Groups] WHERE GpToken LIKE @Tok", paramss))
                {
                    paramss = new List<ExcParameters>();
                    if (dt.Rows[0][0].ToString() == "0")
                    {
                        par = new ExcParameters()
                        {
                            _KEY = "@Name",
                            _VALUE = Name
                        };
                        paramss.Add(par);
                        par = new ExcParameters()
                        {
                            _KEY = "@Token",
                            _VALUE = Token
                        };
                        paramss.Add(par);
                        resultPost = db.Script("INSERT INTO [tbl_BLOG_Groups] VALUES (@Name,0,0,@Token)", paramss);
                        if (resultPost != "1")
                        {
                            resultPost = "عدم توانایی در ایجاد گروه";
                        }
                    }
                    else
                    {
                        resultPost = "این توکن در پایگاه داده موجود میباشد!";
                    }

                }
            }
            else if (Action == "Update")
            {
                paramss=new List<ExcParameters>();
                ExcParameters par = new ExcParameters()
                {
                    _KEY = "@Name",
                    _VALUE = Name
                };
                paramss.Add(par);
                par = new ExcParameters()
                {
                    _KEY = "@Token",
                    _VALUE = Token
                };
                paramss.Add(par);
                par = new ExcParameters()
                {
                    _KEY = "@G_Id",
                    _VALUE = id
                };
                paramss.Add(par);
                resultPost = db.Script("UPDATE [tbl_BLOG_Groups] SET [name] = @Name , [GpToken] = @Token WHERE G_Id= @G_Id" , paramss);
                if (resultPost != "1")
                {
                    resultPost = "عدم توانایی در بروز رسانی";
                }
            }
            if (resultPost == "1")
            {
                return "Success";
            }
            else
            {
                return resultPost;
            }
        }

        public string Add_Update_Tag(string Action, string Name, int CatId, int id = 0)
        {
            PDBC db = new PDBC("PandaMarketCMS", true);
            db.Connect();

            if (Action == "insert")
            {
                db.Script("INSERT INTO [tbl_BLOG_Tags] VALUES (N'" + Name + "'," + CatId + ",0,0)");
            }
            else if (Action == "Update")
            {
                db.Script("UPDATE [tbl_BLOG_Tags] SET [Name] = N'" + Name + "',[CtegoryId] = " + CatId + " WHERE Id=" + id);
            }

            return "Success";
        }

        public List<CategoryModel> Blog_CategoryTable()
        {
            var res = new List<CategoryModel>();
            PDBC db = new PDBC("PandaMarketCMS", true);
            db.Connect();

            DataTable dt = db.Select("SELECT [Id],[name],[Is_Disabled],[Is_Deleted]FROM [tbl_BLOG_Categories]");

            for (int i = 0; i < dt.Rows.Count; i++)
            {
                var model = new CategoryModel()
                {
                    Num = i + 1,
                    Id = Convert.ToInt32(dt.Rows[i]["Id"]),
                    Name = dt.Rows[i]["name"].ToString(),
                    Deleted = Convert.ToInt32(dt.Rows[i]["Is_Deleted"]),
                    Disabled = Convert.ToInt32(dt.Rows[i]["Is_Disabled"])
                };
                res.Add(model);
            }


            return res;
        }

        public List<CategoryModel> Blog_GroupTable()
        {
            var res = new List<CategoryModel>();
            PDBC db = new PDBC("PandaMarketCMS", true);
            db.Connect();

            DataTable dt = db.Select("SELECT [G_Id],[name],[Is_Disabled],[Is_Deleted],[GpToken] FROM [tbl_BLOG_Groups]");

            for (int i = 0; i < dt.Rows.Count; i++)
            {
                var model = new CategoryModel()
                {
                    Num = i + 1,
                    Id = Convert.ToInt32(dt.Rows[i]["G_Id"]),
                    Name = dt.Rows[i]["name"].ToString(),
                    Deleted = Convert.ToInt32(dt.Rows[i]["Is_Deleted"]),
                    Disabled = Convert.ToInt32(dt.Rows[i]["Is_Disabled"]),
                    Category = dt.Rows[i]["GpToken"].ToString()
                };
                res.Add(model);
            }


            return res;
        }

        public List<CategoryModel> Blog_TagTable()
        {
            var res = new List<CategoryModel>();
            PDBC db = new PDBC("PandaMarketCMS", true);
            db.Connect();

            DataTable dt = db.Select("SELECT A.[Id],A.[Name],A.[CtegoryId],A.[Is_Disabled],A.[Is_Deleted],B.[Name] as CatName FROM [tbl_BLOG_Tags] as A inner join [tbl_BLOG_Categories] as B on A.CtegoryId=B.Id");

            for (int i = 0; i < dt.Rows.Count; i++)
            {
                var model = new CategoryModel()
                {
                    Num = i + 1,
                    Id = Convert.ToInt32(dt.Rows[i]["Id"]),
                    Name = dt.Rows[i]["Name"].ToString(),
                    Deleted = Convert.ToInt32(dt.Rows[i]["Is_Deleted"]),
                    Disabled = Convert.ToInt32(dt.Rows[i]["Is_Disabled"]),
                    CatId = Convert.ToInt32(dt.Rows[i]["CtegoryId"]),
                    Category = dt.Rows[i]["CatName"].ToString()
                };
                res.Add(model);
            }


            return res;
        }

        public List<PostModel> Posttable()
        {
            var res = new List<PostModel>();
            PDBC db = new PDBC("PandaMarketCMS", true);
            db.Connect();

            DataTable dt = db.Select("SELECT [Id],[Title],[GroupId],[Text_min],[Text],(SELECT [ad_firstname]+ ' '+ [ad_lastname] as name FROM [tbl_ADMIN_main]where id_Admin=[WrittenBy_AdminId])as adminName ,[Date],[IsImportant],[Is_Deleted],[Is_Disabled],(SELECT [name]FROM [tbl_BLOG_Categories] where Id=[Cat_Id]) as Category,(SELECT [name]FROM [tbl_BLOG_Groups] where G_Id=[GroupId]) as GroupName,(SELECT top 1 B.PicAddress FROM [tbl_BLOG_Pic_Connector] as A inner join [tbl_ADMIN_UploadStructure_ImageAddress] as B on A.[PicId]=B.PicID where A.PostId=Id)as Pic FROM [tbl_BLOG_Post] order by(date)desc");

            for (int i = 0; i < dt.Rows.Count; i++)
            {
                DateTime date = Convert.ToDateTime(dt.Rows[i]["Date"]);
                PersianDateTime persianDateTime = new PersianDateTime(date);
                var model = new PostModel()
                {
                    Id = Convert.ToInt32(dt.Rows[i]["Id"]),
                    by = dt.Rows[i]["adminName"].ToString(),
                    Category = dt.Rows[i]["Category"].ToString(),
                    InGroup = dt.Rows[i]["GroupName"].ToString(),
                    ImagePath = AppendServername(dt.Rows[i]["Pic"].ToString()),
                    IsDeleted = Convert.ToInt32(dt.Rows[i]["Is_Deleted"]),
                    IsDisabled = Convert.ToInt32(dt.Rows[i]["Is_Disabled"]),
                    text = dt.Rows[i]["Text"].ToString(),
                    title = dt.Rows[i]["Title"].ToString(),
                    text_min = dt.Rows[i]["Text_min"].ToString(),
                    date = persianDateTime.ToLongDateString(),
                    GPIDforPostPAge = dt.Rows[i]["GroupId"].ToString()
                };
                res.Add(model);
            }
            return res;
        }

        public List<Id_ValueModel> B_AllTags_Filler()
        {
            PDBC db = new PDBC("PandaMarketCMS", true);
            db.Connect();
            var res = new List<Id_ValueModel>();

            DataTable dt = db.Select("SELECT [Id],[name] FROM [tbl_BLOG_Tags] WHERE [Is_Disabled]=0 AND [Is_Deleted]=0 ");
            for (int i = 0; i < dt.Rows.Count; i++)
            {
                var model = new Id_ValueModel()
                {
                    Id = Convert.ToInt32(dt.Rows[i]["Id"]),
                    Value = dt.Rows[i]["name"].ToString()
                };
                res.Add(model);
            }

            return res;
        }
        public List<Id_ValueModel> C_AllTags_Filler()
        {
            PDBC db = new PDBC("PandaMarketCMS", true);
            db.Connect();
            var res = new List<Id_ValueModel>();

            DataTable dt = db.Select("SELECT [G_Id],[name] FROM [tbl_BLOG_Groups] WHERE [Is_Deleted]=0 AND [Is_Disabled]=0 ");
            for (int i = 0; i < dt.Rows.Count; i++)
            {
                var model = new Id_ValueModel()
                {
                    Id = Convert.ToInt32(dt.Rows[i]["G_Id"]),
                    Value = dt.Rows[i]["name"].ToString()
                };
                res.Add(model);
            }

            return res;
        }

        public List<PostModel> UserPostModels(string Cat, int Page, int Id, string search,string DateType= "Date")
        {
            var res = new List<PostModel>();
            PDBC db = new PDBC("PandaMarketCMS", true);
            db.Connect();
            DataTable dt = db.Select(QueryMaker_BlogPost(Cat, Page, Id, search));

            for (int i = 0; i < dt.Rows.Count; i++)
            {
                var model = new PostModel()
                {
                    Id = Convert.ToInt32(dt.Rows[i]["Id"]),
                    by = dt.Rows[i]["adminName"].ToString(),
                    Category = dt.Rows[i]["Category"].ToString(),
                    InGroup = dt.Rows[i]["GroupName"].ToString(),
                    GPIDforPostPAge = dt.Rows[i]["GroupId"].ToString(),
                    ImagePath = AppendServername(dt.Rows[i]["Pic"].ToString()),
                    IsDeleted = Convert.ToInt32(dt.Rows[i]["Is_Deleted"]),
                    IsDisabled = Convert.ToInt32(dt.Rows[i]["Is_Disabled"]),
                    text = dt.Rows[i]["Text"].ToString(),
                    title = dt.Rows[i]["Title"].ToString(),
                    text_min = dt.Rows[i]["Text_min"].ToString(),
                    date = DateReturner(dt.Rows[i]["Date"].ToString(),DateType),
                    AdminPic = AppendServername(dt.Rows[i]["AdminPic"].ToString()),
                    PostType = dt.Rows[i]["TypeId"].ToString()
                };
                res.Add(model);
            }
            return res;
        }

        public string QueryMaker_BlogPost(string Cat, int Page, int Id, string search,int PostsInPage= 15)
        {
            PDBC db = new PDBC("PandaMarketCMS", true);
            db.Connect();

            int num = 1;
            if (Cat == "همه")
            {
                num = Convert.ToInt32(db.Select("SELECT Count(*) FROM [tbl_BLOG_Post]  where Is_Deleted=0 AND Is_Disabled=0").Rows[0][0]);
            }
            else if (Cat == "دسته بندی")
            {
                num = Convert.ToInt32(db.Select("SELECT Count(*) FROM [tbl_BLOG_Post] where Is_Deleted=0 AND Is_Disabled=0 AND Cat_Id=" + Id).Rows[0][0]);
            }
            else if (Cat == "برچسب")
            {
                num = Convert.ToInt32(db.Select("SELECT COUNT(*) FROM [tbl_BLOG_TagConnector] as A inner join [tbl_BLOG_Post] as B on A.Post_Id=B.Id where Is_Deleted=0 AND Is_Disabled=0 AND Tag_Id=" + Id).Rows[0][0]);
            }
            else if (Cat == "جست و جو")
            {
                num = Convert.ToInt32(db.Select("SELECT Count(*) FROM [tbl_BLOG_Post] where Is_Deleted=0 AND Is_Disabled=0 AND Title Like N'%" + search + "%' OR Text_min Like N'%" + search + "%' OR [Text] Like N'%" + search + "%' ").Rows[0][0]);
            }
            else if (Cat == "گروه بندی")
            {
                num = Convert.ToInt32(db.Select("SELECT Count(*) FROM [tbl_BLOG_Post] where Is_Deleted=0 AND Is_Disabled=0 AND GroupId=" + Id).Rows[0][0]);
            }

            if (num % PostsInPage == 0)
            {
                num = (num / PostsInPage);
            }
            else
            {
                num = (num / PostsInPage) + 1;
            }


            StringBuilder Query = new StringBuilder();
            if (TopSelector == 0)
            {
                Query.Append("select * from(SELECT NTILE(");
            }
            else
            {
                Query.Append("select TOP(");
                Query.Append(TopSelector);
                Query.Append(") * from(SELECT NTILE(");
            }
            Query.Append(num);
            Query.Append(")over(order by(Date)DESC)as tile,[weight], [Id],[Title],[Text_min],[GroupId],[Text],(SELECT [ad_firstname]+ ' '+ [ad_lastname] as name FROM [tbl_ADMIN_main]where id_Admin=[WrittenBy_AdminId])as adminName ,[Date],[IsImportant],[Is_Deleted],[Is_Disabled],(SELECT [name]FROM [tbl_BLOG_Categories] where Id=[Cat_Id]) as Category,(SELECT [name]FROM [tbl_BLOG_Groups] where G_Id=[GroupId]) as GroupName,(SELECT top 1 B.PicAddress FROM [tbl_BLOG_Pic_Connector] as A inner join [tbl_ADMIN_UploadStructure_ImageAddress] as B on A.[PicId]=B.PicID where A.PostId=Id)as Pic,(SELECT [ad_avatarprofile] FROM[tbl_ADMIN_main] where id_Admin=WrittenBy_AdminId) as AdminPic ,(SELECT[B_TypeToken] FROM [tbl_BLOG_PostType] WHERE B_TypeId=[TypeId]) as TypeId FROM [tbl_BLOG_Post]");

            if (Cat == "همه")
            {
                Query.Append(" where Is_Deleted=0 AND Is_Disabled=0");
                Query.Append(")b where b.tile=");
                Query.Append(Page);
            }
            else if (Cat == "دسته بندی")
            {
                Query.Append(" where Is_Deleted=0 AND Is_Disabled=0 AND Cat_Id=");
                Query.Append(Id);
                Query.Append(")b where b.tile=");
                Query.Append(Page);

            }
            else if (Cat == "گروه بندی")
            {
                Query.Append(" where Is_Deleted=0 AND Is_Disabled=0 AND GroupId=");
                Query.Append(Id);
                Query.Append(")b where b.tile=");
                Query.Append(Page);

            }
            else if (Cat == "برچسب")
            {
                Query.Append(" as B1 inner join [tbl_BLOG_TagConnector] as B2 on B1.Id=B2.Post_Id where Is_Deleted=0 AND Is_Disabled=0 AND B2.Tag_Id=");
                Query.Append(Id);
                Query.Append(")b where b.tile=");
                Query.Append(Page);
            }
            else if (Cat == "جست و جو")
            {
                Query.Append(" where Is_Deleted=0 AND Is_Disabled=0 AND Title Like N'%");
                Query.Append(search);
                Query.Append("%' OR Text_min Like N'%");
                Query.Append(search);
                Query.Append("%' OR [Text] Like N'%");
                Query.Append(search);
                Query.Append("%')b where b.tile=");
                Query.Append(Page);
                Query.Append("order by([weight])DESC");
            }

            return Query.ToString();
        }

        public List<TableModel> SearchResult(string search)
        {
            PDBC db = new PDBC("PandaMarketCMS", true);
            db.Connect();

            DataTable dt = db.Select("SELECT top 100 [Id],[Title],(SELECT top 1 B.PicAddress FROM [tbl_BLOG_Pic_Connector] as A inner join [tbl_ADMIN_UploadStructure_ImageAddress] as B on A.[PicId]=B.PicID where A.PostId=Id)as Pic FROM [tbl_BLOG_Post] where Is_Deleted=0 AND Is_Disabled=0 AND Title Like N'%" + search + "%' OR Text_min Like N'%" + search + "%' OR [Text] Like N'%" + search + "%' order by([weight])DESC,[date] DESC");

            var res = new List<TableModel>();

            for (int i = 0; i < dt.Rows.Count; i++)
            {
                var model = new TableModel()
                {
                    Group1 = AppendServername(dt.Rows[i]["Pic"].ToString()),
                    Group2 = dt.Rows[i]["Title"].ToString(),
                    Id = Convert.ToInt32(dt.Rows[i]["Id"])
                };
                res.Add(model);
            }
            return res;
        }

        public List<BlogPics> GetAllBlogPostPics(int postid)
        {
            List<BlogPics> result = new List<BlogPics>();
            PDBC db = new PDBC("PandaMarketCMS", true);
            db.Connect();
            using (DataTable dt = db.Select("SELECT * FROM [v_Blog_AllImages] WHERE ISDELETE<>1 AND PostID = " + postid))
            {

                for (int i = 0; i < dt.Rows.Count; i++)
                {
                    BlogPics BP = new BlogPics();
                    BP.PicAddress = AppendServername(dt.Rows[i]["PicAddress"].ToString());
                    BP.alt = dt.Rows[i]["alt"].ToString();
                    BP.uploadPicName = dt.Rows[i]["uploadPicName"].ToString();
                    BP.Descriptions = dt.Rows[i]["Descriptions"].ToString();
                    result.Add(BP);
                }
            }
            return result;
        }

        public SinglePostPostDetail SinglePostFiller(int idPost,string DateType="Date")
        {
            SinglePostPostDetail result = new SinglePostPostDetail();
            PDBC db = new PDBC("PandaMarketCMS", true);
            db.Connect();
            using (DataTable dt = db.Select("SELECT * FROM [v_Blog_SinglePost] WHERE PostID = " + idPost))
            {      
                if (dt.Rows.Count > 0)
                {
                    result.Cat_Id = dt.Rows[0]["Cat_Id"].ToString();
                    result.GroupId = dt.Rows[0]["GroupId"].ToString();
                    result.Gpname = dt.Rows[0]["Gpname"].ToString();
                    result.CatName = dt.Rows[0]["CatName"].ToString();
                    result.Title = dt.Rows[0]["Title"].ToString();
                    result.Text_min = dt.Rows[0]["Text_min"].ToString();
                    result.Text = dt.Rows[0]["Text"].ToString();
                    result.Date = DateReturner(dt.Rows[0]["Date"].ToString(),DateType);
                    result.weight = dt.Rows[0]["weight"].ToString();
                    result.IsImportant = dt.Rows[0]["IsImportant"].ToString();
                    result.PostID = dt.Rows[0]["PostID"].ToString();
                    result.WrittenBy_AdminId = dt.Rows[0]["WrittenBy_AdminId"].ToString();
                    result.ad_firstname = dt.Rows[0]["ad_firstname"].ToString();
                    result.ad_lastname = dt.Rows[0]["ad_lastname"].ToString();
                    result.ad_avatarprofile = AppendServername(dt.Rows[0]["ad_avatarprofile"].ToString());
                    DataTable Comments = db.Select("SELECT [Id],[Email],[message],[Name],[ImagePath],[Date] FROM [tbl_BLOG_Comment] where PostId="+idPost);
                    var Com = new List<CommentsModel>();
                    for (int i = 0; i < Comments.Rows.Count; i++)
                    {
                        var Rep = new List<CommentsModel>();
                        DataTable rep = db.Select("SELECT [Id],[Email],[Name],[Message],[ImagePath],[Date]FROM [tbl_BLOG_Reply] where commentId="+ Comments.Rows[i]["Id"]);
                        for (int j = 0; j < rep.Rows.Count; j++)
                        {
                            var Rmodel = new CommentsModel()
                            {
                                Id=Convert.ToInt32(rep.Rows[j]["Id"]),
                                Email= rep.Rows[j]["Email"].ToString(),
                                ImagePath=AppendServername(rep.Rows[j]["ImagePath"].ToString()),
                                Message= rep.Rows[j]["Message"].ToString(),
                                Name = rep.Rows[j]["Name"].ToString(),
                                Date=DateReturner(rep.Rows[j]["Date"].ToString(),DateType)
                            };
                            Rep.Add(Rmodel);
                        }

                        var model = new CommentsModel()
                        {
                            Id = Convert.ToInt32(Comments.Rows[i]["Id"]),
                            Email = Comments.Rows[i]["Email"].ToString(),
                            ImagePath = AppendServername(Comments.Rows[i]["ImagePath"].ToString()),
                            Message = Comments.Rows[i]["Message"].ToString(),
                            Name = Comments.Rows[i]["Name"].ToString(),
                            Date = DateReturner(Comments.Rows[i]["Date"].ToString(), DateType),
                            Reply=Rep
                        };
                        Com.Add(model);
                    }

                    result.Comments = Com;
                }
                else
                {
                    result.PostID = "0";
                }
            }
            return result;
        }

        public List<PostModel> PostModels_ByType(string Type_token,string DateType = "Date")
        {
            var res = new List<PostModel>();
            PDBC db = new PDBC("PandaMarketCMS", true);
            db.Connect();
            DataTable dt1 = db.Select("SELECT [G_Id] FROM [tbl_BLOG_Groups] where [GpToken] LIKE N'" + Type_token + "'");
            if (dt1.Rows.Count != 0)
            {
                DataTable dt = db.Select("SELECT [Id],[Title],[Text_min],[Text],(SELECT [ad_firstname]+ ' '+ [ad_lastname] as name FROM [tbl_ADMIN_main]where id_Admin=[WrittenBy_AdminId])as adminName ,[Date],[IsImportant],[Is_Deleted],[Is_Disabled],(SELECT [name]FROM [tbl_BLOG_Categories] where Id=[Cat_Id]) as Category,(SELECT [name]FROM [tbl_BLOG_Groups] where G_Id=[GroupId]) as GroupName,(SELECT top 1 B.PicAddress FROM [tbl_BLOG_Pic_Connector] as A inner join [tbl_ADMIN_UploadStructure_ImageAddress] as B on A.[PicId]=B.PicID where A.PostId=Id)as Pic,(SELECT [ad_avatarprofile] FROM[tbl_ADMIN_main] where id_Admin=WrittenBy_AdminId) as AdminPic ,(SELECT[B_TypeToken] FROM [tbl_BLOG_PostType] WHERE B_TypeId=[TypeId]) as TypeId FROM [tbl_BLOG_Post] WHERE [GroupId] = " + dt1.Rows[0]["B_TypeId"]);

                for (int i = 0; i < dt.Rows.Count; i++)
                {
                    var model = new PostModel()
                    {
                        Id = Convert.ToInt32(dt.Rows[i]["Id"]),
                        by = dt.Rows[i]["adminName"].ToString(),
                        Category = dt.Rows[i]["Category"].ToString(),
                        InGroup = dt.Rows[i]["GroupName"].ToString(),
                        GPIDforPostPAge = dt.Rows[i]["GroupId"].ToString(),
                        ImagePath = AppendServername(dt.Rows[i]["Pic"].ToString()),
                        IsDeleted = Convert.ToInt32(dt.Rows[i]["Is_Deleted"]),
                        IsDisabled = Convert.ToInt32(dt.Rows[i]["Is_Disabled"]),
                        text = dt.Rows[i]["Text"].ToString(),
                        title = dt.Rows[i]["Title"].ToString(),
                        text_min = dt.Rows[i]["Text_min"].ToString(),
                        date = DateReturner(dt.Rows[i]["Date"].ToString(), DateType),
                        AdminPic = AppendServername(dt.Rows[i]["AdminPic"].ToString()),
                        PostType = dt.Rows[i]["TypeId"].ToString()
                    };
                    res.Add(model);
                }
            }


            return res;
        }


        public List<PostModel> PostModels_Chosen(string Cat,int TopSelect ,string DateType = "Date")
        {
            var res = new List<PostModel>();
            PDBC db = new PDBC("PandaMarketCMS", true);
            db.Connect();
            string Query = "";
            if(Cat=="Popular")
            {
                Query = "SELECT top " + TopSelect + " [Id],[Title],[Text_min],[Text],(SELECT [ad_firstname]+ ' '+ [ad_lastname] as name FROM [tbl_ADMIN_main]where id_Admin=[WrittenBy_AdminId])as adminName ,[Date],[IsImportant],[Is_Deleted],[Is_Disabled],(SELECT [name]FROM [tbl_BLOG_Categories] where Id=[Cat_Id]) as Category,(SELECT [name]FROM [tbl_BLOG_Groups] where G_Id=[GroupId]) as GroupName,(SELECT top 1 B.PicAddress FROM [tbl_BLOG_Pic_Connector] as A inner join [tbl_ADMIN_UploadStructure_ImageAddress] as B on A.[PicId]=B.PicID where A.PostId=Id)as Pic,(SELECT [ad_avatarprofile] FROM[tbl_ADMIN_main] where id_Admin=WrittenBy_AdminId) as AdminPic ,(SELECT[B_TypeToken] FROM [tbl_BLOG_PostType] WHERE B_TypeId=[TypeId]) as TypeId FROM [tbl_BLOG_Post] Order By(SELECT COUNT(*) FROM [tbl_BLOG_Comment] WHERE PostId=Id) DESC,Date DESC";
            }
            else if(Cat=="New")
            {
                Query = "SELECT top " + TopSelect + " [Id],[Title],[Text_min],[Text],(SELECT [ad_firstname]+ ' '+ [ad_lastname] as name FROM [tbl_ADMIN_main]where id_Admin=[WrittenBy_AdminId])as adminName ,[Date],[IsImportant],[Is_Deleted],[Is_Disabled],(SELECT [name]FROM [tbl_BLOG_Categories] where Id=[Cat_Id]) as Category,(SELECT [name]FROM [tbl_BLOG_Groups] where G_Id=[GroupId]) as GroupName,(SELECT top 1 B.PicAddress FROM [tbl_BLOG_Pic_Connector] as A inner join [tbl_ADMIN_UploadStructure_ImageAddress] as B on A.[PicId]=B.PicID where A.PostId=Id)as Pic,(SELECT [ad_avatarprofile] FROM[tbl_ADMIN_main] where id_Admin=WrittenBy_AdminId) as AdminPic ,(SELECT[B_TypeToken] FROM [tbl_BLOG_PostType] WHERE B_TypeId=[TypeId]) as TypeId FROM [tbl_BLOG_Post] Order By(Date)DESC";
            }



            DataTable dt = db.Select(Query);

            for (int i = 0; i < dt.Rows.Count; i++)
            {
                var model = new PostModel()
                {
                    Id = Convert.ToInt32(dt.Rows[i]["Id"]),
                    by = dt.Rows[i]["adminName"].ToString(),
                    Category = dt.Rows[i]["Category"].ToString(),
                    InGroup = dt.Rows[i]["GroupName"].ToString(),
                    GPIDforPostPAge = dt.Rows[i]["GroupId"].ToString(),
                    ImagePath = AppendServername(dt.Rows[i]["Pic"].ToString()),
                    IsDeleted = Convert.ToInt32(dt.Rows[i]["Is_Deleted"]),
                    IsDisabled = Convert.ToInt32(dt.Rows[i]["Is_Disabled"]),
                    text = dt.Rows[i]["Text"].ToString(),
                    title = dt.Rows[i]["Title"].ToString(),
                    text_min = dt.Rows[i]["Text_min"].ToString(),
                    date = DateReturner(dt.Rows[i]["Date"].ToString(), DateType),
                    AdminPic = AppendServername(dt.Rows[i]["AdminPic"].ToString()),
                    PostType = dt.Rows[i]["TypeId"].ToString()
                };
                res.Add(model);
            }
            return res;
        }


    }

}