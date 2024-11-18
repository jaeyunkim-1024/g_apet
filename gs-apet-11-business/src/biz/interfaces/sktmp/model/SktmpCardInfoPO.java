package biz.interfaces.sktmp.model;

import framework.common.model.BaseSysVO;
import lombok.Data;
import lombok.EqualsAndHashCode;

/**
 * <pre>
 * - 프로젝트명	: gs-apet-11-business
 * - 패키지명	: biz.interfaces.sktmp.model
 * - 파일명		: SktmpCardInfoPO.java
 * - 작성일		: 2021. 08. 06.
 * - 작성자		: hjh
 * - 설명		: SKTMP 카드 정보 PO
 * </pre>
 */
@Data
@EqualsAndHashCode(callSuper=false)
public class SktmpCardInfoPO extends BaseSysVO {
	/** UID */
	private static final long serialVersionUID = 1L;
	
	/** 카드 정보 번호 */
    private Long cardInfoNo;
    
    /** 회원 번호 */
    private Long mbrNo;
    
    /** 카드 번호 */
    private String cardNo;
    
    /** PIN 번호 */
    private String pinNo;
    
    /** 사용 여부 */
    private String useYn;

    /** 기본 여부 */
    private String dfltYn;
    
    /** 정렬 순서 */
    private Integer sortSeq;
    
    /** 약관번호 */
	private String[] termsNo;

}
