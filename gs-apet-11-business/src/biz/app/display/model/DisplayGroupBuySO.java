package biz.app.display.model;

import java.util.List;

import lombok.Data;
import lombok.EqualsAndHashCode;
import framework.common.model.BaseSearchVO;

@Data
@EqualsAndHashCode(callSuper=false)
public class DisplayGroupBuySO extends BaseSearchVO<DisplayGroupBuySO> {

	/** UID */
	private static final long serialVersionUID = 1L;
	
	/** 상품 번호 */
	private String goodsId;
	
	/** Site ID */
	private Long stId;
	
	/** 회원번호  */
	private Long mbrNo;
	
	/** 웹모바일 구분  */
	private List<String> webMobileGbCds;
	private String webMobileGbCd;
	
	/** 정렬 기준 */
	private String sortType;
	
	/** 필터링 구분 타입 */
	private String goodsInYn;
	/** 필터링할 상품 ID */
	private List<String> goodsIds;
	
	/** 상품이 속한 페이지 */
	private Integer goodsPage;
	
	/** 전시 분류 코너 번호 */
	private Long dispClsfCornNo;
	
}