package biz.app.event.dao;

import biz.app.display.model.DisplayCategorySO;
import biz.app.display.model.DisplayCategoryVO;
import biz.app.event.model.*;
import biz.app.goods.model.GoodsBaseSO;
import biz.app.goods.model.GoodsBaseVO;
import biz.app.member.model.MemberBaseVO;
import biz.app.st.model.StStdInfoPO;
import framework.common.dao.MainAbstractDao;
import org.springframework.stereotype.Repository;

import java.util.List;

/**
* <pre>
* - 프로젝트명	: 11.business
* - 패키지명	: biz.app.BASE_DAO_PACKAGE + "dao
* - 파일명		: EventDao.java
* - 작성일		: 2016. 3. 8.
* - 작성자		: phy
* - 설명		:
* </pre>
*/
@Repository
public class EventDao extends MainAbstractDao {

	private static final String BASE_DAO_PACKAGE = "event.";

	//-------------------------------------------------------------------------------------------------------------------------//
	//- Front
	//-------------------------------------------------------------------------------------------------------------------------//

	/**
	* <pre>
	* - 프로젝트명	: 11.business
	* - 파일명		: EventDao.java
	* - 작성일		: 2016. 3. 8.
	* - 작성자		: phy
	* - 설명		: 이벤트 목록 조회
	* </pre>
	* @param so
	* @return
	*/
	public List<EventBaseVO> pageEvent(EventBaseSO so) {
		return selectListPage(BASE_DAO_PACKAGE + "pageEvent", so);
	}

	/**
	* <pre>
	* - 프로젝트명	: 11.business
	* - 파일명		: EventDao.java
	* - 작성일		: 2016. 6. 2.
	* - 작성자		: syj
	* - 설명		: 이벤트 기획전 목록
	* </pre>
	* @param po
	* @return
	*/
	public List<DisplayCategoryVO> pageExhibition(DisplayCategorySO so) {
		return selectListPage(BASE_DAO_PACKAGE + "pageExhibition",so);
	}

	//-------------------------------------------------------------------------------------------------------------------------//
	//- Admin
	//-------------------------------------------------------------------------------------------------------------------------//

	/**
	 * <pre>
	 * - 프로젝트명	: 11.business
	 * - 파일명		: EventDao.java
	 * - 작성일		: 2016. 6. 20.
	 * - 작성자		: joeunok
	 * - 설명		: 이벤트 목록 그리드
	 * </pre>
	 * @param so
	 * @return
	 */
	public List<EventBaseVO> pageEventBase(EventBaseSO so) {
		return selectListPage(BASE_DAO_PACKAGE + "pageEventBase", so);
	}


	/**
	* <pre>
	* - 프로젝트명	: 11.business
	* - 파일명		: EventDao.java
	* - 작성일		: 2016. 6. 20.
	* - 작성자		: valueFactory
	* - 설명			: 이벤트 등록
	* </pre>
	* @param po
	* @return
	*/
	public int insertEventBase (EventBasePO po ) {
		return insert(BASE_DAO_PACKAGE + "insertEventBase", po );
	}
	
	/**
	* <pre>
	* - 프로젝트명	: 11.business
	* - 파일명		: EventDao.java
	* - 작성일		: 2021. 01. 29.
	* - 작성자		: 김재윤
	* - 설명			: 이벤트 등록
	* </pre>
	* @param po
	* @return
	*/
	public int insertEventEntry (EventBasePO po ) {
		return insert(BASE_DAO_PACKAGE + "insertEventEntry", po );
	}


	/**
	* <pre>
	* - 프로젝트명	: 11.business
	* - 파일명		: EventDao.java
	* - 작성일		: 2016. 6. 20.
	* - 작성자		: valueFactory
	* - 설명			: 이벤트 수정
	* </pre>
	* @param po
	* @return
	*/
	public int updateEventBase (EventBasePO po ) {
		return update(BASE_DAO_PACKAGE + "updateEventBase", po );
	}
	
	/**
	* <pre>
	* - 프로젝트명	: 11.business
	* - 파일명		: EventDao.java
	* - 작성일		: 2016. 6. 20.
	* - 작성자		: 김재윤
	* - 설명			: 응모 이벤트 수정
	* </pre>
	* @param po
	* @return
	*/
	public int updateEventEntry(EventBasePO po ) {
		return update(BASE_DAO_PACKAGE + "updateEventEntry", po );
	}

	/**
	* <pre>
	* - 프로젝트명	: 11.business
	* - 파일명		: EventDao.java
	* - 작성일		: 2016. 6. 20.
	* - 작성자		: 김재윤
	* - 설명			: 이벤트 경로 수정
	* </pre>
	* @param po
	* @return
	*/
	public int updateEventDlgtImgPath(EventBasePO po ) {
		return update(BASE_DAO_PACKAGE + "updateEventDlgtImgPath", po );
	}


	
	/**
	 * <pre>
	 * - 프로젝트명	: 11.business
	 * - 파일명		: EventDao.java
	 * - 작성일		: 2017. 1. 09.
	 * - 작성자		: 이성용
	 * - 설명		: 사이트와 이벤트 매핑 정보 등록
	 * </pre>
	 * @param po
	 * @return
	 */
	public int insertStEventMap(StStdInfoPO po) {
		
		return insert(BASE_DAO_PACKAGE + "insertStStdEventMap", po);
	}
	
	/**
	 * <pre>
	 * - 프로젝트명	: 11.business
	 * - 파일명		: EventDao.java
	 * - 작성일		: 2017. 1. 09.
	 * - 작성자		: 이성용
	 * - 설명		: 사이트와 이벤트 매핑 정보 삭제
	 * </pre>
	 * @param po
	 * @return
	 */	
	public int deleteStEventMap(EventBasePO po) {
		
		return delete(BASE_DAO_PACKAGE + "deleteStStdEventMap", po);
	}

	/**
	* <pre>
	* - 프로젝트명	: 11.business
	* - 파일명		: EventDao.java
	* - 작성일		: 2016. 6. 20.
	* - 작성자		: valueFactory
	* - 설명			: 이벤트 조회
	* </pre>
	* @param eventNo
	* @return
	*/
	public EventBaseVO getEventBase (Long eventNo) {
		return (EventBaseVO)selectOne(BASE_DAO_PACKAGE + "getEventBase", eventNo );
	}

	public List<GoodsBaseVO> getExhibitionGoods(GoodsBaseSO gso) {
		return selectList(BASE_DAO_PACKAGE + "getExhibitionGoods", gso);
	}
	
	public List<GoodsBaseVO> getExhibitionDealGoods(GoodsBaseSO gso) {
		return selectList(BASE_DAO_PACKAGE + "getExhibitionDealGoods", gso);
	}

	public EventBaseVO getEventPayment() {
		return selectOne(BASE_DAO_PACKAGE + "getEventPayment", null);
	}

	/**
	 * <pre>
	 * - Method 명	: insertQuestionInfo
	 * - 작성일		: 2021. 01. 29.
	 * - 작성자		: 김재윤
	 * - 설 명			: 질문 정보 등록
	 * </pre>
	 *
	 * @param po
	 */
	public int insertEventQuestion(EventQuestionPO po) {
		return insert(BASE_DAO_PACKAGE + "insertEventQuestion", po);
	}

	/**
	 * <pre>
	 * - Method 명	: deleteEventQuestion
	 * - 작성일		: 2020. 7. 13.
	 * - 작성자		: Administrator
	 * - 설 명			: 이벤트 질문 정보 삭제
	 * </pre>
	 *
	 * @param po
	 */
	public void deleteEventQuestion(EventQuestionPO po) {
		delete(BASE_DAO_PACKAGE + "deleteEventQuestion", po);
	}

	/**
	 * <pre>
	 * - Method 명	: insertAnswerInfo
	 * - 작성일		: 2020. 7. 8.
	 * - 작성자		: Administrator
	 * - 설 명			: 답변 정보 등록
	 * </pre>
	 *
	 * @param po
	 */
	public int insertEventAnswer(EventAnswerPO po) {
		return insert(BASE_DAO_PACKAGE + "insertEventAnswer", po);
	}

	/**
	 * <pre>
	 * - Method 명	: deleteAnswerInfo
	 * - 작성일		: 2020. 7. 13.
	 * - 작성자		: Administrator
	 * - 설 명			: 이벤트 답변 정보 삭제
	 * </pre>
	 *
	 * @param po
	 */
	public void deleteEventAnswer(EventAnswerPO po) {
		delete(BASE_DAO_PACKAGE + "deleteEventAnswer", po);
	}

	/**
	 * <pre>
	 * - Method 명	: insertEventAddField
	 * - 작성일		: 2020. 7. 8.
	 * - 작성자		: Administrator
	 * - 설 명			: 이벤트 추가 필드 등록
	 * </pre>
	 *
	 * @param  po
	 * @return
	 */
	public int insertEventAddField(EventAddFieldPO po) {
		return insert(BASE_DAO_PACKAGE + "insertEventAddField", po);
	}

	/**
	 * <pre>
	 * - Method 명	: deleteEventAddField
	 * - 작성일		: 2020. 7. 13.
	 * - 작성자		: Administrator
	 * - 설 명			: 이벤트 추가 필드 삭제
	 * </pre>
	 *
	 * @param po
	 */
	public void deleteEventAddField(EventAddFieldPO po) {
		delete(BASE_DAO_PACKAGE + "deleteEventAddField", po);
	}

	/**
	 * <pre>
	 * - Method 명	: insertEventCollectItem
	 * - 작성일		: 2020. 7. 7.
	 * - 작성자		: Administrator
	 * - 설 명			: 이벤트 수집 항목 등록
	 * </pre>
	 *
	 * @param  po
	 * @return
	 */
	public int insertEventCollectItem(EventCollectItemPO po) {
		return insert(BASE_DAO_PACKAGE + "insertEventCollectItem", po);
	}

	/**
	 * <pre>
	 * - Method 명	: deleteEventCollectItem
	 * - 작성일		: 2020. 7. 13.
	 * - 작성자		: Administrator
	 * - 설 명			: 이벤트 수집 항목 삭제
	 * </pre>
	 *
	 * @param po
	 */
	public void deleteEventCollectItem(EventCollectItemPO po) {
		delete(BASE_DAO_PACKAGE + "deleteEventCollectItem", po);
	}

	/**
	 * <pre>
	 * - Method 명	: listEventAddField
	 * - 작성일		: 2021.01. 29.
	 * - 작성자		: 김재윤
	 * - 설 명			: 이벤트 추가 필드 조회
	 * </pre>
	 *
	 * @param so
	 * @return
	 */
	public List<EventAddFieldVO> listEventAddField(Long eventNo){
		return selectList(BASE_DAO_PACKAGE + "listEventAddField", eventNo);
	}

	/**
	 * <pre>
	 * - Method 명	: listQuestionAndAnswerInfo
	 * - 작성일		: 2021.01. 29.
	 * - 작성자		: 김재윤
	 * - 설 명			: 이벤트 퀴즈 조회
	 * </pre>
	 *
	 * @param so
	 * @return
	 */
	public List<EventQuestionVO> listQuestionAndAnswerInfo(Long eventNo){
		return selectList(BASE_DAO_PACKAGE + "listQuestionAndAnswerInfo", eventNo);
	}

	/**
	 * <pre>
	 * - Method 명	: listQuestionAndAnswerInfo
	 * - 작성일		: 2021.02. 03.
	 * - 작성자		: 김재윤
	 * - 설 명			: 이벤트 참여자 목록 조회
	 * </pre>
	 *
	 * @param so
	 * @return
	 */
	public List<EventEntryWinInfoVO> pageEventJoinMember(EventEntryWinInfoSO so){
		return selectListPage(BASE_DAO_PACKAGE + "pageEventJoinMember", so);
	}

	/**
	 * <pre>
	 * - Method 명	: listQuestionAndAnswerInfo
	 * - 작성일		: 2021.02. 03.
	 * - 작성자		: 김재윤
	 * - 설 명			: 이벤트 당첨자 목록 조회
	 * </pre>
	 *
	 * @param so
	 * @return
	 */
	public List<MemberBaseVO> pageEventWinnerMember(EventEntryWinInfoSO so){
		return selectListPage(BASE_DAO_PACKAGE + "pageEventWinnerMember", so);
	}

	/**
	 * <pre>
	 * - Method 명	: listQuestionAndAnswerInfo
	 * - 작성일		: 2021.02. 03.
	 * - 작성자		: 김재윤
	 * - 설 명			: 이벤트 당첨 정보 조회
	 * </pre>
	 *
	 * @param so
	 * @return
	 */
	public EventBaseVO getEventWinInfo(EventBaseSO so){
		return selectOne(BASE_DAO_PACKAGE + "getEventWinInfo", so);
	}
}