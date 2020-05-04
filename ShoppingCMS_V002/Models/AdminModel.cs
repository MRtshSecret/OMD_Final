using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace ShoppingCMS_V002.Models
{
    public class AdminModel
    {
        public int Id { get; set; }
        public string Name { get; set; }
        public string AdminType { get; set; }
        public int IsActive { get; set; }
        public int IsDeleted { get; set; }
        public string Pic { get; set; }
        public string Email { get; set; }
        public string Phone { get; set; }
        public string LastSeen { get; set; }
        public int LastSeenQuantity { get; set; }
    }
}