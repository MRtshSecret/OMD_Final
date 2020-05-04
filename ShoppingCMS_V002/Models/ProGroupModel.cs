using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace ShoppingCMS_V002.Models
{
    public class ProGroupModel
    {
        public int Num { get; set; }
        public int Id { get; set; }
        public int IsDeleted { get; set; }
        public int IsDisables { get; set; }
        public string Type { get; set; }
        public string Main { get; set; }
        public string Sub { get; set; }
        public string SubK { get; set; }
        public string SubVal { get; set; }
    }
}