package biz.app.goods.model;

import framework.common.model.BaseSysVO;
import lombok.Data;
import lombok.EqualsAndHashCode;

@Data
@EqualsAndHashCode(callSuper=false)
public class GoodsCommentDetailReplyVO extends BaseSysVO {

	/** UID */
	private static final long serialVersionUID = 1L;

	/* 순번 */
	private Integer rownum;

	/* 평가 문항 내용 */
	private String qstContent;
	/* 평가 문항 분류 */
	private String qstClsf;
	/* 평가 문항 내용 사용 여부 */
	private String useYn;
	/* 평가 답변 유형 코드 */
	private String rplTpCd;
	/* 평가 답변 내용 */
	private String itemContent;
	/* 평가 전시 순서 */
	private String dispSeq;
	/* 상품 답변 번호 */
	private String estmRplNo;
	/* 상품평 번호 */
	private String goodsEstmNo;
	/* 평가 그룹 번호(fk) */
	private String estmGrpNo;
	/* 평가 문항 순번(fk) */
	private String estmQstSeq;
	/* 평가 항목 번호(fk) */
	private String estmItemNo;
	/* 평가 점수 */
	private String estmScore;
	/* 회원 번호 */
	private String mbrNo;
	/* 회원 번호 */
	private String loginId;
	/* 상품평 액션 코드 */
	private String goodsEstmActnCd;
	/* 신고 사유 코드 */
	private String rptpRsnCd;
	/* 신고 사유 코드 명 */
	private String rptpRsnNm;
	/* 신고 사유 내용 */
	private String rptpRsnContent;
	private String rptpContent;
	
	

}