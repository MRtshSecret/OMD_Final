using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace ShoppingCMS_V002.Models.D_APIModels
{
    public class Company_Customers_Model
    {
        public int Id { get; set; }
        public string Name { get; set; }
        public string Job { get; set; }
        public string Message { get; set; }
        public int stars { get; set; }
        public string ImagePath { get; set; }
    }
}