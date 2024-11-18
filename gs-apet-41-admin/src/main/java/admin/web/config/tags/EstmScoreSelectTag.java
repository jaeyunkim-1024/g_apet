package admin.web.config.tags;

import biz.app.goods.service.GoodsCommentDetailService;
import biz.app.system.model.CodeDetailVO;
import framework.admin.model.Session;
import framework.admin.util.AdminSessionUtil;
import framework.common.constants.CommonConstants;
import framework.common.util.StringUtil;
import lombok.Getter;
import lombok.Setter;
import lombok.extern.slf4j.Slf4j;
import org.apache.commons.collections.CollectionUtils;
import org.springframework.context.ApplicationContext;
import org.springframework.web.context.support.WebApplicationContextUtils;

import javax.servlet.jsp.JspException;
import javax.servlet.jsp.tagext.TagSupport;
import java.util.List;

/**
 *
* <pre>
* - 프로젝트명	: 41.admin.web
* - 패키지명	: admin.web.config.tags
* - 파일명		: EstmScoreSelectTag.java
* - 작성일		: 2020. 01. 06.
* - 작성자		: yjs01
* - 설명		: 상품 후기 평점 관리.
* </pre>
 */
@Slf4j
@Getter @Setter
public class EstmScoreSelectTag extends TagSupport {

	private static final long serialVersionUID = 1L;

	private List<CodeDetailVO> selectKey;

	private String defaultName;

	/* 10점 척도, 5분위 게시 */
	private String grpCd;

	/* 상품 후기 평점 */
	private String usrDfn1Val;

	private boolean readOnly;

	@Override
	public int doStartTag() throws JspException {

		ApplicationContext ac = WebApplicationContextUtils.getWebApplicationContext(pageContext.getServletContext());
		GoodsCommentDetailService service = ac.getBean(GoodsCommentDetailService.class);

		List<CodeDetailVO> list = service.getGoodsCommentEstmScoreList();

		StringBuilder sb = new StringBuilder (1024);

		try {

			Session session = AdminSessionUtil.getSession();
			if(session != null && CollectionUtils.isNotEmpty(list) ) {
				StringBuilder optionSelected = new StringBuilder(1024);

				if (list.size() > 1 && StringUtil.isNotBlank(defaultName)) {
					// 목록의 내용이 2개 이상일 때 defaultName 을 표시하도록 수정함.
					sb.append("<option value=\"\" >").append(defaultName).append("</option>");
				}

				for(CodeDetailVO vo : list){
					boolean selected = false;
					if(selectKey != null){
						for(CodeDetailVO sk : selectKey) {
							optionSelected = new StringBuilder(1024);
							if(sk.getDtlCd().equals(vo.getDtlCd())){
								optionSelected.append("selected=\"selected\" ");
								selected = true;
							}

							if (readOnly && ! selected) {
								optionSelected.append("disabled=\"disabled\" ");
							}
						}
					}

					sb.append("<option value=\"").append(vo.getDtlCd()).append("\" ");
					sb.append("title=\"").append(vo.getUsrDfn1Val()).append("\" ").append(optionSelected);
					sb.append(">").append(vo.getUsrDfn1Val());
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