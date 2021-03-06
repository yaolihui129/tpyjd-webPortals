package cn.pacificimmi.common.models.base;

import com.jfinal.plugin.activerecord.Model;
import com.jfinal.plugin.activerecord.IBean;

/**
 * Generated by JFinal, do not modify this file.
 */
@SuppressWarnings("serial")
public abstract class BaseProject<M extends BaseProject<M>> extends Model<M> implements IBean {

	public void setProjectId(java.lang.Integer projectId) {
		set("project_id", projectId);
	}

	public java.lang.Integer getProjectId() {
		return get("project_id");
	}

	public void setProjectName(java.lang.String projectName) {
		set("project_name", projectName);
	}

	public java.lang.String getProjectName() {
		return get("project_name");
	}

	public void setProjectCode(java.lang.String projectCode) {
		set("project_code", projectCode);
	}

	public java.lang.String getProjectCode() {
		return get("project_code");
	}

	public void setProjectStatus(java.lang.String projectStatus) {
		set("project_status", projectStatus);
	}

	public java.lang.String getProjectStatus() {
		return get("project_status");
	}

	public void setProjectType(java.lang.String projectType) {
		set("project_type", projectType);
	}

	public java.lang.String getProjectType() {
		return get("project_type");
	}

	public void setCountry(java.lang.String country) {
		set("country", country);
	}

	public java.lang.String getCountry() {
		return get("country");
	}

	public void setCity(java.lang.String city) {
		set("city", city);
	}

	public java.lang.String getCity() {
		return get("city");
	}

	public void setVisaType(java.lang.String visaType) {
		set("visa_type", visaType);
	}

	public java.lang.String getVisaType() {
		return get("visa_type");
	}

	public void setVisaTypeDescription(java.lang.String visaTypeDescription) {
		set("visa_type_description", visaTypeDescription);
	}

	public java.lang.String getVisaTypeDescription() {
		return get("visa_type_description");
	}

	public void setLiveRequirement(java.lang.String liveRequirement) {
		set("live_requirement", liveRequirement);
	}

	public java.lang.String getLiveRequirement() {
		return get("live_requirement");
	}

	public void setLiveRequirementDescription(java.lang.String liveRequirementDescription) {
		set("live_requirement_description", liveRequirementDescription);
	}

	public java.lang.String getLiveRequirementDescription() {
		return get("live_requirement_description");
	}

	public void setInvestments(java.lang.String investments) {
		set("investments", investments);
	}

	public java.lang.String getInvestments() {
		return get("investments");
	}

	public void setAsset(java.lang.String asset) {
		set("asset", asset);
	}

	public java.lang.String getAsset() {
		return get("asset");
	}

	public void setAssetDescription(java.lang.String assetDescription) {
		set("asset_description", assetDescription);
	}

	public java.lang.String getAssetDescription() {
		return get("asset_description");
	}

	public void setQualifications(java.lang.String qualifications) {
		set("qualifications", qualifications);
	}

	public java.lang.String getQualifications() {
		return get("qualifications");
	}

	public void setQualificationsDescription(java.lang.String qualificationsDescription) {
		set("qualifications_description", qualificationsDescription);
	}

	public java.lang.String getQualificationsDescription() {
		return get("qualifications_description");
	}

	public void setImmigrationBudget(java.lang.Integer immigrationBudget) {
		set("immigration_budget", immigrationBudget);
	}

	public java.lang.Integer getImmigrationBudget() {
		return get("immigration_budget");
	}

	public void setLanguage(java.lang.String language) {
		set("language", language);
	}

	public java.lang.String getLanguage() {
		return get("language");
	}

	public void setLanguageDescription(java.lang.String languageDescription) {
		set("language_description", languageDescription);
	}

	public java.lang.String getLanguageDescription() {
		return get("language_description");
	}

	public void setAge(java.lang.String age) {
		set("age", age);
	}

	public java.lang.String getAge() {
		return get("age");
	}

	public void setAgeDescription(java.lang.String ageDescription) {
		set("age_description", ageDescription);
	}

	public java.lang.String getAgeDescription() {
		return get("age_description");
	}

	public void setManage(java.lang.String manage) {
		set("manage", manage);
	}

	public java.lang.String getManage() {
		return get("manage");
	}

	public void setManageDescription(java.lang.String manageDescription) {
		set("manage_description", manageDescription);
	}

	public java.lang.String getManageDescription() {
		return get("manage_description");
	}

	public void setIntroduce(java.lang.String introduce) {
		set("introduce", introduce);
	}

	public java.lang.String getIntroduce() {
		return get("introduce");
	}

	public void setAdvantage(java.lang.String advantage) {
		set("advantage", advantage);
	}

	public java.lang.String getAdvantage() {
		return get("advantage");
	}

	public void setRecommended(java.lang.String recommended) {
		set("recommended", recommended);
	}

	public java.lang.String getRecommended() {
		return get("recommended");
	}

	public void setProjectImg(java.lang.String projectImg) {
		set("project_img", projectImg);
	}

	public java.lang.String getProjectImg() {
		return get("project_img");
	}

	public void setOnlineTime(java.util.Date onlineTime) {
		set("online_time", onlineTime);
	}

	public java.util.Date getOnlineTime() {
		return get("online_time");
	}

	public void setCreateTime(java.util.Date createTime) {
		set("create_time", createTime);
	}

	public java.util.Date getCreateTime() {
		return get("create_time");
	}

	public void setCreateUser(java.lang.Integer createUser) {
		set("create_user", createUser);
	}

	public java.lang.Integer getCreateUser() {
		return get("create_user");
	}

	public void setApplyCondition(java.lang.String applyCondition) {
		set("apply_condition", applyCondition);
	}

	public java.lang.String getApplyCondition() {
		return get("apply_condition");
	}

	public void setDeleteFlag(java.lang.Integer deleteFlag) {
		set("delete_flag", deleteFlag);
	}

	public java.lang.Integer getDeleteFlag() {
		return get("delete_flag");
	}

	public void setOtherDescription(java.lang.String otherDescription) {
		set("other_description", otherDescription);
	}

	public java.lang.String getOtherDescription() {
		return get("other_description");
	}

	public void setPriority(java.lang.Integer priority) {
		set("priority", priority);
	}

	public java.lang.Integer getPriority() {
		return get("priority");
	}

}
