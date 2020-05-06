using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace ShoppingCMS_V002.Models.D_APIModels
{
    public class FactorMasterModel
    {
        public FactorPopUpModel ListOfProducts { get; set; }
        public MiniFactorModel Totality { get; set; }
    }
}