package biz.app.display.model;

import java.sql.Timestamp;
import java.util.List;

import lombok.Data;
import lombok.EqualsAndHashCode;
import framework.common.model.BaseSysVO;

@Data
@EqualsAndHashCode(callSuper=false)
public class DisplayCornerPO extends BaseSysVO {

	/** UID */
	private static final long serialVersionUID = 1L;

	/** 사이트 명 */
	private Long stId;
	
	/** 전시 코너 번호 */
	private Long dispCornNo;

	/** 템플릿 번호 */
	private Long tmplNo;

	/** 전시 코너 설명 */
	private String dispCornDscrt;
	
	/** 노출 개수 */
	private Integer showCnt;
	
	/** 전시 우선 순위*/
	private Integer dispPriorRank;

	/** 전시 코너 타입 코드 */
	private String dispCornTpCd;
	
	/** 전시 코너 타입 코드 변경 여부*/
	private String orgValue;

	/** 전시 코너명 */
	private String dispCornNm;

	/** 전시 시작일자 */
	private Timestamp dispStrtdt;

	/** 전시 종료일자 */
	private Timestamp dispEnddt;

	/** 전시 분류 번호 */
	private Long dispClsfNo;
	
	/** 전시 분류 코너 번호 */
	private Long dispClsfCornNo;
	
	/** 전시 여부 */
	private String dispYn;
	
	/** 메인 상품 구좌 찜 상태  때문에...추가함*/
	private Long mbrNo;	
	
	/**웹.모바일 구분 ...추가함*/
	private String webMobileGbCd;
	
	/** 신규 전시 코너 번호 */
	private Long dispCornNoNew;
	
	/** 베스트 전시 코너 번호 */
	private Long dispCornNoBest;	
	
	/** 전시 코너 리스트*/
	private List<DisplayCornerPO> displayCornerPOlist;
}