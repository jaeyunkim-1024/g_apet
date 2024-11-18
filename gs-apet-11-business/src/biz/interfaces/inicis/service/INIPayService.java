package biz.interfaces.inicis.service;

import biz.interfaces.inicis.model.INIMobileApprove;
import biz.interfaces.inicis.model.INIMobileCertification;
import biz.interfaces.inicis.model.INIPayCancel;
import biz.interfaces.inicis.model.INIPayPartCancel;
import biz.interfaces.inicis.model.INIRcptApprove;
import biz.interfaces.inicis.model.INIRcptApproveRequest;
import biz.interfaces.inicis.model.INIStdApprove;
import biz.interfaces.inicis.model.INIStdCertification;


/**
* <pre>
* - 프로젝트명	: 11.business
* - 패키지명		: biz.itf.inicis.service
* - 파일명		: InipayService.java
* - 작성일		: 2017. 4. 19.
* - 작성자		: Administrator
* - 설명			: Inipay 서비스
* </pre>
*/
public interface INIPayService {

//	/**
//	* <pre>
//	* - 프로젝트명	: 11.business
//	* - 파일명		: InipayService.java
//	* - 작성일		: 2017. 4. 20.
//	* - 작성자		: Administrator
//	* - 설명			: INIpay Standard 승인
//	* 					인증데이터를 이용한 승인
//	* 					신용카드, 실시간계좌이체, 가상계좌
//	* </pre>
//	* @param dto
//	* @return
//	*/
//	INIStdApprove approveStd(INIStdCertification dto);
//	
//	/**
//	* <pre>
//	* - 프로젝트명	: 11.business
//	* - 파일명		: INIPayService.java
//	* - 작성일		: 2017. 4. 27.
//	* - 작성자		: Administrator
//	* - 설명			: INIPay Mobile 승인
//	*                    신용카드, 가상계좌
//	*                    (실시간계좌이체는 별도의 승인과정을 거치지 않고 이체 결과에 대한 별도 URL호출됨)
//	* </pre>
//	* @param dto
//	* @return
//	*/
//	INIMobileApprove approveMobile(INIMobileCertification dto);
//	
//	/**
//	* <pre>
//	* - 프로젝트명	: 11.business
//	* - 파일명		: INIRcptService.java
//	* - 작성일		: 2017. 4. 24.
//	* - 작성자		: Administrator
//	* - 설명			: 현금영수증 신청
//	* </pre>
//	* @param req
//	* @return
//	*/
//	INIRcptApprove approveReceipt(INIRcptApproveRequest req);
//
//	/**
//	* <pre>
//	* - 프로젝트명	: 11.business
//	* - 파일명		: InipayService.java
//	* - 작성일		: 2017. 4. 24.
//	* - 작성자		: Administrator
//	* - 설명			: 취소
//	*                    결제취소 및 현금영수증 취소
//	*                    (단, 가상계좌의 취소는 별도 제공)
//	* </pre>
//	* @param strId					상점아이디
//	* @param tid					거래번호
//	* @param cancelReasonCd	INIPayConstants.CACNEL_REASON_CODE 참조
//	* @param cancelReasonMsg	취소사유
//	* @return
//	*/
//	INIPayCancel cancel(String strId, String tid, String cancelReasonCd, String cancelReasonMsg );
//
//	/**
//	* <pre>
//	* - 프로젝트명	: 11.business
//	* - 파일명		: INIPayService.java
//	* - 작성일		: 2017. 5. 9.
//	* - 작성자		: Administrator
//	* - 설명			: 취소
//	* 					  가상계좌 환불
//	*                     이니시스와의 별도 계약에 의거 환불처리 가능
//	* </pre>
//	* @param strId		상점아이디
//	* @param tid		거래번호
//	* @param cancelReasonMsg	취소사유
//	* @param rfdAcctNo			환불계좌번호
//	* @param rfdBankCd			환불은행코드
//	* @param rfdOoaNm			환불예금주명
//	* @return
//	*/
//	INIPayCancel cancelVirtual(String strId, String tid, String cancelReasonMsg, String rfdAcctNo, String rfdBankCd, String rfdOoaNm);
//
//	/**
//	* <pre>
//	* - 프로젝트명	: 11.business
//	* - 파일명		: INIPayService.java
//	* - 작성일		: 2017. 4. 25.
//	* - 작성자		: Administrator
//	* - 설명			: 부분 취소
//	*                    가상계좌를 제외한 결제수단
//	* </pre>
//	* @param strId				상점 아이디
//	* @param orgTid			원 거래번호
//	* @param price				부분 취소 금액
//	* @param confirmPrice	승인요청금액 : 원승인금액 - 부분취소금액
//	* @param buyerEmail		구매자 이메일
//	* @return
//	*/
//	INIPayPartCancel cancelPart(String strId, String orgTid, Long price, Long confirmPrice, String buyerEmail);
//	
//	
//	/**
//	* <pre>
//	* - 프로젝트명	: 11.business
//	* - 파일명		: INIPayService.java
//	* - 작성일		: 2017. 5. 9.
//	* - 작성자		: Administrator
//	* - 설명			: 부분 취소
//	*                    가상계좌의 부분 취소
//	*                    이니시스와 별도의 계약 체결 후 가능
//	* </pre>
//	* @param strId				상점 아이디
//	* @param orgTid			원 거래번호
//	* @param price				부분 취소 금액
//	* @param confirmPrice	승인요청금액 : 원승인금액 - 부분취소금액
//	* @param rfdAcctNo		환불계좌번호
//	* @param rfdBankCd		환불은행코드
//	* @param rfdOoaNm		환불예금주명
//	* @return
//	*/
//	INIPayPartCancel cancelPartVirtual(String strId, String orgTid, Long price, Long confirmPrice, String rfdAcctNo, String rfdBankCd, String rfdOoaNm);
}