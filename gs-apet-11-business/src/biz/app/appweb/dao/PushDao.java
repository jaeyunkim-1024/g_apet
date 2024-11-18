package biz.app.appweb.dao;

import java.util.List;

import biz.app.appweb.model.*;
import org.springframework.stereotype.Repository;

import framework.common.dao.MainAbstractDao;

/**
 * <pre>
 * - 프로젝트명	: 11.business
 * - 패키지명		: biz.app.appweb.dao
 * - 파일명		: PushDao.java
 * - 작성일		: 2020. 12. 21. 
 * - 작성자		: hjh
 * - 설 명		: push/문자 발송 DAO
 * </pre>
 */
@Repository
public class PushDao extends MainAbstractDao {
	private static final String BASE_DAO_PACKAGE = "push.";

	/**
	 * <pre>
	 * - 프로젝트명	: 41.admin.web
	 * - 파일명		: PushDao.java
	 * - 작성일		: 2020. 12. 21.
	 * - 작성자		: hjh
	 * - 설명			: 알림 메시지 목록 그리드
	 * </pre>
	 * @param so
	 * @return
	 */
	public List<PushVO> pageNoticeSendList(PushSO so) {
		return selectListPage(BASE_DAO_PACKAGE+"pageNoticeSendList", so);
	}
	
	/**
	 * <pre>
	 * - 프로젝트명	: 41.admin.web
	 * - 파일명		: PushDao.java
	 * - 작성일		: 2020. 12. 21.
	 * - 작성자		: hjh
	 * - 설명			: 알림 메시지 발송현황 상세
	 * </pre>
	 * @param so
	 * @return
	 */
	public PushVO getPushMessage(PushSO so) {
		return selectOne(BASE_DAO_PACKAGE+"getPushMessage", so);
	}

	/**
	 * <pre>
	 * - 프로젝트명	: 41.admin.web
	 * - 파일명		: PushDao.java
	 * - 작성일		: 2020. 12. 21.
	 * - 작성자		: hjh
	 * - 설명			: 알림 메시지 발송건수 목록 그리드
	 * </pre>
	 * @param so
	 * @return
	 */
	public List<PushVO> pageNoticeCnt(PushSO so) {
		return selectListPage(BASE_DAO_PACKAGE+"pageNoticeCnt", so);
	}

	/**
	 * <pre>
	 * - 프로젝트명	: 41.admin.web
	 * - 파일명		: PushDao.java
	 * - 작성일		: 2020. 12. 21.
	 * - 작성자		: hjh
	 * - 설명			: 알림 메시지 템플릿 목록 그리드
	 * </pre>
	 * @param so
	 * @return
	 */
	public List<PushVO> pageNoticeTemplate(PushSO so) {
		return selectListPage(BASE_DAO_PACKAGE+"pageNoticeTemplate", so);
	}
	
	/**
	 * <pre>
	 * - 프로젝트명	: 41.admin.web
	 * - 파일명		: PushDao.java
	 * - 작성일		: 2020. 12. 21.
	 * - 작성자		: hjh
	 * - 설명			: 알림 메시지 템플릿 단건 조회
	 * </pre>
	 * @param so
	 * @return
	 */
	public PushVO getNoticeTemplate(PushSO so) {
		return selectOne(BASE_DAO_PACKAGE+"getNoticeTemplate", so);
	}

	/**
	 * <pre>
	 * - 프로젝트명	: 41.admin.web
	 * - 파일명		: PushDao.java
	 * - 작성일		: 2020. 12. 21.
	 * - 작성자		: hjh
	 * - 설명			: 알림 메시지 템플릿 등록
	 * </pre>
	 * @param po
	 * @return
	 */
	public int insertNoticeTemplate(PushPO po) {
		return insert(BASE_DAO_PACKAGE+"insertNoticeTemplate", po);
	}

	/**
	 * <pre>
	 * - 프로젝트명	: 41.admin.web
	 * - 파일명		: PushDao.java
	 * - 작성일		: 2020. 12. 21.
	 * - 작성자		: hjh
	 * - 설명			: 알림 메시지 템플릿 수정
	 * </pre>
	 * @param po
	 * @return
	 */
	public int updateNoticeTemplate(PushPO po) {
		return update(BASE_DAO_PACKAGE+"updateNoticeTemplate", po);
	}

	/**
	 * <pre>
	 * - 프로젝트명	: 41.admin.web
	 * - 파일명		: PushDao.java
	 * - 작성일		: 2020. 12. 21.
	 * - 작성자		: hjh
	 * - 설명			: 알림 메시지 템플릿 삭제
	 * </pre>
	 * @param po
	 * @return
	 */
	public int deleteNoticeTemplate(PushPO po) {
		return update(BASE_DAO_PACKAGE+"deleteNoticeTemplate", po);
	}

	/**
	 * <pre>
	 * - 프로젝트명	: 41.admin.web
	 * - 파일명		: PushDao.java
	 * - 작성일		: 2020. 12. 21.
	 * - 작성자		: hjh
	 * - 설명			: 알림 메시지 발송 정보 목록
	 * </pre>
	 * @param po
	 * @return
	 */
	public List<PushVO> listPushMsgSendView(PushSO so) {
		return selectList(BASE_DAO_PACKAGE+"listPushMsgSendView", so);
	}


	/**
	 * <pre>
	 * - 프로젝트명	: 41.admin.web
	 * - 파일명		: PushDao.java
	 * - 작성일		: 2021. 01. 08
	 * - 작성자		: KJY
	 * - 설명			: 마케팅,개인정보,휴면 ,데이터3법 일자별 발송내역
	 * </pre>
	 * @param po
	 * @return
	 */
	public List<NoticeSendCommonVO> pageNoticeSendListByDailiy(NoticeSendSO so) {
		return selectListPage(BASE_DAO_PACKAGE+"pageNoticeSendListByDailiy",so);
	}

	/**
	 * <pre>
	 * - 프로젝트명	: 41.admin.web
	 * - 파일명		: PushDao.java
	 * - 작성일		: 2021. 01. 08
	 * - 작성자		: kjy
	 * - 설명			: 마케팅,개인정보,휴면 ,데이터3법 회원별 발송 내역
	 * </pre>
	 * @param po
	 * @return
	 */
	public List<NoticeSendCommonVO> pageNoticeSendListForMbr(NoticeSendSO so) {
		return selectListPage(BASE_DAO_PACKAGE+"pageNoticeSendListForMbr",so);
	}

	/**
	 * <pre>
	 * - 프로젝트명	: 41.admin.web
	 * - 파일명		: PushDao.java
	 * - 작성일		: 2020. 12. 21.
	 * - 작성자		: hjh
	 * - 설명			: 알림 메시지 발송 정보 등록
	 * </pre>
	 * @param po
	 * @return
	 */
	public int insertNoticeSendList(PushPO po) {
		return insert(BASE_DAO_PACKAGE+"insertNoticeSendList", po);
	}
	
	/**
	 * <pre>
	 * - 프로젝트명	: 41.admin.web
	 * - 파일명		: PushDao.java
	 * - 작성일		: 2020. 12. 21.
	 * - 작성자		: hjh
	 * - 설명			: 알림 메시지 발송 정보 수정
	 * </pre>
	 * @param po
	 * @return
	 */
	public int updateNoticeSendList(PushPO po) {
		return update(BASE_DAO_PACKAGE+"updateNoticeSendList", po);
	}

	/**
	 * <pre>
	 * - 프로젝트명	: 41.admin.web
	 * - 파일명		: PushDao.java
	 * - 작성일		: 2020. 12. 21.
	 * - 작성자		: hjh
	 * - 설명			: 알림 메시지 발송 정보 삭제
	 * </pre>
	 * @param po
	 * @return
	 */
	public int deleteNoticeSendList(PushPO po) {
		return delete(BASE_DAO_PACKAGE+"deleteNoticeSendList", po);
	}
	
	/**
	 * <pre>
	 * - 프로젝트명	: 41.admin.web
	 * - 파일명		: PushDao.java
	 * - 작성일		: 2021. 01. 28.
	 * - 작성자		: KKB
	 * - 설명		: 알림 메시지 발송 상세 정보 등록
	 * </pre>
	 * @param po
	 * @return
	 */
	public int insertNoticeSendDetailList(PushDetailPO po) {
		return insert(BASE_DAO_PACKAGE+"insertNoticeSendDetailList", po);
	}
	
	/**
	 * <pre>
	 * - 프로젝트명	: 41.admin.web
	 * - 파일명		: PushDao.java
	 * - 작성일		: 2021. 01. 28.
	 * - 작성자		: hjh
	 * - 설명			: 알림 메시지 발송 상세 정보 수정
	 * </pre>
	 * @param po
	 * @return
	 */
	public int updateNoticeSendDetailList(PushDetailPO po) {
		return update(BASE_DAO_PACKAGE+"updateNoticeSendDetailList", po);
	}
	
	/**
	 * <pre>
	 * - 프로젝트명	: 41.admin.web
	 * - 파일명		: PushDao.java
	 * - 작성일		: 2021. 01. 28.
	 * - 작성자		: hjh
	 * - 설명			: 알림 메시지 발송 상세 정보 삭제
	 * </pre>
	 * @param po
	 * @return
	 */
	public int deleteNoticeSendDetailList(PushDetailPO po) {
		return delete(BASE_DAO_PACKAGE+"deleteNoticeSendDetailList", po);
	}

	/**
	 * <pre>
	 * - 프로젝트명	: 41.admin.web
	 * - 파일명		: PushDao.java
	 * - 작성일		: 2021. 02. 15.
	 * - 작성자		: KKB
	 * - 설명		: 예약 발송 리스트 조회
	 * </pre>
	 * @param so
	 * @return List<NoticeSendListVO>
	 */
	public List<NoticeSendListVO> listRsrvNotice(PushSO so) {
		return selectList(BASE_DAO_PACKAGE+"listRsrvNotice", so);
	}
	
	/**
	 * <pre>
	 * - 프로젝트명	: 41.admin.web
	 * - 파일명		: PushService.java
	 * - 작성일		: 2021. 03. 03
	 * - 작성자		: KKB
	 * - 설명		: 발송 상세 리스트 조회 (이력 미입력 데이터)
	 * </pre>
	 * @param so
	 * @return List<NoticeSendListVO>
	 */
	public List<NoticeSendListDetailVO> listSentNoticeDetail(PushSO so){
		return selectList(BASE_DAO_PACKAGE+"listSentNoticeDetail", so);
	}
	
	public List<PushVO> getFrontPushList(PushSO so){
		return selectList(BASE_DAO_PACKAGE+"getFrontPushList" , so);
	}
	
	/**
	 * <pre>
	 * - 프로젝트명	: 41.admin.web
	 * - 파일명		: PushService.java
	 * - 작성일		: 2021. 03. 10
	 * - 작성자		: KWJ
	 * - 설명		: SSG 알림발송 상세 리스트 조회 (이력 미입력 데이터)
	 * </pre>
	 * @param so
	 * @return List<NoticeSendListVO>
	 */
	public List<NoticeSendListDetailVO> listSsgNoticeDetail(PushSO so){
		return selectList(BASE_DAO_PACKAGE+"listSsgNoticeDetail", so);
	}
	
	/**
	 * <pre>
	 * - 프로젝트명	: 41.admin.web
	 * - 파일명		: PushService.java
	 * - 작성일		: 2021. 03. 12
	 * - 작성자		: KWJ
	 * - 설명		: SENS PUSH 상세 리스트 조회 (이력 미입력 데이터)
	 * </pre>
	 * @param so
	 * @return List<NoticeSendListVO>
	 */
	public List<NoticeSendListDetailVO> listSensPushDetail(PushSO so){
		return selectList(BASE_DAO_PACKAGE+"listSensPushDetail", so);
	}
}
