package biz.interfaces.sktmp.model.request;

import java.io.Serializable;

import biz.interfaces.sktmp.constants.SktmpConstants;
import biz.interfaces.sktmp.model.StrLenVO;
import lombok.Data;
/**
 * <pre>
 * - 프로젝트명	: gs-apet-11-business
 * - 패키지명	: biz.interfaces.sktmp.model.request
 * - 파일명		: MpPntApproveReqVO.java
 * - 작성일		: 2021. 06. 28.
 * - 작성자		: kjhvf01
 * - 설명		: MP 포인트 통합 승인요청 전문
 * </pre>
 */
@Data
public class MpPntApproveReqVO implements Serializable {
	private static final long serialVersionUID = 1L;
	
	/** 전문 유형 */
	private StrLenVO msgType = new StrLenVO(SktmpConstants.MSG_TYPE_0500, 4);
	
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
	 * */
	private StrLenVO useMpPnt = new StrLenVO(12, StrLenVO.Type.INTEGER);
	
	/** 전문 전송 일시 : YYYYMMDDhhmmss */
	private StrLenVO msgSndDtm = new StrLenVO(14);
	
	/** 카드 번호 : SK-T 멤버십 번호 */
	private StrLenVO cardNum = new StrLenVO(16);
	
	/** 거래 고유 번호 : ‘67’ + 고유번호(10자리) */
	private StrLenVO dealNum = new StrLenVO(12);
	
	/** 단말# : FIX - 1000000000*/
	private StrLenVO device = new StrLenVO(SktmpConstants.DEVICE_DEFALUT, 10);
	
	/** 가맹점#: 제휴사코드 + 점포코드 */
	private StrLenVO storeNum = new StrLenVO(SktmpConstants.PRTNR_CODE + SktmpConstants.STORE_CODE,10);
	
	/** 상품 유형 : 4자리 상품코드(default:’    ’)  */
	private StrLenVO goodsType = new StrLenVO(4);
	
	/** 사용자 ID 구분 코드 
	 * ‘00’ or  ‘  ‘ -> 사용자 ID  CHECK NO (아무것도 체크하지않음)
	 * ‘01’ ->  OTB 
	 * ‘02’ ->  PIN & OTB
	 * ‘03’ ->  CI & OTB
	 * ‘04’ ->  연계정보(CI) (88 byte) & PIN & OTB 
	 * ‘05’ ->  리얼멤버십카드번호
	 * ‘06’ ->  PIN & 리얼멤버십카드번호
	 * ‘07’ -> 연계정보(CI) (88 byte) & 리얼멤버십카드번호
	 * ‘08’ -> 연계정보(CI) (88 byte) & PIN & 리얼멤버십카드번호
	 * ‘09’ 미지정
	 * 
	 * -SKT와 별도의 협의가 없으면 08 (연계정보(CI) (88 byte) & PIN & 리얼멤버십카드번호)로 요청
	 */
	private StrLenVO userIdGbCd = new StrLenVO(2);
	
	/** 사용자 ID : Space (스페이스처리) */
	private StrLenVO userId = new StrLenVO(20);
	
	/** PIN넘버 : PIN넘버 6자리 */
	private StrLenVO pinNum = new StrLenVO(6);
	
	/** dummy*/
	private StrLenVO dummy = new StrLenVO(29);
	
	/** 통화 코드 : '410' */
	private StrLenVO currNum = new StrLenVO(SktmpConstants.CURR_KR, 3);
	
	/** 연계 정보 : 주민번호 연계정보 - CI 값 */
	private StrLenVO ifInfo = new StrLenVO(88);

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

	public void setUserIdGbCd(String userIdGbCd) {
		this.userIdGbCd.setValue(userIdGbCd);
	}

	public void setUserId(String userId) {
		this.userId.setValue(userId);
	}

	public void setPinNum(String pinNum) {
		this.pinNum.setValue(pinNum);
	}

	public void setDummy(String dummy) {
		this.dummy.setValue(dummy);
	}

	public void setCurrNum(String currNum) {
		this.currNum.setValue(currNum);
	}

	public void setIfInfo(String ifInfo) {
		this.ifInfo.setValue(ifInfo);
	}
}
