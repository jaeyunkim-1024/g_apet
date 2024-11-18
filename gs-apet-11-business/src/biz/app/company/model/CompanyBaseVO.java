package biz.app.company.model;

import java.util.ArrayList;
import java.util.List;

import org.apache.commons.collections.CollectionUtils;
import org.apache.commons.lang.StringUtils;

import biz.app.order.model.OrderDeliveryVO;
import biz.app.st.model.StStdInfoVO;
import framework.admin.constants.AdminConstants;
import framework.common.model.BaseSysVO;
import lombok.Data;
import lombok.EqualsAndHashCode;

@Data
@EqualsAndHashCode(callSuper=false)
public class CompanyBaseVO extends BaseSysVO {

	/** UID */
	private static final long serialVersionUID = 1L;

	/** 업체 번호 */
	private Long compNo;

	/** 상위 업체 번호 */
	private Long upCompNo;

	/** 상위 업체명 */
	private String upCompNm;

	/** 업체 명 */
	private String compNm;
	private String compNm2;

	/** 사업자 번호 */
	private String bizNo;

	/** 업체 상태 코드 */
	private String compStatCd;

	/** 대표자 명 */
	private String ceoNm;

	/** 업태 */
	private String bizCdts;

	/** 종목 */
	private String bizTp;

	/** 업체 구분 코드 */
	private String compGbCd;

	/** 업체 유형 코드 */
	private String compTpCd;

	/** 팩스 */
	private String fax;

	/** 전화 */
	private String tel;

	/** 우편 번호 구 */
	private String postNoOld;

	/** 우편 번호 신 */
	private String postNoNew;

	/** 도로 주소 */
	private String roadAddr;

	/** 도로 상세 주소 */
	private String roadDtlAddr;

	/** 지번 주소 */
	private String prclAddr;

	/** 지번 상세 주소 */
	private String prclDtlAddr;


	/** 담당 MD 사용자번호 */
	private Long mdUsrNo;

	/** 담당 MD 명  */
	private String mdUsrNm;

	/** 업체 CS 담당 사용자 명  */
	private String csChrgNm;

	/** 업체 CS 담당 사용자 전화번호 */
	private String csChrgTel;

	/** 업체 정산 담당 사용자 명  */
	private String stlChrgNm;

	/** 업체 정산 담당 사용자 전화번호 */
	private String stlChrgTel;

	/** 은행 코드 */
	private String bankCd;

	/** 계좌 번호 */
	private String acctNo;

	/** 예금주 명 */
	private String ooaNm;

	/** 비고 */
	private String bigo;

	/** 대표이메일 */
	private String dlgtEmail;

	/** 사이트 정보 */
	private List<StStdInfoVO> stStdList;

	/** 업체 레벨 */
	private Long cpLevel;

	/** 쿠폰번호 */
	private Long cpNo;

	/** 브랜드 한글, 업체검색 팝업에서 브랜드 이름으로 검색할 때만 사용함. */
	private String bndNmKo;

	/** 브랜드 영어, 업체검색 팝업에서 브랜드 이름으로 검색할 때만 사용함. */
	private String bndNmEn;

	/** 업체 정산 주기 */
	private String cclTermCd;

	/** API KEY **/
	private String apiKey;
	/** IP 일련 번호 */
	private Long ipSeq;
	/** 업체 번호 */
	private String pmtIp;

	
	/** CIS 등록 여부 */
	private String cisRegYn;
	
	private String cisRegNo;
	
	/** 사업자 등록증 이미지 패스 */
	private String bizLicImgPath;
	
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

	/** 편집가능 여부 */
	public boolean isEditable() {
		boolean editable = false;

		if (StringUtils.isEmpty(this.compStatCd) || StringUtils.equals(this.compStatCd, AdminConstants.COMP_STAT_10)) {
			editable = true;
		}

		return editable;
	}

	/** 입고리드타임 */
	private String incmReadTm;		
	
	/** 주문 수집 문자 알림 코드 */
	private String ordCletCharAlmCd;
	
}