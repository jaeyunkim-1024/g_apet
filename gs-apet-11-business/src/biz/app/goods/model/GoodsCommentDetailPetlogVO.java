package biz.app.goods.model;

import framework.common.model.BaseSysVO;
import lombok.Data;
import lombok.EqualsAndHashCode;

@Data
@EqualsAndHashCode(callSuper=false)
public class GoodsCommentDetailPetlogVO extends BaseSysVO {

	/** UID */
	private static final long serialVersionUID = 1L;

	/* 펫 번호 */
	private String petNo;
	/* 펫 번호 */
	private long goodsEstmNo;
	/* 회원 번호 */
	private String mbrNo;
	/* 회원 아이디 */
	private String estmId;
	/* 회원 아이디 */
	private String petlogEstmId;
	/* 이미지 경로 */
	private String imgPath;
	/* 펫 구분 코드 */
	private String petGbCd;
	/* 종류 코드 */
	private String petKindNm;
	/* 펫 이름 */
	private String petNm;
	/* 펫 성별 구분 코드 */
	private String petGdGbCd;
	/* 펫 나이 */
	private String age;
	/* 개월 */
	private String month;
	/* 펫 출생일 */
	private String birth;
	/* weight(소형,중형,대형)*/
	private String weight;
	/* 네이버 펫 key */
	private String naverPetKey;
	/* 펫 대표 여부 */
	private String dlgtYn;
	/* 알러지 여부 */
	private String allergyYn;
	/* 중성화 여부 */
	private String fixingYn;
	/* 염려 질환 여부 */
	private String wryDaYn;
	/* 펫로그 이미지1 */
	private String imgPath1;
	/* 펫로그 이미지2 */
	private String imgPath2;
	/* 펫로그 이미지3 */
	private String imgPath3;
	/* 펫로그 이미지4 */
	private String imgPath4;
	/* 펫로그 이미지5 */
	private String imgPath5;
	/* 펫로그 영상 */
	private String vdPath;
}