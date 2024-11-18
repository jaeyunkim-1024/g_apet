package biz.app.goods.model;

import java.sql.Timestamp;
import java.util.List;

import framework.common.model.BaseSysVO;
import lombok.Data;
import lombok.EqualsAndHashCode;

@Data
@EqualsAndHashCode(callSuper=false)
public class GoodsInquiryPO extends BaseSysVO {

	/** UID */
	private static final long serialVersionUID = 1L;

	/** 상품 문의 번호 */
	private Long goodsIqrNo;

	/** 문의 내용 */
	private String iqrContent;

	/** 답변 내용 */
	private String rplContent;

	/** 답변자 명 */
	private String rplrNm;

	/** 상품 문의 상태 코드 */
	private String goodsIqrStatCd;

	/** 문의 제목 */
	private String iqrTtl;

	/** 상품 아이디 */
	private String goodsId;

	/** 답변 일시 */
	private Timestamp rplDtm;

	/** 문의자 회원 번호 */
	private Long eqrrMbrNo;

	/** 답변자 사용자 번호 */
	private Long rplrUsrNo;

	/** 문의자 휴대전화번호 */
	private String eqrrMobile;

	/** 문의자 이메일 */
	private String eqrrEmail;

	/** 비밀글 여부 */
	private String hiddenYn;
	
	/** 답변알림 여부 */
	private String rplAlmRcvYn;
	
	// 추가[BO]
	/* 전시 여부 */
	private String dispYn;
	/* 비고 */
	private String bigo;
	/* 답변 내용 머리말 */
	private String rplContentHeader;
	/* 답변 내용 맺음말 */
	private String rplContentFooter;
	/* 전시여부 업데이트 */
	private String strDispYn;
	
	/* 사이트 아이디 */
	private Long stId;
	
	/* 이미지 경로 */
	private List<String> imgPaths;
	/* 삭제 이미지 번호 */
	private Long[] delImgSeqs;
	/* 이미지 번호 */
	private Long imgSeq;
	
}