package admin.web.config.tags;

import java.util.List;
import java.util.Objects;
import java.util.Optional;

import javax.servlet.jsp.JspException;
import javax.servlet.jsp.tagext.TagSupport;

import org.apache.commons.collections.CollectionUtils;
import org.apache.commons.lang.StringUtils;
import org.springframework.context.ApplicationContext;
import org.springframework.web.context.support.WebApplicationContextUtils;
import biz.app.system.model.CodeDetailVO;
import biz.common.service.CacheService;
import framework.common.constants.CommonConstants;
import framework.common.util.StringUtil;
import lombok.extern.slf4j.Slf4j;

/**
 * <pre>
 * - 프로젝트명	: 41.admin.web
 * - 패키지명		: admin.web.config.tags
 * - 파일명		: SelectTag.java
 * - 작성일		: 2020. 4. 10.
 * - 작성자		: VALFAC
 * - 설 명			: 셀렉트 박스 Tag
 * </pre>
 */
@Slf4j
public class QuikBtnTag extends TagSupport {

    private static final long serialVersionUID = 1L;

    private String grpCd;

    private String name;

    private String selectKey;

    private String defaultName;

    private boolean readOnly;

    private String[] excludeOptionArray;

    private Boolean selectKeyOnly = false;

    private String useYn;

    /** 참조1문자값 */
    private String usrDfn1Val;

    /** 참조2문자값 */
    private String usrDfn2Val;

    /** 참조3문자값 */
    private String usrDfn3Val;

    /** 참조4문자값 */
    private String usrDfn4Val;

    /** 참조5문자값 */
    private String usrDfn5Val;

    /** 코드값 표현 */
    private Boolean showValue;

    public void setName(String name) {
        this.name = name;
    }

    public void setGrpCd(String grpCd) {
        this.grpCd = grpCd;
    }

    public void setSelectKey(String selectKey) {
        this.selectKey = selectKey;
    }

    public void setDefaultName(String defaultName) {
        this.defaultName = defaultName;
    }

    public void setReadOnly(boolean readOnly) {
        this.readOnly = readOnly;
    }

    public void setExcludeOption(String excludeOption) {
        this.excludeOptionArray = StringUtils.split(excludeOption, ",");
    }

    public void setSelectKeyOnly(Boolean selectKeyOnly) {
        this.selectKeyOnly = selectKeyOnly;
    }

    public void setUseYn(String useYn) {
        this.useYn = useYn;
    }

    public void setUsrDfn1Val(String usrDfn1Val) {
        this.usrDfn1Val = usrDfn1Val;
    }

    public void setUsrDfn2Val(String usrDfn2Val) {
        this.usrDfn2Val = usrDfn2Val;
    }

    public void setUsrDfn3Val(String usrDfn3Val) {
        this.usrDfn3Val = usrDfn3Val;
    }

    public void setUsrDfn4Val(String usrDfn4Val) {
        this.usrDfn4Val = usrDfn4Val;
    }

    public void setUsrDfn5Val(String usrDfn5Val) {
        this.usrDfn5Val = usrDfn5Val;
    }

    public void setShowValue(Boolean showValue) {
        this.showValue = showValue;
    }

    @Override
    public int doStartTag() throws JspException {
        try {
            ApplicationContext ac = WebApplicationContextUtils.getWebApplicationContext(pageContext.getServletContext());
            CacheService cacheService = ac.getBean(CacheService.class);

            StringBuilder sb = new StringBuilder();
            List<CodeDetailVO> list = cacheService.listCodeCache(grpCd, StringUtils.equalsIgnoreCase(CommonConstants.COMM_YN_Y, this.useYn), usrDfn1Val, usrDfn2Val, usrDfn3Val, usrDfn4Val, usrDfn5Val);

            if(CollectionUtils.isNotEmpty(list)) {
                if(StringUtil.isNotBlank(defaultName)){
                    sb.append("<label class=\"fQuik\"><span class=\"quikBtn\">").append(defaultName).append("<input type=\"radio\" style=\"display:none\" name=\"").append(name).append("\"/>").append("</span></label>");
                }

                for(CodeDetailVO vo : list) {
                    if (isExcludeOption(vo, excludeOptionArray) || (selectKeyOnly && !isOnlySelectKey(vo, selectKey))) {
                        continue;
                    }

                    boolean selected = StringUtil.isNotBlank(selectKey) && selectKey.equals(vo.getDtlCd());
                    sb.append("<label class=\"fQuik\"><span class=\"quikBtn");
                    if(selected){
                        sb.append(" select-quik-btn");
                    }
                    sb.append("\">");
                    sb.append("<a href=\"#\">"+vo.getDtlNm()+"</a>");
                    sb.append("<input type=\"radio\" style=\"display:none\" name=\"");
                    sb.append(name);
                    sb.append("\"");
                    sb.append("data-usrdfn1=\"").append(Optional.ofNullable(vo.getUsrDfn1Val()).orElseGet(()->"")).append("\" ");
                    sb.append("data-usrdfn2=\"").append(Optional.ofNullable(vo.getUsrDfn2Val()).orElseGet(()->"")).append("\" ");
                    sb.append("data-usrdfn3=\"").append(Optional.ofNullable(vo.getUsrDfn3Val()).orElseGet(()->"")).append("\" ");
                    sb.append("value=\"");
                    sb.append(vo.getDtlCd());
                    sb.append("\"");
                    if(selected){
                        sb.append("checked");
                    }

                    sb.append("/>");
                    sb.append("</span></label>");
                }
            } else {
                sb.append("<label class=\"fQuik\">").append(("<span class=\"quikBtn\">")).append("해당 없음").append("</span></label>");
            }
            this.pageContext.getOut().write(sb.toString());
            return SKIP_BODY;
        } catch (Exception e) {
            log.error(CommonConstants.LOG_EXCEPTION_STACK_TRACE, e);
            return SKIP_BODY;
        }
    }

    private boolean isExcludeOption(CodeDetailVO vo, String[] excludeOptionArray) {
        boolean excludeOption = false;

        if (Objects.isNull(excludeOptionArray)) {
            return excludeOption;
        }

        for (int idx = 0; idx < excludeOptionArray.length; idx++) {
            if (StringUtils.equalsIgnoreCase(excludeOptionArray[idx], vo.getDtlCd())) {
                excludeOption = true;
            }
        }

        return excludeOption;
    }

    private boolean isOnlySelectKey(CodeDetailVO vo, String selectKey) {

        return StringUtils.equalsIgnoreCase(vo.getDtlCd(), selectKey);
    }
}