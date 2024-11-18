package framework.common.util.image;

import java.awt.Graphics2D;
import java.awt.image.BufferedImage;
import java.io.File;
import java.io.IOException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Properties;

import javax.imageio.ImageIO;

import org.apache.commons.io.FileUtils;
import org.apache.commons.io.FilenameUtils;
import org.imgscalr.Scalr;

import framework.common.constants.CommonConstants;
import framework.common.util.FtpImgUtil;
import lombok.extern.slf4j.Slf4j;
import net.coobird.thumbnailator.Thumbnails;
import net.coobird.thumbnailator.geometry.Positions;

@Slf4j
public class ImageResizer {

	/** 원본 이미지 객체 */
	private final BufferedImage originalImage;
	/** 원본 이미지 path */
	private final String orgImgPath;
	/** image type enum */
	private final ImageType imageType;

	private Properties bizConfig;

	/**
	 * constructor
	 * 
	 * @throws IOException
	 */
	public ImageResizer(ImageInfoData data) throws IOException {
		orgImgPath = data.getOrgImgPath();
		imageType = data.getImageType();
		originalImage = ImageIO.read(new File(orgImgPath));
	}

	/**
	 * constructor
	 * 
	 * @throws IOException
	 */
	public ImageResizer(ImageInfoData data, Properties bizConfig) throws IOException {
		orgImgPath = data.getOrgImgPath();
		imageType = data.getImageType();
		originalImage = ImageIO.read(new File(orgImgPath));
		this.bizConfig = bizConfig;
	}

	/**
	 * <pre>process 이미지 resize process</pre>
	 * 
	 * @param data
	 * @throws IOException
	 */
	public void process() throws IOException  {
		int type = getImgType();
		// String imgFormat = imageType.imgFormat();
		String imgFormat = FilenameUtils.getExtension(orgImgPath);

		List<String[]> imgSizeList = imageType.imageSizeList();

		for (String[] size : imgSizeList) {
			// 가로, 세로 사이즈 추출
			Map<String, Integer> sizeMap = getSize(size);
			int width = sizeMap.get("width");
			int height = sizeMap.get("height");

			// 이미지 리사이즈
			// BufferedImage resizeImage = resizeImageHighQuality (type, width, height);
			BufferedImage resizeImage = resizeImageThumbnailator(type, width, height);

			// 이미지 파일 생성
			String destResizeImgFilePath = makeDestImgFilePath(size);
			File destFile = new File(destResizeImgFilePath);
			ImageIO.write(resizeImage, imgFormat, destFile);
		}
	}

	public void ftpProcess() throws IOException  {
		int type = getImgType();
		// String imgFormat = imageType.imgFormat();
		String imgFormat = FilenameUtils.getExtension(orgImgPath);

		List<String[]> imgSizeList = imageType.imageSizeList();

		FtpImgUtil ftpImgUtil;
		if (bizConfig != null) {
			ftpImgUtil = new FtpImgUtil(bizConfig);
		} else {
			ftpImgUtil = new FtpImgUtil();
		}
		for (String[] size : imgSizeList) {
			// 가로, 세로 사이즈 추출
			Map<String, Integer> sizeMap = getSize(size);
			int width = sizeMap.get("width");
			int height = sizeMap.get("height");

			// 이미지 리사이즈
			BufferedImage resizeImage = resizeImageHighQuality(type, width, height);
			// 이미지 파일 생성
			String destResizeImgFilePath = makeDestImgFilePath(size);
			File destFile = new File(destResizeImgFilePath);
			if(!destFile.getParentFile().exists()) {
				FileUtils.forceMkdir(destFile.getParentFile());
			}
			ImageIO.write(resizeImage, imgFormat, destFile);

			// FTP 전송
			ftpImgUtil.goodsImgUpload(destResizeImgFilePath);

			if(!destFile.delete()){
				log.error(CommonConstants.LOG_EXCEPTION_DELETE_FILE);
			}
		}
	}

	/**
	 * <pre>resizeImage 이미지 리사이즈 빠른 속도로 이미지 크기 변환을 처리하지만 새롭게 생성된 이미지의 품질이 떨어진다.</pre>
	 * 
	 * @param type
	 * @param width
	 * @param height
	 * @return
	 * @throws InterruptedException
	 * @deprecated (..)
	 */
	@Deprecated
	@SuppressWarnings("unused")
	private BufferedImage resizeImage(int type, int width, int height) {
		BufferedImage destImg = new BufferedImage(width, height, type);
		Graphics2D graphics2d = destImg.createGraphics();
		graphics2d.drawImage(originalImage, 0, 0, width, height, null);
		graphics2d.dispose();

		return destImg;
	}

	/**
	 * <pre>
	 * resizeImageHighQuality 이미지 리사이즈 (원본 품질 유지)
	 * getScaledInstance 함수를 통해 이미지 크기 변환을 하면 변환된 이미지의 품질이 떨어지지 않는다.
	 * Image.SCALE_SMOOTH를 이용하면 새롭게 생성된 이미지의 품질이 떨어지지 않게 된다.
	 * </pre>
	 * 
	 * @param type
	 * @param width
	 * @param height
	 * @return
	 * @throws Exception
	 */
	private BufferedImage resizeImageHighQuality(int type, int width, int height)  {

		BufferedImage resizedImage = null;

		/***************************************
		 * 넓이 비율 기준으로 리사이징(세로 가변)
		 ***************************************/
		// int imgwidth = originalImage.getWidth();
		// int imgheight = originalImage.getHeight();
		//
		// double rate = (double)width/(double)imgwidth;
		//
		// height = (int)(imgheight * rate);
		//
		// resizedImage = Scalr.resize(originalImage, Scalr.Method.ULTRA_QUALITY,
		// Scalr.Mode.AUTOMATIC, width, height, null);

		/******************************
		 * 가로 세로 지정된 사이즈로 자른 후 리사이징
		 ******************************/
		int imgwidth = Math.min(originalImage.getHeight(), originalImage.getWidth());
		int imgheight = imgwidth;

		BufferedImage scaledImage = Scalr.crop(originalImage, (originalImage.getWidth() - imgwidth) / 2,
				(originalImage.getHeight() - imgheight) / 2, imgwidth, imgheight, null);
		resizedImage = Scalr.resize(scaledImage, width, height, null);

		return resizedImage;
	}

	/**
	 * <pre>getSize 가로, 세로 데이터 추출</pre>
	 * 
	 * @param size
	 * @return
	 */
	private Map<String, Integer> getSize(String[] size) {
		Map<String, Integer> sizeMap = new HashMap<>();

		String widthStr = size[0];
		String heightStr = size[1];
		int width = Integer.parseInt(widthStr);
		int height = Integer.parseInt(heightStr);

		sizeMap.put("width", width);
		sizeMap.put("height", height);

		return sizeMap;
	}

	/**
	 * <pre>
	 * getImgType BufferedImage.TYPE_INT_RGB 이면, 배경색이 검정 BufferedImage.TYPE_INT_ARGB이면, 배경색이 투명
	 * </pre>
	 * 
	 * @return
	 */
	private int getImgType() {
		int imtType = 0;
		int originalImgType = originalImage.getType(); // 원본 이미지 type
		if (originalImgType == 0) {
			imtType = BufferedImage.TYPE_INT_ARGB;
		} else {
			imtType = originalImgType;
		}
		return imtType;
	}

	/**
	 * <pre>getDestImgFilePath resize 이미지 path 생성</pre>
	 * 
	 * @param orgImgPath
	 * @param imgFormat
	 * @param size
	 */
	private String makeDestImgFilePath(String[] size) {
		// String imgFormat = imageType.imgFormat();
		String imgFormat = FilenameUtils.getExtension(orgImgPath);

		int idx = orgImgPath.lastIndexOf('.');
		String destFilePrefix = orgImgPath.substring(0, idx);

		StringBuilder destFilePathBuf = new StringBuilder();
		destFilePathBuf.append(destFilePrefix);
		destFilePathBuf.append("_");
		destFilePathBuf.append(size[0] + "x" + size[1]);
		destFilePathBuf.append(".");
		destFilePathBuf.append(imgFormat);

		return destFilePathBuf.toString();
	}

	/**
	 * Thumbnailator
	 * 
	 * @param type
	 * @param width
	 * @param height
	 * @return
	 * @throws IOException 
	 * @throws Exception
	 */
	private BufferedImage resizeImageThumbnailator(int type, int width, int height) throws IOException {

		BufferedImage resizedImage = null;

		int imgwidth = Math.min(originalImage.getHeight(), originalImage.getWidth());
		int imgheight = imgwidth;

		BufferedImage scaledImage = Thumbnails.of(originalImage).crop(Positions.CENTER).size(imgwidth, imgheight).asBufferedImage();
		resizedImage = Thumbnails.of(scaledImage).size(width, height).asBufferedImage();

		return resizedImage;
	}
}
