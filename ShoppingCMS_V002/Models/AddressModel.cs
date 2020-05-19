using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace ShoppingCMS_V002.Models
{
    public class AddressModel
    {
        public int Id { get; set; }
        public string City { get; set; }
        public string FullAddress { get; set; }
        public string HintAddress { get; set; }
    }
}