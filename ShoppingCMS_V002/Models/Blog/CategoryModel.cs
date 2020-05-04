using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace ShoppingCMS_V002.Models.Blog
{
    public class CategoryModel
    {
        public int Num { get; set; }
        public int Id { get; set; }
        public int Disabled { get; set; }
        public int Deleted { get; set; }
        public string Name { get; set; }
        public int CatId { get; set; }
        public string Category { get; set; }


    }
}