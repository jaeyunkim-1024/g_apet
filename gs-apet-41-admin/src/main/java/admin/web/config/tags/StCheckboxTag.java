package admin.web.config.tags;

import java.util.ArrayList;
import java.util.List;

import javax.servlet.jsp.JspException;
import javax.servlet.jsp.tagext.TagSupport;

import org.apache.commons.collections.CollectionUtils;
import org.apache.commons.lang.StringUtils;
import org.springframework.context.ApplicationContext;
import org.springframework.web.context.support.WebApplicationContextUtils;

import biz.app.st.model.StStdInfoSO;
import biz.app.st.model.StStdInfoVO;
import biz.app.st.service.StService;
import framework.admin.model.Session;
import framework.admin.util.AdminSessionUtil;
import framework.common.constants.CommonConstants;
import lombok.extern.slf4j.Slf4j;

/** 사이트 목록  checkbox custom Tag
 *
* <pre>
* - 프로젝트명	: 41.admin.web
* - 패키지명	: admin.web.config.tags
* - 파일명		: StCheckboxTag.java
* - 작성일		: 2017. 1. 9.
* - 작성자		: hjko
* - 설명		:
* </pre>
 */
@Slf4j
public class StCheckboxTag extends TagSupport {

	private static final long serialVersionUID = 1L;

	private List<StStdInfoVO> selectKey;

	private String name = "stId";

	private Long compNo;

	private Long stId;

	private Boolean disabled = false;

	private Boolean required = false;

	private Boolean selectKeyOnly = false;

	public List<StStdInfoVO> getSelectKey() {
		//return selectKey;
		
		//보안진단 처리-Public 메소드로부터 반환된 Private 배열
		List<StStdInfoVO> copySelectKey = new ArrayList<>();
		if(this.selectKey != null){
			copySelectKey.addAll(this.selectKey);
		}
		return copySelectKey;
	}
	public void setSelectKey(List<StStdInfoVO> selectKey) {
		//this.selectKey = selectKey;
		//보안진단 처리-Private 배열에 Public 데이터 할당
		this.selectKey = new ArrayList<StStdInfoVO>();
		if(selectKey != null){
			this.selectKey.addAll(selectKey);
		}
	}

	public Long getCompNo() {
		return compNo;
	}
	public void setCompNo(Long compNo) {
		this.compNo = compNo;
	}

	public Long getStId() {
		return stId;
	}

	public void setStId(Long stId) {
		this.stId = stId;
	}

	public Boolean setDisabled() {
		return disabled;
	}

	public void setDisabled(Boolean disabled) {
		this.disabled = disabled;
	}

	public void setRequired(Boolean required) {
		this.required = required;
	}

	public void setSelectKeyOnly(Boolean selectKeyOnly) {
		this.selectKeyOnly = selectKeyOnly;
	}

	public void setName(String name) {
		this.name = name;
	}

	@Override
	public int doStartTag() throws JspException {

		ApplicationContext ac = WebApplicationContextUtils.getWebApplicationContext(pageContext.getServletContext());
		StService stService = (StService) ac.getBean("stService");

		StStdInfoSO so = new StStdInfoSO();
		if(compNo != null){
			so.setCompNo(compNo);
		}
		if(stId != null){
			so.setStId(stId);
		}

		List<StStdInfoVO> list = stService.getStList(so);

		StringBuilder sb = new StringBuilder (1024);

		try {

			Session session = AdminSessionUtil.getSession();
			if(session != null && CollectionUtils.isNotEmpty(list)) {
				List<Long> checkedStIdList = new ArrayList<>();
				List<String> checkedStNmList = new ArrayList<>();
				for(StStdInfoVO vo : list){
					String checked = "";

					if(selectKey != null){
						for(StStdInfoVO sk : selectKey){
							if(sk.getStId().equals(vo.getStId())){
								checked = "checked";
							}
						}
					}
					if (list.size() == 1) {
						// 사이트가 1개일 때는 기본으로 checked 표시함.
						checked = "checked";
					}
					if (selectKeyOnly && (! StringUtils.equals(checked, "checked"))) {
						continue;
					}

					if(vo.getCheckedYn() != null && vo.getCheckedYn().equals("Y")){
						checkedStIdList.add(vo.getStId());
						checkedStNmList.add(vo.getStNm());
					}
					sb.append("<label class=\"fCheck\"><input type=\"checkbox\" name=\"").append(name).append("\" id=\"").append("st_").append(vo.getStId()).append("\" ").append("value=\"").append(vo.getStId()).append("\" ");
					if(required) {
						sb.append("class=\"validate[required]\" ");
					}
					if(disabled) {
						sb.append("disabled=\"disabled\" ");
					}
					sb.append(checked+"> <span>").append(vo.getStNm()).append("</span></label>");
				}
				String checkedCompStIds =  StringUtils.join(checkedStIdList,",");
				String checkedCompStNms = StringUtils.join(checkedStNmList,",");
				sb.append("<input type=\"hidden\" id=\"checkedCompStIds\" name=\"checkedCompStIds\" value='").append(checkedCompStIds).append("' />");
				sb.append("<input type=\"hidden\" id=\"checkedCompStNms\" name=\"checkedCompStNms\" value='").append(checkedCompStNms).append("' />");
			}


			this.pageContext.getOut().write(sb.toString() );
			return SKIP_BODY;
		} catch (Exception e) {
			log.error(CommonConstants.LOG_EXCEPTION_STACK_TRACE, e);
			return SKIP_BODY;
		}
	}
}
