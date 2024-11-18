package biz.app.member.service;

import java.util.List;

import biz.app.member.model.MemberAddressPO;
import biz.app.member.model.MemberAddressSO;
import biz.app.member.model.MemberAddressVO;

/**
* <pre>
* - 프로젝트명	: 11.business
* - 패키지명	: biz.app.member.service
* - 파일명		: MemberAddressService.java
* - 작성일		: 2016. 3. 2.
* - 작성자		: snw
* - 설명		: 회원 주소록 서비스 구조
* </pre>
*/
public interface MemberAddressService {


	/**
	* <pre>
	* - 프로젝트명	: 11.business
	* - 파일명		: MemberAddressService.java
	* - 작성일		: 2016. 3. 2.
	* - 작성자		: snw
	* - 설명		: 회원 주소록 목록 조회
	* </pre>
	* @param so
	* @return
	* @throws Exception
	*/
	List<MemberAddressVO> listMemberAddress(MemberAddressSO so);
	
	/**
	* <pre>
	* - 프로젝트명	: 11.business
	* - 파일명		: MemberAddressService.java
	* - 작성일		: 2016. 3. 2.
	* - 작성자		: snw
	* - 설명		: 회원 주소록 상세 조회
	* </pre>
	* @param mbrDlvraNo
	* @return
	* @throws Exception
	*/
	MemberAddressVO getMemberAddress(Long mbrDlvraNo);

	/**
	* <pre>
	* - 프로젝트명	: 11.business
	* - 파일명		: MemberAddressService.java
	* - 작성일		: 2016. 4. 26.
	* - 작성자		: snw
	* - 설명		: 회원의 기본 배송지 상세 조회
	* </pre>
	* @param mbrNo
	* @return
	* @throws Exception
	*/
	MemberAddressVO getMemberAddressDefault(Long mbrNo);

	/**
	* <pre>
	* - 프로젝트명	: 11.business
	* - 파일명		: MemberAddressService.java
	* - 작성일		: 2016. 3. 2.
	* - 작성자		: snw
	* - 설명		: 회원 주소록 등록
	*             회원 배송지 등록 번호, 0:실패
	* </pre>
	* @param po
	* @return
	* @throws Exception
	*/
	int insertMemberAddress(MemberAddressPO po);


	/**
	* <pre>
	* - 프로젝트명	: 11.business
	* - 파일명		: MemberAddressService.java
	* - 작성일		: 2016. 3. 2.
	* - 작성자		: snw
	* - 설명		: 회원 주소록 수정
	*             1:정상, 0:실패
	* </pre>
	* @param po
	* @return
	* @throws Exception
	*/
	int updateMemberAddress(MemberAddressPO po);
	

	/**
	* <pre>
	* - 프로젝트명	: 11.business
	* - 파일명		: MemberAddressService.java
	* - 작성일		: 2016. 3. 2.
	* - 작성자		: snw
	* - 설명		: 회원 주소록 기본 설정
	*             1:정상, 0:실패
	* </pre>
	* @param po
	* @return
	* @throws Exception
	*/
	void updateMemberAddressDefault(MemberAddressPO po);

	/**
	* <pre>
	* - 프로젝트명	: 11.business
	* - 파일명		: MemberAddressService.java
	* - 작성일		: 2016. 3. 2.
	* - 작성자		: snw
	* - 설명		: 회원 주소록 선택 삭제
	*             삭제수, 0:실패
	* </pre>
	* @param mbrDlvraNos
	* @return
	* @throws Exception
	*/
//	int deleteMemberAddress(Long mbrDlvraNos);

	/**
	* <pre>
	* - 프로젝트명	: 11.business
	* - 파일명		: MemberAddressService.java
	* - 작성일		: 2016. 3. 3.
	* - 작성자		: snw
	* - 설명		: 회원 주소록 삭제(건별)
	* </pre>
	* @param mbrDlvraNo
	* @return
	* @throws Exception
	*/
	int deleteMemberAddress(Long mbrDlvraNo);

}