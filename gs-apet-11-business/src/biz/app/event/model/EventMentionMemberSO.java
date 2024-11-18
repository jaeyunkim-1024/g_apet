package biz.app.event.model;

import framework.common.model.BaseSearchVO;
import lombok.Data;
import lombok.EqualsAndHashCode;

@Data	
@EqualsAndHashCode(callSuper=false)
public class EventMentionMemberSO extends BaseSearchVO<EventMentionMemberSO>{
	 /** UID */
	private static final long serialVersionUID = 1L;
	
	/*언급 번호*/	
	private Long srlNo;
	
	/*이벤트 번호*/
	private Long eventNo;
	
	/*댓글 번호*/
	private int aplyNo;
	
	/*멘션 순번*/
	private int metnSeq;
	
	/*언급 회원 번호 */
	private Long metnTgMbrNo;
	
	/* 댓글 등록 회원 번호 */
	private Long metnMbrNo;
	
	/** 회원명 */
	private String nickNm;
}
