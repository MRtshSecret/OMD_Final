﻿using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace ShoppingCMS_V002.Models.D_APIModels
{
    public class MiniProductModel
    {
        public int Id { get; set; }
        public string Title { get; set; }
        public string PicPath { get; set; }
        public string Discription { get; set; }
        public string Price { get; set; }
        public string OffPrice { get; set; }
        public string date { get; set; }
        public string MoneyQ { get; set; }
        public string PricePerQ { get; set; }
    }
}