using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace ShoppingCMS_V002.Models.D_APIModels
{
    public class MiniFactorModel
    {
        public int Id { get; set; }
        public int Items { get; set; }
        public long totality { get; set; }
        public int CustomerId { get; set; }

    }
}