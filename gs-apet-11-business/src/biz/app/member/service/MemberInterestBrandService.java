package biz.app.member.service;

import java.util.List;

import biz.app.member.model.MemberInterestBrandPO;
import biz.app.member.model.MemberInterestBrandSO;
import biz.app.member.model.MemberInterestBrandVO;
import biz.app.member.model.MemberInterestGoodsSO;


/**
* <pre>
* - 프로젝트명	: 11.business
* - 패키지명	: biz.app.member.service
* - 파일명		: MemberInterestBrandService.java
* - 작성일		: 2017. 02. 08.
* - 작성자		: wyjeong
* - 설명		: 회원 관심 브랜드 서비스
* </pre>
*/
public interface MemberInterestBrandService {


	/**
	* <pre>
	* - 프로젝트명	: 11.business
	* - 파일명		: MemberInterestBrandService.java
	* - 작성일		: 2017. 02. 08.
	* - 작성자		: wyjeong
	* - 설명		: 회원 관심 브랜드 등록
	* </pre>
	* @param po
	* @throws Exception
	*/
	int insertMemberInterestBrand(MemberInterestBrandPO po);


	/**
	* <pre>
	* - 프로젝트명	: 11.business
	* - 파일명		: MemberInterestBrandService.java
	* - 작성일		: 2017. 02. 08.
	* - 작성자		: wyjeong
	* - 설명		: 회원 관심 브랜드 목록
	* </pre>
	* @param so
	* @return
	* @throws Exception
	*/
	List<MemberInterestBrandVO> pageMemberInterestBrand(MemberInterestBrandSO so);

	/**
	* <pre>
	* - 프로젝트명	: 11.business
	* - 파일명		: MemberInterestBrandService.java
	* - 작성일		: 2017. 02. 08.
	* - 작성자		: wyjeong
	* - 설명		: 회원 관심 브랜드 삭제
	* </pre>
	* @param bndNos
	* @throws Exception
	*/
	void deleteMemberInterestBrand(Long mbrNo, Long[] bndNos);

	/**
	* <pre>
	* - 프로젝트명	: 11.business
	* - 파일명		: MemberInterestGoodsService.java
	* - 작성일		: 2017. 02. 08.
	* - 작성자		: wyjeong
	* - 설명		: 회원 관심 상품 삭제(Batch용)
	* </pre>
	* @param po
	*/
	void deleteMemberInterestBrand(MemberInterestBrandPO po);


	/**
	 *
	* <pre>
	* - 프로젝트명	: 11.business
	* - 파일명		: MemberInterestBrandService.java
	* - 작성일		: 2017. 3. 14.
	* - 작성자		: hjko
	* - 설명		: 마이페이지 > 찜 > 브랜드 목록
	* </pre>
	* @param so
	* @return
	 */
	List<MemberInterestBrandVO> listMemberInterestBrands(MemberInterestGoodsSO so);

	/**
	 *
	 * <pre>
	 * - 프로젝트명		: 11.business
	 * - 파일명		: MemberInterestBrandService.java
	 * - 작성일		: 2017. 3. 14.
	 * - 작성자		: hjko
	 * - 설명			: 마이페이지 > 위시리스트 > 위시리스트 브랜드 목록
	 * </pre>
	 * @param so
	 * @return
	 */
	List<MemberInterestBrandVO> pageMemberInterestBrands(MemberInterestBrandSO so);
}