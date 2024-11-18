package biz.app.goods.util;

import java.io.IOException;
import java.lang.reflect.Array;

import org.apache.commons.io.FilenameUtils;

import lombok.extern.slf4j.Slf4j;

/**
* <pre>
* - 프로젝트명	: 11.business
* - 패키지명		: biz.app.goods.util
* - 파일명		: GoodsUtil.java
* - 작성일		: 2017. 6. 9.
* - 작성자		: Administrator
* - 설명			: 상품 관련 Util
* </pre>
*/
@Slf4j
public class GoodsUtil {

	/**
	* <pre>
	* - 프로젝트명	: 11.business
	* - 파일명		: GoodsUtil.java
	* - 작성일		: 2017. 6. 9.
	* - 작성자		: Administrator
	* - 설명		 	: 상품 이미지 URL 생성
	* </pre>
	* @param imgDomain		bizConfig의 image.domain 값을 설정
	* @param imgPath			상품이미지 테이블의 이미지 경로
	* @param goodsId			상품아이디
	* @param seq				상품이미지 테이블의 이미지 순번
	* @param width			상품이미지 사이즈
	* @param height			상품이미지 사이즈
	* @return
	* @throws IOException
	*/
	public static String getGoodsImageSrc(String imgDomain, String imgPath, String goodsId, Integer imgSeq, String[] size)  {
		
		String ext = FilenameUtils.getExtension(imgPath);
		
		return "http://" + imgDomain + "/goods/" + goodsId + "/" + goodsId + "_" + imgSeq + "_" + size[0] + "x" + size[1] + "." + ext;
	}

	/**
	 * <pre>
	 * - 프로젝트명	: 11.business
	 * - 파일명		: GoodsUtil.java
	 * - 작성일		: 2021. 1. 5.
	 * - 작성자		: Administrator
	 * - 설명		: Object null check
	 * </pre>
	 * @param obj
	 * @return flag
	 */
	public static boolean isEmpty(Object obj) {
		boolean flag = false;
		if(obj == null) {
			flag = true;
		} else if(obj instanceof Object[]) {
			flag = obj == null || Array.getLength(obj) == 0;
		}

		return flag;
	}

	/**
	 * <pre>
	 * - 프로젝트명	: 11.business
	 * - 파일명		: GoodsUtil.java
	 * - 작성일		: 2021. 1. 5.
	 * - 작성자		: Administrator
	 * - 설명		: Object not null check
	 * </pre>
	 * @param obj
	 * @return flag
	 */
	public static boolean isNotEmpty(Object obj) {
		return !isEmpty(obj);
	}
}
