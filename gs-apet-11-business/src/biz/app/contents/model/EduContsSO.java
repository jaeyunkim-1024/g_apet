package biz.app.contents.model;

import lombok.Data;
import lombok.EqualsAndHashCode;

@Data
@EqualsAndHashCode(callSuper=false)
public class EduContsSO extends VodSO {

	/** UID */
	private static final long serialVersionUID = 1L;

	/** 교육용 컨텐츠 카테고리_L_코드 */
	private String eudContsCtgLCd;
	
	/** 교육용 컨텐츠 카테고리_M_코드 */
	private String eudContsCtgMCd;
	
	/** 교육용 컨텐츠 카테고리_S_코드 */
	private String eudContsCtgSCd;
	
	/** 교육완료 후 펫로그 등록 여부 */
	private String petLogYn;
	
	/** 교육완료에서 다음교육을 위해 페이지 이동횟수 */
	private int histCnt=0;
	
	/** 교육완료에서 로그인을 위해 페이지 이동횟수 */
	private int histLoginCnt=0;
	
	/** 공유하기등의 링크를 통해 진입 여부 */
	private String linkYn;
	
}