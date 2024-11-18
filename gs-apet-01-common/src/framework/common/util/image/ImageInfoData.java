package framework.common.util.image;

import lombok.Data;

@Data
public class ImageInfoData {

	/** 원본 이미지 */
	private String		orgImgPath;
	/** 이미지 타입 */
	private ImageType	imageType;

}
