using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace ShoppingCMS_V002.Models
{
    public class FactorModel
    {
        public int Id { get; set; }
        public string CustomerName { get; set; }
        public int ItmNumbers { get; set; }
        public string totality { get; set; }
        public string deposit { get; set; }
        public string priceQuantity { get; set; } 
        public string Date { get; set; }
        public int status { get; set; }
        public int IsDeleted { get; set; }

    }
}