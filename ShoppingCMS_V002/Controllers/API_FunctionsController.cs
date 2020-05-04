using ShoppingCMS_V002.DBConnect;
using ShoppingCMS_V002.Models.D_APIModels;
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

            if(db.Select("SELECT [CustomerId],[ProductId] FROM [tbl_Customer_Favorites] where [CustomerId]=@UId AND ProductId=@ProId", parss).Rows.Count==0)
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
            string GeneratedCode = generator.Next(100000, 999999).ToString("D6");
             parss = new List<ExcParameters>();
             par = new ExcParameters()
            {
                _KEY = "@id_Customer",
                _VALUE = UserId
             };
            parss.Add(par);
            par = new ExcParameters()
            {
                _KEY = "@sms_irKeyType",
                _VALUE = 2
            };
            parss.Add(par);
            par = new ExcParameters()
            {
                _KEY = "@sms_irSentKey",
                _VALUE = GeneratedCode
            };
            parss.Add(par);
            par = new ExcParameters()
            {
                _KEY = "@sms_irIsKeyAlive",
                _VALUE = 1
            };
            parss.Add(par);
            string result = db.Script("INSERT INTO [dbo].[tbl_sms_ir_CustomerKeys]([id_Customer],[sms_irKeyType],[sms_irSentKey],[sms_irKeyGeneratedDate],[sms_irIsKeyAlive]) VALUES(@id_Customer ,@sms_irKeyType ,@sms_irSentKey ,GETDATE(),@sms_irIsKeyAlive)", parss);
            SMS_ir sms = new SMS_ir();

            return Json(sms.SendVerificationCodeWithTemplate(UserId, "VelvetRegister", 2));
        }

        public ActionResult CheckCode(int UId,string Code) 
        {
            PDBC db = new PDBC("PandaMarketCMS", true);
            db.Connect();

            DataTable dt = db.Select("SELECT [C_ActivationToken] FROM [tbl_Customer_Main] where id_Customer = " + UId);
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
            string s = "{\"CustomerId\":" + Token + ",\"Status\":\"Active\"}";
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

        [HttpPost]
        public ActionResult GetMPCs(int id)
        {
            D_APIModelFiller DMF = new D_APIModelFiller();
            return Json(DMF.MPCs(id));
        }

        public ActionResult Add_ShoppingCart(int proId,int CustomerId,int number,int FactorId)
        {
            PDBC db = new PDBC("PandaMarketCMS", true);
            db.Connect();
            Encryption ENC = new Encryption();
            if (FactorId==0)
            {
                List<ExcParameters> parss = new List<ExcParameters>();
                ExcParameters par = new ExcParameters()
                {
                    _KEY = "@CustomerId",
                    _VALUE = CustomerId
                };
                parss.Add(par);

                var FactorId_ =Convert.ToInt32( db.Script("INSERT INTO [tbl_FACTOR_Main] output inserted.Factor_Id VALUES(@CustomerId,0,GetDate(),'',NULL,NULL,0,0,0,0,0,0,'','')",parss));

                par = new ExcParameters()
                {
                    _KEY = "@Number",
                    _VALUE = number
                };
                parss.Add(par);

                par = new ExcParameters()
                {
                    _KEY = "@FactorId",
                    _VALUE = FactorId_
                };
                parss.Add(par);

                par = new ExcParameters()
                {
                    _KEY = "@ProId",
                    _VALUE = proId
                };
                parss.Add(par);

                DataTable dt = db.Select("SELECT top 1 [id_PPH] ,PriceOff FROM [tbl_Product_PastProductHistory] where id_MPC=@ProId order by([ChangedDate])DESC", parss);
                int DateId = 0;
                long price = 0;
                if(dt.Rows.Count!=0)
                {
                    DateId = Convert.ToInt32(dt.Rows[0]["id_PPH"]);
                    price = long.Parse(dt.Rows[0]["PriceOff"].ToString());
                }
                par = new ExcParameters()
                {
                    _KEY = "@DateId",
                    _VALUE = DateId
                };
                parss.Add(par);

                db.Script("INSERT INTO [tbl_FACTOR_Items]VALUES(@ProId,@Number,@DateId,@FactorId)", parss);

                var Factor = new MiniFactorModel()
                {
                    CustomerId = CustomerId,
                    Id = FactorId_
                };


                parss = new List<ExcParameters>();
                par = new ExcParameters()
                {
                    _KEY = "@price",
                    _VALUE = price*number
                };
                parss.Add(par);

                par = new ExcParameters()
                {
                    _KEY = "@FactorId",
                    _VALUE = FactorId_
                };
                parss.Add(par);

                if (price!=0)
                {
                    db.Script("UPDATE [tbl_FACTOR_Main] SET [toality] =@price  WHERE Factor_Id=@FactorId", parss);
                }

                Factor.Items = Convert.ToInt32(db.Select("SELECT COUNT(*) FROM [tbl_FACTOR_Items] where FactorId=@FactorId", parss).Rows[0][0]);
                Factor.totality = price;
                
                return Content(ENC.EncryptText(Newtonsoft.Json.JsonConvert.SerializeObject(Factor),"OMD_FACTOR"));
            }
            else
            {
                List<ExcParameters> parss = new List<ExcParameters>();
                ExcParameters par = new ExcParameters()
                {
                    _KEY = "@CustomerId",
                    _VALUE = CustomerId
                };
                parss.Add(par);

                par = new ExcParameters()
                {
                    _KEY = "@Number",
                    _VALUE = number
                };
                parss.Add(par);

                par = new ExcParameters()
                {
                    _KEY = "@FactorId",
                    _VALUE = FactorId
                };
                parss.Add(par);

                par = new ExcParameters()
                {
                    _KEY = "@ProId",
                    _VALUE = proId
                };
                parss.Add(par);

                DataTable dt = db.Select("SELECT top 1 [id_PPH] ,PriceOff FROM [tbl_Product_PastProductHistory] where id_MPC=@ProId order by([ChangedDate])DESC", parss);
                int DateId = 0;
                long price = 0;
                if (dt.Rows.Count != 0)
                {
                    DateId = Convert.ToInt32(dt.Rows[0]["id_PPH"]);
                    price = long.Parse(dt.Rows[0]["PriceOff"].ToString());
                }
                par = new ExcParameters()
                {
                    _KEY = "@DateId",
                    _VALUE = DateId
                };
                parss.Add(par);

                db.Script("INSERT INTO [tbl_FACTOR_Items]VALUES(@ProId,@Number,@DateId,@FactorId)", parss);

                var Factor = new MiniFactorModel()
                {
                    CustomerId = CustomerId,
                    Id = FactorId
                };


                parss = new List<ExcParameters>();
                par = new ExcParameters()
                {
                    _KEY = "@FactorId",
                    _VALUE = FactorId
                };
                parss.Add(par);

                DataTable Price = db.Select("SELECT [toality] FROM [tbl_FACTOR_Main]where Factor_Id=@FactorId", parss);
                long totality = 0;
                if(Price.Rows.Count!=0)
                {
                    totality = long.Parse(Price.Rows[0][0].ToString());
                }
                
                if (price != 0)
                {
                    
                    par = new ExcParameters()
                    {
                        _KEY = "@price",
                        _VALUE =(price * number)+totality
                    };
                    parss.Add(par);
                    
                    db.Script("UPDATE [tbl_FACTOR_Main] SET [toality] =@price  WHERE Factor_Id=@FactorId", parss);
                }

                Factor.Items = Convert.ToInt32(db.Select("SELECT COUNT(*) FROM [tbl_FACTOR_Items] where FactorId=@FactorId", parss).Rows[0][0]);
                Factor.totality = ((price * number) + totality);

                return Content(ENC.EncryptText(Newtonsoft.Json.JsonConvert.SerializeObject(Factor), "OMD_FACTOR"));
            }

            
        }


        public ActionResult DecryptFactor(string str)
        {
            Encryption ENC = new Encryption();
            return Content(ENC.DecryptText(str, "OMD_FACTOR"));
        }


    }
}