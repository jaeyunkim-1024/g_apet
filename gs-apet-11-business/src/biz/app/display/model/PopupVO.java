package biz.app.display.model;

import java.sql.Timestamp;
import java.util.List;

import framework.common.model.BaseSysVO;
import lombok.Data;
import lombok.EqualsAndHashCode;

@Data
@EqualsAndHashCode(callSuper=false)
public class PopupVO extends BaseSysVO {

	/** UID */
	private static final long serialVersionUID = 1L;

	/** 팝업 번호 */
	private Integer popupNo;

	/** 팝업 명 */
	private String popupNm;

	/** 서비스 구분 코드 */
	private String svcGbCd;

	/** 사이트 구분 코드 */
	private String stGbCd;

	/** 전시 여부 */
	private String dispYn;

	/** 가로 크기 */
	private Long wdtSz;

	/** 세로 크기 */
	private Long heitSz;

	/** 내용 */
	private String content;

	/** 위치 TOP */
	private Long pstTop;

	/** 위치 LEFT */
	private Long pstLeft;

	/** 전시 시작 일시 */
	private Timestamp dispStrtDtm;

	/** 전시 종료 일시 */
	private Timestamp dispEndDtm;

	/** 사이트 ID */
	private Integer stId;

	/** 사이트 명 */
	private String stNm;

	/** 팝업 유형 코드 */ 
	private String  popupTpCd;
	
	/** 팝업 상품 정보 */
	private List<PopupGoodsVO> goodsList; 

}