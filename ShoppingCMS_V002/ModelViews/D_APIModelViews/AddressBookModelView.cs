using ShoppingCMS_V002.Models;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace ShoppingCMS_V002.ModelViews.D_APIModelViews
{
    public class AddressBookModelView
    {
        public List<Id_ValueModel> City { get; set; }
        public List<AddressModel> Addresses { get; set; }

    }
}