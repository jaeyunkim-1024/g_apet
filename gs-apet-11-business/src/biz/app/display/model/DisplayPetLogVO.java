package biz.app.display.model;

import biz.app.petlog.model.PetLogBaseListVO;
import lombok.Data;
import lombok.EqualsAndHashCode;

/**
 * <pre>
 * - 프로젝트명 : workspace
 * - 패키지명   : biz.app.display.model
 * - 파일명     : DisplayPetLogVO.java
 * - 작성일     : 2021. 02. 23.
 * - 작성자     : lhj01
 * - 설명       :
 * </pre>
 */

@Data
@EqualsAndHashCode(callSuper=false)
public class DisplayPetLogVO extends PetLogBaseListVO{

	private int dispPriorRank;
	
	/** 전시 분류 코너 번호 */
	private Long dispClsfCornNo;
	
	/** 펫로그 썸네일 경로 */
	private String vdThumPath;
}
