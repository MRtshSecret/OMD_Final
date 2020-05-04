using ShoppingCMS_V002.Models;
using ShoppingCMS_V002.Models.Blog;
using ShoppingCMS_V002.Models.D_APIModels;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace ShoppingCMS_V002.ModelViews.D_APIModelViews
{
    public class MainPage_ModelView
    {

        public List<TreeModel> Cateqories { get; set; }
        public List<MiniProductModel> SelectedProducts { get; set; }
        public List<MiniProductModel> Sale_Products { get; set; }
        public List<MiniProductModel> NewProducts { get; set; }
        public List<MiniProductModel> ProductsG3 { get; set; }
        public List<PostModel> Posts { get; set; }
        public List<Company_Customers_Model> Company_Customers { get; set; }

    }
}