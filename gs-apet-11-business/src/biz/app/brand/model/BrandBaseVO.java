package biz.app.brand.model;

import java.util.ArrayList;
import java.util.List;
import org.apache.commons.collections.CollectionUtils;
import org.apache.commons.lang.StringUtils;

import biz.app.st.model.StStdInfoVO;
import framework.common.model.BaseSysVO;
import lombok.Data;
import lombok.EqualsAndHashCode;

@Data
@EqualsAndHashCode(callSuper=false)
public class BrandBaseVO extends BaseSysVO {

	/** UID */
	private static final long serialVersionUID = 1L;

	/** 브랜드 번호 */
	private Integer bndNo;

	/** 브랜드 유형 구분 */
	private String bndTpCd;

	/** 대표 브랜드 번호 */
	private Integer dlgtBndNo;

	/** 브랜드 명 국문 */
	private String bndNmKo;

	/** 브랜드 구분 코드 */
	private String bndGbCd;

	/** 사용 여부 */
	private String useYn;

	/** 브랜드 명 영문 */
	private String bndNmEn;

	/** 정렬 순서 */
	private Long sortSeq;

	/** 국문 초성 코드 */
	private String koInitCharCd;

	/** 영문 초성 코드 */
	private String enInitCharCd;

	/** 브랜드 소개 */
	private String bndItrdc;

	/** 브랜드 소개 이미지 */
	private String bndItrdcImgPath;

	/** 노출 상태 */
	private String bndShowYn;

	/** 대표 브랜드 명 국문 */
	private String dlgtBndNmKo;

	/** 대표 브랜드 명 영문 */
	private String dlgtBndNmEn;

	//---------추가---------//

	/** 카테고리 아이콘 */
	private String cateIcon;
	
	/** 공급업체 정보 */
	//private List<CompanyBaseVO> compList;

	/** 사이트 정보 */
	private List<StStdInfoVO> stStdList;

	/** 업체 번호 */
	private Long compNo;

	/** 업체 명 */
	private String compNm;

	/** 업체 상태 */
	private String compStatCd;

	/** 브랜드 모바일 소개 */
	private String bndMoItrdc;

	/** 브랜드 모바일 소개 이미지 */
	private String bndItrdcMoImgPath;

	/** 브랜드 콘텐츠 유형 */
	private String bndCntsTpCd;

	/** 브랜드 신규상품 */
	private String[] arrNewGoodsId;
	/** 브랜드 베스트상품 */
	private String[] arrBestGoodsId;

	/** 브랜드 스토리 */
	private String bndStry;

	/** 썸네일 이미지 */
	private String tnImgPath;

	/** 썸네일 모바일 이미지 */
	private String tnMoImgPath;

	/** WISH 여부 */
	private String interestYn;

	/** 쿠폰번호 */
	private Long cpNo;

	/** 노출 브랜드 명 */
	private String bndNm;

	/** 사이트 아이디 전체 */
	public String getStIds() {
		if (hasManySite()) {
			List<String> stIds = new ArrayList<String>();
			for(StStdInfoVO st : this.stStdList) {
				stIds.add(st.getStId().toString());
			}

			return StringUtils.join(stIds.iterator(), "|");
		} else {
			return getFirstStId();
		}
	}

	/** 사이트 명 전체 */
	public String getStNms() {
		if (hasManySite()) {
			List<String> stNms = new ArrayList<String>();
			for(StStdInfoVO st : this.stStdList) {
				stNms.add(st.getStNm());
			}

			return StringUtils.join(stNms.iterator(), " | ");
		} else {
			return getFirstStNm();
		}
	}

	private boolean hasManySite() {

		return CollectionUtils.isNotEmpty(this.stStdList) && CollectionUtils.size(this.stStdList) > 1 ? true : false;
	}

	private String getFirstStId() {
		if (CollectionUtils.isEmpty(this.stStdList) || CollectionUtils.sizeIsEmpty(this.stStdList)) {
			return StringUtils.EMPTY;
		}

		return this.stStdList.get(0).getStId().toString();
	}

	private String getFirstStNm() {
		if (CollectionUtils.isEmpty(this.stStdList) || CollectionUtils.sizeIsEmpty(this.stStdList)) {
			return StringUtils.EMPTY;
		}

		return this.stStdList.get(0).getStNm();
	}
	
	/** 브랜드 상품 카운트 */
	private Long bndGoodsCnt;
	
	/** 브랜드 찜 카운트 */
	private Long mbBrandCnt;
	
	/** 정렬순서 */
	private Long sort;
	
	/** 브랜드필터 */
	private Long goodsCnt;
	private Long dispPriorRank;
	private Long saleQty;
	private Long saleAmt;
	private String bndKoNm;
	private Long bndCnt;

}