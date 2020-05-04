using ShoppingCMS_V002.Models.D_APIModels;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace ShoppingCMS_V002.ModelViews.D_APIModelViews
{
    public class ProductDetail_ModelView
    {
        public Product_DesignerModel ProductModel { get; set; }
        public List<MiniProductModel> RelatedProducts { get; set; }
        public List<Company_Customers_Model> Company { get; set; }

    }
}