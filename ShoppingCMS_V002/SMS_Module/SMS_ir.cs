using ShoppingCMS_V002.DBConnect;
using SmsIrRestful;
using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;

namespace ShoppingCMS_V002.SMS_Module
{
    public class SMS_ir
    {
        //for Register ==> 
        // TemplateToken : "VelvetRegister"
        // SMSForWichStatus : 2
        public SMS_ir_Status SendVerificationCodeWithTemplate(int UserID, string TemplateToken, int SMSForWichStatus)
        {
            PDBC db = new PDBC("PandaMarketCMS", true);
            db.Connect();
            using (DataTable dt = db.Select("SELECT [sms_irUserAPIKey] ,[sms_irSecretKey] FROM  [tbl_sms_ir_APIvals]"))
            {

                if (dt.Rows.Count > 0)
                {
                    var token = new Token().GetToken(dt.Rows[0]["sms_irUserAPIKey"].ToString(), dt.Rows[0]["sms_irSecretKey"].ToString());
                    List<ExcParameters> parss = new List<ExcParameters>();
                    ExcParameters par = new ExcParameters()
                    {
                        _KEY = "@id_Customer",
                        _VALUE = UserID
                    };
                    parss.Add(par);
                    par = new ExcParameters()
                    {
                        _KEY = "@sms_irKeyType",
                        _VALUE = SMSForWichStatus
                    };
                    parss.Add(par);
                    using (DataTable dtUser = db.Select("SELECT TOP(1) [sms_irSentKeyID] ,[id_Customer] ,[sms_irKeyType] ,[sms_irSentKey] ,[sms_irKeyGeneratedDate]  ,[sms_irIsKeyAlive]  FROM  [tbl_sms_ir_CustomerKeys] WHERE [id_Customer] = @id_Customer AND sms_irKeyType = @sms_irKeyType AND [sms_irIsKeyAlive] = 1 ORDER BY sms_irSentKeyID DESC", parss))
                    {
                        if (dtUser.Rows.Count > 0)
                        {
                            double RemainingDate =
                                (DateTime.Now - DateTime.Parse(dtUser.Rows[0]["sms_irKeyGeneratedDate"].ToString()))
                                .TotalSeconds;
                            if (RemainingDate < 60)
                            {
                                parss = new List<ExcParameters>();
                                par = new ExcParameters()
                                {
                                    _KEY = "@id_Customer",
                                    _VALUE = UserID
                                };
                                parss.Add(par);
                                using (DataTable UserStructure = db.Select("SELECT  [id_Customer] ,[C_regDate] ,[C_Mobile] ,[C_FirstName] ,[C_LastNAme]  FROM [tbl_Customer_Main] WHERE [id_Customer] = @id_Customer", parss))
                                {
                                    if (dt.Rows.Count > 0)
                                    {
                                        parss = new List<ExcParameters>();
                                        par = new ExcParameters()
                                        {
                                            _KEY = "@TemplatePandaToken",
                                            _VALUE = TemplateToken
                                        };
                                        parss.Add(par);
                                        using (DataTable dtTemplateToken = db.Select("SELECT  [sms_irTemplate] ,[sms_irMessageType] ,[sms_irTemplateAPIKey] ,[TemplatePandaToken] FROM  [tbl_sms_ir_Template] WHERE [TemplatePandaToken] LIKE @TemplatePandaToken", parss))
                                        {
                                            if (dtTemplateToken.Rows.Count > 0)
                                            {
                                                string ssdd = long.Parse(UserStructure.Rows[0]["C_Mobile"].ToString()).ToString();
                                                string UserFullName = $"{UserStructure.Rows[0]["C_FirstName"].ToString()} {UserStructure.Rows[0]["C_LastNAme"].ToString()}";
                                                var ultraFastSend = new UltraFastSend()
                                                {
                                                    Mobile = long.Parse(UserStructure.Rows[0]["C_Mobile"].ToString()),
                                                    TemplateId = Int32.Parse(dtTemplateToken.Rows[0]["sms_irTemplateAPIKey"].ToString()),
                                                    ParameterArray = new List<UltraFastParameters>()
                {
                    new UltraFastParameters()
                    {
                        Parameter = "FullName" , ParameterValue = UserFullName
                    },
                    new UltraFastParameters()
                    {
                        Parameter = "Verify" , ParameterValue = dtUser.Rows[0]["sms_irSentKey"].ToString()
                    }
                }.ToArray()

                                                };
                                                UltraFastSendRespone ultraFastSendRespone = new UltraFast().Send(token, ultraFastSend);
                                                if (ultraFastSendRespone.IsSuccessful)
                                                {

                                                    parss = new List<ExcParameters>();
                                                    par = new ExcParameters()
                                                    {
                                                        _KEY = "@C_ActivationToken",
                                                        _VALUE = dtUser.Rows[0]["sms_irSentKey"].ToString()
                                                    };
                                                    parss.Add(par);
                                                    par = new ExcParameters()
                                                    {
                                                        _KEY = "@id_Customer",
                                                        _VALUE = UserID
                                                    };
                                                    parss.Add(par);
                                                    string RESult = db.Script(
                                                        "UPDATE [dbo].[tbl_Customer_Main] SET [C_ActivationToken] = @C_ActivationToken WHERE [id_Customer] = @id_Customer",
                                                        parss);
                                                    if (RESult == "1")
                                                    {

                                                        return new SMS_ir_Status()
                                                        {
                                                            StatusCode = "smsX:200OK",
                                                            StatusMessage = $"SMS SENT ultraFastSendRespone.IsSuccessful == {ultraFastSendRespone.IsSuccessful} AND ultraFastSendRespone.Message == {ultraFastSendRespone.Message} AND ultraFastSendRespone.VerificationCodeId == {ultraFastSendRespone.VerificationCodeId}",
                                                            StatusReturnedTime = DateTime.Now.ToString(),
                                                            CustomerId = UserID
                                                        };
                                                    }
                                                    else
                                                    {
                                                        return new SMS_ir_Status()
                                                        {
                                                            StatusCode = "smsX:407",
                                                            StatusMessage = $"SMS SENT ultraFastSendRespone.IsSuccessful == {ultraFastSendRespone.IsSuccessful} AND ultraFastSendRespone.Message == {ultraFastSendRespone.Message} AND ultraFastSendRespone.VerificationCodeId == {ultraFastSendRespone.VerificationCodeId} BUT THERE IS ERROR IN Our CMS =={RESult}",
                                                            StatusReturnedTime = DateTime.Now.ToString(),
                                                            CustomerId = UserID
                                                        };
                                                    }
                                                }
                                                else
                                                {
                                                    return new SMS_ir_Status()
                                                    {
                                                        StatusCode = "smsX:406",
                                                        StatusMessage = $"CannotSendSMS Error From SMS.ir API ultraFastSendRespone.Message == {ultraFastSendRespone.Message}",
                                                        StatusReturnedTime = DateTime.Now.ToString(),
                                                        CustomerId = UserID
                                                    };

                                                }
                                            }
                                            else
                                            {
                                                return new SMS_ir_Status()
                                                {
                                                    StatusCode = "smsX:405",
                                                    StatusMessage = $"SMS Template NotFound 404 TemplateToken : {TemplateToken}",
                                                    StatusReturnedTime = DateTime.Now.ToString(),
                                                    CustomerId=UserID
                                                };

                                            }
                                        }
                                    }
                                    else
                                    {
                                        return new SMS_ir_Status()
                                        {
                                            StatusCode = "smsX:404",
                                            StatusMessage = "User NotFound By id_Customer",
                                            StatusReturnedTime = DateTime.Now.ToString(),
                                            CustomerId = UserID
                                        };
                                    }
                                }
                            }
                            else
                            {
                                return new SMS_ir_Status()
                                {
                                    StatusCode = "smsX:403",
                                    StatusMessage = "KeyExpired (Time Remaining is in Parameter[StatusReturnedTime] in (Secend))",
                                    StatusReturnedTime = RemainingDate.ToString(),
                                    CustomerId = UserID
                                };
                            }
                        }
                        else
                        {
                            return new SMS_ir_Status()
                            {
                                StatusCode = "smsX:402",
                                StatusMessage = "CannotFindUserFrom[tbl_sms_ir_CustomerKeys]",
                                StatusReturnedTime = new DateTime().ToString(),
                                CustomerId = UserID
                            };
                        }
                    }
                }
                else
                {
                    return new SMS_ir_Status()
                    {
                        StatusCode = "smsX:401",
                        StatusMessage = "CannotFindSMSAPITokensFrom[tbl_sms_ir_APIvals]",
                        StatusReturnedTime = new DateTime().ToString(),
                        CustomerId = UserID
                    };
                }

            }
        }


    }
}
