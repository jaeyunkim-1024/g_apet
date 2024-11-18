package biz.app.partner.service;

import java.util.List;

import biz.app.member.model.MemberBasePO;
import biz.app.member.model.MemberBaseSO;
import biz.app.member.model.MemberBizInfoPO;
import biz.app.partner.model.PartnerInfoPO;
import biz.app.partner.model.PartnerInfoSO;
import biz.app.partner.model.PartnerInfoVO;

/**
 * <pre>
 * - 프로젝트명	: 11.business
 * - 패키지명		: biz.app.partner.service
 * - 파일명		: PartnerService.java
 * - 작성자		: valueFactory
 * - 설명			: 파트너 Service
 * </pre>
 */
public interface PartnerService {
	
	int getPartnerIdCheck(PartnerInfoSO so);

	void insertPartner(PartnerInfoPO po);
	
	List<PartnerInfoVO> pagePartnerList(PartnerInfoSO so);
	
	PartnerInfoVO getPartner(PartnerInfoSO so);
	
	void updatePartner(PartnerInfoPO po);
	
	int deleteImage(PartnerInfoPO po);
	
	int getPartnerEmailCheck(PartnerInfoSO so);
	
	int getPartnerNickNmCheck(PartnerInfoSO so);
}
