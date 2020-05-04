using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace ShoppingCMS_V002.Models.D_APIModels
{
    public class MPCModel
    {
        public int Id { get; set; }
        public string PricePerQ { get; set; }
        public string PriceXQ { get; set; }
        public string PriceOff { get; set; }
        public int OffType { get; set; }
        public string OffValue { get; set; }
        public string Properties { get; set; }
        public string JsonProperty { get; set; }
    }
}