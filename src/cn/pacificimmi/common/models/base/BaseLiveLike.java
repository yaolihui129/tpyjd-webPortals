package cn.pacificimmi.common.models.base;

import com.jfinal.plugin.activerecord.Model;
import com.jfinal.plugin.activerecord.IBean;

/**
 * Generated by JFinal, do not modify this file.
 */
@SuppressWarnings("serial")
public abstract class BaseLiveLike<M extends BaseLiveLike<M>> extends Model<M> implements IBean {

	public void setId(java.lang.Integer id) {
		set("id", id);
	}

	public java.lang.Integer getId() {
		return get("id");
	}

	public void setLiveId(java.lang.Integer liveId) {
		set("live_id", liveId);
	}

	public java.lang.Integer getLiveId() {
		return get("live_id");
	}

	public void setCustinfoId(java.lang.Integer custinfoId) {
		set("custinfo_id", custinfoId);
	}

	public java.lang.Integer getCustinfoId() {
		return get("custinfo_id");
	}

	public void setLike(java.lang.Integer like) {
		set("like", like);
	}

	public java.lang.Integer getLike() {
		return get("like");
	}

}