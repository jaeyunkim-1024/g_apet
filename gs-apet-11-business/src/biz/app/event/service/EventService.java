package biz.app.event.service;

import biz.app.display.model.DisplayCategorySO;
import biz.app.display.model.DisplayCategoryVO;
import biz.app.event.model.*;
import biz.app.goods.model.GoodsBaseSO;
import biz.app.goods.model.GoodsBaseVO;

import java.util.List;

/**
* <pre>
* - 프로젝트명	: 11.business
* - 패키지명	: biz.app.event.service
* - 파일명		: EventService.java
* - 작성일		: 2016. 4. 14.
* - 작성자		: phy
* - 설명		: 이벤트 서비스 구조
* </pre>
*/
public interface EventService {

	//-------------------------------------------------------------------------------------------------------------------------//
	//- Front
	//-------------------------------------------------------------------------------------------------------------------------//

	/**
	* <pre>
	* - 프로젝트명	: 11.business
	* - 파일명		: EventService.java
	* - 작성일		: 2016. 3. 8.
	* - 작성자		: phy
	* - 설명		:	이벤트 목록 조회
	* </pre>
	* @param so
	* @return
	* @throws Exception
	*/
	List<EventBaseVO> pageEvent(EventBaseSO so);

	/**
	* <pre>
	* - 프로젝트명	: 11.business
	* - 파일명		: EventService.java
	* - 작성일		: 2016. 6. 2.
	* - 작성자		: syj
	* - 설명		: 기획전 목록 조회
	* </pre>
	* @param so
	*/
	List<DisplayCategoryVO> pageExhibition(DisplayCategorySO so);

	//-------------------------------------------------------------------------------------------------------------------------//
	//- Admin
	//-------------------------------------------------------------------------------------------------------------------------//

	/**
	* <pre>
	* - 프로젝트명	: 11.business
	* - 파일명		: EventService.java
	* - 작성일		: 2016. 6. 20.
	* - 작성자		: valueFactory
	* - 설명			: 이벤트 조회
	* </pre>
	* @param eventNo
	* @return
	*/
	public EventBaseVO getEventBase (Long eventNo );


	/**
	 * <pre>
	 * - 프로젝트명	: 11.business
	 * - 파일명		: EventService.java
	 * - 작성일		: 2021. 01. 29.
	 * - 작성자		: 김재윤
	 * - 설명			: 이벤트 등록/저장
	 * </pre>
	 * @param po
	 * @return
	 */
	public Long saveEvent(EventBasePO po);

	/**
	 * <pre>
	 * - 프로젝트명	: 11.business
	 * - 파일명		: EventService.java
	 * - 작성일		: 2021. 01. 29.
	 * - 작성자		: 김재윤
	 * - 설명			: 응모형 이벤트 - 퀴즈 등록
	 * * </pre>
	 * @param po
	 * @return
	 */
	public void insertEventQuestionAndAnswer(EventQuestionPO po);

	/**
	 * <pre>
	 * - 프로젝트명	: 11.business
	 * - 파일명		: EventService.java
	 * - 작성일		: 2016. 6. 20.
	 * - 작성자		: joeunok
	 * - 설명		: 이벤트 목록 그리드
	 * </pre>
	 * @param so
	 * @return
	 */
	List<EventBaseVO> pageEventBase(EventBaseSO so);

	/**
	 * <pre>
	 * - 프로젝트명	: 11.business
	 * - 파일명		: EventService.java
	 * - 작성일		: 2016. 7. 13.
	 * - 작성자		: syj
	 * - 설명		: 기획전 상품 목록
	 * </pre>
	 * @param list
	 */
	List<GoodsBaseVO> getExhibitionGoods(GoodsBaseSO gso);
	
	/**
	 * <pre>
	 * - 프로젝트명	: 11.business
	 * - 파일명		: EventService.java
	 * - 작성일		: 2016. 8. 30.
	 * - 작성자		: hjko
	 * - 설명		: 기획전 딜상품 목록
	 * </pre>
	 * @param list
	 */
	List<GoodsBaseVO> getExhibitionDealGoods(GoodsBaseSO gso);

	/**
	* <pre>
	* - 프로젝트명	: 11.business
	* - 파일명		: EventService.java
	* - 작성일		: 2016. 8. 12.
	* - 작성자		: Administrator
	* - 설명		:
	* </pre>
	* @param po
	* @return
	*/
	public EventBaseVO getEventPayment();

	/**
	* <pre>
	* - 프로젝트명	: 11.business
	* - 파일명		: EventService.java
	* - 작성일		: 2021.01.29
	* - 작성자		: 김재윤
	* - 설명		:
	* </pre>
	* @param po
	* @return
	*/
	public List listEventAddField(Long eventNo);

	/**
	* <pre>
	* - 프로젝트명	: 11.business
	* - 파일명		: EventService.java
	* - 작성일		: 2021.01.29
	* - 작성자		: 김재윤
	* - 설명		:
	* </pre>
	* @param po
	* @return
	*/
	public List listQuestionAndAnswerInfo(Long eventNo);

	/**
	 * <pre>
	 * - 프로젝트명	: 11.business
	 * - 파일명		: EventService.java
	 * - 작성일		: 2021.02.03
	 * - 작성자		: 김재윤
	 * - 설명		: 이벤트 참여자 목록
	 * </pre>
	 * @param eventNO
	 * @return
	 */
	public List pageEventJoinMember(EventEntryWinInfoSO so);

	/**
	 * <pre>
	 * - 프로젝트명	: 11.business
	 * - 파일명		: EventService.java
	 * - 작성일		: 2021.02.03
	 * - 작성자		: 김재윤
	 * - 설명		: 이벤트 당첨자 목록
	 * </pre>
	 * @param eventNO
	 * @return
	 */
	public List pageEventWinnerMember(EventEntryWinInfoSO so);

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
	public EventBaseVO getEventWinInfo(EventBaseSO so);

	/**
	 * <pre>
	 * - Method 명	: insertEventWinList
	 * - 작성일		: 2021.02. 03.
	 * - 작성자		: 김재윤
	 * - 설 명			: 이벤트 당첨자 등록
	 * </pre>
	 *
	 * @param so
	 * @return
	 */
	public void insertEventWinList(EventBasePO po);
}
