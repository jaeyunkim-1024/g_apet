package biz.app.appweb.service;

import java.util.List;

import biz.app.appweb.model.*;

/**
 * <pre>
 * - 프로젝트명	: 11.business
 * - 패키지명		: biz.app.appweb.service
 * - 파일명		: PushService.java
 * - 작성일		: 2020. 12. 21. 
 * - 작성자		: hjh
 * - 설 명		: push/문자 발송 서비스 Interface
 * </pre>
 */
public interface PushService {
	/**
	 * <pre>
	 * - 프로젝트명	: 41.admin.web
	 * - 파일명		: PushService.java
	 * - 작성일		: 2020. 12. 21.
	 * - 작성자		: hjh
	 * - 설명			: 알림 메시지 목록
	 * </pre>
	 * @param so
	 * @return
	 */
	public List<PushVO> pageNoticeSendList(PushSO so);
	
	/**
	 * <pre>
	 * - 프로젝트명	: 41.admin.web
	 * - 파일명		: PushService.java
	 * - 작성일		: 2020. 12. 21.
	 * - 작성자		: hjh
	 * - 설명			: 알림 메시지 발송현황 상세
	 * </pre>
	 * @param so
	 * @return
	 */
	public PushVO getPushMessage(PushSO so);
	
	/**
	 * <pre>
	 * - 프로젝트명	: 41.admin.web
	 * - 파일명		: PushService.java
	 * - 작성일		: 2020. 12. 21.
	 * - 작성자		: hjh
	 * - 설명			: 알림 메시지 발송건수 목록
	 * </pre>
	 * @param so
	 * @return
	 */
	public List<PushVO> pageNoticeCnt(PushSO so);
	
	/**
	 * <pre>
	 * - 프로젝트명	: 41.admin.web
	 * - 파일명		: PushService.java
	 * - 작성일		: 2020. 12. 21.
	 * - 작성자		: hjh
	 * - 설명			: 알림 메시지 템플릿 목록
	 * </pre>
	 * @param so
	 * @return
	 */
	public List<PushVO> pageNoticeTemplate(PushSO so);
	
	/**
	 * <pre>
	 * - 프로젝트명	: 41.admin.web
	 * - 파일명		: PushService.java
	 * - 작성일		: 2020. 12. 21.
	 * - 작성자		: hjh
	 * - 설명			: 알림 메시지 템플릿 단건 조회
	 * </pre>
	 * @param so
	 * @return
	 */
	public PushVO getNoticeTemplate(PushSO so);

	/**
	 * <pre>
	 * - 프로젝트명	: 41.admin.web
	 * - 파일명		: PushService.java
	 * - 작성일		: 2020. 12. 21.
	 * - 작성자		: hjh
	 * - 설명			: 알림 메시지 템플릿 등록/수정
	 * </pre>
	 * @param po
	 * @return
	 */
	public void saveNoticeTemplate(PushPO po);

	/**
	 * <pre>
	 * - 프로젝트명	: 41.admin.web
	 * - 파일명		: PushService.java
	 * - 작성일		: 2020. 12. 21.
	 * - 작성자		: hjh
	 * - 설명			: 알림 메시지 템플릿 삭제
	 * </pre>
	 * @param po
	 * @return
	 */
	public void deleteNoticeTemplate(PushPO po);

	/**
	 * <pre>
	 * - 프로젝트명	: 41.admin.web
	 * - 파일명		: PushService.java
	 * - 작성일		: 2020. 12. 21.
	 * - 작성자		: hjh
	 * - 설명			: 알림 메시지 발송 화면 정보 목록
	 * </pre>
	 * @param so
	 * @return
	 */
	public List<PushVO> listPushMsgSendView(PushSO so);

	/**
	 * <pre>
	 * - 프로젝트명	: 41.admin.web
	 * - 파일명		: PushService.java
	 * - 작성일		: 2021. 01. 08
	 * - 작성자		: KJY
	 * - 설명			: 마케팅,개인정보,휴면 ,데이터3법 일자별 발송내역
	 * </pre>
	 * @param so
	 * @return
	 */
	public List<NoticeSendCommonVO> pageNoticeSendListByDailiy(NoticeSendSO so);

	/**
	 * <pre>
	 * - 프로젝트명	: 41.admin.web
	 * - 파일명		: PushService.java
	 * - 작성일		: 2021. 01. 08
	 * - 작성자		: KJY
	 * - 설명			: 마케팅,개인정보,휴면 ,데이터3법 회원별 발송 내역
	 * </pre>
	 * @param so
	 * @return
	 */
	public List<NoticeSendCommonVO> pageNoticeSendListForMbr(NoticeSendSO so);

	/**
	 * <pre>
	 * - 프로젝트명	: 41.admin.web
	 * - 파일명		: PushService.java
	 * - 작성일		: 2020. 12. 21.
	 * - 작성자		: hjh
	 * - 설명			: 알림 메시지 발송 정보 수정
	 * </pre>
	 * @param po
	 * @return
	 */
	public void updateNoticeSendList(PushPO po);
	
	/**
	 * <pre>
	 * - 프로젝트명	: 41.admin.web
	 * - 파일명		: PushService.java
	 * - 작성일		: 2020. 12. 21.
	 * - 작성자		: hjh
	 * - 설명			: 알림 메시지 발송 리스트/상세 리스트 삭제
	 * </pre>
	 * @param po
	 */
	public void deleteAllNoticeSendList(PushPO po);
	
	/**
	 * <pre>
	 * - 프로젝트명	: 41.admin.web
	 * - 파일명		: PushService.java
	 * - 작성일		: 2020. 12. 21.
	 * - 작성자		: hjh
	 * - 설명			: 알림 메시지 발송 정보 삭제
	 * </pre>
	 * @param po
	 * @return
	 */
	public void deleteNoticeSendList(PushPO po);

	/**
	 * <pre>
	 * - 프로젝트명	: 41.admin.web
	 * - 파일명		: PushService.java
	 * - 작성일		: 2020. 12. 21.
	 * - 작성자		: hjh
	 * - 설명			: 알림 메시지 발송하기
	 * </pre>
	 * @param po
	 * @return
	 */
	public void sendPushMessage(PushPO po);

	/**
	 * <pre>
	 * - 프로젝트명	: 41.admin.web
	 * - 파일명		: PushService.java
	 * - 작성일		: 2021. 02. 15
	 * - 작성자		: KKB
	 * - 설명		: 예약 발송 리스트 조회
	 * </pre>
	 * @param so
	 * @return
	 */
	public List<NoticeSendListVO> listRsrvNotice(PushSO so);
	
	
	public List<PushVO> getFrontPushList(PushSO so);
}
