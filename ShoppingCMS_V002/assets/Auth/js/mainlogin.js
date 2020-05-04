$("#loginButton").on('click', function (e) {
    e.preventDefault();
    $('.login').addClass('test')
    setTimeout(function () {
        $('.login').addClass('testtwo')
    }, 300);
    setTimeout(function () {
        $(".authent").show().animate({ right: -320 }, { easing: 'easeOutQuint', duration: 600, queue: false });
        $(".authent").animate({ opacity: 1 }, { duration: 200, queue: false }).addClass('visible');
    }, 350);
    var AddressToSend = $("#Lurl").val();

    var username = $("#usernametxt").val();
    var password = $("#passwordtxt").val();
    var PostJson = {
        'un': username,
        'pw': password
    };
    $.ajax({
        url: AddressToSend,
        type: "post",
        data: JSON.stringify(PostJson),
        contentType: "application/json; charset=utf-8",
        success: function (response) {

            try {
                if (response.d == "1") {
                    console.log("sdad");
                    console.log(response.d);
                    $("#successh2").text("ورود با موفقیت انجام شد");
                    $("#successp").text("تا لحظاتی دیگر به صفحه مورد نظر راهنمایی خواهید شد");
                    $("#successh22").text("ورود شما به مدت 60 دقیقه پایدار خواهد بود");

                    setTimeout(function () {
                        $(".authent").show().animate({ right: 90 },
                            { easing: 'easeOutQuint', duration: 600, queue: false });
                        $(".authent").animate({ opacity: 1 }, { duration: 200, queue: false }).addClass('visible');
                        $('#Authenn').attr("style", "display:none!important");

                        $('.login').removeClass('testtwo')
                    },
                        2500);
                    setTimeout(function () {
                        $('.login').removeClass('test')
                        $('.login div').fadeOut(123);
                    },
                        2800);
                    setTimeout(function () {
                        $('.success').fadeIn();

                    },
                        3200);

                    setTimeout(function () {
                        $('.success').fadeOut(123);
                        $('.login div').fadeIn(123);
                        $('#error').fadeOut();
                        window.location.replace($("#redAd").val());
                    },
                        10000);
                    
                }
            } catch (e) {

            }
            try {
                console.log(response);
                var responseobj = jQuery.parseJSON(response);
                if (responseobj.StatusCode == "777" || responseobj.StatusCode == "776") {
                    console.log("MRM1");
                    var responseobj = jQuery.parseJSON(response);
                    $("#successh2").text(responseobj.StatusMessage);
                    $("#successp").text("خوش آمدید" +
                        responseobj.ObjectMessage.ad_firstname +
                        " " +
                        responseobj.ObjectMessage.ad_lastname);
                    $("#successh22").text("");
                    $("#Authenn").css("background", "linear-gradient(45deg, #54d988 0%, #1f222e 100%)");

                    setTimeout(function() {
                            $(".authent").show().animate({ right: 90 },
                                { easing: 'easeOutQuint', duration: 600, queue: false });
                            $(".authent").animate({ opacity: 1 }, { duration: 200, queue: false }).addClass('visible');
                            $('#Authenn').attr("style", "display:none!important");

                            $('.login').removeClass('testtwo');
                        },
                        2500);
                    setTimeout(function() {
                            $('.login').removeClass('test');
                            $('.login div').fadeOut(123);
                        },
                        2800);
                    setTimeout(function() {
                            $('.success').fadeIn();
                        },
                        3200);

                    setTimeout(function() {
                            $('.success').fadeOut(123);
                            $('.login div').fadeIn(123);
                            $('#error').fadeOut();
                            window.location.replace($("#redAd").val());
                        },
                        10000);

                } else {
                    console.log("missing");
                    $("#successh2").text(responseobj.StatusMessage);
                    $("#successp").text("متاسفانه شما قادر به ورود نخواهید بود");
                    $("#successh22").text("");
                    $("#Authenn").css("background", "linear-gradient(45deg, #b00 0%, #1f222e 100%)");

                    setTimeout(function () {
                            $(".authent").show().animate({ right: 90 },
                                { easing: 'easeOutQuint', duration: 600, queue: false });
                            $(".authent").animate({ opacity: 1 }, { duration: 200, queue: false }).addClass('visible');
                            $('#Authenn').attr("style", "display:none!important");

                            $('.login').removeClass('testtwo');
                        },
                        2500);
                    setTimeout(function () {
                            $('.login').removeClass('test');
                            $('.login div').fadeOut(123);
                        },
                        2800);
                    setTimeout(function () {
                            $('.success').fadeIn();
                        },
                        3200);

                    setTimeout(function () {
                            $('.success').fadeOut(123);
                            $('.login div').fadeIn(123);
                        $('#error').fadeOut();
                        $("#successh2").text("");
                        $("#successp").text("");
                        $("#successh22").text("");
                           
                        },
                        10000);
                }
            } catch (e) {

            }

        },
        error: function (jqXHR, textStatus, errorThrown) {
            $("#successh2").text("خطای سمت سرور");
            $("#successp").text("متاسفانه شما قادر به ورود نخواهید بود");
            $("#successh22").text("");
            $("#Authenn").css("background", "linear-gradient(45deg, #b00 0%, #1f222e 100%)");

            setTimeout(function () {
                    $(".authent").show().animate({ right: 90 },
                        { easing: 'easeOutQuint', duration: 600, queue: false });
                    $(".authent").animate({ opacity: 1 }, { duration: 200, queue: false }).addClass('visible');
                    $('#Authenn').attr("style", "display:none!important");

                    $('.login').removeClass('testtwo');
                },
                2500);
            setTimeout(function () {
                    $('.login').removeClass('test');
                    $('.login div').fadeOut(123);
                },
                2800);
            setTimeout(function () {
                    $('.success').fadeIn();
                },
                3200);

            setTimeout(function () {
                    $('.success').fadeOut(123);
                    $('.login div').fadeIn(123);
                    $('#error').fadeOut();
                    $("#successh2").text("");
                    $("#successp").text("");
                    $("#successh22").text("");

                },
                10000);
        }
    });


});


$('#usernametxt,#passwordtxt').focus(function () {
    $(this).prev().animate({ 'opacity': '1' }, 200)
});
$('#usernametxt,#passwordtxt').blur(function () {
    $(this).prev().animate({ 'opacity': '.5' }, 200)
});
$('#usernametxt,#passwordtxt').keyup(function () {
    if (!$(this).val() == '') {
        $(this).next().animate({ 'opacity': '1', 'right': '30' }, 200)
    } else {
        $(this).next().animate({ 'opacity': '0', 'right': '20' }, 200)
    }
});