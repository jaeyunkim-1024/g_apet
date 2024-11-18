package biz.common.service;

import java.util.List;
import java.util.Map;

import org.springframework.http.HttpEntity;
import org.springframework.http.HttpMethod;

import com.fasterxml.jackson.databind.JsonNode;

import biz.app.contents.model.VodSO;
import biz.app.member.model.MemberUnsubscribeVO;
import biz.common.model.AttachFilePO;
import biz.common.model.AttachFileSO;
import biz.common.model.AttachFileVO;
import biz.common.model.EmailSend;
import biz.common.model.EmailSendMap;
import biz.common.model.EmailSendPO;
import biz.common.model.LmsSendPO;
import biz.common.model.NaverPushPO;
import biz.common.model.PushMessagePO;
import biz.common.model.PushTokenPO;
import biz.common.model.PushTokenSO;
import biz.common.model.PushTokenVO;
import biz.common.model.SearchEngineEventPO;
import biz.common.model.SendPushPO;
import biz.common.model.SmsSendPO;
import biz.common.model.SsgMessageSendPO;

/**
 * Web service
 * @author	snw
 * @since	    2013.09.02
 */

public interface BizService {

	/**
	* <pre>
	* - 프로젝트명	: 11.business
	* - 파일명		: BizService.java
	* - 작성일		: 2016. 4. 11.
	* - 작성자		: valueFactory
	* - 설명			: get Sequence
	* </pre>
	* @param sequence
	* @return
	*/
	public Long getSequence (String sequence );

	/**
	* <pre>
	* - 프로젝트명	: 11.business
	* - 파일명		: SmsService.java
	* - 작성일		: 2016. 4. 21.
	* - 작성자		: snw
	* - 설명		: Sms 전송
	* 0 : 전송, -1:예약시간 없음, -2:예약시간형식오류, -3:수신자정보가 없음, -4:수신번호수와 수신자명수가 다름, -5:메세지 없음
	* </pre>
	* @param dto
	* @throws Exception
	*/
	int sendSms(SmsSendPO dto);

	/**
	* <pre>
	* - 프로젝트명	: 11.business
	* - 파일명		: SmsService.java
	* - 작성일		: 2016. 4. 21.
	* - 작성자		: snw
	* - 설명		: Lms 전송
	* 0 : 전송, -1:예약시간 없음, -2:예약시간형식오류, -3:수신자정보가 없음, -4:수신번호수와 수신자명수가 다름, -5:메세지 없음
	* 제목이 없는 경우 메세지내용에서 추출하여 전송
	* </pre>
	* @param dto
	* @throws Exception
	*/
	int sendLms(LmsSendPO po);

	/**
	* <pre>
	* - 프로젝트명	: 11.business
	* - 파일명		: BizService.java
	* - 작성일		: 2017. 05. 19.
	* - 작성자		: snw
	* - 설명			: 이메일 전송
	* </pre>
	* @param po
	* @param mpoList
	* @return
	* @throws Exception
	*/
	void sendEmail(EmailSend email, List<EmailSendMap> mapList);

	/**
	 * <pre>
	 * - 프로젝트명	: 11.business
	 * - 파일명		: BizService.java
	 * - 작성일		: 2016. 5. 16.
	 * - 작성자		: valueFactory
	 * - 설명		: 파일 목록
	 * </pre>
	 * @param po
	 * @return
	 */
	public List<AttachFileVO> listAttachFile(AttachFileSO so);

	/**
	 * <pre>
	 * - 프로젝트명	: 11.business
	 * - 파일명		: BizService.java
	 * - 작성일		: 2016. 5. 16.
	 * - 작성자		: valueFactory
	 * - 설명		: 파일 등록
	 * </pre>
	 * @param po
	 */
	public void insertAttachFile(AttachFilePO po);

	/**
	 * <pre>
	 * - 프로젝트명	: 11.business
	 * - 파일명		: BizService.java
	 * - 작성일		: 2016. 5. 16.
	 * - 작성자		: valueFactory
	 * - 설명		: 파일 삭제
	 * </pre>
	 * @param po
	 */
	public void deleteAttachFile(AttachFilePO po);
	
	/**
	 * <pre>
	 * - 프로젝트명	: 11.business
	 * - 파일명		: BizService.java
	 * - 작성일		: 2020. 12. 22.
	 * - 작성자		: valueFactory
	 * - 설명		: 단방향 암호화
	 * </pre>
	 * @param po
	 */
	public String oneWayEncrypt(String strTarget);
	
	/**
	 * <pre>
	 * - 프로젝트명	: 11.business
	 * - 파일명		: BizService.java
	 * - 작성일		: 2020. 12. 22.
	 * - 작성자		: valueFactory
	 * - 설명		: 단방향 암호화
	 * </pre>
	 * @param po
	 */
	public String oneWayEncrypt(String strTarget, Object userId);
	
	/**
	 * <pre>
	 * - 프로젝트명	: 11.business
	 * - 파일명		: BizService.java
	 * - 작성일		: 2020. 12. 22.
	 * - 작성자		: valueFactory
	 * - 설명		: 양방향 암호화
	 * </pre>
	 * @param po
	 */
	public String twoWayEncrypt(String strTarget);
	
	/**
	 * <pre>
	 * - 프로젝트명	: 11.business
	 * - 파일명		: BizService.java
	 * - 작성일		: 2020. 12. 22.
	 * - 작성자		: valueFactory
	 * - 설명		: 양방향 암호화
	 * </pre>
	 * @param po
	 */
	public String twoWayEncrypt(String strTarget, Object userId);
	
	/**
	 * <pre>
	 * - 프로젝트명	: 11.business
	 * - 파일명		: BizService.java
	 * - 작성일		: 2020. 12. 22.
	 * - 작성자		: valueFactory
	 * - 설명		: 양방향 복호화
	 * </pre>
	 * @param po
	 */
	public String twoWayDecrypt(String strTarget);
	
	/**
	 * <pre>
	 * - 프로젝트명	: 11.business
	 * - 파일명		: BizService.java
	 * - 작성일		: 2020. 12. 22.
	 * - 작성자		: valueFactory
	 * - 설명		: 양방향 복호화
	 * </pre>
	 * @param po
	 */
	public String twoWayDecrypt(String strTarget, Object userId);
	
	/**
	 * <pre>
	 * - 프로젝트명	: 11.business
	 * - 파일명		: BizService.java
	 * - 작성일		: 2020. 12. 22.
	 * - 작성자		: valueFactory
	 * - 설명		: 컨텐츠 ID generate
	 * </pre>
	 * @param po
	 */
	public String genContentsId(VodSO so);
	
	/**
	* <pre>
	* - 프로젝트명	: 11.business
	* - 파일명		: BizService.java
	* - 작성일		: 2020. 01. 18.
	* - 작성자		: KKB
	* - 설명		: 이메일 전송
	* </pre>
	* @param po
	* @return
	*/
	public String sendEmail(EmailSendPO email);
	
	/**
	* <pre>
	* - 프로젝트명	: 11.business
	* - 파일명		: BizService.java
	* - 작성일		: 2020. 01. 18.
	* - 작성자		: KKB
	* - 설명		: 이메일 API 전송
	* </pre>
	* @param po
	* @return
	*/
	public JsonNode sendNaverEmail(String JSONInput);
	
	/**
	* <pre>
	* - 프로젝트명	: 11.business
	* - 파일명		: BizService.java
	* - 작성일		: 2020. 01. 18.
	* - 작성자		: KKB
	* - 설명		: 네이버 메일 Signature 생성
	* </pre>
	* @param po
	* @return
	*/
	public String makeSignature(String url, String method, String timestamp, String accessKey, String secretKey);
	
	/**
	* <pre>
	* - 프로젝트명	: 11.business
	* - 파일명		: BizService.java
	* - 작성일		: 2020. 02. 01.
	* - 작성자		: KKB
	* - 설명		: PUSH TOKEN 등록
	* </pre>
	* @param po
	* @return
	*/
	public String insertDeviceToken(PushTokenPO po);
	
	/**
	* <pre>
	* - 프로젝트명	: 11.business
	* - 파일명		: BizService.java
	* - 작성일		: 2020. 02. 01.
	* - 작성자		: KKB
	* - 설명		: PUSH TOKEN 조회
	* </pre>
	* @param po
	* @return
	*/
	public PushTokenVO getDeviceToken(PushTokenSO so);
	
	/**
	* <pre>
	* - 프로젝트명	: 11.business
	* - 파일명		: BizService.java
	* - 작성일		: 2020. 02. 01.
	* - 작성자		: KKB
	* - 설명		: PUSH TOKEN 삭제
	* </pre>
	* @param po
	* @return
	*/
	public String deleteDeviceToken(PushTokenPO po);
	
	/**
	* <pre>
	* - 프로젝트명	: 11.business
	* - 파일명		: BizService.java
	* - 작성일		: 2020. 02. 01.
	* - 작성자		: KKB
	* - 설명		: PUSH 전송
	* </pre>
	* @param po
	* @return
	*/
	public String sendPush(SendPushPO po);
	
	/**
	* <pre>
	* - 프로젝트명	: 11.business
	* - 파일명		: BizService.java
	* - 작성일		: 2020. 02. 23.
	* - 작성자		: KKB
	* - 설명		: 네이버 push에 message 형식에 맞게 셋팅
	* </pre>
	* @param po
	* @return
	*/
	public Map<String, PushMessagePO> convertToNaver(SendPushPO po);
	
	/**
	* <pre>
	* - 프로젝트명	: 11.business
	* - 파일명		: BizService.java
	* - 작성일		: 2020. 02. 23.
	* - 작성자		: KKB
	* - 설명		: sendNaverPush 전송
	* </pre>
	* @param po
	* @return JsonNode
	*/
	public JsonNode sendNaverPush(NaverPushPO po);
	
	/**
	* <pre>
	* - 프로젝트명	: 11.business
	* - 파일명		: BizService.java
	* - 작성일		: 2020. 01. 22.
	* - 작성자		: KKB
	* - 설명		: 검색 클릭이벤트 전송
	* </pre>
	* @param logGb
	* @return
	*/
	public String sendClickEventToSearchEngineServer(SearchEngineEventPO sepo); // SEARCH, ACTION
	
	/**
	* <pre>
	* - 프로젝트명	: 11.business
	* - 파일명		: BizService.java
	* - 작성일		: 2021. 1. 28.
	* - 작성자		: snw
	* - 설명		: SSG message 전송
	* 
	* </pre>
	* @param dto
	* @throws Exception
	*/
	int sendMessage(SsgMessageSendPO po);

	/**
	* <pre>
	* - 프로젝트명	: 11.business
	* - 파일명		: BizService.java
	* - 작성일		: 2022. 02. 24.
	* - 작성자		: KSH
	* - 설명		: 080수신거부 조회
	* </pre>
	* @param 
	* @return List<MemberBaseVO>
	*/
	public MemberUnsubscribeVO getUnsubscribes();
	
	/**
	* <pre>
	* - 프로젝트명	: 11.business
	* - 파일명		: BizService.java
	* - 작성일		: 2022. 02. 24.
	* - 작성자		: KSH
	* - 설명		: 080수신거부 조회
	* </pre>
	* @param 
	* @return List<MemberBaseVO>
	*/
	public MemberUnsubscribeVO getUnsubscribes(String syncYn);

	/**
	* <pre>
	* - 프로젝트명	: 11.business
	* - 파일명		: BizService.java
	* - 작성일		: 2022. 02. 24.
	* - 작성자		: KSH
	* - 설명		: 080수신거부 등록
	* </pre>
	* @param 
	* @return JsonNode
	*/
	public List<MemberUnsubscribeVO> registUnsubscribes(String[] mobileArr);
	
	/**
	* <pre>
	* - 프로젝트명	: 11.business
	* - 파일명		: BizService.java
	* - 작성일		: 2022. 02. 24.
	* - 작성자		: KSH
	* - 설명		: 080수신거부 등록
	* </pre>
	* @param 
	* @return JsonNode
	*/
	public MemberUnsubscribeVO registUnsubscribes(String mobile);
	
	/**
	* <pre>
	* - 프로젝트명	: 11.business
	* - 파일명		: BizService.java
	* - 작성일		: 2022. 02. 24.
	* - 작성자		: KSH
	* - 설명		: 080수신거부 삭제
	* </pre>
	* @param 
	* @return JsonNode
	*/
	public List<MemberUnsubscribeVO> deleteUnsubscribes(String[] mobileArr);
	
	/**
	* <pre>
	* - 프로젝트명	: 11.business
	* - 파일명		: BizService.java
	* - 작성일		: 2022. 02. 24.
	* - 작성자		: KSH
	* - 설명		: 080수신거부 삭제
	* </pre>
	* @param 
	* @return JsonNode
	*/
	public MemberUnsubscribeVO deleteUnsubscribes(String mobile);
	
	/**
	* <pre>
	* - 프로젝트명	: 11.business
	* - 파일명		: BizService.java
	* - 작성일		: 2022. 02. 24.
	* - 작성자		: KSH
	* - 설명		: 080수신거부 조회
	* </pre>
	* @param 
	* @return List<MemberBaseVO>
	*/
	public MemberUnsubscribeVO getUnsubscribesDirect();
	
	/**
	* <pre>
	* - 프로젝트명	: 11.business
	* - 파일명		: BizService.java
	* - 작성일		: 2022. 02. 24.
	* - 작성자		: KSH
	* - 설명		: 080수신거부 조회
	* </pre>
	* @param 
	* @return List<MemberBaseVO>
	*/
	public MemberUnsubscribeVO getUnsubscribesDirect(String syncYn);

	/**
	* <pre>
	* - 프로젝트명	: 11.business
	* - 파일명		: BizService.java
	* - 작성일		: 2022. 02. 24.
	* - 작성자		: KSH
	* - 설명		: 080수신거부 등록
	* </pre>
	* @param 
	* @return JsonNode
	*/
	public List<MemberUnsubscribeVO> registUnsubscribesDirect(String[] mobileArr);
	
	/**
	* <pre>
	* - 프로젝트명	: 11.business
	* - 파일명		: BizService.java
	* - 작성일		: 2022. 02. 24.
	* - 작성자		: KSH
	* - 설명		: 080수신거부 등록
	* </pre>
	* @param 
	* @return JsonNode
	*/
	public MemberUnsubscribeVO registUnsubscribesDirect(String mobile);
	
	/**
	* <pre>
	* - 프로젝트명	: 11.business
	* - 파일명		: BizService.java
	* - 작성일		: 2022. 02. 24.
	* - 작성자		: KSH
	* - 설명		: 080수신거부 삭제
	* </pre>
	* @param 
	* @return JsonNode
	*/
	public List<MemberUnsubscribeVO> deleteUnsubscribesDirect(String[] mobileArr);
	
	/**
	* <pre>
	* - 프로젝트명	: 11.business
	* - 파일명		: BizService.java
	* - 작성일		: 2022. 02. 24.
	* - 작성자		: KSH
	* - 설명		: 080수신거부 삭제
	* </pre>
	* @param 
	* @return JsonNode
	*/
	public MemberUnsubscribeVO deleteUnsubscribesDirect(String mobile);
	
	/**
	* <pre>
	* - 프로젝트명	: 11.business
	* - 파일명		: BizService.java
	* - 작성일		: 2021. 03. 11.
	* - 작성자		: 김우진
	* - 설명		: 푸시발송결과조회
	* </pre>
	* @param 
	* @return JsonNode
	*/
	public JsonNode getNaverPushResult(String requestId);

	/**
	* <pre>
	* - 프로젝트명	: 11.business
	* - 파일명		: BizService.java
	* - 작성일		: 2020. 03. 24.
	* - 작성자		: KKB
	* - 설명		: CIS gateway API로 변경
	* </pre>
	* @param po
	* @return String
	*/
	public String convertToCisApi(String url, HttpMethod method, HttpEntity<String> entity);
}