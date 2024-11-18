package biz.app.system.service;

import java.util.List;

import biz.app.system.model.ChnlStdInfoPO;
import biz.app.system.model.ChnlStdInfoSO;
import biz.app.system.model.ChnlStdInfoVO;

/**
 * get업무명		:	단권
 * list업무명	:	리스트
 * page업무명	:	리스트 페이징
 * insert업무명	:	입력
 * update업무명	:	수정
 * delete업무명	:	삭제
 * save업무명	:	입력 / 수정
 */
public interface ChnlStdInfoService {

	/**
	 * <pre>
	 * - 프로젝트명	: 11.business
	 * - 파일명		: ChnlStdInfoService.java
	 * - 작성일		: 2017. 2. 22.
	 * - 작성자		: hongjun
	 * - 설명		: 채널 기준 정보 페이징
	 * </pre>
	 * @param so
	 * @return
	 */
	public List<ChnlStdInfoVO> pageChnlStdInfo(ChnlStdInfoSO so);

	/**
	 * <pre>
	 * - 프로젝트명	: 11.business
	 * - 파일명		: ChnlStdInfoService.java
	 * - 작성일		: 2017. 2. 22.
	 * - 작성자		: hongjun
	 * - 설명		: 채널 기준 정보 등록
	 * </pre>
	 * @param po
	 */
	public void insertChnlStdInfo(ChnlStdInfoPO po);

	/**
	 * <pre>
	 * - 프로젝트명	: 11.business
	 * - 파일명		: ChnlStdInfoService.java
	 * - 작성일		: 2017. 2. 22.
	 * - 작성자		: hongjun
	 * - 설명		: 채널 기준 정보 수정
	 * </pre>
	 * @param po
	 */
	public void updateChnlStdInfo(ChnlStdInfoPO po);

	/**
	 * <pre>
	 * - 프로젝트명	: 11.business
	 * - 파일명		: ChnlStdInfoService.java
	 * - 작성일		: 2017. 2. 22.
	 * - 작성자		: hongjun
	 * - 설명		: 채널 기준 정보 삭제
	 * </pre>
	 * @param po
	 */
	public void deleteChnlStdInfo(ChnlStdInfoPO po);
}