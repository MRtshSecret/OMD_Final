using ShoppingCMS_V002.Models.Blog;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace ShoppingCMS_V002.Models
{
    public class BlogPostsModel
    {
        public List<Id_ValueModel> Categories { get; set; }
        public List<Id_ValueModel> GroupsList { get; set; }
        public List<Id_ValueModel> Tags { get; set; }
        public List<PostModel> Posts { get; set; }
        public int Page { get; set; }
        public int Pages { get; set; }
        public string Cat { get; set; }
        public int Id { get; set; }
        public string SearchNAmeHeaderH1 { get; set; }

    }
}