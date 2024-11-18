package framework.common.util.image;

import java.util.ArrayList;
import java.util.List;
import java.util.Properties;

import framework.common.constants.CommonConstants;
import lombok.extern.slf4j.Slf4j;

@Slf4j
public class ImageHandler {
	/** validation check list */
	private final List<ImageValid> validCheckList;

	private Properties bizConfig;

	/**
	 * constructor
	 */
	public ImageHandler() {
		validCheckList = new ArrayList<>();
		validCheckList.add(new ImageSizeCheck());
	}

	public ImageHandler(Properties bizConfig) {
		validCheckList = new ArrayList<>();
		validCheckList.add(new ImageSizeCheck());
		this.bizConfig = bizConfig;
	}

	/**
	 * <pre>job 이미지 resize handle</pre>
	 * 
	 * @param data
	 * @return
	 */
	public boolean job(ImageInfoData data) {
		boolean isSuccess = false;
		try {
			for (ImageValid imageValid : validCheckList) {
				isSuccess = imageValid.valid(data);

				log.debug("########## imageValid : " + isSuccess);

				// validation check 실패의 경우
				if (!isSuccess) {
					return false;
				}
			}

			// 이미지 resize
			ImageResizer resizer = new ImageResizer(data);
			resizer.process();

		} catch (Exception ex) {
			log.info("##job## (exception failed) data=" + data);
			log.error(CommonConstants.LOG_EXCEPTION_STACK_TRACE, ex);

			isSuccess = false;
		}

		return isSuccess;
	}

	public boolean ftpJob(ImageInfoData data) {
		boolean isSuccess = false;
		try {
			for (ImageValid imageValid : validCheckList) {
				isSuccess = imageValid.valid(data);

				log.debug("########## imageValid : " + isSuccess);

				// validation check 실패의 경우
				// if (isSuccess == false) {
				// return false;
				// }
			}

			// 이미지 resize
			ImageResizer resizer = new ImageResizer(data);
			if (bizConfig != null) {
				resizer = new ImageResizer(data, bizConfig);
			}
			resizer.ftpProcess();

		} catch (Exception ex) {
			log.info("##ftpJob## (exception failed) data=" + data);
			log.error(CommonConstants.LOG_EXCEPTION_STACK_TRACE, ex);

			isSuccess = false;
		}

		return isSuccess;
	}
}
