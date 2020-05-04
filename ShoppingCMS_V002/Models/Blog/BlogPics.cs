using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace ShoppingCMS_V002.Models.Blog
{
    public class BlogPics
    {
        public string PicId { get; set; }
        public string PostId { get; set; }
        public string picSizeTypeName { get; set; }
        public string picSizeTypeWidth { get; set; }
        public string picSizeTypeHeight { get; set; }
        public string Expr1 { get; set; }
        public string PicAddress { get; set; }
        public string PicThumbnailAddress { get; set; }
        public string PicCategoryTypeName { get; set; }
        public string alt { get; set; }
        public string uploadPicName { get; set; }
        public string ISDELETE { get; set; }
        public string Descriptions { get; set; }
    }
}