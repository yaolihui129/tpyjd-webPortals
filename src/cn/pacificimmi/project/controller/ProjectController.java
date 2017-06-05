package cn.pacificimmi.project.controller;

import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import com.jfinal.core.Controller;
import com.jfinal.kit.PropKit;
import com.jfinal.plugin.activerecord.Db;
import com.jfinal.plugin.activerecord.Record;

import cn.pacificimmi.common.ParamsParser;
import cn.pacificimmi.common.models.Custinfo;
import cn.pacificimmi.common.models.Dictionary;
import cn.pacificimmi.common.models.Project;
import cn.pacificimmi.common.models.ProjectApplyProcess;
import cn.pacificimmi.common.models.ProjectResource;
import cn.pacificimmi.project.models.view.ProjectByCountryInfo;

public class ProjectController extends Controller{
	
	private static Logger log = LoggerFactory.getLogger(ProjectController.class);
	
	/**
	 * 获取项目大列表
	 */
	public void index() {
		String type=this.getPara(0);
		List<Record> list = null;
		if(null != type && !"".equals(type)) {
			list = Db.find("SELECT "+
					"* "+
				"FROM "+
					"( "+
						"SELECT "+
							"cd.dict_code, "+
							"cd.short_name as value, "+
							"cd. NAME as name, "+
							"substring(cd.short_name, 1, 1) AS fist_value "+
						"FROM "+
							"( "+
								"SELECT "+
									"cp.project_id, "+
									"cp.country "+
								"FROM "+
									"crm_project cp "+
								"WHERE "+
									"delete_flag = 0 "+
									"AND project_type = "+type+
									" AND project_status = "+PropKit.use("constants.txt").get("project_status_sx")+
								" GROUP BY "+
									"country "+
							") cty "+
						"LEFT JOIN (select * from console_dictionary where delete_flag=0) cd ON cty.country = cd.dict_code "+
					") c "+
				"ORDER BY "+
					"c.fist_value ASC");
		} else {
			list = Db.find("SELECT "+
					"* "+
				"FROM "+
					"( "+
						"SELECT "+
							"cd.dict_code, "+
							"cd.short_name as value, "+
							"cd. NAME as name, "+
							"substring(cd.short_name, 1, 1) AS fist_value "+
						"FROM "+
							"( "+
								"SELECT "+
									"cp.project_id, "+
									"cp.country "+
								"FROM "+
									"crm_project cp "+
								"WHERE "+
									"delete_flag = 0 "+
									"AND project_status = "+PropKit.use("constants.txt").get("project_status_sx")+
								" GROUP BY "+
									"country "+
							") cty "+
						"LEFT JOIN (select * from console_dictionary where delete_flag=0) cd ON cty.country = cd.dict_code "+
					") c "+
				"ORDER BY "+
					"c.fist_value ASC");
		}
		
		List<ProjectByCountryInfo> result = new ArrayList<ProjectByCountryInfo>();
		for(Record rd : list) {
			ProjectByCountryInfo pci = new ProjectByCountryInfo();
			pci.bindingData(pci, rd);
			List<Project> pList = null;
			if(null != type && !"".equals(type)) {
				pList = Project.dao.find("SELECT "+
						"* "+
					"FROM "+
						"crm_project "+
					"WHERE "+
						"project_status = "+PropKit.use("constants.txt").get("project_status_sx")+
					" AND country = "+pci.getDict_code()+
					" AND project_type = "+type+
					" AND delete_flag = 0");
			} else {
				pList = Project.dao.find("SELECT "+
						"* "+
					"FROM "+
						"crm_project "+
					"WHERE "+
						"project_status = "+PropKit.use("constants.txt").get("project_status_sx")+
					" AND country = "+pci.getDict_code()+
					" AND delete_flag = 0");
			}
			
			pci.setProjectList(pList);
			result.add(pci);
		}
		
		List<Dictionary> projectTypeList = Dictionary.dao.find("SELECT "+
					"cd.* "+
				"FROM "+
					"console_dictionary cd "+
				"JOIN ( "+
					"SELECT "+
						"cp.project_id, "+
						"cp.project_type "+
					"FROM "+
						"crm_project cp "+
					"WHERE "+
						"cp.delete_flag = 0 "+
					"AND cp.project_status = "+PropKit.use("constants.txt").get("project_status_sx")+
					" GROUP BY "+
						"cp.project_type "+
				") cpd ON cpd.project_type = cd.dict_code "+
				"WHERE "+
					"cd.delete_flag = 0");
		
		if(result.size()>0) {
			this.setAttr("type", type);
			this.setAttr("projectTypeList", projectTypeList);
			this.setAttr("projectList", result);
			this.renderJsp("/WEB-INF/jsp/project/projects_list.jsp");
		} else {
			this.renderJsp("/WEB-INF/jsp/noData.jsp");
		}
	}
	
	
	/**
	 * 生活体验项目列表 
	 */
	public void projectList() {
		String country = this.getPara("country");
		String city = this.getPara("city");
		
		List<Project> projectList = null;
		if(null != city && !"".equals(city)) {
			projectList = Project.dao.find("SELECT "+
					"* "+
				"FROM "+
					"crm_project "+
				"WHERE "+
					"delete_flag = 0 "+
				"AND country = "+country+
				" AND project_status = "+PropKit.use("constants.txt").get("project_status_sx")+
				" AND city IS NULL "+
				"UNION "+
					"SELECT "+
						"* "+
					"FROM "+
						"crm_project "+
					"WHERE "+
						"delete_flag = 0 "+
					"AND country = "+country+
					" AND project_status = "+PropKit.use("constants.txt").get("project_status_sx")+
					" AND city = "+city+
					" ORDER BY city DESC");
		} else {
			projectList = Project.dao.find("SELECT "+
					"* "+
				"FROM "+
					"crm_project "+
				"WHERE "+
					"delete_flag = 0 "+
				"AND country = "+country+
				" AND project_status = "+PropKit.use("constants.txt").get("project_status_sx"));
		}
		
		if(projectList != null && projectList.size()>0) {
			this.setAttr("projectList", projectList);
			this.renderJsp("/WEB-INF/jsp/project/project_list.jsp");
		} else {
			this.renderJsp("/WEB-INF/jsp/noData.jsp");
		}
	}
	
	
	/**
	 * 获取项目详细信息
	 */
	public void projectInfo() {
		String id=getPara(0);
		Project project = Project.dao.findById(id);
		//图片
		List<ProjectResource> picList = ProjectResource.dao.find("SELECT "+
								"* "+
							"FROM "+
								"crm_project_resource "+
							"WHERE "+
								"project_id = "+project.getProjectId()+
							" AND media_type = "+PropKit.use("constants.txt").get("media_type_pic")+
							" AND delete_flag = 0 "+
							"ORDER BY "+
								"priority ASC");
		//视频
		List<ProjectResource> tvList = ProjectResource.dao.find("SELECT "+
				"* "+
			"FROM "+
				"crm_project_resource "+
			"WHERE "+
				"project_id = "+project.getProjectId()+
			" AND media_type = "+PropKit.use("constants.txt").get("media_type_tv")+
			" AND delete_flag = 0 "+
			"ORDER BY "+
				"priority ASC");
		
		//特点
		String advantage = project.getAdvantage();
		if(null != advantage && !"".equals(advantage)) {
			advantage = advantage.replaceAll("；", ";");
			String[] adary = advantage.split(";");
			this.setAttr("adary", adary);
		} else {
			this.setAttr("adary", null);
		}
		
		//流程
		List<ProjectApplyProcess> papList = ProjectApplyProcess.dao.find("SELECT "+
				"* "+
			"FROM "+
				"crm_project_apply_process "+
			"WHERE "+
				"project_id = "+project.getProjectId()+
			" AND delete_flag = 0 "+
			"ORDER BY "+
				"priority ASC");
		
		//年龄
		if(null == project.getAgeDescription() || "".equals(project.getAgeDescription())) {
			Dictionary ad = Dictionary.dao.findFirst("SELECT * FROM console_dictionary WHERE dict_code = "+project.getAge()+" and delete_flag = 0");
			project.setAgeDescription(ad.getName());
		}
		
		//家庭资产
		if(null == project.getAssetDescription() || "".equals(project.getAssetDescription())) {
			Dictionary ad = Dictionary.dao.findFirst("SELECT * FROM console_dictionary WHERE dict_code = "+project.getAsset()+" and delete_flag = 0");
			project.setAssetDescription(ad.getName());
		}
		
		//投资额度
		if(null == project.getAgeDescription() || "".equals(project.getAgeDescription())) {
			Dictionary ad = Dictionary.dao.findFirst("SELECT * FROM console_dictionary WHERE dict_code = "+project.getAge()+" and delete_flag = 0");
			project.setAgeDescription(ad.getName());
		}
		
		//管理经验
		if(null == project.getManageDescription() || "".equals(project.getManageDescription())) {
			Dictionary ad = Dictionary.dao.findFirst("SELECT * FROM console_dictionary WHERE dict_code = "+project.getManage()+" and delete_flag = 0");
			project.setManageDescription(ad.getName());
		}
		
		//学历要求
		if(null == project.getQualificationsDescription() || "".equals(project.getQualificationsDescription())) {
			Dictionary ad = Dictionary.dao.findFirst("SELECT * FROM console_dictionary WHERE dict_code = "+project.getQualifications()+" and delete_flag = 0");
			project.setQualificationsDescription(ad.getName());
		}
		
		//语言要求
		if(null == project.getLanguageDescription() || "".equals(project.getLanguageDescription())) {
			Dictionary ad = Dictionary.dao.findFirst("SELECT * FROM console_dictionary WHERE dict_code = "+project.getLanguage()+" and delete_flag = 0");
			project.setLanguageDescription(ad.getName());
		}
				
		
		this.setAttr("project", project);
		this.setAttr("papList", papList);
		this.setAttr("picList", picList);
		this.setAttr("tvList", tvList);
		this.renderJsp("/WEB-INF/jsp/project/project_info.jsp");
	}
	
	/**
	 * 添加客户信息
	 */
	public void addCustinfo() {
		ParamsParser pp = new ParamsParser(this);
		
		String name = pp.getNormStr("name");
		String mobile = pp.getNormStr("mobile");
		
		Map<String, Object> map = new HashMap<String ,Object>();
		
		if(null != name && !"".equals(name) && null != mobile && !"".equals(mobile)) {
			Custinfo ci = new Custinfo();
			ci.setDirection(0);
			ci.setCustSource(PropKit.use("constants.txt").get("cust_source_mfzx"));
			ci.setName(name);
			ci.setPhoneNum(mobile);
			ci.setCreateTime(new Date());
			ci.save();
			map.put("status", 1);
			map.put("msg", "保存成功");
		} else {
			map.put("status", 0);
			map.put("msg", "保存失败");
		}
		this.renderJson(map);
	}
	
}
