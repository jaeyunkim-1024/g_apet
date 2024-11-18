package framework.common.model;

import java.io.Serializable;

import lombok.Data;

/**
 * File Download VO
 * 
 * @author valueFactory
 * @since 2013. 09. 25.
 */
@Data
public class FileVO implements Serializable {

	private static final long serialVersionUID = 1L;

	/** 파일 이름 */
	private String	fileName;

	/** 파일 경로 */
	private String	filePath;

	/** 파일 크기 */
	private Long	fileSize;

	/** 파일 타입 */
	private String	fileType;

	/** 파일 확장자 */
	private String	fileExe;
}