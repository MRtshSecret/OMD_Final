﻿using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace ShoppingCMS_V002.Models.Blog
{
    public class LatestNewsModel
    {
        public int Id { get; set; }
        public string title { get; set; }
        public string date { get; set; }
        public string ImagePath { get; set; }
        public string ImageValue { get; set; }
        public string Category { get; set; }
    }
}