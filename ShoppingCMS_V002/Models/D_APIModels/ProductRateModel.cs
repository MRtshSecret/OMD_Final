using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace ShoppingCMS_V002.Models.D_APIModels
{
    public class ProductRateModel
    {
        public int ProductId { get; set; }
        public string Title { get; set; }
        public string Message { get; set; }
        public string Name { get; set; }
        public string Date { get; set; }

    }
}