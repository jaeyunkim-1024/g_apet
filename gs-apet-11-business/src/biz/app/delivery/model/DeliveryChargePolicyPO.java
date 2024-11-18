package biz.app.delivery.model;

import java.sql.Timestamp;

import framework.common.model.BaseSysVO;
import lombok.Data;
import lombok.EqualsAndHashCode;

@Data
@EqualsAndHashCode(callSuper=false)
public class DeliveryChargePolicyPO extends BaseSysVO {

	/** UID */
	private static final long serialVersionUID = 1L;

	/** 업체 번호 */
	private Long compNo;

	/** 배송비 정책 번호 */
	private Long dlvrcPlcNo;

	/** 이력 시작 일시 */
	private Timestamp histStrtDtm;

	/** 정책 명 */
	private String plcNm;

	/** 배송비 기준 코드 */
	private String dlvrcStdCd;

	/** 배송 금액 */
	private Long dlvrAmt;

	/** 추가 배송 금액 - 도서산간 */
	private Long addDlvrAmt;

	/** 배송비 조건 코드 */
	private String dlvrcCdtCd;

	/** 배송비 조건 기준 코드 */
	private String dlvrcCdtStdCd;

	/** 배송비 결제 방법 코드 */
	private String dlvrcPayMtdCd;

	/** 반품/교환 우편 번호 구 */
	private String rtnaPostNoOld;

	/** 반품/교환 우편 번호 신 */
	private String rtnaPostNoNew;

	/** 반품/교환 도로 주소 */
	private String rtnaRoadAddr;

	/** 반품/교환 도로 상세 주소 */
	private String rtnaRoadDtlAddr;

	/** 반품/교환 지번 주소 */
	private String rtnaPrclAddr;

	/** 반품/교환 지번 상세 주소 */
	private String rtnaPrclDtlAddr;

	/** 출고지 우편 번호 구 */
	private String rlsaPostNoOld;

	/** 출고지 우편 번호 신 */
	private String rlsaPostNoNew;

	/** 출고지 도로 주소 */
	private String rlsaRoadAddr;

	/** 출고지 도로 상세 주소 */
	private String rlsaRoadDtlAddr;

	/** 출고지 지번 주소 */
	private String rlsaPrclAddr;

	/** 출고지 지번 상세 주소 */
	private String rlsaPrclDtlAddr;

	/** 반품/교환 담당자 */
	private String rtnExcMan;

	/** 반품/교환 연락처 */
	private String rtnExcTel;

	/** 반품 배송비 */
	private Long rtnDlvrc;

	/** 교환 배송비 */
	private Long excDlvrc;

	/** 배송 최소 소요일 */
	private Long dlvrMinSmldd;

	/** 배송 최대 소요일 */
	private Long dlvrMaxSmldd;

	/** 배송가능 지역 코드 */
	private String compDlvrPsbAreaCd;

	/** 배송방법 코드 */
	private String compDlvrMtdCd;

	/** 기본 택배업체 코드 */
	private String dftHdcCd;

	/** 지역 구분 코드 */
	private String areaGbCd;

	/** 구매 수량 */
	private Long buyQty;

	/** 구매 가격 */
	private Long buyPrc;

	/** 삭제 여부 */
	private String delYn;

	/** 상세보기, 추가 등록 구분 코드 */
	private String viewDlvrPlcyDetail;

	/** 승인 여부 - NEW */
	private String cfmYn;

	/** 승인 사용자 번호 - NEW */
	private Long cfmUsrNo;

	/** 승인 처리 일시  - NEW */
	private Timestamp cfmPrcsDtm;

	/** 정책 등록자(사용자) 등급 구분 코드 */
//	private String usrGbCd;

	/** 정책 등록자(사용자) 등급 그룹 코드, 관리자(CommonConstants.USR_GRP_10) 가 등록한 정책이 아니면 무조건 승인과정을 거쳐야 함. */
	private String usrGrpCd;

	/** 정책 등록자(사용자) 번호 */
	private Long usrNo;

	public Long getAddDlvrAmt() {
		return addDlvrAmt == null ? 0L : addDlvrAmt;
	}
	
	/** 반품/교환 정보 */
	private String rtnExcInfo;
	
	/** 환불 정보 */
	private String rfdInfo;
	
	/** as정보 */
	private String asInfo;

}