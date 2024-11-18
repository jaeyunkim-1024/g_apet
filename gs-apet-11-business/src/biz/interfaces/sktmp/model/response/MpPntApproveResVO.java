package biz.interfaces.sktmp.model.response;

import java.io.Serializable;

import biz.interfaces.sktmp.model.StrLenVO;
import lombok.Data;


/**
 * <pre>
 * - 프로젝트명	: gs-apet-11-business
 * - 패키지명	: biz.interfaces.sktmp.model.response
 * - 파일명		: MpPntApproveResVO.java
 * - 작성일		: 2021. 06. 29.
 * - 작성자		: JinHong
 * - 설명		: MP 포인트 통합 승인응답 전문
 * </pre>
 */
@Data
public class MpPntApproveResVO implements Serializable {
	private static final long serialVersionUID = 1L;
	
	/** 전문 유형 */
	private StrLenVO msgType = new StrLenVO(4);
	
	/** 거래 구분 코드
	 * 000010 : 승인 요청시
	 * 000020 : 조회 요청시
	 **/
	private StrLenVO dealGbCd = new StrLenVO(6, StrLenVO.Type.INTEGER);
	
	/** 거래 금액 : Right Justify(할인전금액 입력) */
	private StrLenVO dealAmt = new StrLenVO(12, StrLenVO.Type.INTEGER);
	
	/** MP포인트 사용 금액 : Right Justify(할인전금액 입력) 
	 * 1.포인트 사용 없으면 0처리
	 * 2.MAX 처리시 거래금액과 동일하게 처리
	 * -요청 MP포인트와 다를 수 있음 (예 : 고객 MAX 사용 요청시 or 부스트 이벤트 등)
	 * */
	private StrLenVO useMpPnt = new StrLenVO(12, StrLenVO.Type.INTEGER);
	
	/** 전문 전송 일시 : YYYYMMDDhhmmss */
	private StrLenVO msgSndDtm = new StrLenVO(14);
	
	/** 카드 번호 : SK-T 멤버십 번호 */
	private StrLenVO cardNum = new StrLenVO(16);
	
	/** 거래 고유 번호 : ‘67’ + 고유번호(10자리) */
	private StrLenVO dealNum = new StrLenVO(12);
	
	/** 단말# : FIX - 1000000000*/
	private StrLenVO device = new StrLenVO(10);
	
	/** 가맹점# : 제휴사코드 4자리 +  점포코드 4자리 + SPACE  2자리 */
	private StrLenVO storeNum = new StrLenVO(10);
	
	/** 상품 유형 : 4자리 상품코드(default:’    ’)  */
	private StrLenVO goodsType = new StrLenVO(4);
	
	/** 응답 코드 : 승인:00, 거절:define要  */
	private StrLenVO resCd = new StrLenVO(2);
	
	/** 응답 코드 상세 : 할인,사용,적립 각 단계 결과코드 */
	private StrLenVO resDtlCd = new StrLenVO(6);
	
	/** 승인 번호 
	 * 거절이면 승인번호는 ‘008’+Space
	 * 거래거절에 대한 세부적Define에 대해 유형코드 참조
	 * 조회 요청시    응답 코드  : ‘00’ 정상 일 때   승인번호 :  00000000  , 
	 * */
	private StrLenVO apprNum = new StrLenVO(8);
	
	/** 레인보우포인트 여부 
	 * 정상멤버십포인트: ‘M ‘
	 * 최종 잔여 포인트 사용시 : ‘L’
	 * 최종 포인트 사용후: ‘R ‘
	 * 2 번째 BYTE :
	 * V’  이면 등급 : VIP 카드 
	 * A’  이면 등급 :일반 카드
	 * G’  이면 등급 :골드 카드 추가 ‘ S’  이면 등급 :실버 카드 추가
	 *  전표 출력 및 화면 표시
	 */
	private StrLenVO rainbowCd = new StrLenVO(2);
	
	/** 할인 금액 :거래 금액 * 할인율 또는 고정할인 금액 */
	private StrLenVO discountAmt = new StrLenVO(8, StrLenVO.Type.INTEGER);
	
	/** 지불 금액 :거래 금액 – 할인 금액  */
	private StrLenVO payAmt = new StrLenVO(10, StrLenVO.Type.INTEGER);
	
	/** 잔여 MP 포인트 */
	private StrLenVO rmnMpPnt = new StrLenVO(10, StrLenVO.Type.INTEGER);
	
	/** 부스트 업 포인트 */
	private StrLenVO boostUpPnt = new StrLenVO(10, StrLenVO.Type.INTEGER);
	
	/** 적립 MP 포인트 */
	private StrLenVO accumMpPnt = new StrLenVO(10, StrLenVO.Type.INTEGER);
	
	/** 제휴사 통합 바코드 : 승인요청된 제휴사와 카드에 맵핑된 통합바코드 */
	private StrLenVO barcode = new StrLenVO(26);
	
	public void setMsgType(String msgType) {
		this.msgType.setValue(msgType);
	}

	public void setDealGbCd(String dealGbCd) {
		this.dealGbCd.setValue(dealGbCd);
	}

	public void setDealAmt(String dealAmt) {
		this.dealAmt.setValue(dealAmt);
	}

	public void setUseMpPnt(String useMpPnt) {
		this.useMpPnt.setValue(useMpPnt);
	}

	public void setMsgSndDtm(String msgSndDtm) {
		this.msgSndDtm.setValue(msgSndDtm);
	}

	public void setCardNum(String cardNum) {
		this.cardNum.setValue(cardNum);
	}

	public void setDealNum(String dealNum) {
		this.dealNum.setValue(dealNum);
	}

	public void setDevice(String device) {
		this.device.setValue(device);
	}

	public void setStoreNum(String storeNum) {
		this.storeNum.setValue(storeNum);
	}

	public void setGoodsType(String goodsType) {
		this.goodsType.setValue(goodsType);
	}

	public void setResCd(String resCd) {
		this.resCd.setValue(resCd);
	}

	public void setResDtlCd(String resDtlCd) {
		this.resDtlCd.setValue(resDtlCd);
	}

	public void setApprNum(String apprNum) {
		this.apprNum.setValue(apprNum);
	}

	public void setRainbowCd(String rainbowCd) {
		this.rainbowCd.setValue(rainbowCd);
	}

	public void setDicountAmt(String discountAmt) {
		this.discountAmt.setValue(discountAmt);
	}

	public void setPayAmt(String payAmt) {
		this.payAmt.setValue(payAmt);
	}

	public void setRmnMpPnt(String rmnMpPnt) {
		this.rmnMpPnt.setValue(rmnMpPnt);
	}

	public void setBoostUpPnt(String boostUpPnt) {
		this.boostUpPnt.setValue(boostUpPnt);
	}

	public void setAccumMpPnt(String accumMpPnt) {
		this.accumMpPnt.setValue(accumMpPnt);
	}

	public void setBarcode(String barcode) {
		this.barcode.setValue(barcode);
	}
}
