package biz.app.appweb.model;

import framework.common.model.BaseSearchVO;
import lombok.Data;
import lombok.EqualsAndHashCode;

import java.sql.Timestamp;

/**
 * <pre>
 * - 프로젝트명	: 11.business
 * - 패키지명		: biz.app.appweb.model
 * - 파일명		: PushSO.java
 * - 작성일		: 2020. 12. 21.
 * - 작성자		: hjh
 * - 설 명		: push/문자 발송 Search Object
 * </pre>
 */
@Data
@EqualsAndHashCode(callSuper=false)
public class NoticeSendSO extends BaseSearchVO<NoticeSendSO> {
    /** UID */
    private static final long serialVersionUID = 1L;

    /** 이력 통지 번호 */
    private Long noticeSendNo;

    /** 발송 방식 */
    private String noticeTypeCd;

    /** 전송 방식 */
    private String sndTypeCd;

    /** 카테고리 */
    private String ctgCd;

    /** 발송일자  시작 일시*/
    private Timestamp sendReqStrtDtm;
    /** 발송일자  종료 일시*/
    private Timestamp sendReqEndDtm;

    /** 발송 결과*/
    private String sndRstCd;

    /** 템플릿 번호 */
    private Long tmplNo;
    
    /** 시스템 코드*/
    private String sysCd;
    /** 시스템 코드 배열 */
    private String[] sysCds;

    /** 요청 결과 코드 */
    private String reqRstCd;

}
