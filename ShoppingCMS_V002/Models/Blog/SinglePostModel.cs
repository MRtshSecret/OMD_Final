using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace ShoppingCMS_V002.Models.Blog
{
    public class SinglePostModel
    {
        public SinglePostPostDetail SPPD { set; get; }
        public List<PostModel> PostModel { set; get; }
        public List<BlogPics> BlogPicSlider { set; get; }
    }
}