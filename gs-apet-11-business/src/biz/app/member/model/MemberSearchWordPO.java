package biz.app.member.model;

import framework.common.model.BaseSysVO;
import lombok.Data;
import lombok.EqualsAndHashCode;

@Data
@EqualsAndHashCode(callSuper=false)
public class MemberSearchWordPO extends BaseSysVO {

	/** UID */
	private static final long serialVersionUID = 1L;

	/** 회원 번호 */
	private Long mbrNo;
	
	/** 검색 구분 코드 */
	private String srchGbCd;
	
	/** 검색어 */
	private String srchWord;
	
	/** 순번 */
	private Long seq;
}