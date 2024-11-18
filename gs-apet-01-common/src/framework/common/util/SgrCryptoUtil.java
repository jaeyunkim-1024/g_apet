package framework.common.util;

import java.util.Properties;

import javax.crypto.Cipher;
import javax.crypto.spec.IvParameterSpec;
import javax.crypto.spec.SecretKeySpec;
import javax.servlet.http.HttpServletRequest;

import org.springframework.web.context.WebApplicationContext;
import org.springframework.web.context.request.RequestContextHolder;
import org.springframework.web.context.request.ServletRequestAttributes;
import org.springframework.web.context.support.WebApplicationContextUtils;

/**
 * 암호화/복호화 Util 클래스 AES 알고리즘 / CBC 운영모드
 * 
 * @author valueFactory
 */
public class SgrCryptoUtil {

	private SgrCryptoUtil() {
		throw new IllegalStateException("Utility class");
	}


	// AES 암호화 키 18byte
	private static String aes_key = null;

	/** 고정키 정보 **/
	private static void getKey() {
		HttpServletRequest request = ((ServletRequestAttributes) RequestContextHolder.getRequestAttributes()).getRequest();
		WebApplicationContext wContext = WebApplicationContextUtils.getWebApplicationContext(request.getSession().getServletContext());
		Properties bizConfig = (Properties) wContext.getBean("bizConfig");
		aes_key = bizConfig.getProperty("sgr.crypto.encrypt.key.aes");
	}

	private static String byteArrayToHex(byte[] a) {
		StringBuilder sb = new StringBuilder();
		for(final byte b: a) {sb.append(String.format("%02x", b&0xff));}
		return sb.toString();
	}
	
	public static byte[] hexStringToByteArray(String s) {
		int len = s.length();
		byte[] data = new byte[len / 2];
		for (int i = 0; i < len; i += 2) {
			data[i / 2] = (byte) ((Character.digit(s.charAt(i), 16) << 4)
									+ Character.digit(s.charAt(i+1), 16));
		}
		return data;
	}
	
	// 텍스트 암호화
	public static String encrypt(String text) throws Exception {
		getKey();
		Cipher cipher = Cipher.getInstance("AES/CBC/PKCS5Padding");
		byte[] keyBytes= new byte[16];
		byte[] b= aes_key.getBytes("UTF-8");
		int len= b.length;
		if (len > keyBytes.length) {len = keyBytes.length;}
		System.arraycopy(b, 0, keyBytes, 0, len);
		SecretKeySpec keySpec = new SecretKeySpec(keyBytes, "AES");
		IvParameterSpec ivSpec = new IvParameterSpec(keyBytes);
		cipher.init(Cipher.ENCRYPT_MODE,keySpec,ivSpec);
		byte[] results = cipher.doFinal(text.getBytes("UTF-8"));
		return byteArrayToHex(results);
	}
	
	public static String decrypt(String text) throws Exception {
		getKey();
		Cipher cipher = Cipher.getInstance("AES/CBC/PKCS5Padding");
		byte[] keyBytes= new byte[16];
		byte[] b= aes_key.getBytes("UTF-8");
		int len= b.length;
		if (len > keyBytes.length) {len = keyBytes.length;}
		System.arraycopy(b, 0, keyBytes, 0, len);
		SecretKeySpec keySpec = new SecretKeySpec(keyBytes, "AES");
		IvParameterSpec ivSpec = new IvParameterSpec(keyBytes);
		cipher.init(Cipher.DECRYPT_MODE,keySpec,ivSpec);
		byte [] results = cipher.doFinal(hexStringToByteArray(text));
		return new String(results,"UTF-8");
	}
	
	// 텍스트 암호화
	public static String getAuthKey() throws Exception {
		String str = "pk|" + RequestUtil.getClientIp() + "|" + DateUtil.calDate("yyyyMMddHHmmss");
		return encrypt(str);
	}
}
