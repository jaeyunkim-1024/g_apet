package biz.app.partner.dao;

import java.util.List;

import org.springframework.stereotype.Repository;

import biz.app.member.model.MemberBasePO;
import biz.app.member.model.MemberBaseSO;
import biz.app.member.model.MemberBizInfoPO;
import biz.app.partner.model.PartnerInfoPO;
import biz.app.partner.model.PartnerInfoSO;
import biz.app.partner.model.PartnerInfoVO;
import framework.common.dao.MainAbstractDao;

/**
* <pre>
* - 프로젝트명	: 11.business
* - 패키지명	: biz.app.partner.dao
* - 파일명		: PartnerDao.java
* - 작성일		: 2021. 01. 05
* - 작성자		: jejvf
* - 설명		: 파트너 Dao
* </pre>
*/
@Repository
public class PartnerDao extends MainAbstractDao {
	private static final String BASE_DAO_PACKAGE = "partner.";
	
	public int getPartnerIdCheck(PartnerInfoSO so) {
		return (int) selectOne(BASE_DAO_PACKAGE + "getPartnerIdCheck", so);
	}
	
	public int insertPartner(PartnerInfoPO po) {
		return insert(BASE_DAO_PACKAGE + "insertPartner", po);
	}

	public int insertPartnerBizInfo(PartnerInfoPO po) {
		return insert(BASE_DAO_PACKAGE + "insertPartnerBizInfo", po);
	}
	
	public List<PartnerInfoVO> pagePartnerList(PartnerInfoSO so) {
		return selectListPage(BASE_DAO_PACKAGE + "pagePartnerList", so);
	}
	
	public PartnerInfoVO getPartner(PartnerInfoSO so) {
		return selectOne(BASE_DAO_PACKAGE + "getPartner", so);
	}
	
	public int updatePartner(PartnerInfoPO po) {
		return update(BASE_DAO_PACKAGE + "updatePartner", po);
	}
	
	public int updatePartnerBizInfo(PartnerInfoPO po) {
		return update(BASE_DAO_PACKAGE + "updatePartnerBizInfo", po);
	}
	
	public int deleteImage(PartnerInfoPO po) {
		return update(BASE_DAO_PACKAGE + "deleteImage", po);
	}
	
	public int getPartnerEmailCheck(PartnerInfoSO so) {
		return (int) selectOne(BASE_DAO_PACKAGE + "getPartnerEmailCheck", so);
	}
	
	public int getPartnerNickNmCheck(PartnerInfoSO so) {
		return (int) selectOne(BASE_DAO_PACKAGE + "getPartnerNickNmCheck", so);
	}
	
}
