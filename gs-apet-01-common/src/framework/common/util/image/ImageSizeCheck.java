package framework.common.util.image;

import java.awt.image.BufferedImage;
import java.io.File;
import java.io.FileInputStream;

import javax.imageio.ImageIO;

import lombok.extern.slf4j.Slf4j;

@Slf4j
public class ImageSizeCheck implements ImageValid {

	@Override
	public boolean valid(ImageInfoData data) throws Exception {
		String orgImgPath = data.getOrgImgPath();
		//보안 진단. 부적절한 자원 해제 (IO)
		File orgImgFile = new File(orgImgPath);
		FileInputStream fis = null;
		try {
			fis = new FileInputStream(orgImgFile);
			BufferedImage originalImage = ImageIO.read(fis);
			
			if(originalImage==null) {
				log.info("1>>> orgImgFile "+orgImgPath+" exists? ==> " + orgImgFile.exists());
				log.info("2>>> orgImgFile "+orgImgPath+" readable? ==> " + orgImgFile.canRead());
				log.info("3>>> originalImage is null? ==> " + (originalImage==null));
				log.info("4>>> NPE!!");
			}
			int originWidth = originalImage != null ? originalImage.getWidth() : 0;
			int originHeight = originalImage != null ? originalImage.getHeight() : 0;

			// validation width, height 정보
			int validWidth = ImageType.GOODS_IMAGE.validWidthSize();
			int validHeight = ImageType.GOODS_IMAGE.validHeightSize();

			// validation check
			if (originWidth == validWidth && originHeight == validHeight) {
				return true;
			}

			log.debug("##valid## (image size check failed) originWidth=" + originWidth + ", originHeight=" + originHeight
					+ ", validWidth=" + validWidth + ", validHeight=" + validHeight + ", orgImgPath=" + orgImgPath);
			
			return false;
		} finally {
			if(fis != null) {
				fis.close();
			}
		}
		

	}

}
