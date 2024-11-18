package biz.app.contents.model;

import java.sql.Timestamp;
import java.util.List;

import biz.app.goods.model.GoodsListVO;
import framework.common.model.BaseSearchVO;
import lombok.Data;
import lombok.EqualsAndHashCode;

@Data
@EqualsAndHashCode(callSuper=false)
public class VodSO extends BaseSearchVO<VodSO> {

	/** UID */
	private static final long serialVersionUID = 1L;

	/** 영상 ID */
	private String vdId;

	/** 영상 IDs */
	private String[] vdIds;

	/** 영상 구분 코드 */
	private String vdGbCd;

	/** 타입 코드 */
	private String tpCd;

	/** 등록일 시작 일시 : Start */
	private Timestamp dtmStart;
	
	/** 등록일 종료 일시 : End */
	private Timestamp dtmEnd;
	
	/** 영상 타입 코드 */
	private String vdTpCd;
	
	/** 컨텐츠 상태 코드 */
	private String contsStatCd;
	
	/** 제목 */
	private String ttl;
	
	/** 펫 구분 코드 */
	private String petGbCd;
	
	/** 펫 구분 코드 Param */
	private String pgCd;
	
	/** 시리즈 여부 */
	private String srisYn;
	
	/** 전시 여부 */
	private String dispYn;
	
	/** 난이도 코드 */
	private String lodCd;

	/** 준비물 코드 */
	private String prpmCd;
	
	/** 멤버 번호 */
	private Long mbrNo;
	
	/** 교육용 컨텐츠 카테고리_M_코드 */
	private String eudContsCtgMCd;
	
	/** 교육용 컨텐츠 카테고리_S_코드 */
	private String eudContsCtgSCd;
	
	/* 시스템 등록 일시 : Start */
	private Timestamp sysRegDtmStart;
	
	/* 시스템 등록 일시 : End */
	private Timestamp sysRegDtmEnd;
	
	/** 스텝 갯수 */
	private Long totStepCnt;
	
	/** 시리즈 번호 */
	private Long srisNo;

	/** 시즌 번호 */
	private Long sesnNo;
	
	/** 정렬순서 */
	private Long sortCd;
	
	/** 전시 코너번호 */
	private Long dispCornNo;
	
	/** 영상리스트 여부 */
	private String commonYn;
	
	/** 공유건수 부터 */
	private Long shareFrom;

	/** 공유건수 까지 */
	private Long shareTo;
	
	/** 좋아요 건수 부터 */
	private Long likeFrom;
	
	/** 좋아요 건수 까지 */
	private Long likeTo;
	
	/** 중복 영상 제거*/
	private List<String> vodList;
	
	/** total 중복 영상 제거*/
	private List<String> dupleVdIds;

	/** 엑셀다운로드 모드 */
	private String excelMode;
}