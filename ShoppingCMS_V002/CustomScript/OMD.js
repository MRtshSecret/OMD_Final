

function setCookie(cname, cvalue, exdays) {
    var d = new Date();
    d.setTime(d.getTime() + (exdays * 24 * 60 * 60 * 1000));
    var expires = "expires=" + d.toUTCString();
    document.cookie = cname + "=" + cvalue + ";" + expires + ";path=/";
}

function getCookie(cname) {
    var name = cname + "=";
    var decodedCookie = decodeURIComponent(document.cookie);
    var ca = decodedCookie.split(';');
    for (var i = 0; i < ca.length; i++) {
        var c = ca[i];
        while (c.charAt(0) == ' ') {
            c = c.substring(1);
        }
        if (c.indexOf(name) == 0) {
            return c.substring(name.length, c.length);
        }
    }
    return "";
}


function deleteCookie(cname) {
    document.cookie = cname + "=; expires=Thu, 01 Jan 1970 00:00:00 UTC; path=/;";
}
//////cookie actions end
function Enc(str) {
    PostJson = {
        'Token': str
    };
    var res = "";
    $.ajax({
        url: '/API_Functions/EncryptOMD',
        type: "post",
        data: JSON.stringify(PostJson),
        contentType: "application/json; charset=utf-8",
        success: function (response) {
            res = response;

            setCookie("OMD_Active", res, 30);
        },
        error: function (jqXHR, textStatus, errorThrown) {
            alert(textStatus);

        }
    });
    return res;
}

function Dec(str) {

    PostJson = {
        'Token': str
    };
    var result = "";
    $.ajax({
        url: '/API_Functions/DecryptOMD',
        type: "post",
        data: JSON.stringify(PostJson),
        contentType: "application/json; charset=utf-8",
        success: function (response) {
            result = response;
            
        },
        error: function (jqXHR, textStatus, errorThrown) {
            alert(textStatus);
            result= "";
        }
    });
    
}

function AddFavorite(ProId) {
    var cookie = getCookie("OMD_Active");
    PostJson = {
        'Token': cookie
    };

    $.ajax({
        url: '/API_Functions/DecryptOMD',
        type: "post",
        data: JSON.stringify(PostJson),
        contentType: "application/json; charset=utf-8",
        success: function (response) {
            var token = JSON.parse(response);
            if (token.Status == "Active") {
                PostJson = {
                    'Id': ProId,
                    'CustomerId': token.CustomerId
                };

                $.ajax({
                    url: '/API_Functions/AddToFavorite',
                    type: "post",
                    data: JSON.stringify(PostJson),
                    contentType: "application/json; charset=utf-8",
                    success: function (response) {
                        var res = response;
                        
                        if (res == "1") {
                            danger("مشتری عزیز", " محصول به علاقه مندی ها اضافه شد.");
                        } else if (res == "0") {
                            danger("مشتری عزیز", "محصول از علاقه مندی ها حذف شد.");
                        }
                    },
                    error: function (jqXHR, textStatus, errorThrown) {
                        alert(textStatus);
                        return "";
                    }
                });
            } else {
                danger("مشتری عزیز", "لطفا ابتدا وارد حساب کاربری خود شوید");

            }

        },
        error: function (jqXHR, textStatus, errorThrown) {
            alert(textStatus);
            result = "";
        }
    });

    return false;
}


function AddComment(ProId) {
    
    var Name = $('#Com_Name').val();
    var Email = $('#Com_Email').val();
    var Message = $('#Com_Mess').val();
   // alert(ProId + Name + Email + Message);
        PostJson = {
            'ProId': ProId,
            'Email': Email,
            'Name': Name,
            'Message': Message
        };

        $.ajax({
            url: '/API_Functions/AddComment_Product',
            type: "post",
            data: JSON.stringify(PostJson),
            contentType: "application/json; charset=utf-8",
            success: function (response) {
               
                $('#Com_Name').val("");
                $('#Com_Email').val("");
                $('#Com_Mess').val("");
            },
            error: function (jqXHR, textStatus, errorThrown) {
                alert(textStatus);
                
            }
        });

        return false;
}

function PlusCount() {

    $('#Counter_inp').val(+$('#Counter_inp').val() + 1);

    return false;
}

function MinusCount() {

    $('#Counter_inp').val($('#Counter_inp').val() - 1);

    return false;
}
/////MyAccount
function SendCode() {
    var MobileNum = $('#CMobile').val();
    var Pass1 = $('#CPass1').val();
    var pass2 = $('#CPass2').val();
    if (MobileNum != "" && Pass1 != "" && pass2 != "") {
        if (Pass1 == pass2) {

            $('#SendCodeBtn').attr("disabled", true);

            setTimeout(function () { $('#SendCodeBtn').attr("disabled", false); }, 60000);

            PostJson = {
                'MobileNum': MobileNum,
                'Pass': Pass1
            };



            $.ajax({
                url: '/API_Functions/SmsRegister',
                type: "post",
                data: JSON.stringify(PostJson),
                contentType: "application/json; charset=utf-8",
                success: function (response) {
                    if (response == "Reapited Num") {
                        $('#SendCodeBtn').attr("disabled", false);
                        danger("مشتری عزیز", "حساب کاربری با این شماره موجود است.");
                    } else {
                        
                        

                        var Token = response;
                        if (Token.StatusCode == "smsX:200OK") {
                            danger("مشتری عزیز", "پیامک با موفقیت ارسال شد");
                            $('#Id_UUU').text(Token.CustomerId);
                            $('#NewAcc').hide();
                            $('#CodeDiv').show();

                        } else {
                            danger("مشتری عزیز", "در پروسه ی ارسال پیامک مشکلی ایجاد شده ، لطفا بعد از 60 ثانیه دوباره تلاش کنید");
                            console.log(Token);
                        }
                    }
                },
                error: function (jqXHR, textStatus, errorThrown) {
                    alert(textStatus);
                }
            });
        } else {
            
            danger("مشتری عزیز", "مقدار دو رمز عبور یکسان نیست");
        }
    } else {
        
        danger("مشتری عزیز", "لطفا مقدار ورودی را پر کنید");
    }



}

function CheckCode() {
    var Id = $('#Id_UUU').text();
    var Code = $('#C_Token').val();
    PostJson = {
        'UId': Id,
        'Code': Code
    };

    $.ajax({
        url: '/API_Functions/CheckCode',
        type: "post",
        data: JSON.stringify(PostJson),
        contentType: "application/json; charset=utf-8",
        success: function (response) {
            var Token = response;
            if (Token == "Success") {

                danger("مشتری عزیز", "ثبت نام شما با موفقیت انجام شد");
                Enc(Id);
                $('#miniFactor_divM').show();
                $('#NewAcc').hide();
                $('#CodeDiv').hide();

            } else if (Token == "Wrong Code") {

                
                danger("مشتری عزیز", "کد وارد شده اشتباه است . دوباره تلاش کنید");
                $('#C_Token').val("");
            } else {
                
                danger("مشتری عزیز", "مشکلی در پروسه ی ثبت نام ایجاد شده ، لطفادوباره تلاش کنید");
                $('#NewAcc').show();
                $('#CodeDiv').hide();
            }
        },
        error: function (jqXHR, textStatus, errorThrown) {
            alert(textStatus);
        }
    });

}

function NewAccount() {

    $('#NewAcc').show();
    $('#Log').hide();
    return false;
}

function AddToShoppingCart() {
    var ProId = $('#MPC_Id').text();
    var cookie = getCookie("OMD_Active");
    PostJson = {
        'Token': cookie
    };

    $.ajax({
        url: '/API_Functions/DecryptOMD',
        type: "post",
        data: JSON.stringify(PostJson),
        contentType: "application/json; charset=utf-8",
        success: function (response) {
            var token = JSON.parse(response);
            if (token.Status == "Active") {

                if (getCookie("OMD_Factor") == "") {
                    PostJson = {
                        'proId': ProId,
                        'CustomerId': token.CustomerId,
                        'FactorId': 0,
                        'number': $('#Counter_inp').val()
                    };

                    $.ajax({
                        url: '/API_Functions/Add_ShoppingCart',
                        type: "post",
                        data: JSON.stringify(PostJson),
                        contentType: "application/json; charset=utf-8",
                        success: function (response) {
                            var res = response;
                            setCookie("OMD_Factor", response, 2);
                        },
                        error: function (jqXHR, textStatus, errorThrown) {
                            alert(textStatus);
                            return "";
                        }
                    });
                } else {

                    var Cookie = getCookie("OMD_Factor");

                    PostJson1 = {
                        'str': Cookie
                    };

                    $.ajax({
                        url: '/API_Functions/DecryptFactor',
                        type: "post",
                        data: JSON.stringify(PostJson1),
                        contentType: "application/json; charset=utf-8",
                        success: function (response) {
                            var res = JSON.parse(response);

                            PostJson = {
                                'proId': ProId,
                                'CustomerId': token.CustomerId,
                                'FactorId': res.Id,
                                'number': $('#Counter_inp').val()
                            };

                            $.ajax({
                                url: '/API_Functions/Add_ShoppingCart',
                                type: "post",
                                data: JSON.stringify(PostJson),
                                contentType: "application/json; charset=utf-8",
                                success: function (response) {
                                    var res = response;
                                    deleteCookie("OMD_Factor");
                                    setCookie("OMD_Factor", response, 2);
                                },
                                error: function (jqXHR, textStatus, errorThrown) {
                                    alert(textStatus);
                                    return "";
                                }
                            });



                        },
                        error: function (jqXHR, textStatus, errorThrown) {
                            alert(textStatus);
                            return "";
                        }
                    });

                }


                
            } else {
                danger("مشتری عزیز", "لطفا ابتدا وارد حساب کاربری خود شوید.");

            }

        },
        error: function (jqXHR, textStatus, errorThrown) {
            alert(textStatus);
            result = "";
        }
    });
    MsterFactor();
    setTimeout(function () {
        var factorId = $('#Master_miniFactorId').text();
        const url = $("#URLFactor").val() + factorId;
        $('#popup-cart').load(url);
    }, 200);
    return false;
}

function MsterFactor() {
    var Cookie = getCookie("OMD_Factor");
    if (Cookie == "") {
        $('#miniFactor_divM').hide();
    } else {
        PostJson1 = {
            'str': Cookie
        };
        $.ajax({
            url: '/API_Functions/DecryptFactor',
            type: "post",
            data: JSON.stringify(PostJson1),
            contentType: "application/json; charset=utf-8",
            success: function (response) {
                var res = JSON.parse(response);
                var text1 = res.Items + " عدد  " + res.totality+" تومان "
                $('#Master_miniFactor').text(text1);
                $('#Master_miniFactorId').text(res.Id);

            },
            error: function (jqXHR, textStatus, errorThrown) {
                alert(textStatus);
                return "";
            }
        });

    }

    return false;
}


function ContactUsMessage()
{

    var Name = $('#name').val();
    var Email = $('#email').val();
    var Subject = $('#subject').val();
    var Message = $('#input-message').val();

    if (Name == "" || Email == "" || Subject == "" || Message == "") {

        danger("مشتری عزیز", "لطفا همه ی مقادیر ورودی را پر کنید");
    } else {

        PostJson1 = {
            'Name': Name,
            'Email': Email,
            'Subject': Subject,
            'Message': Message
        };

        $.ajax({
            url: '/API_Functions/ContactUsMessage',
            type: "post",
            data: JSON.stringify(PostJson1),
            contentType: "application/json; charset=utf-8",
            success: function (response) {
                if (response == "Success") {
                    
                    danger("مشتری عزیز", "پیام شما با موفقیت ثبت شد !");

                    $('#name').val("");
                    $('#email').val("");
                    $('#subject').val("");
                    $('#input-message').val("");
                }
               

            },
            error: function (jqXHR, textStatus, errorThrown) {
                alert(textStatus);
                return "";
            }
        });

    }

    return false;
}

function login() {

    var MobileNum = $('#CMobile1').val();
    var Pass1 = $('#CPass11').val();
    
    if (MobileNum != "" && Pass1 != "" ) {

            PostJson = {
                'MobileNum': MobileNum,
                'pass': Pass1
            };


            $.ajax({
                url: '/D_API/login2',
                type: "post",
                data: JSON.stringify(PostJson),
                contentType: "application/json; charset=utf-8",
                success: function (response) {
                    
                    if (response == "Wrong value") {
                        danger("مشتری عزیز", "شماره موبایل یا رمز عبور اشتباه است");
                    } else {
                        
                        setCookie("OMD_Active", response, 30);
                        danger("مشتری عزیز", "وارد حساب کاربری خود شدید");
                        $('#Log').hide();
                        location.reload(true);
                    }
                },
                error: function (jqXHR, textStatus, errorThrown) {
                    alert(textStatus);
                }
            });
        
        
    } else {
        danger("مشتری عزیز", "لطفا مقدار ورودی را پر کنید");
    }
}


function danger(title, body) {
    $(".modal-header").css({ "background-color": "#dc3545" });
    $(".modal-title").text(title);
    $(".modal-body").text(body);
    setTimeout(function () {
        $("#modal").modal();
    },
        200);
    
}

