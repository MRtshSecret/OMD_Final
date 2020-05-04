using ShoppingCMS_V002.DBConnect;
using ShoppingCMS_V002.OtherClasses;
using ShoppingCMS_V002.OtherClasses.D_APIOtherClasses;
using ShoppingCMS_V002.SMS_Module;
using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.Mvc;

namespace ShoppingCMS_V002.Controllers
{
    public class API_FunctionsController : Controller
    {
        // GET: API_Functions
        [HttpPost]
        public ActionResult MasterTags()
        {
            D_APIModelFiller DMF = new D_APIModelFiller();
            return Json(DMF.ProductTags("min",0));
        }

        [HttpPost]
        public ActionResult Category(string Cat,int Id=0)
        {
            D_APIModelFiller DMF = new D_APIModelFiller();
            return Json(DMF.Categories(Cat,Id));

        }

        [HttpPost]
        public ActionResult City(string Cat, int Id = 0)
        {
            D_APIModelFiller DMF = new D_APIModelFiller();
            if(Cat=="City")
            {
                return Json(DMF.City(Id));
            }
            else
            {
                return Json(DMF.Ostanha());
            }  

        }


        [HttpPost]
        public ActionResult TagsFiller()
        {
            D_APIModelFiller DMF = new D_APIModelFiller();
            
                return Json(DMF.ProductTags("tag",0));
            

        }

        [HttpPost]
        public ActionResult AddToFavorite(int Id,int CustomerId)
        {
            PDBC db = new PDBC("PandaMarketCMS", true);
            db.Connect();

            Encryption ENC = new Encryption();
            List<ExcParameters> parss = new List<ExcParameters>();
            ExcParameters par = new ExcParameters()
            {
                _KEY = "@UId",
                _VALUE = CustomerId
            };
            parss.Add(par);
            par = new ExcParameters()
            {
                _KEY = "@ProId",
                _VALUE = Id
            };
            parss.Add(par);

            if(db.Select("",parss).Rows.Count!=0)
            {
                db.Script("INSERT INTO [tbl_Customer_Favorites]([CustomerId],[ProductId])VALUES(@UId,@ProId)", parss);
                return Content("1");
            }
            else
            {
                db.Script("DELETE FROM [tbl_Customer_Favorites]WHERE CustomerId=@UId AND ProductId=@ProId", parss);
                return Content("0");
            }
        }

        [HttpPost]
        public ActionResult SmsRegister(string MobileNum,string Pass)
        {
            PDBC db = new PDBC("PandaMarketCMS", true);
            db.Connect();

            Encryption ENC = new Encryption();
            List<ExcParameters> parss = new List<ExcParameters>();
            ExcParameters par = new ExcParameters()
            {
                _KEY = "@Mobile",
                _VALUE = MobileNum
            };
            parss.Add(par);
            par = new ExcParameters()
            {
                _KEY = "@PassWord",
                _VALUE = ENC.MD5Hash(Pass)
            };
            parss.Add(par);
            int UserId = Convert.ToInt32(db.Script("INSERT INTO [tbl_Customer_Main] OUTPUT inserted.id_Customer VALUES(GETDATE(),@Mobile,N'',N'',N'',0,0,NULL,@PassWord)", parss));
            Random generator = new Random();
            string r = generator.Next(0, 999999).ToString("D6");

            SMS_ir sms = new SMS_ir();
            

            return Json(sms.SendVerificationCodeWithTemplate(UserId, "VelvetRegister", 2));
        }

        public ActionResult CheckCode(int UId,string Code)
        {
            PDBC db = new PDBC("PandaMarketCMS", true);
            db.Connect();

            DataTable dt = db.Select("SELECT [C_ActivationToken] FROM [tbl_Customer_Main] where id_Customer=SELECT [C_ActivationToken] FROM [tbl_Customer_Main] where id_Customer=SELECT [C_ActivationToken] FROM [tbl_Customer_Main] where id_Customer=" + UId);
            if(dt.Rows.Count!=0)
            {
                string token = dt.Rows[0][0].ToString();
                if(token==Code)
                {
                    return Content("Success");
                }
                else
                {
                    return Content("Wrong Code");
                }
            }else
            {
                return Content("User Not Found");
            }
        }

        public ActionResult EncryptOMD(string Token)
        {
            Encryption ENC = new Encryption();
            string s = "{'CustomerId':" + Token + ",'Status':'Active'}";
            return Content(ENC.EncryptText(s, "OMD_Token"));

        }

        public ActionResult DecryptOMD(string Token)
        {
            Encryption ENC = new Encryption();
            return Content(ENC.DecryptText(Token, "OMD_Token"));

        }

        [HttpPost]
        public ActionResult AddComment_Product(int ProId,string Email,string Name,string Message)
        {
            PDBC db = new PDBC("PandaMarketCMS", true);
            db.Connect();

            List<ExcParameters> parss = new List<ExcParameters>();
            
            ExcParameters par = new ExcParameters()
            {
                _KEY = "@ProId",
                _VALUE = ProId
            };
            parss.Add(par);
            par = new ExcParameters()
            {
                _KEY = "@Email",
                _VALUE = Email
            };
            parss.Add(par); par = new ExcParameters()
            {
                _KEY = "@Name",
                _VALUE = Name
            };
            parss.Add(par); par = new ExcParameters()
            {
                _KEY = "@Message",
                _VALUE = Message
            };
            parss.Add(par);

            db.Script("INSERT INTO [tbl_Product_Comment]VALUES(@Email,@Name,N'',@Message,@ProId,GETDATE())", parss);
            return Content("Success");
        }

    }
}