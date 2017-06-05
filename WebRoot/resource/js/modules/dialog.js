function Dialog(opt) {
    var defaults = {
        title: "消息",
        msg1: "",
        msg2: "",
        btn: ["删除", "取消"],
        callback1: null,
        callback2: null,
    }
    var s = $.extend({}, defaults, opt);
    //扩展默认值
    var html = '<div class="mask"></div>' +
        '<div class="alert_box">' +
        '<div class="alert_msg">' + '<p class="alert_msg1 ">' + s.msg1 + '</p>' + '<p class="alert_msg2">' + s.msg2 + '</p>' + '</div>' +
        '<div class="alert_btn"></div>' +
        '</div>';
    $(html).appendTo($("body"));
    if (s.msg2 == "") {
        $(".alert_msg2").css("margin-top", "0");
    }
    //渲染按钮
    if (s.btn.length == 0) return;
    if (s.btn.length == 1) {
        $(".alert_btn").css("color", "#0e89fc");
    }
    var btnHtml = "";
    for (var i = 0; i < s.btn.length; i++) {
        btnHtml += '<div class="btn' + i + '">' + s.btn[i] + '</div>';
    }
    $(btnHtml).appendTo($(".alert_btn"));
    //按钮1
    $(".btn1").on("tap", function () {
            s.callback1 && s.callback1();

        })
        //按钮2
    $(".btn0").on("tap", function () {
        s.callback2 && s.callback2();
    });


}
$.dialog = function (opt) {
    Dialog(opt);
}