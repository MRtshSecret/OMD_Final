using ShoppingCMS_V002.DBConnect;
using ShoppingCMS_V002.Models.D_APIModels;
using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;

namespace ShoppingCMS_V002.OtherClasses.D_APIOtherClasses
{
    public class DataClass
    {
        public List<tbl_BLOG> BLOG(string NamePage, string Valuepage)
        {
            PDBC db = new PDBC("PandaMarketCMS", true);


            List<tbl_BLOG> List_BLG = new List<tbl_BLOG>();
            string query = "";

            query = " SELECT [tbl_BLOG_Post].[Id], [Title],[Text_min],[Date]  ,[name] as'Cat_Id'";
            query += " ,(SELECT [ad_firstname]FROM  [tbl_ADMIN_main] where[id_Admin]= [tbl_BLOG_Post].[WrittenBy_AdminId]) as'firstname'  ";
            query += " ,(SELECT [ad_lastname]FROM  [tbl_ADMIN_main] where[id_Admin]= [tbl_BLOG_Post].[WrittenBy_AdminId]) as'lastname'  ";
            query += " ,(SELECT count([Id])FROM  [tbl_BLOG_Comment]where [PostId] = [tbl_BLOG_Post].[Id] )as'Comments' ";
            query += " FROM  [tbl_BLOG_Post] ";
            query += " inner join  [tbl_BLOG_Categories] on  [tbl_BLOG_Post].[Cat_Id] =  [tbl_BLOG_Categories].[Id] ";
            query += " where  [tbl_BLOG_Post].[Is_Deleted]  like 0 AND   [tbl_BLOG_Post].[Is_Disabled] like 0 ";
            query += " And  [tbl_BLOG_Categories].[Is_Deleted]  like 0 AND   [tbl_BLOG_Categories].[Is_Disabled] like 0 ";




            if (NamePage == "post")
            {
                query += " order by [Date] desc ";
            }
            else if (NamePage == "Categories")
            {
                query += $" And  [name] = N'{Valuepage}' order by [Date] desc ";

            }
            else if (NamePage == "Search")
            {
                query += $"And [tbl_BLOG_Post].Title like N'%{Valuepage}%' OR [tbl_BLOG_Post].Text like N'%{Valuepage}%' order by([tbl_BLOG_Post].weight) DESC,[Date] DESC";
            }
            else if (NamePage == "tag")
            {
                query = BLOG_Tags(Valuepage, true)[0].name;
            }

            db.Connect();
            using (DataTable dt = db.Select(query))
            {
                db.DC();
                for (int i = 0; i < dt.Rows.Count; i++)
                {

                    tbl_BLOG BLG = new tbl_BLOG();


                    BLG.Id = Convert.ToInt32(dt.Rows[i]["Id"]);
                    BLG.Title = dt.Rows[i]["Title"].ToString();
                    BLG.Text_min = dt.Rows[i]["Text_min"].ToString();
                    BLG.Date = dt.Rows[i]["Date"].ToString();
                    BLG.Cat_Id = dt.Rows[i]["Cat_Id"].ToString();
                    BLG.Comments = dt.Rows[i]["Comments"].ToString();
                    BLG.WrittenBy_AdminId = dt.Rows[i]["firstname"].ToString() + " " + dt.Rows[i]["lastname"].ToString();
                    BLG.list_pic = Pic_BLOG(dt.Rows[i]["Id"].ToString());
                    List_BLG.Add(BLG);

                }
            }

            return List_BLG;
        }
        public List<tbl_BLOG> Pic_BLOG(string id)
        {
            List<tbl_BLOG> List_BLG = new List<tbl_BLOG>();
            PDBC db = new PDBC("PandaMarketCMS", true);

            string query = "SELECT distinct [PostId],[PicSizeType],[PicAddress],[PicThumbnailAddress]";
            query += "FROM [tbl_ADMIN_UploadStructure_ImageAddress]inner join [tbl_BLOG_Pic_Connector]";
            query += " on [tbl_BLOG_Pic_Connector].PicId =[tbl_ADMIN_UploadStructure_ImageAddress].PicID ";
            query += $" where PostId ={id}";

            db.Connect();

            using (DataTable dt = db.Select(query))
            {
                db.DC();
                for (int i = 0; i < dt.Rows.Count; i++)
                {
                    tbl_BLOG BLG = new tbl_BLOG();
                    BLG.PicId = id;
                    BLG.PicSizeType = dt.Rows[i]["PicSizeType"].ToString();
                    BLG.PicAddress = dt.Rows[i]["PicAddress"].ToString();
                    BLG.PicThumbnailAddress = dt.Rows[i]["PicThumbnailAddress"].ToString();
                    List_BLG.Add(BLG);
                }
            }

            return List_BLG;
        }
        public List<tbl_BLOG> BLOG_Categories(string Valuepage, bool IsVal)
        {
            List<tbl_BLOG> List_BLG = new List<tbl_BLOG>();
            PDBC db = new PDBC("PandaMarketCMS", true);

            string query;

            if (IsVal)
            {
                /**/

                query = "  SELECT top 3 [tbl_BLOG_Post].[Id], [Title],[Text_min],[Date],[name] as'Cat_Id' ";
                query += ",(SELECT count([Id])FROM[tbl_BLOG_Comment]where[PostId] =[tbl_BLOG_Post].[Id] )as'Comments'  ";
                query += " FROM [tbl_BLOG_Post]  ";
                query += " inner join [tbl_BLOG_Categories] on [tbl_BLOG_Post].[Cat_Id] = [tbl_BLOG_Categories].[Id]  ";
                query += " where [tbl_BLOG_Post].[Is_Deleted]  like 0 AND [tbl_BLOG_Post].[Is_Disabled] like 0  ";
                query += " And [tbl_BLOG_Categories].[Is_Deleted]  like 0 AND [tbl_BLOG_Categories].[Is_Disabled] like 0  ";
                query += " And[name] = N'" + Valuepage + "'order by[Date] desc";
                db.Connect();
                using (DataTable dt = db.Select(query))
                {
                    db.DC();
                    for (int i = 0; i < dt.Rows.Count; i++)
                    {
                        tbl_BLOG BLG = new tbl_BLOG();

                        BLG.name = dt.Rows[i]["Cat_Id"].ToString();
                        BLG.Id = Convert.ToInt32(dt.Rows[0]["Id"]);
                        BLG.Comments = dt.Rows[i]["Comments"].ToString();
                        BLG.Title = dt.Rows[i]["Title"].ToString();
                        BLG.Text_min = dt.Rows[i]["Text_min"].ToString();
                        BLG.Date = dt.Rows[i]["Date"].ToString();
                        foreach (var item in Pic_BLOG(dt.Rows[i]["Id"].ToString()))
                        {
                            BLG.PicAddress = item.PicAddress;
                        }
                        List_BLG.Add(BLG);
                    }
                }

            }
            else
            {
                query = " SELECT  [name] ,( SELECT count(Id)";
                query += " FROM  [tbl_BLOG_Post]where [Cat_Id] = [tbl_BLOG_Categories].[Id])as 'count'";
                query += " FROM  [tbl_BLOG_Categories]";
                query += " where [Is_Deleted]  like 0 AND  [Is_Disabled] like 0 order by id desc ";
                db.Connect();
                using (DataTable dt = db.Select(query))
                {
                    db.DC();
                    for (int i = 0; i < dt.Rows.Count; i++)
                    {
                        tbl_BLOG BLG = new tbl_BLOG();

                        BLG.name = dt.Rows[i]["name"].ToString();
                        BLG.count = dt.Rows[i]["count"].ToString();
                        List_BLG.Add(BLG);
                    }
                }
            }

            return List_BLG;
        }
        public List<tbl_BLOG> BLOG_Tags(string Valuepage, bool IsVal)
        {
            List<tbl_BLOG> List_BLG = new List<tbl_BLOG>();
            PDBC db = new PDBC("PandaMarketCMS", true);

            string query;


            if (IsVal)
            {
                query = "  SELECT [tbl_BLOG_Post].[Id], [Title],[Text_min],[Date] , [tbl_BLOG_Categories].[name] as'Cat_Id'";
                query += "  ,(SELECT [ad_firstname]FROM [tbl_ADMIN_main] where[id_Admin]=[tbl_BLOG_Post].[WrittenBy_AdminId]) as'firstname'";
                query += "  ,(SELECT [ad_lastname]FROM  [tbl_ADMIN_main] where[id_Admin]= [tbl_BLOG_Post].[WrittenBy_AdminId]) as'lastname' ";
                query += "  ,(SELECT count([Id])FROM  [tbl_BLOG_Comment]where [PostId] = [tbl_BLOG_Post].[Id] )as'Comments' ";
                query += "  FROM  [tbl_BLOG_Post] ";
                query += "  inner join  [tbl_BLOG_TagConnector] on  [tbl_BLOG_TagConnector].[Tag_Id] =  [tbl_BLOG_Post].[Id]";
                query += "  inner join  [tbl_BLOG_Tags] on  [tbl_BLOG_TagConnector].[Tag_Id] =  [tbl_BLOG_Tags].[Id]";
                query += "  inner join  [tbl_BLOG_Categories] on  [tbl_BLOG_Post].[Cat_Id] =  [tbl_BLOG_Categories].[Id] ";
                query += "  where  [tbl_BLOG_Post].[Is_Deleted]  like 0 AND   [tbl_BLOG_Post].[Is_Disabled] like 0 ";
                query += "  And  [tbl_BLOG_Categories].[Is_Deleted]  like 0 AND   [tbl_BLOG_Categories].[Is_Disabled] like 0 ";
                query += "  And   [tbl_BLOG_Tags].[Is_Deleted]  like 0 AND   [tbl_BLOG_Tags].[Is_Disabled] like 0";
                query += $" And   [tbl_BLOG_Tags].[name] = N'{Valuepage}' order by [Date] desc ";



                tbl_BLOG BLG = new tbl_BLOG
                {
                    name = query
                };
                List_BLG.Add(BLG);
            }
            else
            {
                if (Valuepage == "مشاهده همه")
                {
                    query = " SELECT [Name] ";
                    query += " FROM  [tbl_BLOG_Tags] ";
                    query += " where [Is_Deleted]  like 0 AND  [Is_Disabled] like 0 order by id desc ";
                    db.Connect();
                    using (DataTable dt = db.Select(query))
                    {
                        db.DC();
                        for (int i = 0; i < dt.Rows.Count; i++)
                        {
                            tbl_BLOG BLG = new tbl_BLOG();

                            BLG.name = dt.Rows[i]["name"].ToString();

                            List_BLG.Add(BLG);
                        }
                    }
                }
                else
                {

                    query = " SELECT top 10 [Name] ";
                    query += " FROM  [tbl_BLOG_Tags] ";
                    query += " where [Is_Deleted]  like 0 AND  [Is_Disabled] like 0 order by id desc ";
                    db.Connect();
                    using (DataTable dt = db.Select(query))
                    {
                        db.DC();
                        for (int i = 0; i < dt.Rows.Count; i++)
                        {
                            tbl_BLOG BLG = new tbl_BLOG();

                            BLG.name = dt.Rows[i]["name"].ToString();

                            List_BLG.Add(BLG);
                        }
                    }
                }

            }
            return List_BLG;
        }
        public List<tbl_BLOG> TabS(string Value)
        {
            PDBC db = new PDBC("PandaMarketCMS", true);


            List<tbl_BLOG> List_BLG = new List<tbl_BLOG>();
            string query = "";
            if (Value == "new")
            {
                query = " SELECT top 5  [tbl_BLOG_Post].[Id], [Title],[Date],[name]";
                query += " ,(SELECT count([Id])FROM  [tbl_BLOG_Comment]where [PostId] = [tbl_BLOG_Post].[Id] )as'Comments' ";
                query += " FROM  [tbl_BLOG_Post]";
                query += " inner join  [tbl_BLOG_Categories] on  [tbl_BLOG_Post].[Cat_Id] =  [tbl_BLOG_Categories].[Id]";
                query += " where  [tbl_BLOG_Post].[Is_Deleted]  like 0 AND   [tbl_BLOG_Post].[Is_Disabled] like 0";
                query += " And  [tbl_BLOG_Categories].[Is_Deleted]  like 0 AND   [tbl_BLOG_Categories].[Is_Disabled] like 0 order by Date desc ";
            }
            else if (Value == "like")
            {
                query = " SELECT top 5  [tbl_BLOG_Post].[Id],  [tbl_BLOG_Post].[Title], [tbl_BLOG_Post].[Date], [tbl_BLOG_Categories].[name] ";
                query += " ,(SELECT count([Id])FROM  [tbl_BLOG_Comment]where [PostId] = [tbl_BLOG_Post].[Id] )as'Comments' ";
                query += "  FROM  [tbl_BLOG_Post] ";
                query += "  inner join  [tbl_BLOG_Comment]   on  [tbl_BLOG_Post].[Id] =  [tbl_BLOG_Comment].[PostId]";
                query += "  inner join  [tbl_BLOG_Categories] on  [tbl_BLOG_Post].[Cat_Id] =  [tbl_BLOG_Categories].[Id]";
                query += "  where  [tbl_BLOG_Post].[Is_Deleted]  like 0 AND   [tbl_BLOG_Post].[Is_Disabled] like 0 ";
                query += "  And  [tbl_BLOG_Categories].[Is_Deleted]  like 0 AND   [tbl_BLOG_Categories].[Is_Disabled] like 0 ";
                query += "  And [tbl_BLOG_Comment].[PostId] = [tbl_BLOG_Post].[Id]";
                query += "  GROUP BY [tbl_BLOG_Post].[Id] , [tbl_BLOG_Post].[Title], [tbl_BLOG_Post].[Date],[tbl_BLOG_Categories].[name] ";
                query += "  HAVING COUNT([PostId]) > 5 order by count([PostId]) desc";
            }

            db.Connect();
            using (DataTable dt = db.Select(query))
            {
                db.DC();
                for (int i = 0; i < dt.Rows.Count; i++)
                {

                    tbl_BLOG BLG = new tbl_BLOG();


                    BLG.Id = Convert.ToInt32(dt.Rows[0]["Id"]);
                    BLG.Title = dt.Rows[i]["Title"].ToString();
                    BLG.Date = dt.Rows[i]["Date"].ToString();
                    BLG.Comments = dt.Rows[i]["Comments"].ToString();

                    foreach (var item in Pic_BLOG(dt.Rows[i]["Id"].ToString()))
                    {
                        BLG.PicAddress = item.PicAddress;
                    }

                    List_BLG.Add(BLG);

                }
            }

            return List_BLG;
        }
        //////////////////////////////////////////////BlogPost      tbl_BLOG
        public tbl_BLOG BLOGPOST(string id)
        {
            PDBC db = new PDBC("PandaMarketCMS", true);
            string query = "";
            query += " SELECT  [tbl_BLOG_Post].[Id], [Title],[Text_min],[Text],[Date]  ,[name] as'Cat_Id' ";
            query += " ,(SELECT [ad_firstname]FROM  [tbl_ADMIN_main] where[id_Admin]= [tbl_BLOG_Post].[WrittenBy_AdminId]) as'firstname'";
            query += " ,(SELECT [ad_lastname]FROM  [tbl_ADMIN_main] where[id_Admin]= [tbl_BLOG_Post].[WrittenBy_AdminId]) as'lastname'";
            query += " ,(SELECT count([Id])FROM  [tbl_BLOG_Comment]where [PostId] = [tbl_BLOG_Post].[Id] )as'Comments'";
            query += " FROM  [tbl_BLOG_Post]";
            query += " inner join  [tbl_BLOG_Categories] on  [tbl_BLOG_Post].[Cat_Id] =  [tbl_BLOG_Categories].[Id] ";
            query += " where  [tbl_BLOG_Post].[Is_Deleted]  like 0 AND   [tbl_BLOG_Post].[Is_Disabled] like 0";
            query += " And  [tbl_BLOG_Categories].[Is_Deleted]  like 0 AND   [tbl_BLOG_Categories].[Is_Disabled] like 0";
            query += " And [tbl_BLOG_Post].[Id]=" + id;

            db.Connect();
            DataTable dt = db.Select(query);
            db.DC();
            var tbg = new tbl_BLOG
            {
                Id = Convert.ToInt32(dt.Rows[0]["Id"]),
                Title = dt.Rows[0]["Title"].ToString(),
                Text_min = dt.Rows[0]["Text_min"].ToString(),
                Text = dt.Rows[0]["Text"].ToString(),
                Date = dt.Rows[0]["Date"].ToString(),
                Cat_Id = dt.Rows[0]["Cat_Id"].ToString(),
                Comments = dt.Rows[0]["Comments"].ToString(),
                WrittenBy_AdminId = dt.Rows[0]["firstname"].ToString() + " " + dt.Rows[0]["lastname"].ToString(),
                list_pic = Pic_BLOG(dt.Rows[0]["Id"].ToString()),
                list_cat = BLOG_Categories(dt.Rows[0]["Cat_Id"].ToString(), true),
                list_comment = list_comm(dt.Rows[0]["Id"].ToString())
            };

            return tbg;
        }
        private List<tbl_BLOG> list_comm(string id)
        {
            PDBC db = new PDBC("PandaMarketCMS", true);
            

            List<tbl_BLOG> List_BLG = new List<tbl_BLOG>();
            string query = "SELECT [Id],[message],[Name],[PostId],[ImagePath],[Date]";
            query += "FROM [tbl_BLOG_Comment] where[PostId] = " + id + "order by Id desc";

db.Connect();
            DataTable dt = db.Select(query);
            db.DC();
            for (int i = 0; i < dt.Rows.Count; i++)
            {

                tbl_BLOG BLG = new tbl_BLOG();


                BLG.Id = Convert.ToInt32(dt.Rows[0]["Id"]);
                BLG.message = dt.Rows[i]["message"].ToString();
                BLG.name = dt.Rows[i]["Name"].ToString();
                BLG.Date = dt.Rows[i]["Date"].ToString();
                BLG.ImagePath = dt.Rows[i]["ImagePath"].ToString();


                List_BLG.Add(BLG);

            }


            return List_BLG;
        }

    }
}

