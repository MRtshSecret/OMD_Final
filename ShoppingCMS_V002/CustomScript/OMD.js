

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

    $.ajax({
        url: '/API_Functions/DecryptOMD',
        type: "post",
        data: JSON.stringify(PostJson),
        contentType: "application/json; charset=utf-8",
        success: function (response) {
            var res = response;
            return res;
        },
        error: function (jqXHR, textStatus, errorThrown) {
            alert(textStatus);
            return "";
        }
    });
}

function CheckActive() {
    var cookie = getCookie("OMD_Active");
    if (cookie == "") {
        return 0;
    } else {
        var token = JSON.parse(Dec(cookie));
        if (token.Status == 'Active') {
            return 1;
        } else {
            return 2;
        }
    }

}

function GetId() {
    var cookie = getCookie("OMD_Active");

        var token = JSON.parse(Dec(cookie));
    if (token.Status == 'Active') {
        return token.CustomerId;
    } else {
        return "";
    }
    
}

function AddFavorite(ProId) {
    if (CheckActive == 1) {

        PostJson = {
            'Id': ProId,
            'CustomerId': GetId()
        };

        $.ajax({
            url: '/API_Functions/AddToFavorite',
            type: "post",
            data: JSON.stringify(PostJson),
            contentType: "application/json; charset=utf-8",
            success: function (response) {
                var res = response;
                if (res == "1") {
                    alert(" محصول به علاقه مندی ها اضافه شد.");
                } else if (res == "0") {
                    alert(" محصول از علاقه مندی ها حذف شد.");
                }
            },
            error: function (jqXHR, textStatus, errorThrown) {
                alert(textStatus);
                return "";
            }
        });

    } else {
        alert(" لطفا ابتدا وارد حساب کاربری خود شوید.");
    }
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



