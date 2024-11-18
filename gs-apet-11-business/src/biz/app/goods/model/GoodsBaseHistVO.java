package biz.app.goods.model;

import java.sql.Timestamp;

import lombok.Data;
import lombok.EqualsAndHashCode;
import framework.common.model.BaseSysVO;

@Data
@EqualsAndHashCode(callSuper=false)
public class GoodsBaseHistVO extends BaseSysVO {

	/** UID */
	private static final long serialVersionUID = 1L;

	/** 상품 기본 이력 번호 */
	//private Long goodsBaseHistNo;
	private Long histNo;

	/** 상품 명 */
	private String goodsNm;

	/** 상품 상태 코드 */
	private String goodsStatCd;

	/** 고시 아이디 */
	private String ntfId;

	/** 모델 명 */
	private String mdlNm;

	/** 업체 번호 */
	private Long compNo;

	/** 키워드 */
	private String kwd;

	/** 원산지 */
	private String ctrOrg;

	/** 최소 주문 수량 */
	private Long minOrdQty;

	/** 최대 주문 수량 */
	private Long maxOrdQty;

	/** 브랜드 번호 */
	private Integer bndNo;

	/** 배송 방법 코드 */
	private String dlvrMtdCd;

	/** 배송 정책 번호 */
	private Integer dlvrcPlcNo;

	/** 업체 정책 번호 */
	private Integer compPlcNo;

	/** 홍보 문구 */
	private String prWds;

	/** 무료 배송 여부 */
	private String freeDlvrYn;

	/** 수입사 */
	private String importer;

	/** 제조사 */
	private String mmft;

	/** 과세 구분 코드 */
	private String taxGbCd;

	/** 재고 관리 여부 */
	private String stkMngYn;

	/** MD 사용자 번호 */
	private Integer mdUsrNo;

	/** 인기 순위 */
	private Long pplrtRank;

	/** 인기 설정 코드 */
	private String pplrtSetCd;

	/** 상품 아이디 */
	private String goodsId;

	/** 판매 시작 일시 */
	private Timestamp saleStrtDtm;

	/** 판매 종료 일시 */
	private Timestamp saleEndDtm;

	/** 노출 여부 */
	private String showYn;

	/** 업체 상품 아이디 */
	private String compGoodsId;

	/** 웹 모바일 구분 코드 */
	private String webMobileGbCd;

	/** 반품 가능 여부 */
	private String rtnPsbYn;

	/** 반품 메세지 */
	private String rtnMsg;

	/** 홍보 문구 노출 여부 */
	private String prWdsShowYn;

	/** 단품 관리 여부 */
	private String itemMngYn;

	/** 상품 유형 코드 */
	private String goodsTpCd;

	/** 비고 */
	private String bigo;

	/** 동영상 링크 url */
	private String vdLinkUrl;
	
	/** 히트수 */
	private Long hits;
}