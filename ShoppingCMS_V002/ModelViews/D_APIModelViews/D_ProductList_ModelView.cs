using ShoppingCMS_V002.Models;
using ShoppingCMS_V002.Models.D_APIModels;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace ShoppingCMS_V002.ModelViews.D_APIModelViews
{
    public class D_ProductList_ModelView
    {
        public int Pages { get; set; }
        public int thisPage { get; set; }
        public List<TreeModel> Cateqories { get; set; }
        public List<MiniProductModel> Sale_Products { get; set; }
        public List<MiniProductModel> NewProducts { get; set; }
        public List<MiniProductModel> ProductsG3 { get; set; }
        public List<Id_ValueModel> tags { get; set; }
        public List<MiniProductModel> Products { get; set; }
        public string Cat { get; set; }
        public int CatId { get; set; }
        public string Search { get; set; }
    }
}