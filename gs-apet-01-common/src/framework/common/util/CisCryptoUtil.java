package framework.common.util;

import java.util.Properties;

import javax.crypto.Cipher;
import javax.crypto.spec.IvParameterSpec;
import javax.crypto.spec.SecretKeySpec;

import org.apache.commons.codec.binary.Base64;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

/**
 * 암호화/복호화 Util 클래스 AES 알고리즘 / CBC 운영모드
 * 
 * @author valueFactory
 */
@Component
public class CisCryptoUtil {

	@Autowired
	private Properties bizConfig;
	
	// AES 암호화 키 18byte
	private static String aes_key = null;
	private static SecretKeySpec KEY_SPEC = null;
	private static IvParameterSpec IVP_SPEC = null;

	
	/** 고정키 정보 **/
	private void getKey() {
		aes_key = bizConfig.getProperty("cis.crypto.encrypt.key.aes");
		KEY_SPEC = new SecretKeySpec(aes_key.getBytes(), "AES");
		IVP_SPEC = new IvParameterSpec(aes_key.substring(0, 16).getBytes());
	}

	/**
	 * 암호화
	 *
	 * @param arg 암호화할 문자열
	 * @return 암호화된 문자열
	 * @throws Exception
	 */
	public String encrypt(String arg) throws Exception {
		if (arg == null || "".equals(arg)) {
			return "";
		}
		getKey();
		Cipher cipher = Cipher.getInstance("AES/CBC/PKCS5Padding");
		cipher.init(Cipher.ENCRYPT_MODE, KEY_SPEC, IVP_SPEC);
		byte[] encryptedText = cipher.doFinal(arg.getBytes("UTF-8"));
		
		return new String(Base64.encodeBase64(encryptedText));
	}

	/**
	 * 복호화
	 *
	 * @param arg 복호화할 문자열
	 * @return 복호화된 문자열
	 * @throws Exception
	 */
	public String decrypt(String arg) throws Exception {
		if (arg == null || "".equals(arg)) {
			return "";
		}
		getKey();
		Cipher cipher = Cipher.getInstance("AES/CBC/PKCS5Padding");
		cipher.init(Cipher.DECRYPT_MODE, KEY_SPEC, IVP_SPEC);
		byte[] decryptedText = cipher.doFinal(Base64.decodeBase64(arg.getBytes()));
		
		return new String(decryptedText, "UTF-8");
	}

}
