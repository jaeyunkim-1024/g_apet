package biz.app.system.dao;

import java.util.List;

import org.springframework.stereotype.Repository;

import biz.app.system.model.DeliverAreaSetPO;
import biz.app.system.model.DeliverAreaSetSO;
import biz.app.system.model.DeliverAreaSetVO;
import biz.app.system.model.ZipcodeMappingPO;
import biz.app.system.model.ZipcodeMappingSO;
import biz.app.system.model.ZipcodeMappingVO;
import framework.common.dao.MainAbstractDao;

@Repository
public class DirectDeliverAreaDao extends MainAbstractDao {

	/**
	 * <pre>
	 * - 프로젝트명	: 11.business
	 * - 파일명		: DirectrDeliverAreaDao.java
	 * - 작성일		: 2016. 5. 26.
	 * - 작성자		: valueFactory
	 * - 설명		: 직배송지역 리스트
	 * </pre>
	 * @param so
	 * @return
	 */
	public List<DeliverAreaSetVO> listDirectDeliverArea(DeliverAreaSetSO so) {
		return selectList("directDeliverArea.listDirectDeliverArea", so);
	}

	/**
	 * <pre>
	 * - 프로젝트명	: 11.business
	 * - 파일명		: DirectDeliverAreaDao.java
	 * - 작성일		: 2016. 6. 2.
	 * - 작성자		: valueFactory
	 * - 설명		: 직배송지역 삭제
	 * </pre>
	 * @param po
	 * @return
	 */
	public int deleteDirectDeliverArea(DeliverAreaSetPO po) {
		return delete("directDeliverArea.deleteDirectDeliverArea", po);
	}

	/**
	 * <pre>
	 * - 프로젝트명	: 11.business
	 * - 파일명		: DirectDeliverAreaDao.java
	 * - 작성일		: 2016. 6. 2.
	 * - 작성자		: valueFactory
	 * - 설명		: 창고 리스트
	 * </pre>
	 * @param so
	 * @return
	 */
	public List<DeliverAreaSetVO> listWareHouse(DeliverAreaSetSO so) {
		return selectList("directDeliverArea.listWareHouse", so);
	}

	/**
	 * <pre>
	 * - 프로젝트명	: 11.business
	 * - 파일명		: DirectDeliverAreaDao.java
	 * - 작성일		: 2016. 6. 2.
	 * - 작성자		: valueFactory
	 * - 설명		: 직배송지역 수정
	 * </pre>
	 * @param po
	 * @return
	 */
	public int updateDirectDeliverArea(DeliverAreaSetPO po) {
		return insert("directDeliverArea.updateDirectDeliverArea", po);
	}

	/**
	 * <pre>
	 * - 프로젝트명	: 11.business
	 * - 파일명		: DirectDeliverAreaDao.java
	 * - 작성일		: 2016. 6. 2.
	 * - 작성자		: valueFactory
	 * - 설명		: 직배송지역 추가
	 * </pre>
	 * @param po
	 * @return
	 */
	public int insertDirectDeliverArea(DeliverAreaSetPO po) {
		return update("directDeliverArea.insertDirectDeliverArea", po);
	}

	/**
	 * <pre>
	 * - 프로젝트명	: 11.business
	 * - 파일명		: DirectDeliverAreaDao.java
	 * - 작성일		: 2016. 6. 7.
	 * - 작성자		: valueFactory
	 * - 설명		: 우편번호 리스트
	 * </pre>
	 * @param so
	 * @return
	 */
	public List<ZipcodeMappingVO> iistZipCodeGrid(ZipcodeMappingSO so) {
		return selectListPage("directDeliverArea.iistZipCodeGrid", so);
	}

	/**
	 * <pre>
	 * - 프로젝트명	: 11.business
	 * - 파일명		: DirectDeliverAreaDao.java
	 * - 작성일		: 2016. 6. 8.
	 * - 작성자		: valueFactory
	 * - 설명		: 직배송 지역 저장
	 * </pre>
	 * @param po
	 * @return
	 */
	public int saveDeliverAreaZipCode(ZipcodeMappingPO po) {
		return update("directDeliverArea.saveDeliverAreaZipCode", po);
	}

	/**
	 * <pre>
	 * - 프로젝트명	: 11.business
	 * - 파일명		: DirectDeliverAreaDao.java
	 * - 작성일		: 2016. 6. 9.
	 * - 작성자		: valueFactory
	 * - 설명		: 신우편번호 존재 여부 확인
	 * </pre>
	 * @param so
	 * @return
	 */
	public ZipcodeMappingVO getAreaZipCode(ZipcodeMappingSO so) {
		return (ZipcodeMappingVO) selectOne("directDeliverArea.getAreaZipCode", so);
	}

	/**
	 * <pre>
	 * - 프로젝트명	: 11.business
	 * - 파일명		: DirectDeliverAreaDao.java
	 * - 작성일		: 2016. 6. 9.
	 * - 작성자		: valueFactory
	 * - 설명		: 신우편번호 추가
	 * </pre>
	 * @param po
	 * @return
	 */
	public int insertDeliverAreaZipCode(ZipcodeMappingPO po) {
		return update("directDeliverArea.insertDeliverAreaZipCode", po);
	}
}