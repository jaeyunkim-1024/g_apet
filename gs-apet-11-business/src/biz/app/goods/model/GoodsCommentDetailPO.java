package biz.app.goods.model;

import framework.common.model.BaseSysVO;
import lombok.Data;
import lombok.EqualsAndHashCode;

import java.sql.Timestamp;

@Data
@EqualsAndHashCode(callSuper=false)
public class GoodsCommentDetailPO extends BaseSysVO {

	/** UID */
	private static final long serialVersionUID = 1L;

	/** 상품 평가 번호 */
	private Long goodsEstmNo;
	private String[] goodsEstmNos;
	
	/* 후기 유형 코드 */
	private String goodsEstmTp;
	
	/* 상품id */
	private String goodsId;
	
	/* 평가회원번호 */
	private String estmMbrNo;

	/** 상품 베스트 설정 */
	private String goodsBestYn;

	/** 사이트 아이디 */
	private Long stId;

	/** 베스트 설정 */
	private String bestYn;

	/** 전시 여부 */
	private String dispYn;

	/** 제제 */
	private String snctYn;

	/** 제재 알럿 메시지 */
	private String snctRsn;

	/** 시스템 삭제 사유(알림 메시지) */
	private String sysDelRsn;
}