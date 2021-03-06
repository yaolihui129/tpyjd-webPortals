package cn.pacificimmi.common.models.base;

import com.jfinal.plugin.activerecord.Model;
import com.jfinal.plugin.activerecord.IBean;

/**
 * Generated by JFinal, do not modify this file.
 */
@SuppressWarnings("serial")
public abstract class BaseProjectApplyProcess<M extends BaseProjectApplyProcess<M>> extends Model<M> implements IBean {

	public void setProjectApplyProcessId(java.lang.Integer projectApplyProcessId) {
		set("project_apply_process_id", projectApplyProcessId);
	}

	public java.lang.Integer getProjectApplyProcessId() {
		return get("project_apply_process_id");
	}

	public void setProjectId(java.lang.Integer projectId) {
		set("project_id", projectId);
	}

	public java.lang.Integer getProjectId() {
		return get("project_id");
	}

	public void setName(java.lang.String name) {
		set("name", name);
	}

	public java.lang.String getName() {
		return get("name");
	}

	public void setCycle(java.lang.String cycle) {
		set("cycle", cycle);
	}

	public java.lang.String getCycle() {
		return get("cycle");
	}

	public void setContent(java.lang.String content) {
		set("content", content);
	}

	public java.lang.String getContent() {
		return get("content");
	}

	public void setPriority(java.lang.Integer priority) {
		set("priority", priority);
	}

	public java.lang.Integer getPriority() {
		return get("priority");
	}

	public void setDeleteFlag(java.lang.Integer deleteFlag) {
		set("delete_flag", deleteFlag);
	}

	public java.lang.Integer getDeleteFlag() {
		return get("delete_flag");
	}

}
