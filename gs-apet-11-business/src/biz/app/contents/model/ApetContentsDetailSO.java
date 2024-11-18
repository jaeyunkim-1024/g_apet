package biz.app.contents.model;

import framework.common.model.BaseSysVO;
import lombok.Data;
import lombok.EqualsAndHashCode;

@Data
@EqualsAndHashCode(callSuper=false)
public class ApetContentsDetailSO extends BaseSysVO {

	/** UID */
	private static final long serialVersionUID = 1L;

	/** 회원번호 */
	private Long mbrNo;
	
	/** 영상 ID */
	private String vdId;
	
	/** 단계 번호 */
	private Long stepNo;

	/** 파일 번호 */
	private Long flNo;
	
	/** 제목 */
	private String ttl;
	
	/** 설명 */
	private String dscrt;
	
	/** 순번 */
	private Long seq;

	/** 컨텐츠 유형 코드 */
	private String contsTpCd;

	/** 물리 경로 */
	private String phyPath;

	/** 원 파일 명 */
	private String orgFlNm;

	/** 파일 크기 */
	private Long flSz;
	
	/** 영상 외부 ID */
	private String outsideVdId;

	/** 영상 길이 */
	private Long vdLnth;
	
	/** 펫 구분 코드 */
	private String petGbCd;
	
	/** 교육상세에서 다음교육을 위해 페이지 이동횟수 */
	private int histCnt = 0;
	
	/** 교육상세에서 로그인을 위해 페이지 이동횟수 */
	private int histLoginCnt=0;
	
	/** 공유하기등의 링크를 통해 진입 여부 */
	private String linkYn;
	
	/** 연관상품 바텀시트 오픈 후 페이지 이동시 값 셋팅 */
	private String goodsVal;

}