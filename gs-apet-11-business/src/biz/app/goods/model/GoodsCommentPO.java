package biz.app.goods.model;

import java.sql.Timestamp;

import framework.common.model.BaseSysVO;
import lombok.Data;
import lombok.EqualsAndHashCode;

@Data
@EqualsAndHashCode(callSuper=false)
public class GoodsCommentPO extends BaseSysVO {

	/** UID */
	private static final long serialVersionUID = 1L;

	/** 상품 평가 번호 */
	private Long goodsEstmNo;

	/** 제목 */
	private String ttl;

	/** 내용 */
	private String content;

	/** 평가 점수 */
	private Long estmScore;

	/** 추천 여부 */
	private String rcomYn;

	/** 상품 평가 유형 */
	private String goodsEstmTp;
	
	/** 조회수 */
	private Long hits;

	/** 시스템 삭제 여부 */
	private String sysDelYn;

	/** 시스템 삭제자 번호 */
	private Long sysDelrNo;

	/** 시스템 삭제 일시 */
	private Timestamp sysDelDtm;

	/** 시스템 삭제 사유 */
	private String sysDelRsn;

	/** 상품 아이디 */
	private String goodsId;

	/** 이미지 등록 여부 */
	private String imgRegYn;

	/** 평가 회원 번 */
	private Long estmMbrNo;

	/** 이미지 경로 */
	private String[] imgPath;
	
	/** 이미지 순번 */
	private String[] imgSeq;
	
	/** 이미지 삭제 순번 */
	private String[] deleteSeq;

	/** 업체 번호 */
	private Long compNo;
	
	/** 사이트 아이디 */
	private Long stId;

	
	/** 상품 평가 문항 */
	private Long[] estmQstNos;

	/** 상품 평가 항목 */
	private Long[] estmItemNos;
	
	/* 펫 정보 */
	/*펫 번호*/
	private Long petNo;
	/*펫 구분 코드*/
	private String petGbCd;
	/*펫 종류 */
	private String petKindNm;
	
	/*펫 이름*/
	private String petNm;
	
	/*펫 나이*/
	private String age;
	
	/*개월수*/
	private String month;
	
	/*생년월일*/
	private String birth;
	
	/*몸무게*/
	private Double weight;
	
	/*펫 성별*/
	private String petGdGbCd;
	
	/*중성화 여부*/
	private String fixingYn;
	
	/*알러지 여부*/
	private String allergyYn;

	/*염려질환 여부*/
	private String wryDaYn;

	/*펫 이미지 */
	private String petImgPath;
	
	/* 추가항목 */
	/** 주문 번호 */
	private String ordNo;
	/** 주문 상세 순번 */
	private Integer ordDtlSeq;
	/** 삭제 이미지 번호 */
	private Long[] delImgSeq;
	/** 상품 평가 번호 배열 */
	private Long[] estmRplNos;
	/** 상품 평가 신고 사유 코드 */
	private String rptpRsnCd;
	/** 신고 사유 내용 */
	private String rptpRsnContent;
	/** 상품평 액션 코드 */
	private String goodsEstmActnCd;

}