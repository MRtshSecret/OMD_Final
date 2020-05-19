using ShoppingCMS_V002.Models;
using ShoppingCMS_V002.Models.D_APIModels;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace ShoppingCMS_V002.ModelViews.D_APIModelViews
{
    public class ShoppingCartModelView
    {
        public FactorPopUpModel FactorModel { get; set; }
        public List<Id_ValueModel> Ostan { get; set; }
        public List<AddressModel> Adresses { get; set; }
        public CustomerDitaile Customer { get; set; }
    }
}