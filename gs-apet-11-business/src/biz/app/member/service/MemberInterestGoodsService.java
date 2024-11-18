package biz.app.member.service;

import java.util.List;

import biz.app.member.model.MemberInterestGoodsPO;
import biz.app.member.model.MemberInterestGoodsSO;
import biz.app.member.model.MemberInterestGoodsVO;

/**
* <pre>
* - 프로젝트명	: 11.business
* - 패키지명	: biz.app.member.service
* - 파일명		: MemberInterestGoodsService.java
* - 작성일		: 2016. 3. 2.
* - 작성자		: snw
* - 설명		: 회원 관심상품 서비스
* </pre>
*/
public interface MemberInterestGoodsService {


	/**
	* <pre>
	* - 프로젝트명	: 11.business
	* - 파일명		: MemberInterestGoodsService.java
	* - 작성일		: 2016. 4. 29.
	* - 작성자		: snw
	* - 설명		: 회원 관심 상품 등록
	* </pre>
	* @param po
	* @throws Exception
	*/
	public int insertMemberInterestGoods(MemberInterestGoodsPO po, String search);

	/**
	* <pre>
	* - 프로젝트명	: 11.business
	* - 파일명		: MemberInterestGoodsService.java
	* - 작성일		: 2016. 5. 4.
	* - 작성자		: phy
	* - 설명		: 회원 관심 상품 목록
	* </pre>
	* @param so
	* @return
	* @throws Exception
	*/
	public List<MemberInterestGoodsVO> pageMemberInterestGoods(MemberInterestGoodsSO so);

	/**
	* <pre>
	* - 프로젝트명	: 11.business
	* - 파일명		: MemberInterestGoodsService.java
	* - 작성일		: 2016. 5. 9.
	* - 작성자		: phy
	* - 설명		: 회원 관심 상품 삭제
	* </pre>
	* @param goodsIds
	* @throws Exception
	*/
	public void deleteMemberInterestGoods(Long mbrNo, String[] goodsIds);


	/**
	* <pre>
	* - 프로젝트명	: 11.business
	* - 파일명		: MemberInterestGoodsService.java
	* - 작성일		: 2016. 7. 29.
	* - 작성자		: snw
	* - 설명		: 회원 관심 상품 삭제(Batch용)
	* </pre>
	* @param po
	*/
	public void deleteMemberInterestGoods(MemberInterestGoodsPO po);

	/**
	 *
	* <pre>
	* - 프로젝트명	: 11.business
	* - 파일명		: MemberInterestGoodsService.java
	* - 작성일		: 2017. 3. 14.
	* - 작성자		: hjko
	* - 설명		: 마이페이지> 찜> 상품목록
	* </pre>
	* @param so
	* @return
	 */
	public List<MemberInterestGoodsVO> listMemberInterestGoods(MemberInterestGoodsSO so);

	/**
	 *
	 * <pre>
	 * - 프로젝트명	: 11.business
	 * - 파일명		: MemberInterestGoodsService.java
	 * - 작성일		: 2017. 3. 14.
	 * - 작성자		: hjko
	 * - 설명		: 마이페이지> 찜상품 개수
	 * </pre>
	 * @param so
	 * @return
	 */
	public int listMemberInterestGoodsCount(MemberInterestGoodsSO so);
	
	
	/**
	 *
	 * <pre>
	 * - 프로젝트명	: 11.business
	 * - 파일명		: MemberService.java
	 * - 작성일		: 2017. 07. 11.
	 * - 작성자		: wyjeong
	 * - 설명		: 회원 찜 상품 여부
	 * </pre>
	 * @param so
	 * @return
	 */
	public List<MemberInterestGoodsVO> checkMemberInterestGoods(MemberInterestGoodsSO so);
	/**
	 *
	 * <pre>
	 * - 프로젝트명	: 11.business
	 * - 파일명		: MemberService.java
	 * - 작성일		: 2021. 02. 25.
	 * - 작성자		: yjs01
	 * - 설명		: 회원관심상품 단건 조회
	 * </pre>
	 * @param so
	 * @return
	 */
	public MemberInterestGoodsVO getMemberInterestGoods(String goodsId);
}