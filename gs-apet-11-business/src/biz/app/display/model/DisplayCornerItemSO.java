package biz.app.display.model;

import java.sql.Timestamp;

import lombok.Data;
import lombok.EqualsAndHashCode;
import framework.common.model.BaseSearchVO;

@Data
@EqualsAndHashCode(callSuper=false)
public class DisplayCornerItemSO extends BaseSearchVO<DisplayCornerItemSO> {

	/** UID */
	private static final long serialVersionUID = 1L;

	/** 전시 분류 코너 번호 */
	private Long dispClsfCornNo;

	/** 전시 배너 번호 */
	private Long dispBnrNo;
	
	/** 배너 번호*/
	private String bnrNo;
	
	/** 영상 번호*/
	private String vdId;

	/** 전시 시작일자 */
	private Timestamp dispStrtdt;

	/** 전시 종료일자 */
	private Timestamp dispEnddt;

	/** 전시 우선 순위 */
	private Long dispPriorRank;

	/** 삭제 여부 */
	private String delYn;

	/** 상품평 번호 */
	private Long goodsEstmNo;

	/** 상품 번호 */
	private String goodsId;

	/** 상품 TEXT */
	private String goodsText;

	/** 전시 코너 타입 코드 */
	private String dispCornTpCd;

	/** 아이템 번호 */
	private Long dispCnrItemNo;
	
	/** 전시 분류 번호 */
	private Long dispClsfNo;
	
	/** 태그 번호 */
	private String tagNo;
	
	/** 회원 번호 */
	private Long mbrNo;
	
	/** 펫로그 번호 */
	private Long petLogNo;
	
	/** 시리즈 번호*/
	private Long srisNo;
	
	/** 전시 코너 번호 */
	private Long dispCornNo;
	
	/** 미리보기 날짜 */
	private String previewDt;
	
	/** 전시코너 아이템 갯수 */
	private int itemLength;
}