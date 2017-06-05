requirejs(["configs"], function () {
    require(['jquery','common','formValidate','yzm','lay','laydate'], function ($) {

		//input格式验证
		var body = $("body");
		body.on("blur",".js-person-email",function(){//邮箱验证
	    	var $this = $(this),
	            this_email = $this.val().trim();
	        var atpos = this_email.indexOf("@"),
	            dotpos = this_email.lastIndexOf(".");
	            if(this_email){
	            	if (atpos < 1 || dotpos < atpos + 2 || dotpos + 2 >= this_email.length) {
			            addClass($this);
			
			        } else {
			            removeClass($this);
			        }
	            }
    	});
    	body.on("blur",".js-person-tel",function(){//对电话号码校验
	    	var $this = $(this),
	            tel = $this.val().trim();
	        if(tel){	        	
		        if (/^(1[3|5|7|8])\d{9}$/.test(tel)) {
		            removeClass($this);
		        } else {
		            addClass($this);
		        }
	        }
	    });
	    body.on("blur",".js-person-name",function(){//对姓名校验
	    	var $this = $(this),
	            name = $this.val().trim(),
	             reg = /[^\w\u4e00-\u9fa5]/g;
				
	        if(name){
	        	if(name.length<2 || name.length>10){
	        		addClass($this);
	        		return;
	        	}
	        	if(reg.test(name)){
		           	addClass($this);
		            return;
	        	}
	        }
			
	    });
	    
	    body.on("keyup","input",function(){//input框输入时，error红色提醒取消
			removeClass($(this));					
		});
		
		function removeClass(node){
			node.removeClass("forbid");
			node.next(".person-tips").addClass("hide");
		}
		function addClass(node){
			node.addClass("forbid");
			node.next(".person-tips").removeClass("hide");
		}
		
		$("#borntime").on("click",function(){
			//自定义日期格式
			laydate({
			    elem: '#borntime',
			    format: 'YYYY年MM月DD日',
			    festival: true //显示节日
			});
		});
		
    });
});