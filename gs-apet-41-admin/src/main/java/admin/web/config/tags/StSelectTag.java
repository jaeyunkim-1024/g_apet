package admin.web.config.tags;

import java.util.ArrayList;
import java.util.List;

import javax.servlet.jsp.JspException;
import javax.servlet.jsp.tagext.TagSupport;

import org.apache.commons.collections.CollectionUtils;
import org.springframework.context.ApplicationContext;
import org.springframework.web.context.support.WebApplicationContextUtils;

import biz.app.st.model.StStdInfoSO;
import biz.app.st.model.StStdInfoVO;
import biz.app.st.service.StService;
import framework.admin.model.Session;
import framework.admin.util.AdminSessionUtil;
import framework.common.constants.CommonConstants;
import framework.common.util.StringUtil;
import lombok.extern.slf4j.Slf4j;

/**
 *
* <pre>
* - 프로젝트명	: 41.admin.web
* - 패키지명	: admin.web.config.tags
* - 파일명		: StSelectTag.java
* - 작성일		: 2017. 1. 12.
* - 작성자		: hjko
* - 설명		:
* </pre>
 */
@Slf4j
public class StSelectTag extends TagSupport {

	private static final long serialVersionUID = 1L;

	private List<StStdInfoVO> selectKey;

	private String defaultName;

	private Long compNo;

	private Long stId;

	private boolean readOnly;

	public List<StStdInfoVO> getSelectKey() {
		//return selectKey;
		
		//보안진단 처리-Public 메소드로부터 반환된 Private 배열
		List<StStdInfoVO> copySelectKey = new ArrayList<>();
		copySelectKey.addAll(this.selectKey);
		
		return copySelectKey;
	}
	public void setSelectKey(List<StStdInfoVO> selectKey) {
		//this.selectKey = selectKey;
		//보안진단 처리-Private 배열에 Public 데이터 할당
		this.selectKey = new ArrayList<StStdInfoVO>();
		this.selectKey.addAll(selectKey);
	}

	public Long getCompNo() {
		return compNo;
	}
	public void setCompNo(Long compNo) {
		this.compNo = compNo;
	}

	public String getDefaultName() {
		return defaultName;
	}
	public void setDefaultName(String defaultName) {
		this.defaultName = defaultName;
	}
	public Long getStId() {
		return stId;
	}
	public void setStId(Long stId) {
		this.stId = stId;
	}
	public void setReadOnly(boolean readOnly) {
		this.readOnly = readOnly;
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
			if(session != null && CollectionUtils.isNotEmpty(list) ) {
				StringBuilder optionSelected = new StringBuilder(1024);

				if (list.size() > 1 && StringUtil.isNotBlank(defaultName)) {
					// 목록의 내용이 2개 이상일 때 defaultName 을 표시하도록 수정함.
					sb.append("<option value=\"\" >").append(defaultName).append("</option>");
				}

				for(StStdInfoVO vo : list){
					boolean selected = false;
					if(selectKey != null){
						for(StStdInfoVO sk : selectKey) {
							optionSelected = new StringBuilder(1024);
							if(sk.getStId().equals(vo.getStId())){
								optionSelected.append("selected=\"selected\" ");
								selected = true;
							}

							if (readOnly && ! selected) {
								optionSelected.append("disabled=\"disabled\" ");
							}
						}
					}

					sb.append("<option value=\"").append(vo.getStId()).append("\" ");
					sb.append("title=\"").append(vo.getStNm()).append("\" ").append(optionSelected);
					sb.append(">").append(vo.getStNm());
					sb.append("</option>");
				}
			}

			this.pageContext.getOut().write(sb.toString() );
			return SKIP_BODY;
		} catch (Exception e) {
			log.error(CommonConstants.LOG_EXCEPTION_STACK_TRACE, e);
			return SKIP_BODY;
		}
	}
}