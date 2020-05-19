using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace ShoppingCMS_V002.Models
{
    public class CustomerDitaile
    {
        public int Id { get; set; }
        public string Name { get; set; }
        public string Familly { get; set; }
        public string PhoneNum { get; set; }
        public string Discription { get; set; }
        public string registerDate { get; set; }
        public string Email { get; set; }
        public List<AddressModel> Addresses { get; set; }
    }
}