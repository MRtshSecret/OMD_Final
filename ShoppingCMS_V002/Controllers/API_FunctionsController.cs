using Newtonsoft.Json;
using ShoppingCMS_V002.DBConnect;
using ShoppingCMS_V002.Models.D_APIModels;
using ShoppingCMS_V002.OtherClasses;
using ShoppingCMS_V002.OtherClasses.D_APIOtherClasses;
using ShoppingCMS_V002.OtherClasses.MasterChi_Fu;
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
            return Json(DMF.ProductTags("min", 0));
        }

        [HttpPost]
        public ActionResult Category(string Cat, int Id = 0)
        {
            D_APIModelFiller DMF = new D_APIModelFiller();
            return Json(DMF.Categories(Cat, Id));

        }

        [HttpPost]
        public ActionResult City(string Cat, int Id = 0)
        {
            D_APIModelFiller DMF = new D_APIModelFiller();
            if (Cat == "City")
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

            return Json(DMF.ProductTags("tag", 0));


        }

        [HttpPost]
        public ActionResult AddToFavorite(int Id, int CustomerId)
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
            if (db.Select("SELECT [CustomerId],[ProductId] FROM [tbl_Customer_Favorites] where [CustomerId]=@UId AND ProductId=@ProId", parss).Rows.Count == 0)
            {
                db.Script("INSERT INTO [tbl_Customer_Favorites]([CustomerId],[ProductId])VALUES(@UId,@ProId)", parss);
                db.DC();
                return Content("1");
            }
            else
            {
                db.Script("DELETE FROM [tbl_Customer_Favorites]WHERE CustomerId=@UId AND ProductId=@ProId", parss);
                db.DC();
                return Content("0");
            }
        }

        [HttpPost]
        public ActionResult SmsRegister(string MobileNum, string Pass)
        {
            PDBC db = new PDBC("PandaMarketCMS", true);
            db.Connect();
            if (Convert.ToInt32(db.Select("SELECT COUNT(*) FROM [tbl_Customer_Main] WHERE C_Mobile LIKE N'" + MobileNum + "' AND C_ISActivate=1").Rows[0][0]) == 0) 
            {
                db.Script("DELETE FROM [tbl_Customer_Main] WHERE C_Mobile=" + MobileNum);
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
                int UserId = Convert.ToInt32(db.Script("INSERT INTO [tbl_Customer_Main] OUTPUT inserted.id_Customer VALUES(GETDATE(),@Mobile,N'',N'',N'',0,0,NULL,@PassWord,N'')", parss));
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

                string result = db.Script("INSERT INTO [tbl_sms_ir_CustomerKeys]([id_Customer],[sms_irKeyType],[sms_irSentKey],[sms_irKeyGeneratedDate],[sms_irIsKeyAlive]) VALUES(@id_Customer ,@sms_irKeyType ,@sms_irSentKey ,GETDATE(),@sms_irIsKeyAlive)", parss);
                SMS_ir sms = new SMS_ir();
                db.DC();
                return Json(sms.SendVerificationCodeWithTemplate(UserId, "VelvetRegister", 2));
            }
            else
            {
                db.DC();
                return Content("Reapited Num");
            }


        }

        public ActionResult CheckCode(int UId, string Code)
        {
            PDBC db = new PDBC("PandaMarketCMS", true);
            db.Connect();

            DataTable dt = db.Select("SELECT [C_ActivationToken] FROM [tbl_Customer_Main] where id_Customer = " + UId);
            if (dt.Rows.Count != 0)
            {
                string token = dt.Rows[0][0].ToString();
                if (token == Code)
                {
                    db.DC();
                    return Content("Success");
                }
                else
                {
                    db.DC();
                    return Content("Wrong Code");
                }
            }
            else
            {
                db.DC();
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
        public ActionResult AddComment_Product(int ProId, string Email, string Name, string Message)
        {
            string CustomerId = "0";
            if (HttpContext.Request.Cookies[StaticLicense.LicName + "Active"] != null)
            {
                string SSSession = "";
                HttpCookie cookie = HttpContext.Request.Cookies.Get(StaticLicense.LicName + "Active");
                if (cookie != null)
                {
                    Encryption ENC = new Encryption();
                    SSSession = ENC.DecryptText(cookie.Value, "OMD_Token");
                    ActivationModel act = JsonConvert.DeserializeObject<ActivationModel>(SSSession);
                    CustomerId = act.CustomerId;
                }
            }



            PDBC db = new PDBC("PandaMarketCMS", true);

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
            parss.Add(par);
            par = new ExcParameters()
            {
                _KEY = "@Name",
                _VALUE = Name
            };
            parss.Add(par); 
            par = new ExcParameters()
            {
                _KEY = "@Message",
                _VALUE = Message
            };
            parss.Add(par);
            
            par = new ExcParameters()
            {
                _KEY = "@CustomerId",
                _VALUE = CustomerId
            };
            parss.Add(par);
            db.Connect();
            string result = db.Script("INSERT INTO [tbl_Product_Comment]VALUES(@Email,@Name,N'',@Message,@ProId,GETDATE(),@CustomerId)", parss);
            db.DC();
            if (result == "1")
            {

                return Content("Success");
            }
            else
            {
                return Content("NOSuccess");
            }
        }

        [HttpPost]
        public ActionResult GetMPCs(int id)
        {
            D_APIModelFiller DMF = new D_APIModelFiller();
            return Json(DMF.MPCs(id));
        }

        public ActionResult Add_ShoppingCart(int proId, int CustomerId, int number, int FactorId)
        {
            PDBC db = new PDBC("PandaMarketCMS", true);
            Encryption ENC = new Encryption();
            if (FactorId == 0)
            {
                List<ExcParameters> parss = new List<ExcParameters>();
                ExcParameters par = new ExcParameters()
                {
                    _KEY = "@CustomerId",
                    _VALUE = CustomerId
                };
                parss.Add(par);

                db.Connect();
                var FactorId_ = Convert.ToInt32(db.Script("INSERT INTO [tbl_FACTOR_Main] output inserted.Factor_Id VALUES(@CustomerId,0,GetDate(),'',NULL,0,0,0,0,0,0,0,'','')", parss));
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
                    Id = FactorId_
                };


                parss = new List<ExcParameters>();
                par = new ExcParameters()
                {
                    _KEY = "@price",
                    _VALUE = price * number
                };
                parss.Add(par);

                par = new ExcParameters()
                {
                    _KEY = "@FactorId",
                    _VALUE = FactorId_
                };
                parss.Add(par);

                if (price != 0)
                {
                    db.Script("UPDATE [tbl_FACTOR_Main] SET [toality] =@price  WHERE Factor_Id=@FactorId", parss);
                }

                Factor.Items = Convert.ToInt32(db.Select("SELECT COUNT(*) FROM [tbl_FACTOR_Items] where FactorId=@FactorId", parss).Rows[0][0]);
                Factor.totality = price;
                db.DC();
                return Content(ENC.EncryptText(Newtonsoft.Json.JsonConvert.SerializeObject(Factor), "OMD_FACTOR"));
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
                db.Connect();
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
                if (Price.Rows.Count != 0)
                {
                    totality = long.Parse(Price.Rows[0][0].ToString());
                }

                if (price != 0)
                {

                    par = new ExcParameters()
                    {
                        _KEY = "@price",
                        _VALUE = (price * number) + totality
                    };
                    parss.Add(par);

                    db.Script("UPDATE [tbl_FACTOR_Main] SET [toality] =@price  WHERE Factor_Id=@FactorId", parss);
                }

                Factor.Items = Convert.ToInt32(db.Select("SELECT COUNT(*) FROM [tbl_FACTOR_Items] where FactorId=@FactorId", parss).Rows[0][0]);
                Factor.totality = ((price * number) + totality);
                db.DC();
                return Content(ENC.EncryptText(Newtonsoft.Json.JsonConvert.SerializeObject(Factor), "OMD_FACTOR"));
            }
        }


        public ActionResult DecryptFactor(string str)
        {
            Encryption ENC = new Encryption();
            return Content(ENC.DecryptText(str, "OMD_FACTOR"));
        }

        public ActionResult ContactUsMessage(string Name, string Email, string Subject, string Message)
        {
           // PDBC db = new PDBC("PandaMarketCMS", true);
            List<ExcParameters> parss = new List<ExcParameters>();
            ExcParameters par = new ExcParameters()
            {
                _KEY = "@Name",
                _VALUE = Name
            };
            parss.Add(par);

            par = new ExcParameters()
            {
                _KEY = "@Email",
                _VALUE = Email
            };
            parss.Add(par);

            par = new ExcParameters()
            {
                _KEY = "@Subject",
                _VALUE = Subject
            };
            parss.Add(par);

            par = new ExcParameters()
            {
                _KEY = "@Message",
                _VALUE = Message
            };
            parss.Add(par);

            return Content("Success");
        }

        public ActionResult AddFactor(string Name, string familly, int cityId, int factorId, string Address, string Email, string Phonenum, string CodePosti, string PaymentToken, string PaymentSerial, int CustomerId, string depositMoney,string AddressSelect)
        {
            PDBC db = new PDBC("PandaMarketCMS", true);
           
            List<ExcParameters> parss = new List<ExcParameters>();
            ExcParameters par = new ExcParameters()
            {
                _KEY = "@Name",
                _VALUE = Name
            };
            parss.Add(par);

            par = new ExcParameters()
            {
                _KEY = "@familly",
                _VALUE = familly
            };
            parss.Add(par);

            par = new ExcParameters()
            {
                _KEY = "@CustomerId",
                _VALUE = CustomerId
            };
            parss.Add(par);

            par = new ExcParameters()
            {
                _KEY = "@Phonenum",
                _VALUE = Phonenum
            };
            parss.Add(par);

            par = new ExcParameters()
            {
                _KEY = "@Email",
                _VALUE = Email
            };
            parss.Add(par);

            db.Connect();

            db.Script("UPDATE [tbl_Customer_Main]SET [C_Mobile] = @Phonenum,[C_FirstName] =@Name ,[C_LastNAme] =@familly ,[C_ISActivate] = 1 ,[C_Email] =@Email  WHERE id_Customer=@CustomerId", parss);

            parss = new List<ExcParameters>();
            par = new ExcParameters()
            {
                _KEY = "@cityId",
                _VALUE = cityId
            };
            parss.Add(par);

            par = new ExcParameters()
            {
                _KEY = "@Address",
                _VALUE = Address
            };
            parss.Add(par);

            par = new ExcParameters()
            {
                _KEY = "@CodePosti",
                _VALUE = CodePosti
            };
            parss.Add(par);

            par = new ExcParameters()
            {
                _KEY = "@CustomerId",
                _VALUE = CustomerId
            };
            parss.Add(par);

            string AddresId;
            if (AddressSelect=="0")
            {
                AddresId = db.Script("INSERT INTO [tbl_Customer_Address] output inserted.id_CAddress VALUES( @CustomerId ,@cityId ,@CodePosti,@Address)", parss);

            }else
            {
                AddresId = AddressSelect;
            }


            parss = new List<ExcParameters>();
            par = new ExcParameters()
            {
                _KEY = "@AddresId",
                _VALUE = AddresId
            };
            parss.Add(par);
            par = new ExcParameters()
            {
                _KEY = "@factorId",
                _VALUE = factorId
            };
            parss.Add(par);
            par = new ExcParameters()
            {
                _KEY = "@PaymentToken",
                _VALUE = PaymentToken
            };
            parss.Add(par);
            par = new ExcParameters()
            {
                _KEY = "@PaymentSerial",
                _VALUE = PaymentSerial
            };
            parss.Add(par);
            par = new ExcParameters()
            {
                _KEY = "@depositMoney",
                _VALUE = depositMoney
            };
            parss.Add(par);

            db.Script("UPDATE [tbl_FACTOR_Main] SET[AddressId] = @AddresId,[date] = GetDate(),[deposit_price] = @depositMoney,[Done] = 1,[PaymentSerial] = @PaymentSerial ,[PaymentToken] =@PaymentToken WHERE Factor_Id=@factorId", parss);
            db.DC();
            return Content("Success");
        }

        public ActionResult deleteItem(int itemId)
        {
            PDBC db = new PDBC("PandaMarketCMS", true);
            db.Connect();
            DataTable dt = db.Select("SELECT (A.PriceOff*B.number) AS totality ,B.FactorId FROM [tbl_Product_PastProductHistory] AS A INNER JOIN [tbl_FACTOR_Items] AS B ON A.id_PPH=B.PriceDateId where B.ItemId=" + itemId);
            if (dt.Rows.Count != 0)
            {
                long totality_item = long.Parse(dt.Rows[0]["totality"].ToString());
                string FactorId = dt.Rows[0]["FactorId"].ToString();
                long totality = long.Parse(db.Select("SELECT [toality] FROM [tbl_FACTOR_Main] WHERE Factor_Id=" + FactorId).Rows[0]["toality"].ToString());

                db.Script("UPDATE [tbl_FACTOR_Main]SET [toality] =" + (totality - totality_item) + " WHERE Factor_Id=" + FactorId);
                db.Script("DELETE FROM [tbl_FACTOR_Items] WHERE ItemId=" + itemId);
                db.DC();
                return Content("Success");
            }
            else
            {
                db.DC();
                return Content("There Isnt any row with this item");
            }

        }

        public ActionResult AddCustomerAddress(int cityId, string Address,string CodePosti)
        {


            if (HttpContext.Request.Cookies[StaticLicense.LicName + "Active"] != null)
            {
                string SSSession = "";
                HttpCookie cookie = HttpContext.Request.Cookies.Get(StaticLicense.LicName + "Active");
                if (cookie != null)
                {
                    Encryption ENC = new Encryption();
                    SSSession = ENC.DecryptText(cookie.Value, "OMD_Token");
                    ActivationModel act = JsonConvert.DeserializeObject<ActivationModel>(SSSession);

                    PDBC db = new PDBC("PandaMarketCMS", true);
                    db.Connect();
                    List<ExcParameters> parss = new List<ExcParameters>();

                    ExcParameters par = new ExcParameters()
                    {
                        _KEY = "@cityId",
                        _VALUE = cityId
                    };
                    parss.Add(par);

                    par = new ExcParameters()
                    {
                        _KEY = "@Address",
                        _VALUE = Address
                    };
                    parss.Add(par);

                    par = new ExcParameters()
                    {
                        _KEY = "@CodePosti",
                        _VALUE = CodePosti
                    };
                    parss.Add(par);

                    par = new ExcParameters()
                    {
                        _KEY = "@CustomerId",
                        _VALUE = act.CustomerId
                    };
                    parss.Add(par);
                    string AddresId = db.Script("INSERT INTO [tbl_Customer_Address] output inserted.id_CAddress VALUES( @CustomerId ,@cityId ,@CodePosti,@Address)", parss);
                    db.DC();

                    return Content("Success");
                }
                else
                {
                    return Content("Error");
                }
            }
            else
            {
                return Content("Login");
            }
        }

        public ActionResult UpdateCustomerData(string Name, string familly,string Email, string Phonenum)
        {
            if (HttpContext.Request.Cookies[StaticLicense.LicName + "Active"] != null)
            {
                string SSSession = "";
                HttpCookie cookie = HttpContext.Request.Cookies.Get(StaticLicense.LicName + "Active");
                if (cookie != null)
                {
                    Encryption ENC = new Encryption();
                    SSSession = ENC.DecryptText(cookie.Value, "OMD_Token");
                    ActivationModel act = JsonConvert.DeserializeObject<ActivationModel>(SSSession);

                    PDBC db = new PDBC("PandaMarketCMS", true);
                    
                    List<ExcParameters> parss = new List<ExcParameters>();
                    ExcParameters par = new ExcParameters()
                    {
                        _KEY = "@Name",
                        _VALUE = Name
                    };
                    parss.Add(par);

                    par = new ExcParameters()
                    {
                        _KEY = "@familly",
                        _VALUE = familly
                    };
                    parss.Add(par);

                    par = new ExcParameters()
                    {
                        _KEY = "@CustomerId",
                        _VALUE = act.CustomerId
                    };
                    parss.Add(par);

                    par = new ExcParameters()
                    {
                        _KEY = "@Phonenum",
                        _VALUE = Phonenum
                    };
                    parss.Add(par);
                    par = new ExcParameters()
                    {
                        _KEY = "@Email",
                        _VALUE = Email
                    };
                    parss.Add(par);

                    db.Connect();

                    db.Script("UPDATE [tbl_Customer_Main]SET [C_Mobile] = @Phonenum,[C_FirstName] =@Name ,[C_LastNAme] =@familly ,[C_ISActivate] = 1 ,[C_Email] =@Email  WHERE id_Customer=@CustomerId", parss);
                    db.DC();

                    return Content("Success");
                }
                else
                {
                    return Content("Error");
                }
            }
            else
            {
                return Content("Login");
            }
        }

        public ActionResult UpdateCustomerPass(string CurrentPass, string Pass)
        {
            if (HttpContext.Request.Cookies[StaticLicense.LicName + "Active"] != null)
            {
                string SSSession = "";
                HttpCookie cookie = HttpContext.Request.Cookies.Get(StaticLicense.LicName + "Active");
                if (cookie != null)
                {
                    Encryption ENC = new Encryption();
                    SSSession = ENC.DecryptText(cookie.Value, "OMD_Token");
                    ActivationModel act = JsonConvert.DeserializeObject<ActivationModel>(SSSession);

                    PDBC db = new PDBC("PandaMarketCMS", true);
                    
                    List<ExcParameters> parss = new List<ExcParameters>();
                    ExcParameters par = new ExcParameters()
                    {
                        _KEY = "@CurrentPass",
                        _VALUE = ENC.MD5Hash(CurrentPass)
                    };
                    parss.Add(par);

                    par = new ExcParameters()
                    {
                        _KEY = "@Pass",
                        _VALUE = ENC.MD5Hash(Pass)
                    };
                    parss.Add(par);

                    par = new ExcParameters()
                    {
                        _KEY = "@CustomerId",
                        _VALUE = act.CustomerId
                    };
                    parss.Add(par);

                    db.Connect();

                    if(Convert.ToInt32(db.Select("SELECT COUNT(*) FROM [tbl_Customer_Main] WHERE id_Customer= @CustomerId AND C_Password = @CurrentPass", parss).Rows[0][0])!=0)
                    {
                        db.Script("UPDATE [tbl_Customer_Main] SET[C_Password] =@Pass  WHERE id_Customer= @CustomerId", parss);
                        db.DC();
                        return Content("Success");
                    }else
                    {
                        db.DC();
                        return Content("WrongPass");
                    }

                }
                else
                {
                    return Content("Error");
                }
            }
            else
            {
                return Content("Login");
            }
        }
    }
}