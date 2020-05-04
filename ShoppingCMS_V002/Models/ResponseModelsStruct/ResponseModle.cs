using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using ShoppingCMS_V002.Models.Admin;

namespace ShoppingCMS_V002.Models.ResponseModelsStruct
{
    public class ResponseModleUser
    {
        public string StatusCode { get; set; }
        public string StatusMessage { get; set; }
        public MainAdminView ObjectMessage { get; set; }
        
    }
}