package biz.interfaces.sktmp.util;

import java.lang.reflect.Field;
import java.lang.reflect.Modifier;
import java.util.List;
import java.util.Properties;

import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletRequest;

import org.apache.commons.lang3.StringUtils;
import org.springframework.stereotype.Component;
import org.springframework.web.context.WebApplicationContext;
import org.springframework.web.context.request.RequestContextHolder;
import org.springframework.web.context.request.ServletRequestAttributes;
import org.springframework.web.context.support.WebApplicationContextUtils;

import biz.interfaces.sktmp.model.StrLenVO;
import cryptix.provider.key.RawSecretKey;
import cryptix.util.core.Hex;
import framework.common.constants.CommonConstants;
import framework.common.util.ClassUtil;
import framework.common.util.StringUtil;
import lombok.extern.slf4j.Slf4j;
import xjava.security.Cipher;

/**
 * <pre>
 * - 프로젝트명	: gs-apet-11-business
 * - 패키지명	: biz.interfaces.sktmp.util
 * - 파일명		: SktmpConvertUtil.java
 * - 작성일		: 2021. 06. 29.
 * - 작성자		: JinHong
 * - 설명		: SKT MP 변환 유틸
 * </pre>
 */
@Slf4j
@Component
public class SktmpConvertUtil<T,R>{

	/**
	 * <pre>
	 * - 프로젝트명	: gs-apet-11-business
	 * - 파일명		: biz.interfaces.sktmp.util
	 * - 작성일		: 2021. 06. 29.
	 * - 작성자		: JinHong
	 * - 설명		: Class 데이터 순서 별 데이터 parsing 전문 생성
	 * </pre>
	 * @param data
	 * @return
	 */
	public String getReqData(T data) {
		List<Field> fieldList = ClassUtil.getAllFields(data.getClass());
		StrLenVO value = null;
		StringBuilder builder = new StringBuilder();
		for(Field field : fieldList) {
			field.setAccessible(true);
			//final 변수 제외
			if ((field.getModifiers() & Modifier.FINAL) != Modifier.FINAL) {
				try {
					value = (StrLenVO)field.get(data);
					builder.append(this.getParse(value));
					
				} catch (IllegalArgumentException e) {
					log.error("SKT MP REQUEST DATA parsing error");
					e.printStackTrace();
				} catch (IllegalAccessException e) {
					log.error("SKT MP REQUEST DATA parsing error");
					e.printStackTrace();
				}
				
			}
		}
		
		log.debug("### REQUEST DATA #### \n length : {} \n {}",builder.length(),builder.toString());

		return builder.toString();
	}
	
	/**
	 * <pre>
	 * - 프로젝트명	: gs-apet-11-business
	 * - 파일명		: biz.interfaces.sktmp.util
	 * - 작성일		: 2021. 06. 29.
	 * - 작성자		: JinHong
	 * - 설명		: 전문 속성
	 *  	 String : 왼쪽 정렬, 공백 채움
	 *  	Integer : 오른쪽 정렬, 0 채움
	 * </pre>
	 * @param vo
	 * @return String
	 */
	public String getParse(StrLenVO vo) {
		if(StrLenVO.Type.STRING.equals(vo.getType())) {
			return StringUtils.rightPad(StringUtil.nvl(vo.getValue(), ""), vo.getLen());
		}else {
			return StringUtils.leftPad(StringUtil.nvl(vo.getValue(), ""), vo.getLen(), "0");
		}
	}
	
	/**
	 * <pre>
	 * - 프로젝트명	: gs-apet-11-business
	 * - 파일명		: biz.interfaces.sktmp.util
	 * - 작성일		: 2021. 06. 29.
	 * - 작성자		: JinHong
	 * - 설명		: 전문 String to VO
	 *  StrLenVO에 설정한 length 별로 잘라서 VO 에 세팅
	 * </pre>
	 * @param str
	 * @param res
	 */
	public void getResData(String str, R res) {
		List<Field> fieldList = ClassUtil.getAllFields(res.getClass());
		byte[] bdata = str.getBytes();
	    int pos = 0;
	    StrLenVO item = null;
	    for(Field field : fieldList) {
	    	if(pos >= str.length()) {
	    		break;
	    	}
	    	field.setAccessible(true);
			//final 변수 제외
			if ((field.getModifiers() & Modifier.FINAL) != Modifier.FINAL) {
				try {
					item = (StrLenVO)field.get(res);
					int length = 0;
					if(pos+ item.getLen() > str.length()) {
						length = str.length() - pos;
					}else {
						length = item.getLen();
					}
					
					byte[] temp = new byte[length];
					
					System.arraycopy(bdata, pos, temp, 0, length);
					pos += item.getLen();
					item.setValue(new String(temp));
					field.set(res, item);
				} catch (IllegalArgumentException e) {
					log.error("SKT MP RESPONSE DATA parsing error");
					e.printStackTrace();
				} catch (IllegalAccessException e) {
					log.error("SKT MP RESPONSE DATA parsing error");
					e.printStackTrace();
				}
			}
	    }
	    
	    log.debug("RESPONSE DATA -> :{}",res.toString());
	}

	//암호화
	public String encrypt(String str){
		HttpServletRequest request = ((ServletRequestAttributes) RequestContextHolder.getRequestAttributes()).getRequest();
		ServletContext context = request.getSession().getServletContext();
		WebApplicationContext wContext = WebApplicationContextUtils.getWebApplicationContext(context);

		Properties bizConfig = (Properties) wContext.getBean("bizConfig");
		
		String encryptKey = bizConfig.getProperty("skt.membership.encrypt.key");
		
		String algorithm = bizConfig.getProperty("skt.membership.encrypt.algorithm");
		
		String provider = bizConfig.getProperty("skt.membership.encrypt.provider");
		
		byte[] ect = null;
		try {
			/***** 메세지 길이 체크(8의 배수여야 한다) *****/
			while( (str.length() % 8) != 0 ){
				str += " ";
			}
			Cipher alg = Cipher.getInstance(algorithm, provider);
			RawSecretKey key = new RawSecretKey(algorithm, encryptKey.getBytes());

			alg.initEncrypt(key);
			ect = alg.crypt(str.getBytes());
		} catch ( Exception e ){
			log.error(CommonConstants.LOG_EXCEPTION_STACK_TRACE,e);
		}
		return Hex.toString(ect);
	}

	//복호화
	public String decrypt(String str){
		HttpServletRequest request = ((ServletRequestAttributes) RequestContextHolder.getRequestAttributes()).getRequest();
		ServletContext context = request.getSession().getServletContext();
		WebApplicationContext wContext = WebApplicationContextUtils.getWebApplicationContext(context);

		Properties bizConfig = (Properties) wContext.getBean("bizConfig");
		
		String encryptKey = bizConfig.getProperty("skt.membership.encrypt.key");
		
		String algorithm = bizConfig.getProperty("skt.membership.encrypt.algorithm");
		
		String provider = bizConfig.getProperty("skt.membership.encrypt.provider");
		
		byte[] dct = null; 
		try { 
			Cipher alg = Cipher.getInstance(algorithm,provider); 
			RawSecretKey key = new RawSecretKey(algorithm, encryptKey.getBytes());
			alg.initDecrypt(key); dct = alg.crypt(Hex.fromString(str)); 
		} catch (Exception e ){ 
			log.error(CommonConstants.LOG_EXCEPTION_STACK_TRACE,e); 
		}
		return new String(dct).trim();
	}

	//REQ TEST
	/*public static void main(String[] args) {
		SktmpConvertUtil<MpPntApproveReqVO> util = new SktmpConvertUtil<>();
		MpPntApproveReqVO req = new MpPntApproveReqVO();
		req.setMsgType(SktmpConstants.MSG_TYPE_0500);
		req.setDealGbCd(SktmpConstants.DEAL_GB_APPROVE);
		req.setDealAmt("59000");
		req.setUseMpPnt("");
		req.setMsgSndDtm("20210526201100");
		req.setCartNum("2163520263001516");
		req.setDealNum("670000000001");
		req.setDevice("1000000000");
		req.setStoreNum("S2011001");
		req.setGoodsType("8001");
		req.setUserIdGbCd("08");
		//req.setUserId(userId);
		req.setPinNum("123456");
		//req.setDummy(dummy);
		req.setCurrNum("410");
		req.setIfInfo("e3fBgk1GcY0nr+xBfCEC12g9hu6W9tKEnxH+rJ7mcgtC06x5dvd+8IPU/CFsLaTwn7/9sJVy0znCwVzUuK9XuQ==");
		
		util.getReqData(null, req);
	}*/
	
	//RES TEST
	/*public static void main(String[] args) {
		SktmpConvertUtil<MpPntApproveReqVO, MpPntApproveResVO> util = new SktmpConvertUtil<>();
		MpPntApproveResVO res = new MpPntApproveResVO();
		String str = "05100000100000000590000000000000002021052620110021635202630015166700000000011000000000S2011001  80010000000059798898MV00000000000005900000000010010000000000000002360000000000000000000000000000";
		String str =   "05100000100000000320000000000000002021081809583721498897019024276700000000151000000000V7981001  80019254545400000000MV00000000000000000000005000";
		util.getResData(str, res);
		System.out.println(res.toString());
	}*/
}
