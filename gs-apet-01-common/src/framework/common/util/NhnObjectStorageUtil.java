package framework.common.util;

import java.io.BufferedReader;
import java.io.File;
import java.io.IOException;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.io.OutputStream;
import java.net.HttpURLConnection;
import java.net.URL;
import java.net.URLEncoder;
import java.sql.Timestamp;
import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.Iterator;
import java.util.List;
import java.util.Map;
import java.util.Optional;
import java.util.Properties;
import java.util.UUID;
import java.util.stream.Collectors;

import javax.annotation.PostConstruct;
import javax.crypto.Mac;
import javax.crypto.spec.SecretKeySpec;
import javax.servlet.http.HttpServlet;

import org.apache.commons.io.FilenameUtils;
import org.apache.commons.lang3.StringUtils;
import org.apache.commons.net.util.Base64;
import org.json.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import org.springframework.util.FileCopyUtils;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import com.amazonaws.SdkClientException;
import com.amazonaws.auth.AWSStaticCredentialsProvider;
import com.amazonaws.auth.BasicAWSCredentials;
import com.amazonaws.client.builder.AwsClientBuilder;
import com.amazonaws.services.s3.AmazonS3;
import com.amazonaws.services.s3.AmazonS3ClientBuilder;
import com.amazonaws.services.s3.model.AccessControlList;
import com.amazonaws.services.s3.model.AmazonS3Exception;
import com.amazonaws.services.s3.model.Bucket;
import com.amazonaws.services.s3.model.GetObjectRequest;
import com.amazonaws.services.s3.model.GroupGrantee;
import com.amazonaws.services.s3.model.ListObjectsRequest;
import com.amazonaws.services.s3.model.ObjectListing;
import com.amazonaws.services.s3.model.ObjectMetadata;
import com.amazonaws.services.s3.model.Permission;
import com.amazonaws.services.s3.model.PutObjectResult;
import com.amazonaws.services.s3.model.S3Object;
import com.amazonaws.services.s3.model.S3ObjectInputStream;
import com.amazonaws.services.s3.model.S3ObjectSummary;

import framework.admin.constants.AdminConstants;
import framework.admin.util.AdminSessionUtil;
import framework.common.constants.CommonConstants;
import framework.common.constants.ExceptionConstants;
import framework.common.exception.CustomException;
import framework.common.model.FileVO;
import framework.common.model.FileViewParam;
import framework.common.model.PurgeParam;
import framework.front.model.Session;
import framework.front.util.FrontSessionUtil;
import lombok.extern.slf4j.Slf4j;

/**
 * <pre>
 * - 프로젝트명	: 01.common
 * - 패키지명		: framework.common.util
 * - 파일명		: NhnObjectStorageUtil.java
 * - 작성일		: 2021. 1. 27. 
 * - 작성자		: VALFAC
 * - 설 명			: NhnObjectStorageUtil Util
 * </pre>
 */
@Component
@Slf4j
public class NhnObjectStorageUtil extends HttpServlet {

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;

	@Autowired
	private Properties bizConfig;
	@Autowired
	private Properties webConfig;

	private String endPoint;
	private String regionName;
	private String accessKey;
	private String secretKey;
	private AmazonS3 s3;
	private String bucketName;

	@PostConstruct
	public void init() {
		if (StringUtils.equals(bizConfig.getProperty("envmt.gb"), CommonConstants.ENVIRONMENT_GB_LOCAL)) {
			this.endPoint = bizConfig.getProperty("naver.cloud.aws.s3.endpoint");
			this.regionName = bizConfig.getProperty("naver.cloud.aws.s3.region");
			this.accessKey = bizConfig.getProperty("naver.cloud.aws.s3.access");
			this.secretKey = bizConfig.getProperty("naver.cloud.aws.s3.secret");
			this.s3 = AmazonS3ClientBuilder.standard()
					.withEndpointConfiguration(new AwsClientBuilder.EndpointConfiguration(endPoint, regionName))
					.withCredentials(new AWSStaticCredentialsProvider(new BasicAWSCredentials(accessKey, secretKey)))
					.build();
			
			this.bucketName = bizConfig.getProperty("naver.cloud.aws.s3.bucket");
			
			try {
				// create bucket if the bucket name does not exist
				if (!s3.doesBucketExistV2(bucketName)) {
					log.info("Bucket %s has been created.\n", bucketName);
					//s3.createBucket(bucketName);
				}
			} catch (AmazonS3Exception e) {
				log.error(CommonConstants.LOG_EXCEPTION_STACK_TRACE, e);
			} catch(SdkClientException e) {
				log.error(CommonConstants.LOG_EXCEPTION_STACK_TRACE, e);
			}
		}
	}
	
	public List<Bucket> getBucketList(){
		List<Bucket> buckets = new ArrayList<Bucket>();
		try {
			buckets = s3.listBuckets();
//		    for (Bucket bucket : buckets) {
//		    }
		} catch (AmazonS3Exception e) {
			log.error(CommonConstants.LOG_EXCEPTION_STACK_TRACE, e);
			buckets = null;
		} catch(SdkClientException e) {
			log.error(CommonConstants.LOG_EXCEPTION_STACK_TRACE, e);
			buckets = null;
		}
		return buckets;
	}
	public List<S3ObjectSummary> getObjectList() {
		// list all in the bucket
		ObjectListing objectListing = null;
		try {
		    ListObjectsRequest listObjectsRequest = new ListObjectsRequest()
		        .withBucketName(bucketName)
		        .withMaxKeys(300);
		    
		    objectListing = s3.listObjects(listObjectsRequest);

//		    while (true) {
//		        for (S3ObjectSummary objectSummary : objectListing.getObjectSummaries()) {
//		        }
//
//		        if (objectListing.isTruncated()) {
//		            objectListing = s3.listNextBatchOfObjects(objectListing);
//		        } else {
//		            break;
//		        }
//		    }
		} catch (AmazonS3Exception e) {
			//J2EE System.exit() 사용 - 보안성 진단 처리
			//System.exit(1);
			throw new CustomException(ExceptionConstants.ERROR_CODE_DEFAULT);
		}
		return objectListing.getObjectSummaries();

	}
	
	public S3Object getObject(String objectName) {
		// Get an object and print its contents.
        S3Object fullObject = s3.getObject(new GetObjectRequest(bucketName, objectName));
        
		return fullObject;

	}
	
	public List<String> getFolder() {
		
		// top level folders and files in the bucket
		List<String> result = null;
		try {
		    ListObjectsRequest listObjectsRequest = new ListObjectsRequest()
		        .withBucketName(bucketName)
		        .withDelimiter("/")
		        .withMaxKeys(300);

		    ObjectListing objectListing = s3.listObjects(listObjectsRequest);

		    result = objectListing.getCommonPrefixes();

		    
		} catch (AmazonS3Exception e) {
			log.error(CommonConstants.LOG_EXCEPTION_STACK_TRACE, e);
		} catch(SdkClientException e) {
			log.error(CommonConstants.LOG_EXCEPTION_STACK_TRACE, e);
		}
		return result;
	}
	
	public List<S3ObjectSummary> getFiles() {
		
		// top level folders and files in the bucket
		List<S3ObjectSummary> result = null;
		try {
		    ListObjectsRequest listObjectsRequest = new ListObjectsRequest()
		        .withBucketName(bucketName)
		        .withDelimiter("/")
		        .withMaxKeys(300);
		    ObjectListing objectListing = s3.listObjects(listObjectsRequest);
		    
		    result = objectListing.getObjectSummaries();
		} catch (AmazonS3Exception e) {
			log.error(CommonConstants.LOG_EXCEPTION_STACK_TRACE, e);
		} catch(SdkClientException e) {
			log.error(CommonConstants.LOG_EXCEPTION_STACK_TRACE, e);
		}
		return result;
	}

	public FileVO upload(String orgFileStr, String newFileStr) {
		FileVO vo = new FileVO();
		if(StringUtils.equals(CommonConstants.PROJECT_GB_ADMIN, webConfig.getProperty("project.gb"))) {
			if (AdminSessionUtil.getSession() == null) {
				throw new CustomException(ExceptionConstants.UPLOAD_LOGIN_REQUIRED);
			}
		} else {
			if (!StringUtils.equals(bizConfig.getProperty("envmt.gb"), CommonConstants.ENVIRONMENT_GB_LOCAL)) {
				Session session = FrontSessionUtil.getSession();
				Long mbrNo = Optional.ofNullable(session.getMbrNo()).orElseGet(()->0l);
				
				if(Long.compare(mbrNo,0L)== 0){
					throw new CustomException(ExceptionConstants.UPLOAD_LOGIN_REQUIRED);
				}
			}
		}
		String objectName = bizConfig.getProperty("naver.cloud.aws.s3.folder") + FileUtil.SEPARATOR + bizConfig.getProperty("common.storage.base.images") + newFileStr;
		try {
			File file = new File(orgFileStr);

			s3.putObject(bucketName, objectName, file);
		    vo.setFileSize(file.length());
		    vo.setFilePath(bizConfig.getProperty("naver.cloud.cdn.domain") + FileUtil.SEPARATOR + objectName);
		} catch (AmazonS3Exception e) {
		    e.printStackTrace();
		} catch(SdkClientException e) {
		    e.printStackTrace();
		}
		return vo;
		
	}
	
	public FileVO upload(MultipartHttpServletRequest mRequest, String uploadType, String filter, Double maxFileSize, String prePath) {
		FileVO result = new FileVO();
		if(StringUtils.equals(CommonConstants.PROJECT_GB_ADMIN, webConfig.getProperty("project.gb"))) {
			if (AdminSessionUtil.getSession() == null) {
				throw new CustomException(ExceptionConstants.UPLOAD_LOGIN_REQUIRED);
			}
		} else {
			if (!StringUtils.equals(bizConfig.getProperty("envmt.gb"), CommonConstants.ENVIRONMENT_GB_LOCAL)) {
				Session session = FrontSessionUtil.getSession();
				Long mbrNo = Optional.ofNullable(session.getMbrNo()).orElseGet(()->0l);
				
				if(Long.compare(mbrNo,0L)== 0){
					throw new CustomException(ExceptionConstants.UPLOAD_LOGIN_REQUIRED);
				}
			}
		}
		Iterator<String> fileIter = mRequest.getFileNames();
		while (fileIter.hasNext()) {
			MultipartFile mFile = mRequest.getFile(fileIter.next());
			String fileOrgName = mFile.getOriginalFilename();
			String exe = FilenameUtils.getExtension(fileOrgName);

			String[] fileFilter = null;
			
			if(StringUtil.isNotBlank(filter)) {
				fileFilter = filter.split("\\|");
			} else {
				if(StringUtil.isNotBlank(uploadType)) {
					if("image".equals(uploadType)) {
						fileFilter = "jpg,jpeg,png,gif,bmp".split(",");
						//이미지 업로드 시 5MB 제한
						maxFileSize = Optional.ofNullable(maxFileSize).orElse(5D);
					}
					if("file".equals(uploadType)) {
						fileFilter = "jpg,jpeg,png,gif,bmp,txt,pdf,hwp,xls,xlsx".split(",");
					}
					if("xls".equals(uploadType)) {
						fileFilter = "xls,xlsx".split(",");
					}
				}
			}

			if(fileFilter == null || fileFilter.length == 0) {
				throw new CustomException(ExceptionConstants.ERROR_CODE_DEFAULT);
			}
			/*
			 * TODO : 파일 크기 제한 정책 반영 필요.
			 * 각 파일 형식에 따라 제한 필요, xxx.x 까지 크기 표시
			 * 이미지 5MB 제한
			 * 지정 안했을 경우 20MB
			 * */
			maxFileSize = Optional.ofNullable(maxFileSize).orElse(20D);
			Long maxSize = (long)(maxFileSize * 1024 * 1024);

			Boolean checkExe = true;
			for(String ex : fileFilter){
				if(ex.equalsIgnoreCase(exe)){
					checkExe = false;
				}
			}

			if(checkExe){
				throw new CustomException(ExceptionConstants.BAD_EXE_FILE_EXCEPTION);
			}

			if(mFile.getSize() > maxSize) {
				 throw new CustomException(ExceptionConstants.BAD_SIZE_FILE_EXCEPTION, new String[] {String.format("%.1f", maxFileSize).concat("MB")}) ;
			}

			String fileName = UUID.randomUUID() + "." + exe;
			String filePath = bizConfig.getProperty("common.file.upload.base") + AdminConstants.TEMP_IMAGE_PATH + FileUtil.SEPARATOR + DateUtil.getNowDate() + FileUtil.SEPARATOR;
			
			try {
			    //s3.putObject(bucketName, mFile.getOriginalFilename(), (File) mFile);
				//CommonsMultipartFile co = (CommonsMultipartFile)mFile;
				//DiskFileItem diskFileItem = (DiskFileItem)co.getFileItem();
				//File file3 = new File(diskFileItem.getStoreLocation().getAbsolutePath());
				if (!StringUtils.startsWith(prePath, "/")) {
					prePath = FileUtil.SEPARATOR + prePath;
				}
				prePath = StringUtils.stripEnd(prePath, "/");
				String objectName = bizConfig.getProperty("naver.cloud.aws.s3.folder") + FileUtil.SEPARATOR + bizConfig.getProperty("common.storage.base.images") + prePath + FileUtil.SEPARATOR + fileName;
				ObjectMetadata metaData = new ObjectMetadata();
				metaData.setContentType(mFile.getContentType());
				metaData.setContentLength(mFile.getSize());
				PutObjectResult putResult = s3.putObject(bucketName, objectName,  mFile.getInputStream(), metaData );
				String encodeURIComponentValue = URLEncoder.encode(mFile.getOriginalFilename(), "UTF-8").replaceAll("\\+", "%20")
						.replaceAll("\\%21", "!").replaceAll("\\%27", "'").replaceAll("\\%28", "(").replaceAll("\\%29", ")")
						.replaceAll("\\%7E", "~");
				//setObjectAcl(objectName);
				result.setFileExe(exe);
				result.setFileName(fileOrgName);
				result.setFileSize(mFile.getSize());
				result.setFileType(mFile.getContentType());
				result.setFilePath(bizConfig.getProperty("naver.cloud.cdn.domain")+ FileUtil.SEPARATOR + bizConfig.getProperty("naver.cloud.aws.s3.folder") + FileUtil.SEPARATOR + bizConfig.getProperty("common.storage.base.images") + prePath + FileUtil.SEPARATOR + fileName);
				
			} catch (AmazonS3Exception e) {
				log.error(CommonConstants.LOG_EXCEPTION_STACK_TRACE, e);
			} catch(SdkClientException e) {
				log.error(CommonConstants.LOG_EXCEPTION_STACK_TRACE, e);
			} catch (IOException e) {
				log.error(CommonConstants.LOG_EXCEPTION_STACK_TRACE, e);
			}
		}
		return result;
	}
	
	public void setObjectAcl(String objectName) {
		// set object ACL
		try {
		    // get the current ACL
		    AccessControlList accessControlList = s3.getObjectAcl(bucketName, objectName);

		    // add read permission to user by ID
		    accessControlList.grantPermission(GroupGrantee.AllUsers, Permission.Read);

		    s3.setObjectAcl(bucketName, objectName, accessControlList);
		} catch (AmazonS3Exception e) {
			log.error(CommonConstants.LOG_EXCEPTION_STACK_TRACE, e);
		} catch(SdkClientException e) {
			log.error(CommonConstants.LOG_EXCEPTION_STACK_TRACE, e);
		}
	}
	
//	public void download(String objectName) {
//		// download object
//		HttpServletResponse response = ((ServletRequestAttributes)RequestContextHolder.currentRequestAttributes()).getResponse();
//
//		response.setHeader("Content-Disposition", "attachment; filename=\"" + "test.docx" + "\";");
//		response.setHeader("Content-Transfer-Encoding", "binary");
//		try {
//		    S3Object s3Object = s3.getObject(bucketName, objectName);
//		    S3ObjectInputStream s3ObjectInputStream = s3Object.getObjectContent();
//
//		    OutputStream out = response.getOutputStream();
//
//		    try (InputStream is = s3ObjectInputStream;){
//				
//				FileCopyUtils.copy(is, out);
//			} 
//			out.flush();
//		    s3ObjectInputStream.close();
//		} catch (AmazonS3Exception e) {
//			log.error(CommonConstants.LOG_EXCEPTION_STACK_TRACE, e);
//		} catch(SdkClientException e) {
//			log.error(CommonConstants.LOG_EXCEPTION_STACK_TRACE, e);
//		} catch (IOException e) {
//			log.error(CommonConstants.LOG_EXCEPTION_STACK_TRACE, e);
//		}
//	}
	
	public void download(FileViewParam fileView, OutputStream out) {
		// download object
		
		try {
			String objectName = fileView.getFilePath();
			String folderName = bizConfig.getProperty("naver.cloud.aws.s3.folder") + FileUtil.SEPARATOR + bizConfig.getProperty("naver.cloud.aws.s3.folder.images");
			if (StringUtil.isNotEmpty(objectName)) {
				if (objectName.indexOf(bizConfig.getProperty("naver.cloud.domain")) > -1) {
					objectName = objectName.split(bizConfig.getProperty("naver.cloud.domain"))[1];
				} else if (objectName.indexOf(bizConfig.getProperty("naver.cloud.aws.s3.endpoint")) > -1) {
					String spitStr = bizConfig.getProperty("naver.cloud.aws.s3.endpoint") + FileUtil.SEPARATOR + bizConfig.getProperty("naver.cloud.aws.s3.bucket") + FileUtil.SEPARATOR;
					objectName = objectName.split(spitStr)[1];
				} else if (objectName.indexOf(folderName) == -1 && StringUtil.equals(bizConfig.getProperty("envmt.gb"), CommonConstants.ENVIRONMENT_GB_LOCAL)) {
					objectName = folderName + objectName;
				}
				
				S3Object s3Object = s3.getObject(bucketName, objectName);
				S3ObjectInputStream s3ObjectInputStream = s3Object.getObjectContent();
				try (InputStream is = s3ObjectInputStream;){
					FileCopyUtils.copy(is, out);
				} 
				out.flush();
				s3ObjectInputStream.close();
			}
		} catch (AmazonS3Exception e) {
			log.error(CommonConstants.LOG_EXCEPTION_STACK_TRACE, e);
		} catch(SdkClientException e) {
			log.error(CommonConstants.LOG_EXCEPTION_STACK_TRACE, e);
		} catch (IOException e) {
			log.error(CommonConstants.LOG_EXCEPTION_STACK_TRACE, e);
		}
	}
	
	public void delete(String objectName) {
		// delete object
		try {
			if (StringUtil.isNotEmpty(objectName)) {
				if (objectName.indexOf(bizConfig.getProperty("naver.cloud.domain")) > -1) {
					objectName = objectName.split(bizConfig.getProperty("naver.cloud.domain"))[1];
				} else if (objectName.indexOf(bizConfig.getProperty("naver.cloud.aws.s3.endpoint")) > -1) {
					String spitStr = bizConfig.getProperty("naver.cloud.aws.s3.endpoint") + FileUtil.SEPARATOR + bizConfig.getProperty("naver.cloud.aws.s3.bucket") + FileUtil.SEPARATOR;
					objectName = objectName.split(spitStr)[1];
				}
				if (!StringUtils.startsWith(objectName, bizConfig.getProperty("naver.cloud.aws.s3.folder") + FileUtil.SEPARATOR + bizConfig.getProperty("naver.cloud.aws.s3.folder.images"))) {
					objectName = bizConfig.getProperty("naver.cloud.aws.s3.folder") + FileUtil.SEPARATOR + bizConfig.getProperty("naver.cloud.aws.s3.folder.images") + objectName;
				}
				s3.deleteObject(bucketName, objectName);
			}
		} catch (AmazonS3Exception e) {
			log.error(CommonConstants.LOG_EXCEPTION_STACK_TRACE, e);
		} catch(SdkClientException e) {
			log.error(CommonConstants.LOG_EXCEPTION_STACK_TRACE, e);
		}
	}

	public String uploadFilePath(String orgFileStr, String filePath) {
		// 보안 진단 관련 check
		filePath = StringUtils.replace(filePath, "..", StringUtils.EMPTY);		
		String newFileName = FilenameUtils.getName(orgFileStr);
		return filePath + FileUtil.SEPARATOR + newFileName;
	}
	
	public String makeSignature(String url, String method, String timestamp) {
		String space = " "; // 공백
		String newLine = "\n"; // 줄바꿈

		String message = new StringBuilder().append(method).append(space).append(url).append(newLine).append(timestamp)
				.append(newLine).append(bizConfig.getProperty("naver.cloud.outmail.access")).toString();
		String encodeBase64String = "";
		try {
			SecretKeySpec signingKey = new SecretKeySpec(bizConfig.getProperty("naver.cloud.outmail.secret").getBytes("UTF-8"), "HmacSHA256");
			Mac mac = Mac.getInstance("HmacSHA256");
			mac.init(signingKey);

			byte[] rawHmac = mac.doFinal(message.getBytes("UTF-8"));
			encodeBase64String = Base64.encodeBase64String(rawHmac);
		} catch (Exception e) {
			throw new CustomException(ExceptionConstants.ERROR_CODE_DEFAULT);
		}
		return encodeBase64String;
	}
	
	public JSONObject getCdnPlusInstanceList() {
		JSONObject obj = new JSONObject();
		try {
			String apiURL = bizConfig.getProperty("naver.cloud.api.url") + bizConfig.getProperty("naver.cloud.getCdnPlusInstanceList");
			Long timestamp = Timestamp.valueOf(LocalDateTime.now()).getTime();
			URL url = new URL(apiURL);
			String method = "POST";
			HttpURLConnection con = (HttpURLConnection)url.openConnection();
//			con.setRequestProperty("Content-Type", "application/json");
			con.setRequestProperty("x-ncp-apigw-timestamp", String.valueOf(timestamp));
			con.setRequestProperty("x-ncp-iam-access-key", bizConfig.getProperty("naver.cloud.outmail.access"));
			con.setRequestProperty("x-ncp-apigw-signature-v2",makeSignature(bizConfig.getProperty("naver.cloud.getCdnPlusInstanceList"), method, String.valueOf(timestamp)).trim());
			con.setDoOutput(true);
			con.setRequestMethod(method);

			int responseCode = con.getResponseCode();
			BufferedReader br;
			if(responseCode==200) { // 정상 호출
				br = new BufferedReader(new InputStreamReader(con.getInputStream()));
			} else {  // 오류 발생
				br = new BufferedReader(new InputStreamReader(con.getErrorStream()));
			}
			String inputLine;
			StringBuffer response = new StringBuffer();
			while ((inputLine = br.readLine()) != null) {
				response.append(inputLine);
			}
			br.close();
			obj = new JSONObject(response.toString());
		} catch (Exception e) {
			log.error("NhnShortUrlUtil getUrl error : {}", e);
		}
		return obj;
	}
	
	public JSONObject getCdnPlusPurgeHistoryList() {
		return getCdnPlusPurgeHistoryList(null, null);
	}
	
	public JSONObject getCdnPlusPurgeHistoryList(String cdnInstanceNo, Map<String, String> queryMap) {
		JSONObject obj = new JSONObject();
		try {
			if (StringUtil.isEmpty(cdnInstanceNo)) {
				cdnInstanceNo = bizConfig.getProperty("naver.cloud.cdn.instanceNo");
			}
			String queryString = StringUtil.replaceAll(bizConfig.getProperty("naver.cloud.getCdnPlusPurgeHistoryList"), "{cdnInstanceNo}", cdnInstanceNo);
			String query = "";
			if (queryMap != null) {
				query = queryMap.entrySet().stream().map(e -> e.getKey() + "=" + e.getValue())
						.collect(Collectors.joining("&"));
				queryString += "?" + query;
			}
			String apiURL = bizConfig.getProperty("naver.cloud.api.url") + queryString;
			Long timestamp = Timestamp.valueOf(LocalDateTime.now()).getTime();
			URL url = new URL(apiURL);
			String method = "POST";
			HttpURLConnection con = (HttpURLConnection)url.openConnection();
//			con.setRequestProperty("Content-Type", "application/json");
			con.setRequestProperty("x-ncp-apigw-timestamp", String.valueOf(timestamp));
			con.setRequestProperty("x-ncp-iam-access-key", bizConfig.getProperty("naver.cloud.outmail.access"));
			con.setRequestProperty("x-ncp-apigw-signature-v2",makeSignature(queryString, method, String.valueOf(timestamp)).trim());
			con.setDoOutput(true);
			con.setRequestMethod(method);

			int responseCode = con.getResponseCode();
			BufferedReader br;
			if(responseCode==200) { // 정상 호출
				br = new BufferedReader(new InputStreamReader(con.getInputStream()));
			} else {  // 오류 발생
				br = new BufferedReader(new InputStreamReader(con.getErrorStream()));
			}
			String inputLine;
			StringBuffer response = new StringBuffer();
			while ((inputLine = br.readLine()) != null) {
				response.append(inputLine);
			}
			br.close();
			obj = new JSONObject(response.toString());
		} catch (Exception e) {
			log.error("NhnShortUrlUtil getUrl error : {}", e);
		}
		return obj;
	}
	
	public JSONObject requestCdnPlusPurge(PurgeParam param) {
		JSONObject obj = new JSONObject();
		try {
			if (StringUtil.isEmpty(param.getCdnInstanceNo())) {
				param.setCdnInstanceNo(bizConfig.getProperty("naver.cloud.cdn.instanceNo"));
			}
			String queryString = StringUtil.replaceAll(bizConfig.getProperty("naver.cloud.requestCdnPlusPurge"), "{cdnInstanceNo}", param.getCdnInstanceNo());
			String query = "";
			
			// This CDN service can not request purge with partial domains.
			param.setIsWholeDomain("true");
//			if (StringUtil.isEmpty(param.getIsWholeDomain())) {
//				param.setIsWholeDomain("false");
//				String[] domainList = new String[] {bizConfig.getProperty("naver.cloud.cdn.domainId")};
//				param.setDomainIdList(domainList);
//			}
			query += "&isWholeDomain=" + param.getIsWholeDomain();
			if (StringUtil.isNotEmpty(param.getDomainIdList())) {
				for(int i = 0; i < param.getDomainIdList().length; i++) {
					query += "&domainIdList." + (i + 1) + "=" + param.getDomainIdList()[i];
				}
			}
			if (StringUtil.isNotEmpty(param.getTargetFileList()) || StringUtil.isNotEmpty(param.getTargetDirectoryName())) {
				param.setIsWholePurge("false");
			}
			query += "&isWholePurge=" + param.getIsWholePurge();
			if (StringUtil.isNotEmpty(param.getTargetFileList())) {
				for(int i = 0; i < param.getTargetFileList().length; i++) {
					query += "&targetFileList." + (i + 1) + "=" + param.getTargetFileList()[i].trim();
				}
			}

			if (StringUtil.isNotEmpty(param.getTargetDirectoryName())) {
				query += "&targetDirectoryName=aboutPet/images/" + StringUtils.strip(param.getTargetDirectoryName(), "/").trim();
			}
			queryString += query;
			String apiURL = bizConfig.getProperty("naver.cloud.api.url") + queryString;
			Long timestamp = Timestamp.valueOf(LocalDateTime.now()).getTime();
			URL url = new URL(apiURL);
			String method = "POST";
			HttpURLConnection con = (HttpURLConnection)url.openConnection();
//			con.setRequestProperty("Content-Type", "application/json");
			con.setRequestProperty("x-ncp-apigw-timestamp", String.valueOf(timestamp));
			con.setRequestProperty("x-ncp-iam-access-key", bizConfig.getProperty("naver.cloud.outmail.access"));
			con.setRequestProperty("x-ncp-apigw-signature-v2",makeSignature(queryString, method, String.valueOf(timestamp)).trim());
			con.setDoOutput(true);
			con.setRequestMethod(method);

			int responseCode = con.getResponseCode();
			BufferedReader br;
			if(responseCode==200) { // 정상 호출
				br = new BufferedReader(new InputStreamReader(con.getInputStream()));
			} else {  // 오류 발생
				br = new BufferedReader(new InputStreamReader(con.getErrorStream()));
			}
			String inputLine;
			StringBuffer response = new StringBuffer();
			while ((inputLine = br.readLine()) != null) {
				response.append(inputLine);
			}
			br.close();
			obj = new JSONObject(response.toString());
		} catch (Exception e) {
			log.error("NhnShortUrlUtil getUrl error : {}", e);
		}
		return obj;
	}
}
