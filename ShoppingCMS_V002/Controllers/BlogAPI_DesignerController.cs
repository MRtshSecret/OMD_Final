using ShoppingCMS_V002.DBConnect;
using ShoppingCMS_V002.Models;
using ShoppingCMS_V002.OtherClasses;
using ShoppingCMS_V002.OtherClasses.Blog;
using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using ShoppingCMS_V002.Models.Blog;

namespace ShoppingCMS_V002.Controllers
{
    public class BlogAPI_DesignerController : Controller
    {
        // GET: BlogAPI_Designer

        public ActionResult BlogPosts(string Cat = "همه", int Page = 1, int Id = 0,string search="")
        {
            PDBC db = new PDBC("PandaMarketCMS", true);
            string SearchNAmeHeader = "تمامی مطالب";
            int num = 1;
            db.Connect();
            if (Cat == "همه")
            {
                num = Convert.ToInt32(db.Select("SELECT Count(*) FROM [tbl_BLOG_Post]  where Is_Deleted=0 AND Is_Disabled=0").Rows[0][0]);
                db.DC();
            }
            else if (Cat == "دسته بندی")
            {
                num = Convert.ToInt32(db.Select("SELECT Count(*) FROM [tbl_BLOG_Post] where Is_Deleted=0 AND Is_Disabled=0 AND Cat_Id=" + Id).Rows[0][0]);
                using (DataTable dt2 = db.Select("SELECT [name] FROM  [tbl_BLOG_Categories] WHERE [Id] =" + Id))
                {
                    SearchNAmeHeader = dt2.Rows[0][0].ToString();
                }
                db.DC();
            }
            else if (Cat == "گروه بندی")
            {
                num = Convert.ToInt32(db.Select("SELECT Count(*) FROM [tbl_BLOG_Post] where Is_Deleted=0 AND Is_Disabled=0 AND [GroupId] = " + Id).Rows[0][0]);
                using (DataTable dt2 = db.Select("SELECT [name] FROM  [tbl_BLOG_Groups] WHERE [G_Id] =" + Id))
                {
                    SearchNAmeHeader = dt2.Rows[0][0].ToString();
                }
                db.DC();
            }
            else if (Cat == "برچسب")
            {
                num = Convert.ToInt32(db.Select("SELECT COUNT(*) FROM [tbl_BLOG_TagConnector] as A inner join [tbl_BLOG_Post] as B on A.Post_Id=B.Id where Is_Deleted=0 AND Is_Disabled=0 AND Tag_Id=" + Id).Rows[0][0]);
                using (DataTable dt2 = db.Select("SELECT [name] FROM  [tbl_BLOG_Tags] WHERE [Id] =" + Id))
                {
                    SearchNAmeHeader = dt2.Rows[0][0].ToString();
                }
                db.DC();
            }
            else if (Cat == "جست و جو")
            {
                num = Convert.ToInt32(db.Select("SELECT Count(*) FROM [tbl_BLOG_Post] where (Is_Deleted=0 AND Is_Disabled=0) AND (Title Like N'%" + search + "%' OR Text_min Like N'%" + search + "%' OR [Text] Like N'%" + search + "%') ").Rows[0][0]);
                db.DC();
            }

            if (num % 15 == 0)
            {
                num = (num / 15);
            }
            else
            {
                num = (num / 15) + 1;
            }




            Blog_ModelFiller BMF = new Blog_ModelFiller();
            var model = new BlogPostsModel()
            {
                Categories = BMF.BCategory_Filler(),
                Tags = BMF.B_AllTags_Filler(),
                Posts=BMF.UserPostModels(Cat,Page,Id,search),
                GroupsList = BMF.C_AllTags_Filler(),
                Pages=num,
                Page=Page,
                Cat=Cat,
                Id=Id,
                SearchNAmeHeaderH1= SearchNAmeHeader
            };

            return View(model);
        }

        public ActionResult PostList(string search)
        {
            Blog_ModelFiller BMF = new Blog_ModelFiller();

            return View(BMF.SearchResult(search));
        }
        public ActionResult AfraMaterPostsTypes()
        {

            Blog_ModelFiller BMF = new Blog_ModelFiller();
            BlogPostsModel bpm =new BlogPostsModel()
            {
                GroupsList = BMF.Groups_Filler()
            };
            return View(bpm);
        }
        public ActionResult PostDetails(int Id)
        {
            Blog_ModelFiller BMF = new Blog_ModelFiller(3);
            var model = new SinglePostModel()
            {
                PostModel = BMF.UserPostModels("همه", 1, 0, ""),
                SPPD = BMF.SinglePostFiller(Id),
                BlogPicSlider = BMF.GetAllBlogPostPics(Id)
            };
            return View(model);
        }

        public ActionResult MainPage()
        {
            Blog_ModelFiller BMF = new Blog_ModelFiller(3);
            var model = new BlogPostsModel()
            {
                 Posts = BMF.UserPostModels("همه", 1, 0, "")
            };
            return View(model);
        }

        [HttpPost]
        public ActionResult PostModels_ByType(string Type_Token)
        {
            Blog_ModelFiller BMF = new Blog_ModelFiller();
            return Json(BMF.PostModels_ByType(Type_Token));
        }
    }
}