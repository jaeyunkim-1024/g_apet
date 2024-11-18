package framework.common.util;

import framework.common.constants.ExceptionConstants;
import framework.common.exception.CustomException;
import sun.misc.BASE64Decoder;
import sun.misc.BASE64Encoder;

import javax.crypto.Cipher;
import javax.crypto.SecretKeyFactory;
import javax.crypto.spec.DESKeySpec;
import javax.crypto.spec.DESedeKeySpec;
import javax.crypto.spec.IvParameterSpec;
import javax.crypto.spec.SecretKeySpec;
import java.nio.charset.StandardCharsets;
import java.security.Key;
import java.security.MessageDigest;

/**
 * 암호화/복호화 Util 클래스 AES 알고리즘 / CBC 운영모드
 * 
 * @author valueFactory
 */
public class CryptoUtil {

	private CryptoUtil() {
		throw new CustomException(ExceptionConstants.ERROR_CODE_DEFAULT);
	}
	
	// AES 암호화 키 18byte
	private static final String aesKey = "kis_aes_crypto11";

	// DES 암호화 키 임의 가능
	private static final String desKey = "kis_des_crypto";

	// DESede 암호화 키 임의 가능
	//private static String desedeKey = "kis_desede_crypto_201308";
	private static final String desedeKey = "c2r0m2P1e0t1A2b6o1u3t30";
	
	
	// SKT MP API HUB암호화 변환 규칙(암호화알고리즘/운용모드/패딩)
	private static String transformationRule = "AES/CBC/PKCS5Padding";
	private static String IV = "ABCDEFGHIJKLMNOP";

	// SKT MP API R3K 암호화 키
	private static String r3kEncryptKey = "TBL@@PWBB5lmoLDp0pXq77ed";
			

	/**
	 * DES 방식의 암호화 대칭형
	 * 
	 * @param str : 비밀키 암호화를 희망하는 문자열
	 * @return
	 * @exception Exception
	 */
	public static String encryptDES(String str) {
		return encryptChiper("DES", str);
	}

	/**
	 * DES 방식의 복호화 대칭형
	 * 
	 * @param str : 비밀키 복호화를 희망하는 문자열
	 * @return
	 * @exception Exception
	 */
	public static String decryptDES(String str) {
		return decryptChiper("DES", str);
	}

	/**
	 * DES3(Triple) 방식의 암호화 대칭형
	 * 
	 * @param str : 비밀키 암호화를 희망하는 문자열
	 * @return
	 * @exception Exception
	 */
	public static String encryptDES3(String str) {
		return encryptChiper("DESede", str);
	}

	/**
	 * DES3(Triple) 방식의 복호화 대칭형
	 * 
	 * @param str : 비밀키 복호화를 희망하는 문자열
	 * @return
	 * @exception Exception
	 */
	public static String decryptDES3(String str) {
		return decryptChiper("DESede", str);
	}

	/**
	 * AES 방식의 암호화
	 * 
	 * @param str : 비밀키 암호화를 희망하는 문자열
	 * @return 
	 */
	public static String encryptAES(String str) {
		return encryptChiper("AES", str);
	}

	/**
	 * AES 방식의 복호화
	 * 
	 * @param encrypted : 비밀키 복호화를 희망하는 문자열
	 * @return 
	 */
	public static String decryptAES(String encrypted) {
		return decryptChiper("AES", encrypted);
	}

	/** 고정키 정보 **/
	private static String key(String algorithm) {
		String key = "";
		if ("AES".equals(algorithm)) {
			key = aesKey;
		} else if ("DES".equals(algorithm)) {
			key = desKey;
		} else if ("DESede".equals(algorithm)) {
			key = desedeKey;
		}
		return key;
	}

	/**
	 * Cipher의 instance 생성시 사용될 값
	 * 
	 * @param algorithm
	 * @return String DES, TripleDES 구분 
	 */
	private static String getInstance(String algorithm) {
		String result = null;

		if ("AES".equals(algorithm)) {
			result = "AES/ECB/PKCS5Padding";
		} else if ("DES".equals(algorithm)) {
			result = "DES/ECB/PKCS5Padding";
		} else if ("DESede".equals(algorithm)) {
			result = "DESede/ECB/PKCS5Padding";
		}

		return result;
	}

	/**
	 * 키값 구하기
	 *
	 * @param algorithm
	 * @return 
	 */
	private static Key getKey(String algorithm) {
		Key result = null;

		try {
			if ("AES".equals(algorithm)) {
				result = new SecretKeySpec(key(algorithm).getBytes(), algorithm);
			} else if ("DES".equals(algorithm)) {
				DESKeySpec desKeySpec = new DESKeySpec(key(algorithm).getBytes());
				SecretKeyFactory keyFactory = SecretKeyFactory.getInstance(algorithm);
				result = keyFactory.generateSecret(desKeySpec);
			} else if ("DESede".equals(algorithm)) {
				DESedeKeySpec desKeySpec = new DESedeKeySpec(key(algorithm).getBytes());
				SecretKeyFactory keyFactory = SecretKeyFactory.getInstance("DESede");
				result = keyFactory.generateSecret(desKeySpec);
			}

		} catch (Exception e) {
			throw new CustomException(ExceptionConstants.ERROR_CODE_DEFAULT);
		}

		return result;
	}

	/**
	 * Cipher 암호화 암호화 후 BASE64Encoding
	 * 
	 * @param algorithm
	 * @param codedStr
	 * @return 
	 */
	@SuppressWarnings("restriction")
	private static String encryptChiper(String algorithm, String codedStr) {
		if (codedStr == null || codedStr.length() == 0)
			return "";

		Cipher cipher;
		String outputStr1 = "";

		try {
			cipher = Cipher.getInstance(getInstance(algorithm));
			cipher.init(Cipher.ENCRYPT_MODE, getKey(algorithm));

			byte[] inputBytes = codedStr.getBytes(StandardCharsets.UTF_8);
			byte[] encrypted = cipher.doFinal(inputBytes);

			BASE64Encoder encoder = new BASE64Encoder();
			outputStr1 = encoder.encode(encrypted);

		} catch (Exception e) {
			throw new CustomException(ExceptionConstants.ERROR_CODE_DEFAULT);
		}

		return outputStr1;

	}

	/**
	 * Cipher 복호화 BASE64Decoding 후 복호화
	 * 
	 * @param algorithm
	 * @param encrypted
	 * @return @
	 */
	@SuppressWarnings("restriction")
	private static String decryptChiper(String algorithm, String str) {
		if (str == null || str.length() == 0)
			return "";

		String strResult = "";

		try {
			Cipher cipher = Cipher.getInstance(getInstance(algorithm));
			cipher.init(Cipher.DECRYPT_MODE, getKey(algorithm));

			BASE64Decoder decoder = new BASE64Decoder();
			byte[] inputBytes = decoder.decodeBuffer(str);
			byte[] decrypted = cipher.doFinal(inputBytes);

			strResult = new String(decrypted, StandardCharsets.UTF_8);

		} catch (Exception e) {
			throw new CustomException(ExceptionConstants.ERROR_CODE_DEFAULT);
		}

		return strResult;

	}

	/**
	 * SHA1 암호화 단방향
	 * 
	 * @param value
	 * @return @
	 */
	public static String encryptSHA1(String value) {
		return getMessageDigest("SHA1", value);
	}

	/**
	 * SHA-256 암호화 단방향
	 * 
	 * @param value
	 * @return @
	 */
	public static String encryptSHA256(String value) {
		return getMessageDigest("SHA-256", value);
	}

	/**
	 * SHA-256 CRM 암호화 단방향
	 *
	 * @param value
	 * @return @
	 */
	public static String encryptSHA256_CRM(String value) {	return getMessageDigest("SHA-256", value,true);	}

	/**
	 * SHA-512 암호화 단방향
	 * 
	 * @param value
	 * @return @
	 */
	public static String encryptSHA512(String value) {
		return getMessageDigest("SHA-512", value);
	}

	/**
	 * MD5 암호화 단방향
	 * 
	 * @param value
	 * @return @
	 */
	public static String encryptMD5(String value) {	return getMessageDigest("MD5", value);	}

	/**
	 *
	 * 기존 암호화 유틸 getMessageDigest 메소드
	 * @param algorithm - 알고리즘
	 * @param value - 암호화 희망하는 문자열	 
	 * @return @
	 */
	private static String getMessageDigest(String algorithm,String value){
		return getMessageDigest(algorithm,value,false);
	}

	/**
	 *
	 * 
	 * @param algorithm - 알고리즘
	 * @param value - 암호화 희망하는 문자열
	 * @param isCrm - CRM 여부(생성 규칙 분기)
	 * @return @
	 */
	private static String getMessageDigest(String algorithm, String value ,Boolean isCrm) {

		StringBuilder strResult = new StringBuilder();

		try {
			MessageDigest digest = MessageDigest.getInstance(algorithm);

			digest.update(value.getBytes());

			byte[] messageDigest = digest.digest();

			for (int i = 0; i < messageDigest.length; i++) {
				if(isCrm){
					String str = Integer.toHexString((int)messageDigest[i] & 0xff);
					if (str.length() < 2) {
						for(int j = str.length(); j<2; j++) {
							str = "0" + str;
						}
					}
					strResult.append(str);
				}else{
					strResult.append(Integer.toString((messageDigest[i] & 0xff) + 0x100, 16).substring(1));
				}
				// strResult.append(Integer.toHexString(0xFF & messageDigest[i])));
			}
		} catch (Exception e) {
			throw new CustomException(ExceptionConstants.ERROR_CODE_DEFAULT);
		}

		return strResult.toString();
	}
	
	
	

	/**
	 * AES 복호화 메소드
	 * @param cipherText
	 * @param encryptionKey
	 * @return
	 * @throws Exception
	 */
	private static String decrypt(byte[] cipherText, String encryptionKey) throws Exception {
		// 복호화된 텍스트
		String decryptedText = null;
		// 암호화 객체 생성
		Cipher cipher = Cipher.getInstance(transformationRule);
		// Initialization Vector 객체 생성
		IvParameterSpec ivParameterSpec = new IvParameterSpec(IV.getBytes("UTF-8"));
		// AES 알고리즘에 사용할 비밀키(SecretKey) 를 생성
		SecretKeySpec key = new SecretKeySpec(encryptionKey.getBytes("UTF-8"), "AES");
		// 암호화 객체 '복호화 모드'로 초기화
		cipher.init(Cipher.DECRYPT_MODE, key, ivParameterSpec);
		// 복호화 수행
		byte[] decryptedByteArray = cipher.doFinal(cipherText);
		decryptedText = new String(decryptedByteArray, "UTF-8");
		return decryptedText;
	}

	/**
	 * <pre>
	 * - 프로젝트명	: gs-apet-01-common
	 * - 파일명		: framework.common.util
	 * - 작성일		: 2021. 06. 30.
	 * - 작성자		: JinHong
	 * - 설명		: SKT MP APIHUB 전용 AES 복호화 메소드
	 * </pre>
	 * @param cipherText
	 * @param encryptionKey
	 * @return
	 * @throws Exception
	 */
	public static String decryptApiHub(String cipherText, String encryptionKey) throws Exception {
		return decrypt(CryptoUtil.decodeHex(cipherText.toCharArray()), encryptionKey);
	}

	/**
	 * Converts an array of characters representing hexadecimal values into an array
	 * of bytes of those same values. The returned array will be half the length of
	 * the passed array, as it takes two characters to represent any given byte. An
	 * exception is thrown if the passed char array has an odd number of elements.
	 *
	 * @param data An array of characters containing hexadecimal digits
	 * @return A byte array containing binary data decoded from the supplied char
	 *         array.
	 * @throws DecoderException Thrown if an odd number or illegal of characters is
	 *                          supplied
	 */
	private static byte[] decodeHex(char[] data) {
		int len = data.length;
		if ((len & 0x01) != 0) {
		}
		byte[] out = new byte[len >> 1];
		// two characters form the hex value.
		for (int i = 0, j = 0; j < len; i++) {
			int f = toDigit(data[j], j) << 4;
			j++;
			f = f | toDigit(data[j], j);
			j++;
			out[i] = (byte) (f & 0xFF);
		}
		return out;
	}

	/**
	 * Converts a hexadecimal character to an integer.
	 *
	 * @param ch    A character to convert to an integer digit
	 * @param index The index of the character in the source
	 * @return An integer
	 * @throws DecoderException Thrown if ch is an illegal hex character
	 */
	protected static int toDigit(char ch, int index) {
		int digit = Character.digit(ch, 16);
		if (digit == -1) {
		}
		return digit;
	}


	public static String encryptHexR3k(String codedStr){
		String algorithm = "DESede";
		if (codedStr == null || codedStr.length() == 0)
			return "";

		Cipher cipher;
		String outputStr1 = "";

		try {
			DESedeKeySpec desKeySpec = new DESedeKeySpec(r3kEncryptKey.getBytes());
			SecretKeyFactory keyFactory = SecretKeyFactory.getInstance(algorithm);
			Key key = keyFactory.generateSecret(desKeySpec);

			cipher = Cipher.getInstance(getInstance(algorithm));
			cipher.init(Cipher.ENCRYPT_MODE, key);

			byte[] inputBytes = codedStr.getBytes(StandardCharsets.UTF_8);
			byte[] encrypted = cipher.doFinal(inputBytes);

			BASE64Encoder encoder = new BASE64Encoder();
			outputStr1 = encoder.encode(encrypted);

		} catch (Exception e) {
			throw new CustomException(ExceptionConstants.ERROR_CODE_DEFAULT);
		}

		return outputStr1;
	}

	public static String decryptHexR3k(String str){
		String algorithm = "DESede";
		if (str == null || str.length() == 0)
			return "";

		String strResult = "";

		try {
			DESedeKeySpec desKeySpec = new DESedeKeySpec(r3kEncryptKey.getBytes());
			SecretKeyFactory keyFactory = SecretKeyFactory.getInstance(algorithm);
			Key key = keyFactory.generateSecret(desKeySpec);

			Cipher cipher = Cipher.getInstance(getInstance(algorithm));
			cipher.init(Cipher.DECRYPT_MODE, key);

			BASE64Decoder decoder = new BASE64Decoder();
			byte[] inputBytes = decoder.decodeBuffer(str);
			byte[] decrypted = cipher.doFinal(inputBytes);

			strResult = new String(decrypted, StandardCharsets.UTF_8);

		} catch (Exception e) {
			throw new CustomException(ExceptionConstants.ERROR_CODE_DEFAULT);
		}

		return strResult;
	}
}
