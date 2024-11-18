package framework.common.util;

import java.nio.ByteBuffer;
import java.security.SecureRandom;
import java.util.Properties;

import javax.crypto.Cipher;
import javax.crypto.spec.IvParameterSpec;
import javax.crypto.spec.SecretKeySpec;

import org.apache.commons.codec.binary.Base64;
import org.apache.commons.lang3.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

/**
 * 암호화/복호화 Util 클래스 AES 알고리즘 / CBC 운영모드
 * 
 * @author valueFactory
 */
@Component
public class TwcCryptoUtil {

	@Autowired
	private Properties bizConfig;
	
	private static SecretKeySpec KEY_SPEC = null;
	private static IvParameterSpec IVP_SPEC = null;
	private static String ivpStr = null;

	/**
	 * AES
	 * 
	 * @param secretKey 대칭키
	 * @return 
	 * @return 
	 */
	private void AES(String secretKey) {
		if (StringUtil.isEmpty(secretKey)) {
			secretKey = bizConfig.getProperty("twc.secret.key");
		}
		int substrInt = 16;
		if (StringUtil.getByteLength(secretKey) > 16 && StringUtil.getByteLength(secretKey) < 32) {
			substrInt = 16;
		} else if (StringUtil.getByteLength(secretKey) > 32) {
			substrInt = 32;
		} else if (StringUtil.getByteLength(secretKey) < 16) {
			secretKey = StringUtils.leftPad(String.valueOf(secretKey), 16, "0");
		}
		StringBuffer buffer = new StringBuffer();
		SecureRandom random = new SecureRandom();

		String chars1[] = "A,B,C,D,E,F,G,H,I,J,K,L,M,N,O,P,Q,R,S,T,U,V,W,X,Y,Z,a,b,c,d,e,f,g,h,i,j,k,l,m,n,o,p,q,r,s,t,u,v,w,x,y,z".split(",");
		//String chars1[] = "a,b,c,d,e,f,g,h,i,j,k,l,m,n,o,p,q,r,s,t,u,v,w,x,y,z".split(",");
		String chars2[] = "0,1,2,3,4,5,6,7,8,9".split(",");
		for (int i = 0; i < 16; i++) {
			// 보안진단 처리 - 적절하지 않은 난수값 사용
			int div = random.nextInt(5);
			if(div == 0) {
				buffer.append(chars1[random.nextInt(chars1.length)]);
			}else if(div == 1){
				buffer.append(chars1[random.nextInt(chars1.length)]);
			}else if(div == 2){
				buffer.append(chars2[random.nextInt(chars2.length)]);
			}else {
				buffer.append(chars1[random.nextInt(chars1.length)]);
			}
		}
		ivpStr = buffer.toString();
		KEY_SPEC = new SecretKeySpec(secretKey.substring(0, substrInt).getBytes(), "AES");
		IVP_SPEC = new IvParameterSpec(ivpStr.getBytes());
	}
	
	/**
	 * 암호화
	 *
	 * @param arg 암호화할 문자열
	 * @return 암호화된 문자열
	 * @throws Exception
	 */
	public String encryptWithKey(String arg, String key) throws Exception {
		AES(key);
		if (arg == null || "".equals(arg)) {
			return "";
		}
		
		Cipher cipher = Cipher.getInstance("AES/CBC/PKCS5Padding");
		cipher.init(Cipher.ENCRYPT_MODE, KEY_SPEC, IVP_SPEC);
		byte[] encryptedText = cipher.doFinal(arg.getBytes("UTF-8"));
		return new String(Base64.encodeBase64(joinByteArray(ivpStr.getBytes(), encryptedText)));
	}
	
	/**
	 * 복호화
	 *
	 * @param arg 복호화할 문자열
	 * @return 복호화된 문자열
	 * @throws Exception
	 */
	public String decryptWithKey(String arg, String key) throws Exception {
		AES(key);
		if (arg == null || "".equals(arg)) {
			return "";
		}
		byte[] argByte = Base64.decodeBase64(arg.getBytes());
		byte[] ivpStrByte = new byte[16];
		byte[] argument = new byte[argByte.length - ivpStrByte.length];
		System.arraycopy(argByte, 0, ivpStrByte, 0, ivpStrByte.length);
		System.arraycopy(argByte, ivpStrByte.length, argument, 0, argument.length);
		IVP_SPEC = new IvParameterSpec(ivpStrByte);
		Cipher cipher = Cipher.getInstance("AES/CBC/PKCS5Padding");
		cipher.init(Cipher.DECRYPT_MODE, KEY_SPEC, IVP_SPEC);
		byte[] decryptedText = cipher.doFinal(argument);
		
		return new String(decryptedText, "UTF-8");
	}
	
	private byte[] joinByteArray(byte[] byte1, byte[] byte2) {

	    return ByteBuffer.allocate(byte1.length + byte2.length)
	            .put(byte1)
	            .put(byte2)
	            .array();

	}

}
