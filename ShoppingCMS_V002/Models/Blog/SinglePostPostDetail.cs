using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace ShoppingCMS_V002.Models.Blog
{
    public class SinglePostPostDetail
    {
        public string Cat_Id { get; set; }
        public string GroupId { get; set; }
        public string Gpname { get; set; }
        public string CatName { get; set; }
        public string Title { get; set; }
        public string Text_min { get; set; }
        public string Text { get; set; }
        public string Date { get; set; }
        public string weight { get; set; }
        public string IsImportant { get; set; }
        public string PostID { get; set; }
        public string WrittenBy_AdminId { get; set; }
        public string ad_firstname { get; set; }
        public string ad_lastname { get; set; }
        public string ad_avatarprofile { get; set; }
        public List<CommentsModel> Comments { get; set; }
    }
}