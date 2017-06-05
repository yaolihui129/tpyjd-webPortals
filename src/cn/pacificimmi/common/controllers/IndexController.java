package cn.pacificimmi.common.controllers;

import java.util.List;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import cn.pacificimmi.common.models.Custinfo;
import cn.pacificimmi.common.models.Live;
import cn.pacificimmi.common.utils.TpyDateUtil;
import cn.pacificimmi.common.utils.WeiXinConst;

import com.jfinal.core.Controller;
import com.jfinal.kit.PropKit;

public class IndexController extends Controller {
	private static Logger log = LoggerFactory.getLogger(IndexController.class);
	/**
	 * 首页
	 */
	public void index(){
		log.debug("page to index.jsp");
		Custinfo custinfo = this.getSessionAttr(WeiXinConst.CUSTINFO);
		this.setAttr("custinfo", custinfo);
		
		//直播预告
		Live latestLive = Live.dao.findFirst("select * from portal_live where delete_flag = 0 and live_status in ('直播中','已发布') order by live_start_time asc limit 0,1");
		if(null != latestLive && latestLive.getLiveId() != null){
			this.setAttr("liveDate", TpyDateUtil.dateToStrMmdd(latestLive.getLiveStartTime(),false,null)+"开播");
		}
		this.renderJsp(PropKit.use("debug_config.txt").get("TPYJD_PORTALS_JSP_BASE_PATH"));
	}
	
	/**
	 * 退出登录
	 */
	public void logout(){
		this.removeSessionAttr(WeiXinConst.CUSTINFO);
		this.redirect("/");
	}
	
}
