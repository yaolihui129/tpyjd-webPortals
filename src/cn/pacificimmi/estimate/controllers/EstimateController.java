package cn.pacificimmi.estimate.controllers;

import java.util.ArrayList;
import java.util.Collections;
import java.util.Comparator;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import com.jfinal.aop.Before;
import com.jfinal.core.Controller;
import com.jfinal.kit.PropKit;
import com.jfinal.plugin.activerecord.Db;
import com.jfinal.plugin.activerecord.Record;

import cn.pacificimmi.common.interceptor.BindingInterceptor;
import cn.pacificimmi.common.models.Country;
import cn.pacificimmi.common.models.Custinfo;
import cn.pacificimmi.common.models.Dictionary;
import cn.pacificimmi.common.models.EstimateQuestion;
import cn.pacificimmi.common.models.EstimateRecord;
import cn.pacificimmi.common.models.EstimateSelectAdditional;
import cn.pacificimmi.common.models.EstimatetDetailRecord;
import cn.pacificimmi.common.models.Project;
import cn.pacificimmi.common.utils.MemcacheKit;
import cn.pacificimmi.common.utils.WeiXinConst;
import cn.pacificimmi.estimate.models.view.EstimateQuestionInfo;
import cn.pacificimmi.estimate.models.view.EstimateQuestionVersionInfo;
import cn.pacificimmi.estimate.models.view.EstimateResultInfo;
import cn.pacificimmi.estimate.models.view.EstimateSelectInfo;
import cn.pacificimmi.estimate.models.view.EstimatetDetailRecordInfo;
import net.sf.json.JSONArray;

@Before(BindingInterceptor.class)
public class EstimateController extends Controller {
	
	private static Logger log = LoggerFactory.getLogger(EstimateController.class);
	
	
	
	public void index() {
		Custinfo custinfo = this.getSessionAttr(WeiXinConst.CUSTINFO);
		Integer custinfoId = custinfo.getCustinfoId();
//		Integer custinfoId =20;
		
		int one_line_size = new Integer(PropKit.use("constants.txt").get("one_line_size"));
		int two_line_size = new Integer(PropKit.use("constants.txt").get("two_line_size"));
		
		Record record = Db.findFirst("select * from wx_estimate_question_version where status="+
				PropKit.use("constants.txt").get("question_version_status_yfb")+" and delete_flag=0");
		
		List<Project> projectList = null;
		projectList = (List<Project>) MemcacheKit.get("projectList");
		if(null == projectList || projectList.size()==0) {
			List<Project> plist = Project.dao.find("select * from crm_project where project_status = "+
					PropKit.use("constants.txt").get("project_status_sx")+"  and delete_flag=0");
			MemcacheKit.set("projectList", plist, 10*60);
			projectList = plist;
		}
		
		if (record !=null && null != projectList && projectList.size()>0) {
			//获取评估问题
			EstimateQuestionVersionInfo eqvi = new EstimateQuestionVersionInfo();
			eqvi.bindingData(eqvi, record);
			List<Record> result = Db.find("select * from wx_estimate_question where version_id = "+eqvi.getVersion_id()+" and delete_flag=0 order by priority asc");
			if(null != result && result.size()>0) {
				List<EstimateQuestionInfo> eqList = new ArrayList<EstimateQuestionInfo>();
				for(Record r:result) {
					Integer line_num = 1;
					EstimateQuestionInfo eqi = new EstimateQuestionInfo();
					eqi.bindingData(eqi, r);
					//获取评做选择项
					if(null != eqi.getEstimate_question_id()) {
						List<Record> selResult = Db.find("select * from wx_estimate_select where estimate_question_id="+eqi.getEstimate_question_id()+" and delete_flag=0");
						List<EstimateSelectInfo> esList = new ArrayList<EstimateSelectInfo>();
						if(null != selResult && selResult.size()>0) {
							List<Integer> lines = new ArrayList<Integer>();
							for(Record sel:selResult) {
								EstimateSelectInfo esi = new EstimateSelectInfo();
								esi.bindingData(esi, sel);
								if(null != esi.getContent() && !"".equals(esi.getContent())) {
									int num = getStringNum(esi.getContent());
									lines.add(num);
								}
								List<EstimateSelectAdditional> esaList = EstimateSelectAdditional.dao.find("select * from wx_estimate_select_additional where estimate_select_id="+esi.getEstimate_select_id());
								esi.setEsaList(esaList);
								esList.add(esi);
							}
							if(lines.size()>0) {
								Collections.sort(lines, Collections.reverseOrder());
								if(lines.get(0)<one_line_size || lines.get(0)==one_line_size) {
									line_num = 3;
								} else if(lines.get(0)<two_line_size || lines.get(0)==two_line_size){
									line_num=2;
								} else {
									line_num=1;
								}
								eqi.setLine_num(line_num);
							}
						}
						
						if(null != esList && esList.size()>0) {
							eqi.setEsList(esList);
						}
					}
					
					eqList.add(eqi);
				}
				eqvi.setEqList(eqList);
				
				//获取客户信息
				Record estimateRecord = Db.findFirst("select * from wx_estimate_record where custinfo_id ="+custinfoId);
				if(null != estimateRecord) {
					EstimateQuestionVersionInfo ceqvi = new EstimateQuestionVersionInfo();
					ceqvi.bindingData(ceqvi, estimateRecord);
					if(eqvi.getVersion_id().equals(ceqvi.getVersion_id())) {
						List<Record> crList = Db.find("select * from wx_estimatet_detail_record where estimate_record_id ="+ceqvi.getEstimate_record_id());
						if(null != crList && crList.size()>0) {
							//获取客户评估问题
							List<EstimateQuestionInfo> ceqiList = new ArrayList<EstimateQuestionInfo>();
							for(Record cr:crList) {
								EstimateQuestionInfo ceqi = new EstimateQuestionInfo();
								ceqi.bindingData(ceqi, cr);
								ceqiList.add(ceqi);
							}
							this.setAttr("ceqiList", ceqiList);
						}
					}
				}
				
				String country = this.getPara(0);
				if(null != country && !"".equals(country)) {
					this.setAttr("country", country);
				}
				this.setAttr("eqvi", eqvi);
				this.setAttr("danx", PropKit.use("constants.txt").get("estimate_answer_danx"));
				this.setAttr("duox", PropKit.use("constants.txt").get("estimate_answer_duox"));
				this.setAttr("wenb", PropKit.use("constants.txt").get("estimate_answer_wenb"));
				this.setAttr("shi", PropKit.use("constants.txt").get("estimate_isrequired_shi"));
				this.renderJsp("/WEB-INF/jsp/estimate/estimate_list.jsp");
			} else {
				this.renderJsp("/WEB-INF/jsp/noData.jsp");
			}
		} else {
			this.renderJsp("/WEB-INF/jsp/noData.jsp");
		}
	}
	
	/**
	 * 保存
	 */
	public void save() {
		Custinfo custinfo = this.getSessionAttr(WeiXinConst.CUSTINFO);
		Integer custinfoId = custinfo.getCustinfoId();
//		Integer custinfoId =20;
		
		String listStr = getPara("list");
		String versionId = getPara("versionId");
		
		Map<String, Object> map = new HashMap<String, Object>();
		
		if(null != listStr && !"".equals(listStr.trim()) && 
				null != versionId && !"".equals(versionId.trim())) {
			EstimateRecord erd = EstimateRecord.dao.findFirst("select * from wx_estimate_record where custinfo_id="+custinfoId);
			if(null != erd) {
				Db.update("delete from wx_estimatet_detail_record where estimate_record_id = ?", erd.getEstimateRecordId());
				EstimateRecord.dao.deleteById(erd.getEstimateRecordId());
			}
			JSONArray jsonArray = JSONArray.fromObject(listStr);
			List<EstimatetDetailRecord> edrList =  JSONArray.toList(jsonArray, EstimatetDetailRecord.class);
			EstimateRecord er = new EstimateRecord();
			er.setVersionId(new Integer(versionId));
			er.setCustinfoId(custinfoId);
			er.setCreateTime(new Date());
			er.save();
			if(null != edrList && edrList.size()>0) {
				for(EstimatetDetailRecord edr : edrList) {
					if((null != edr.getEstimateSelectId() && !"".equals(edr.getEstimateSelectId())) || (null !=edr.getIntValue() && !"".equals(edr.getIntValue()))) {
						edr.setEstimateRecordId(er.getEstimateRecordId());
						edr.setCreateTime(new Date());
						edr.save();
					}
				}
			}
			map.put("status", "0");
			map.put("msg", "保存成功");
		} else {
			map.put("status", "1");
			map.put("msg", "参数错误");
		}
		this.renderJson(map);
	}
	
	/**
	 * 客户评估结果
	 */
	public void result() {
		Custinfo custinfo = this.getSessionAttr(WeiXinConst.CUSTINFO);
		Integer custinfoId = custinfo.getCustinfoId();
//		Integer custinfoId =20;
		
		List<Project> projectList = null;
		projectList = (List<Project>) MemcacheKit.get("projectList");
		if(null == projectList || projectList.size()==0) {
			List<Project> plist = Project.dao.find("select * from crm_project where project_status = "+
					PropKit.use("constants.txt").get("project_status_sx")+"  and delete_flag=0");
			MemcacheKit.set("projectList", plist, 10*60);
			projectList = plist;
		}
		
		EstimateRecord er = EstimateRecord.dao.findFirst("select * from wx_estimate_record where custinfo_id="+custinfoId);
		if(null != projectList && projectList.size()>0 && null != er) {
			List<Record> result = Db.find("select * from wx_estimatet_detail_record WHERE estimate_record_id="+er.getEstimateRecordId());
			List<EstimatetDetailRecordInfo> edrList = new ArrayList<EstimatetDetailRecordInfo>();
			if(null != result && result.size()>0) {
				for(Record re:result) {
					EstimatetDetailRecordInfo edr = new EstimatetDetailRecordInfo();
					edr.bindingData(edr, re);
					EstimateQuestion eq = EstimateQuestion.dao.findById(edr.getEstimate_question_id());
					edr.setEstimateQuestion(eq);
					if(null != edr.getEstimate_select_id() && !"".equals(edr.getEstimate_select_id())) {
						List<EstimateSelectAdditional> esaList = EstimateSelectAdditional.dao.find("select * from wx_estimate_select_additional where estimate_select_id ="+edr.getEstimate_select_id());
						edr.setEsaList(esaList);
					}
					edrList.add(edr);
				}
				
				List<EstimateResultInfo> eriList = new ArrayList<EstimateResultInfo>();
				for(Project pj:projectList) {
					EstimateResultInfo eri = this.EstimateResultByProjectId(edrList, pj);
					if(null != eri) {
						eriList.add(eri);
					}
				}
				
				if(eriList.size()>0) {
					Collections.sort(eriList,new Comparator<EstimateResultInfo>(){
					      public int compare(EstimateResultInfo arg0, EstimateResultInfo arg1) {
					          int i = arg1.getMatching().compareTo(arg0.getMatching());
					          if(i==0) {
					               int j = arg1.getRecommended().compareTo(arg0.getRecommended());
					               if(j==0) {
					            	   int k = arg0.getOnline_time().compareTo(arg1.getOnline_time());
					            	   return k;
					               }
					               return j;
					          }
					          return i;
					    }
					});
					this.setAttr("resultList", eriList);
					this.renderJsp("/WEB-INF/jsp/estimate/estimate_result.jsp");
				} else {
					this.renderJsp("/WEB-INF/jsp/estimate/not_result.jsp");
				}
			} else {
				this.renderJsp("/WEB-INF/jsp/noData.jsp");
			}
		} else {
			this.redirect("/estimate");
			/*this.renderJsp("/WEB-INF/jsp/noData.jsp");*/
		}
	}
	
	/**
	 * 获取客户对某个项目的评估结果
	 * @param edriList
	 * @param project
	 * @return 0:完全匹配，1:不匹配，2:部分匹配
	 */
	private EstimateResultInfo EstimateResultByProjectId(List<EstimatetDetailRecordInfo> edriList, Project project) {
		String danx = PropKit.use("constants.txt").get("estimate_answer_danx");
		String duox = PropKit.use("constants.txt").get("estimate_answer_duox");
		String wenb = PropKit.use("constants.txt").get("estimate_answer_wenb");
		String coutry = PropKit.use("constants.txt").get("country");
		String hotspots = PropKit.use("constants.txt").get("hotspots");
		String asset = PropKit.use("constants.txt").get("asset");
		String immigration_budget = PropKit.use("constants.txt").get("immigration_budget");
		String qualifications = PropKit.use("constants.txt").get("qualifications");
		String language = PropKit.use("constants.txt").get("language");
		String manage = PropKit.use("constants.txt").get("manage");
		String live_requirement = PropKit.use("constants.txt").get("live_requirement");
		String age = PropKit.use("constants.txt").get("age");
		
		Dictionary di = Dictionary.dao.findFirst("select value from console_dictionary where dict_code="+
				PropKit.use("constants.txt").get("estimate_weight_value")+" and delete_flag=0");
		Integer weight_value = (di.getValue()!=null || !"".equals(di.getValue()))?new Integer(di.getValue()):0;
		EstimateResultInfo eri = new EstimateResultInfo();
		int num = 0;
		
		for(EstimatetDetailRecordInfo edri:edriList) {
			EstimateQuestion eq = edri.getEstimateQuestion();
			List<EstimateSelectAdditional> esaList = edri.getEsaList();
			String code = eq.getDictCode();
			String answer = eq.getAnswer();
			if(danx.equals(answer) || duox.equals(answer)) {
				if(coutry.equals(code)) { //移民国家
					if(null != esaList && esaList.size()>0) {
						for(EstimateSelectAdditional esa:esaList) {
							if(null ==eri.getCountry() || eri.getCountry() == 1) {
								if(project.getCountry().equals(esa.getDictCode())) {
									eri.setCountry(0);
									num+=eq.getWeight();
								} else {
									eri.setCountry(1);
								}
							}
						}
					}
				} else if(hotspots.equals(code)) { //移民目的
					if(null != esaList && esaList.size()>0) {
						for(EstimateSelectAdditional esa:esaList) {
							if(null ==eri.getHotspots() || eri.getHotspots() == 1) {
								Country country = Country.dao.findFirst("select * from crm_country where country_id = "+project.getCountry()+" and delete_flag=0");
								if(null != country && null !=country.getHotspotsId()) {
									if(country.getHotspotsId().contains(esa.getDictCode())) {
										eri.setHotspots(0);
										num+=eq.getWeight();
									} else {
										eri.setHotspots(1);
									}
								}
							}
						}
					}
				} else if(asset.equals(code)) { //资产要求
					if(null != esaList && esaList.size()>0) {
						for(EstimateSelectAdditional esa:esaList) {
							if(null ==eri.getAsset() || eri.getAsset() == 1) {
								if(project.getAsset().equals(esa.getDictCode())) {
									eri.setAsset(0);
									num+=eq.getWeight();
								} else {
									eri.setAsset(1);
								}
							}
						}
					}
				} else if(immigration_budget.equals(code)) { //移民预算
					if(null != esaList && esaList.size()>0) {
						for(EstimateSelectAdditional esa:esaList) {
							if(null ==eri.getImmigration_budget() || eri.getImmigration_budget() == 1) {
								if(project.getImmigrationBudget().equals(esa.getDictCode())) {
									eri.setImmigration_budget(0);
									num+=eq.getWeight();
								} else {
									eri.setImmigration_budget(1);
								}
							}
						}
					}
				} else if(qualifications.equals(code)) { //学历要求
					if(null != esaList && esaList.size()>0) {
						for(EstimateSelectAdditional esa:esaList) {
							if(null ==eri.getQualifications() || eri.getQualifications() == 1) {
								if(project.getQualifications().equals(esa.getDictCode())) {
									eri.setQualifications(0);
									num+=eq.getWeight();
								} else {
									eri.setQualifications(1);
								}
							}
						}
					}
				} else if(language.equals(code)) { //外语能力
					if(null != esaList && esaList.size()>0) {
						for(EstimateSelectAdditional esa:esaList) {
							if(null ==eri.getLanguage() || eri.getLanguage() == 1) {
								if(project.getLanguage().equals(esa.getDictCode())) {
									eri.setLanguage(0);
									num+=eq.getWeight();
								} else {
									eri.setLanguage(1);
								}
							}
						}
					}
				} else if(manage.equals(code)) { //管理经验
					if(null != esaList && esaList.size()>0) {
						for(EstimateSelectAdditional esa:esaList) {
							if(null ==eri.getManage() || eri.getManage() == 1) {
								if(project.getManage().equals(esa.getDictCode())) {
									eri.setManage(0);
									num+=eq.getWeight();
								} else {
									eri.setManage(1);
								}
							}
						}
					}
				} else if(live_requirement.equals(code)) { //居住条件
					if(null != esaList && esaList.size()>0) {
						for(EstimateSelectAdditional esa:esaList) {
							if(null ==eri.getLive_requirement() || eri.getLive_requirement() == 1) {
								if(project.getLiveRequirement().equals(esa.getDictCode())) {
									eri.setLive_requirement(0);
									num+=eq.getWeight();
								} else {
									eri.setLive_requirement(1);
								}
							}
						}
					}
				} else if(age.equals(code)) { //年龄要求
					if(null != esaList && esaList.size()>0) {
						for(EstimateSelectAdditional esa:esaList) {
							if(null ==eri.getAge() || eri.getAge() == 1) {
								if(project.getAge().equals(esa.getDictCode())) {
									eri.setAge(0);
									num+=eq.getWeight();
								} else {
									eri.setAge(1);
								}
							}
						}
					}
				}
			//数值类型
			} else if(wenb.equals(answer)) {
				if(coutry.equals(code)) { //移民国家
					if(null == eri.getCountry() || eri.getCountry() == 1) {
						if(null != edri.getInt_value()) {
							try{
								if(edri.getInt_value()<new Integer(project.getCountry())) {
									eri.setCountry(1);
								} else {
									eri.setCountry(0);
									num+=eq.getWeight();
								}
							}catch(Exception e) {
								eri.setCountry(1);
							}
						} else {
							eri.setCountry(1);
						}
					} else {
						eri.setCountry(1);
					}
				} else if(hotspots.equals(code)) { //移民目的
					if(null == eri.getHotspots() || eri.getHotspots() == 1) {
						if(null != edri.getInt_value()) {
							try{
								Country country = Country.dao.findFirst("select * from crm_country where country_id = "+project.getCountry()+" and delete_flag=0");
								if(null != country && null !=country.getHotspotsId() && edri.getInt_value()< new Integer(country.getHotspotsId())) {
									eri.setHotspots(1);
								} else {
									eri.setHotspots(0);
									num+=eq.getWeight();
								}
							}catch(Exception e) {
								eri.setHotspots(1);
							}
						} else {
							eri.setHotspots(1);
						}
					} else {
						eri.setHotspots(1);
					}
				} else if(asset.equals(code)) { //资产要求
					if(null == eri.getAsset() || eri.getAsset() == 1) {
						if(null != edri.getInt_value()) {
							try{
								if(edri.getInt_value()<new Integer(project.getAsset())) {
									eri.setAsset(1);
								} else {
									eri.setAsset(0);
									num+=eq.getWeight();
								}
							}catch(Exception e) {
								eri.setAsset(1);
							}
						} else {
							eri.setAsset(1);
						}
					} else {
						eri.setAsset(1);
					}
				} else if(immigration_budget.equals(code)) { //移民预算
					if(null == eri.getAsset() || eri.getAsset()==1) {
						for(EstimatetDetailRecordInfo dr:edriList) {
							EstimateQuestion eqn = dr.getEstimateQuestion();
							String dcode = eq.getDictCode();
							String danswer = eq.getAnswer();
							if(asset.equals(dcode)) {
								if(danx.equals(danswer) || duox.equals(danswer)) {
									List<EstimateSelectAdditional> esas= dr.getEsaList();
									if(null != esas && esas.size()>0) {
										for(EstimateSelectAdditional desa:esas) {
											if(null ==eri.getAsset() || eri.getAsset() == 1) {
												if(project.getAsset().equals(desa.getDictCode())) {
													eri.setAsset(0);
													num+=eq.getWeight();
												} else {
													eri.setAsset(1);
												}
											}
										}
									}
								} else if(wenb.equals(danswer)){
									if(null == eri.getAsset() || eri.getAsset() == 1) {
										if(null != edri.getInt_value()) {
											try{
												if(edri.getInt_value()<new Integer(project.getAsset())) {
													eri.setAsset(1);
												} else {
													eri.setAsset(0);
													num+=eq.getWeight();
												}
											}catch(Exception e) {
												eri.setAsset(1);
											}
										} else {
											eri.setAsset(1);
										}
									} else {
										eri.setAsset(1);
									}
								}
							}
						}
					}
					
					if(null == eri.getAsset() || eri.getAsset()==1) {
						eri.setImmigration_budget(1);
					} else if(eri.getAsset() == 0) {
						if(null != edri.getInt_value()) {
							if(edri.getInt_value()<project.getImmigrationBudget()) {
								eri.setImmigration_budget(2);
								num+=(eq.getWeight()/2);
							} else {
								eri.setImmigration_budget(0);
								num+=eq.getWeight();
							}
						} else {
							eri.setImmigration_budget(1);
						}
					}
					
				} else if(qualifications.equals(code)) { //学历要求
					if(null == eri.getQualifications() || eri.getQualifications() == 1) {
						if(null != edri.getInt_value()) {
							try{
								if(edri.getInt_value()<new Integer(project.getQualifications())) {
									eri.setQualifications(1);
								} else {
									eri.setQualifications(0);
									num+=eq.getWeight();
								}
							}catch(Exception e) {
								eri.setQualifications(1);
							}
						} else {
							eri.setQualifications(1);
						}
					} else {
						eri.setQualifications(1);
					}
				} else if(language.equals(code)) { //外语能力
					if(null == eri.getLanguage() || eri.getLanguage() == 1) {
						if(null != edri.getInt_value()) {
							try{
								if(edri.getInt_value()<new Integer(project.getLanguage())) {
									eri.setLanguage(1);
								} else {
									eri.setLanguage(0);
									num+=eq.getWeight();
								}
							}catch(Exception e) {
								eri.setLanguage(1);
							}
						} else {
							eri.setLanguage(1);
						}
					} else {
						eri.setLanguage(1);
					}
				} else if(manage.equals(code)) { //管理经验
					if(null == eri.getManage() || eri.getManage() == 1) {
						if(null != edri.getInt_value()) {
							try{
								if(edri.getInt_value()<new Integer(project.getManage())) {
									eri.setManage(1);
								} else {
									eri.setManage(0);
									num+=eq.getWeight();
								}
							}catch(Exception e) {
								eri.setManage(1);
							}
						} else {
							eri.setManage(1);
						}
					} else {
						eri.setManage(1);
					}
				} else if(live_requirement.equals(code)) { //居住条件
					if(null == eri.getLive_requirement() || eri.getLive_requirement() == 1) {
						if(null != edri.getInt_value()) {
							try{
								if(edri.getInt_value()<new Integer(project.getLiveRequirement())) {
									eri.setLive_requirement(1);
								} else {
									eri.setLive_requirement(0);
									num+=eq.getWeight();
								}
							}catch(Exception e) {
								eri.setLive_requirement(1);
							}
						} else {
							eri.setLive_requirement(1);
						}
					} else {
						eri.setLive_requirement(1);
					}
				} else if(age.equals(code)) { //年龄要求
					if(null == eri.getAge() || eri.getAge() == 1) {
						if(null != edri.getInt_value()) {
							try{
								if(edri.getInt_value()<new Integer(project.getAge())) {
									eri.setAge(1);
								} else {
									eri.setAge(0);
									num+=eq.getWeight();
								}
							}catch(Exception e) {
								eri.setAge(1);
							}
						} else {
							eri.setAge(1);
						}
					} else {
						eri.setAge(1);
					}
				}
			}
		}
		
		if(num>weight_value || num==weight_value) {
			eri.setMatching(num);
			eri.setProjectId(project.getProjectId());
			eri.setProjectName(project.getProjectName());
			eri.setRecommended(new Integer(project.getRecommended()));
			eri.setOnline_time(project.getOnlineTime());
			return eri;
		}
		return null;
	}
	
	private int getStringNum(String str) {
		  String E1 = "[\u4e00-\u9fa5]";// 中文
	        String E2 = "[a-zA-Z]";// 英文
	        String E3 = "[0-9]";// 数字
	 
	        int chineseCount = 0;
	        int englishCount = 0;
	        int numberCount = 0;
	 
	        String temp;
	        for (int i = 0; i < str.length(); i++)
	        {
	            temp = String.valueOf(str.charAt(i));
	            if (temp.matches(E1))
	            {
	                chineseCount++;
	            }
	            if (temp.matches(E2))
	            {
	                englishCount++;
	            }
	            if (temp.matches(E3))
	            {
	                numberCount++;
	            }
	        }
	        
	        int ts =  (str.length() - (chineseCount + englishCount + numberCount));
	        return chineseCount*2+englishCount+numberCount+ts;
	}
	
}
