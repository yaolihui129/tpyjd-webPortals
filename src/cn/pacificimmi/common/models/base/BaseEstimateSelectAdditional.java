package cn.pacificimmi.common.models.base;

import com.jfinal.plugin.activerecord.Model;
import com.jfinal.plugin.activerecord.IBean;

/**
 * Generated by JFinal, do not modify this file.
 */
@SuppressWarnings("serial")
public abstract class BaseEstimateSelectAdditional<M extends BaseEstimateSelectAdditional<M>> extends Model<M> implements IBean {

	public void setEstimateSelectAdditionalId(java.lang.Integer estimateSelectAdditionalId) {
		set("estimate_select_additional_id", estimateSelectAdditionalId);
	}

	public java.lang.Integer getEstimateSelectAdditionalId() {
		return get("estimate_select_additional_id");
	}

	public void setEstimateSelectId(java.lang.Integer estimateSelectId) {
		set("estimate_select_id", estimateSelectId);
	}

	public java.lang.Integer getEstimateSelectId() {
		return get("estimate_select_id");
	}

	public void setDictCode(java.lang.String dictCode) {
		set("dict_code", dictCode);
	}

	public java.lang.String getDictCode() {
		return get("dict_code");
	}

}
