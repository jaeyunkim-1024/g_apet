package biz.app.contents.model;

import framework.common.model.BaseSysVO;
import lombok.Data;
import lombok.EqualsAndHashCode;

@Data
@EqualsAndHashCode(callSuper=false)
public class ApetContentsGoodsMapVO extends BaseSysVO {

	/** UID */
	private static final long serialVersionUID = 1L;

	/** 영상 ID */
	private String vdId;

	/** 상품 번호 */
	private String goodsId;
	
	/** apet 첨부파일 경로 */
	private String phyPath;
	
	/** apet 컨텐츠 타입 */
	private String contsTpCd;

	/** 이력 번호 */
	private Long histNo;
}