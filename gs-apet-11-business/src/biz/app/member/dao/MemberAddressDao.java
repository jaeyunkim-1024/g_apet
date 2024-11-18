package biz.app.member.dao;

import java.util.List;

import org.springframework.stereotype.Repository;

import biz.app.member.model.MemberAddressPO;
import biz.app.member.model.MemberAddressSO;
import biz.app.member.model.MemberAddressVO;
import framework.common.dao.MainAbstractDao;


/**
* <pre>
* - 프로젝트명	: 11.business
* - 패키지명	: biz.app.member.dao
* - 파일명		: MemberAddressDao.java
* - 작성일		: 2016. 3. 2.
* - 작성자		: snw
* - 설명		: 회원 주소록 DAO
* </pre>
*/
@Repository
public class MemberAddressDao extends MainAbstractDao {

	private static final String BASE_DAO_PACKAGE = "memberAddress.";
	

	/**
	* <pre>
	* - 프로젝트명	: 11.business
	* - 파일명		: MemberAddressDao.java
	* - 작성일		: 2016. 3. 2.
	* - 작성자		: snw
	* - 설명		: 회원 주소록(배송지) 목록 조회
	* </pre>
	* @param so
	* @return
	*/
	public List<MemberAddressVO> listMemberAddress(MemberAddressSO so){
		return selectList(BASE_DAO_PACKAGE + "listMemberAddress", so);
	}
	

	/**
	* <pre>
	* - 프로젝트명	: 11.business
	* - 파일명		: MemberAddressDao.java
	* - 작성일		: 2016. 3. 2.
	* - 작성자		: snw
	* - 설명		: 회원 주소록(배송지) 상세 조회
	* </pre>
	* @param so
	* @return
	*/
	public MemberAddressVO getMemberAddress(MemberAddressSO so){
		return selectOne(BASE_DAO_PACKAGE + "getMemberAddress", so);
	}


	/**
	* <pre>
	* - 프로젝트명	: 11.business
	* - 파일명		: MemberAddressDao.java
	* - 작성일		: 2016. 3. 2.
	* - 작성자		: snw
	* - 설명		: 회원 주소록(배송지) 등록
	* </pre>
	* @param po
	* @return
	*/
	public int insertMemberAddress(MemberAddressPO po){
		// 데이터 정제
		if(po.getPostNoOld() != null) {po.setPostNoOld(po.getPostNoOld().replaceAll("-", ""));}
		if(po.getTel() != null) {po.setTel(po.getTel().replaceAll("-", ""));}
		if(po.getMobile() != null) {po.setMobile(po.getMobile().replaceAll("-", ""));}
		
		return insert(BASE_DAO_PACKAGE + "insertMemberAddress", po);
	}
	

	/**
	* <pre>
	* - 프로젝트명	: 11.business
	* - 파일명		: MemberAddressDao.java
	* - 작성일		: 2016. 3. 2.
	* - 작성자		: snw
	* - 설명		: 회원 주소록(배송지) 수정
	* </pre>
	* @param po
	* @return
	*/
	public int updateMemberAddress(MemberAddressPO po){
		// 데이터 정제
		if(po.getPostNoOld() != null) {po.setPostNoOld(po.getPostNoOld().replaceAll("-", ""));}
		if(po.getTel() != null) {po.setTel(po.getTel().replaceAll("-", ""));}
		if(po.getMobile() != null) {po.setMobile(po.getMobile().replaceAll("-", ""));}
		
		return update(BASE_DAO_PACKAGE + "updateMemberAddress", po);
	}


	/**
	* <pre>
	* - 프로젝트명	: 11.business
	* - 파일명		: MemberAddressDao.java
	* - 작성일		: 2016. 3. 2.
	* - 작성자		: snw
	* - 설명		: 회원 주소록(배송지) 기본설정 수정
	* </pre>
	* @param po
	* @return
	*/
	public int updateMemberAddressDefault(MemberAddressPO po){
		return update(BASE_DAO_PACKAGE + "updateMemberAddressDefault", po);
	}
	
	/**
	* <pre>
	* - 프로젝트명	: 11.business
	* - 파일명		: MemberAddressDao.java
	* - 작성일		: 2016. 3. 2.
	* - 작성자		: snw
	* - 설명		: 회원주소록(배송지) 삭제
	* 			단일삭제 : mbr_no 및 mbr_dlvra_no 필수
	* 			일괄삭제 : mbr_no 필수
	* </pre>
	* @param po
	* @return
	*/
	public int deleteMemberAddress(MemberAddressPO po){
		return delete(BASE_DAO_PACKAGE + "deleteMemberAddress", po);
	}

}
