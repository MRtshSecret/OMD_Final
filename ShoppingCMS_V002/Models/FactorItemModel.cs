using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace ShoppingCMS_V002.Models
{
    public class FactorItemModel
    {
        public int Num { get; set; }
        public int Id { get; set; }
        public string Title { get; set; }
        public string Discription { get; set; }
        public long perPrice { get; set; }
        public long allPrice { get; set; }
        public int offType { get; set; }
        public long OffValue { get; set; }
        public long perPrice_off { get; set; }
        public long allPrice_Off { get; set; }
        public int Numbers { get; set; }
        public string Quantity { get; set; }


    }
}