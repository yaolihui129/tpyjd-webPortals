var lyxFn = {
    init: function () {
        this.header(),
            this.login()
    },
    header: function () {

        this.hover($(".tpy-company-branch"), $(".tpy-company-ul")); //顶部导航条分公司hover  	
        $(".tpy-company-ul").hover(function () { //顶部导航条分公司展开效果
            var $this = $(this);
            $(".tpy-company-branch").addClass("on");
            $this.removeClass("hide");
        }, function () {
            var $this = $(this);
            $this.addClass("hide");
            $(".tpy-company-branch").removeClass("on");
        });

        this.hover($(".tpy-contact-chat"), $(".tpy-chat-box")); //顶部导航条微信关注
        this.hover($(".tpy-contact-tel"), $(".tpy-tel-box")); //顶部导航条直接联系
        this.hover($(".tpy-login"), $(".tpy-login-box")); //顶部导航条登录账号hover
        this.hover($(".tpy-login-bar"), $(".tpy-login-box-bar"));
        $(".tpy-login-box").hover(function () { //顶部导航条分公司展开效果
            var $this = $(this);
            $(".tpy-login").addClass("on");
            $this.removeClass("hide");
        }, function () {
            var $this = $(this);
            $this.addClass("hide");
            $(".tpy-login").removeClass("on");
        });
        $(".tpy-login-box-bar").hover(function () { //顶部导航条分公司展开效果
            var $this = $(this);
            $(".tpy-login-bar").addClass("on");
            $this.removeClass("hide");
        }, function () {
            var $this = $(this);
            $this.addClass("hide");
            $(".tpy-login-bar").removeClass("on");
        });
        
        (function(){
        	var login_width = $(".tpy-header-status .tpy-login").outerWidth();
        	console.log(login_width)
        	$(".tpy-header-status .tpy-login-box").outerWidth(login_width+2);
        })();

    },
    hover: function (hoverobj, showobj) { //hover时，showobj显示，否，隐藏
        hoverobj.hover(function () {
            var $this = $(this),
                index = $this.index();
            $this.addClass("on");
            showobj.removeClass("hide");
        }, function () {
            var $this = $(this);
            $this.removeClass("on");
            showobj.addClass("hide");
        });
    },
    login: function () {
        $(".js-log-btn li").on("click", function () { //注册登录按钮点击事件
            var $this = $(this),
                index = $this.index();
            $(".js-login-alert,.js-alert-box").removeClass("hide");
            $(".js-alert-mmbox").addClass("hide");
            $(".tpy-login-title li").eq(index).addClass("on").siblings().removeClass("on");
            $(".tpy-login-context").eq(index).removeClass("hide").addClass("on");
            $(".tpy-login-context").eq(index).siblings().removeClass("on").addClass("hide");
        });
        this.tab($(".js-login-title li"), $(".tpy-login-context")); //弹出框中，注册登录按钮切换
        $(".js-login-forget").on("click", function () { //弹出框中，点击忘记密码，弹出重置密码弹出框
            $(this).parents(".js-alert-box").find(".on").removeClass("on").end().addClass("hide");
            $(".js-alert-mmbox").removeClass("hide");
        });

        $(".js-login-alert").bind('click', function (ev) { //点击弹出框以外的黑色背景，隐藏弹框
            var touch = ev.originalEvent.changedTouches ? ev.originalEvent.changedTouches[0] : ev;
            var evt = $(touch.target);
            if (evt.parents().hasClass('js-alert-box') || evt.parents().hasClass('js-alert-mmbox')) {
                return; // 如果是元素本身，则返回
            } else {
                $('.js-login-alert').addClass("hide"); // 如不是则隐藏元素
            }
        });


    },
    tab: function (hoverobj, showobj) { //tab切换
        hoverobj.on("click", function () {
            var $this = $(this),
                index = $this.index();
            $this.addClass("on").siblings().removeClass("on");
            showobj.eq(index).removeClass("hide").addClass("on").siblings(showobj).addClass("hide").removeClass("on");
        });
    }
};
lyxFn.init();