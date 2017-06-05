package cn.pacificimmi.estimate.models.view;

import java.util.Date;

import cn.pacificimmi.common.ComplexModel;

public class EstimateResultInfo extends ComplexModel<EstimateResultInfo>{
	
	/**
	 * 项目id
	 */
	private Integer projectId;
	
	/**
	 * 项目名称
	 */
	private String projectName;
	
	/**
	 * 推荐星级
	 */
	private Integer recommended;
	
	/**
	 * 上线时间
	 */
	private Date online_time;
	
	/**
	 * 匹配度
	 */
	private Integer matching; 
	
	/**
	 * 移民国家
	 */
	private Integer country;
	
	/**
	 * 移民目的
	 */
	private Integer hotspots;
	
	/**
	 * 资产要求
	 */
	private Integer asset;
	
	/**
	 * 移民预算
	 */
	private Integer immigration_budget;
	
	/**
	 * 学历要求
	 */
	private Integer qualifications;
	
	/**
	 * 外语能力
	 */
	private Integer language;
	
	/**
	 * 管理经验
	 */
	private Integer manage;
	
	/**
	 * 居住条件
	 */
	private Integer live_requirement;
	
	/**
	 * 年龄要求
	 */
	private Integer age;

	public Integer getProjectId() {
		return projectId;
	}

	public void setProjectId(Integer projectId) {
		this.projectId = projectId;
	}

	public String getProjectName() {
		return projectName;
	}

	public void setProjectName(String projectName) {
		this.projectName = projectName;
	}

	public Integer getMatching() {
		return matching;
	}

	public void setMatching(Integer matching) {
		this.matching = matching;
	}

	public Integer getCountry() {
		return country;
	}

	public void setCountry(Integer country) {
		this.country = country;
	}

	public Integer getHotspots() {
		return hotspots;
	}

	public void setHotspots(Integer hotspots) {
		this.hotspots = hotspots;
	}

	public Integer getAsset() {
		return asset;
	}

	public void setAsset(Integer asset) {
		this.asset = asset;
	}

	public Integer getImmigration_budget() {
		return immigration_budget;
	}

	public void setImmigration_budget(Integer immigration_budget) {
		this.immigration_budget = immigration_budget;
	}

	public Integer getQualifications() {
		return qualifications;
	}

	public void setQualifications(Integer qualifications) {
		this.qualifications = qualifications;
	}

	public Integer getLanguage() {
		return language;
	}

	public void setLanguage(Integer language) {
		this.language = language;
	}

	public Integer getManage() {
		return manage;
	}

	public void setManage(Integer manage) {
		this.manage = manage;
	}

	public Integer getLive_requirement() {
		return live_requirement;
	}

	public void setLive_requirement(Integer live_requirement) {
		this.live_requirement = live_requirement;
	}

	public Integer getRecommended() {
		return recommended;
	}

	public void setRecommended(Integer recommended) {
		this.recommended = recommended;
	}

	public Date getOnline_time() {
		return online_time;
	}

	public void setOnline_time(Date online_time) {
		this.online_time = online_time;
	}

	@Override
	public String toString() {
		return "EstimateResultInfo [projectId=" + projectId + ", projectName=" + projectName + ", recommended="
				+ recommended + ", online_time=" + online_time + ", matching=" + matching + ", country=" + country
				+ ", hotspots=" + hotspots + ", asset=" + asset + ", immigration_budget=" + immigration_budget
				+ ", qualifications=" + qualifications + ", language=" + language + ", manage=" + manage
				+ ", live_requirement=" + live_requirement + "]";
	}

	public Integer getAge() {
		return age;
	}

	public void setAge(Integer age) {
		this.age = age;
	}
	
}
