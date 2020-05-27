using ShoppingCMS_V002.Models;
using ShoppingCMS_V002.Models.Blog;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace ShoppingCMS_V002.ModelViews
{
    public class Blog_Post_insert_Model
    {
        public string Action_ToDo { get; set; }
        public List<Id_ValueModel> Groups { get; set; }
        public List<Id_ValueModel> Category { get; set; }
        public PostModel PostData { get; set; }
        public List<Id_ValueModel> Type { get; set; }
        public List<Id_ValueModel> Tags { get; set; }
    }
}