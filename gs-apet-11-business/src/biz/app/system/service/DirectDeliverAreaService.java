package biz.app.system.service;

import java.util.List;

import biz.app.system.model.DeliverAreaSetPO;
import biz.app.system.model.DeliverAreaSetSO;
import biz.app.system.model.DeliverAreaSetVO;
import biz.app.system.model.ZipcodeMappingPO;
import biz.app.system.model.ZipcodeMappingSO;
import biz.app.system.model.ZipcodeMappingVO;

/**
 * get업무명		:	단권
 * list업무명	:	리스트
 * page업무명	:	리스트 페이징
 * insert업무명	:	입력
 * update업무명	:	수정
 * delete업무명	:	삭제
 * save업무명	:	입력 / 수정
 */
/**
 * <pre>
 * - 프로젝트명	: 11.business
 * - 패키지명	: biz.app.system.service
 * - 파일명		: HolidayService.java
 * - 작성일		: 2016. 5. 18.
 * - 작성자		: valueFactory
 * - 설명		:
 * </pre>
 */
public interface DirectDeliverAreaService {

	/**
	 * <pre>
	 * - 프로젝트명	: 11.business
	 * - 파일명		: DirectrDeliverAreaService.java
	 * - 작성일		: 2016. 5. 26.
	 * - 작성자		: valueFactory
	 * - 설명		: 직배송지역 리스트
	 * </pre>
	 * @param so
	 * @return
	 */
	public List<DeliverAreaSetVO> listDirectDeliverArea(DeliverAreaSetSO so);


	/**
	 * <pre>
	 * - 프로젝트명	: 11.business
	 * - 파일명		: DirectDeliverAreaService.java
	 * - 작성일		: 2016. 6. 2.
	 * - 작성자		: valueFactory
	 * - 설명		: 직배송지역 삭제
	 * </pre>
	 * @param po
	 */
	public void deleteDirectDeliverArea(DeliverAreaSetPO po);

	/**
	 * <pre>
	 * - 프로젝트명	: 11.business
	 * - 파일명		: DirectDeliverAreaService.java
	 * - 작성일		: 2016. 6. 2.
	 * - 작성자		: valueFactory
	 * - 설명		: 창고 리스트
	 * </pre>
	 * @param so
	 * @return
	 */
	public List<DeliverAreaSetVO> listWareHouse(DeliverAreaSetSO so);

	/**
	 * <pre>
	 * - 프로젝트명	: 11.business
	 * - 파일명		: DirectDeliverAreaService.java
	 * - 작성일		: 2016. 6. 2.
	 * - 작성자		: valueFactory
	 * - 설명		: 직배송지역 추가/수정
	 * </pre>
	 * @param po
	 */
	public void saveDirectDeliverArea(DeliverAreaSetPO po);

	/**
	 * <pre>
	 * - 프로젝트명	: 11.business
	 * - 파일명		: DirectDeliverAreaService.java
	 * - 작성일		: 2016. 6. 7.
	 * - 작성자		: valueFactory
	 * - 설명		: 우편번호 리스트
	 * </pre>
	 * @param so
	 * @return
	 */
	public List<ZipcodeMappingVO> iistZipCodeGrid(ZipcodeMappingSO so);

	/**
	 * <pre>
	 * - 프로젝트명	: 11.business
	 * - 파일명		: DirectDeliverAreaService.java
	 * - 작성일		: 2016. 6. 8.
	 * - 작성자		: valueFactory
	 * - 설명		: 직배송 지역 저장
	 * </pre>
	 * @param po
	 */
	public void saveDeliverAreaZipCode(ZipcodeMappingPO po);

	/**
	 * <pre>
	 * - 프로젝트명	: 11.business
	 * - 파일명		: DirectDeliverAreaService.java
	 * - 작성일		: 2016. 6. 9.
	 * - 작성자		: valueFactory
	 * - 설명		: 신우편번호 추가
	 * </pre>
	 * @param po
	 */
	public void insertDeliverAreaZipCode(ZipcodeMappingPO po);
}