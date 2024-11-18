package framework.common.util;

import java.io.UnsupportedEncodingException;
import java.security.InvalidKeyException;
import java.security.KeyFactory;
import java.security.KeyPair;
import java.security.KeyPairGenerator;
import java.security.NoSuchAlgorithmException;
import java.security.PrivateKey;
import java.security.PublicKey;
import java.security.spec.InvalidKeySpecException;
import java.security.spec.RSAPublicKeySpec;
import java.util.HashMap;
import java.util.Map;

import javax.crypto.BadPaddingException;
import javax.crypto.Cipher;
import javax.crypto.IllegalBlockSizeException;
import javax.crypto.NoSuchPaddingException;

import lombok.extern.slf4j.Slf4j;

@Slf4j
public class RSAUtil {
	
	public static Map<String,String> createPublicKey(){
		Map<String,String> map = new HashMap<String, String>();
		try {
			KeyPairGenerator generator = KeyPairGenerator.getInstance("RSA");
			generator.initialize(1024);
			KeyPair keyPair = generator.genKeyPair();
			PublicKey publicKey = keyPair.getPublic();
			PrivateKey privateKey = keyPair.getPrivate();

			KeyFactory keyFactory = KeyFactory.getInstance("RSA");
			
			SessionUtil.setAttribute("_RSA_WEB_KEY_",privateKey); 
			RSAPublicKeySpec publicSpec = (RSAPublicKeySpec)keyFactory.getKeySpec(publicKey, RSAPublicKeySpec.class);
			String publicKeyModulus = publicSpec.getModulus().toString(16);
			String publicKeyExponent = publicSpec.getPublicExponent().toString(16);
			
			map.put("RSAModulus", publicKeyModulus);
			map.put("RSAExponent", publicKeyExponent);
			
		} catch (NoSuchAlgorithmException e) {
			log.error("===RSA NoSuchAlgorithmException : ",e.getMessage());
		} catch (InvalidKeySpecException e) {
			log.error("===RSA InvalidKeySpecException : ",e.getMessage());
		}
		return map;
	}
	
	public static String decryptRas(PrivateKey privateKey, String securedValue) {
		String decryptedValue = "";
		
		try {
			byte[] encryptedBytes = hexToByteArray(securedValue);
			Cipher cipher = Cipher.getInstance("RSA");
			cipher.init(Cipher.DECRYPT_MODE, privateKey);
			byte[] decryptedBytes = cipher.doFinal(encryptedBytes);
			decryptedValue = new String(decryptedBytes, "utf-8");
			
		} catch (NoSuchAlgorithmException e) {
			log.error("===RSA decryptRas NoSuchAlgorithmException : ",e.getClass());
		} catch (NoSuchPaddingException e) {
			log.error("===RSA decryptRas NoSuchPaddingException : ",e.getClass());
		} catch (InvalidKeyException e) {
			log.error("===RSA decryptRas InvalidKeyException : ",e.getClass());
		} catch (IllegalBlockSizeException e) {
			log.error("===RSA decryptRas IllegalBlockSizeException : ",e.getClass());
		} catch (BadPaddingException e) {
			log.error("===RSA decryptRas BadPaddingException : ",e.getClass());
		} catch (UnsupportedEncodingException e) { 
			log.error("===RSA decryptRas UnsupportedEncodingException : ",e.getClass());
		}
		
		return decryptedValue;
	}
	
	public static byte[] hexToByteArray(String hex) {
		if(hex == null || hex.length() % 2  != 0) {
			return new byte[]{};
		}
		
		byte[] bytes = new byte[hex.length() / 2];
		for(int i = 0 ; i< hex.length() ; i+=2) {
			byte value = (byte)Integer.parseInt(hex.substring(i,i+2),16);
			bytes[(int) Math.floor(i/2)] = value;
		}
		return bytes;
			
	}
}
