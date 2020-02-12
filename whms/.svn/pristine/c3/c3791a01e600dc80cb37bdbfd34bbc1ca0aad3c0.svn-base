package egovframework.com.utl.fcc.service;

import java.security.MessageDigest;

import org.apache.commons.codec.binary.Base64;
import javax.crypto.Cipher;
import javax.crypto.spec.IvParameterSpec;
import javax.crypto.spec.SecretKeySpec;

public class CryptoUtil {
	
	/**
	 * 해쉬 암호화(SHA-256)
	 * @param key
	 * @return
	 */
	public String encryptSHA256(String key) {
		StringBuffer hexString = new StringBuffer();

		try {
			MessageDigest digest = MessageDigest.getInstance("SHA-256");
			byte[] hash = digest.digest(key.getBytes("UTF-8"));

			for (int i = 0; i < hash.length; i++) {
				String hex = Integer.toHexString(0xff & hash[i]);
				if (hex.length() == 1) {
					hexString.append('0');
				}
				hexString.append(hex);
			}

			return hexString.toString();
		} catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
			
			return null;
		}
	}

	/**
	 * 대칭키 암호화(AES-128)
	 * @param key
	 * @param message
	 * @return
	 */
	public String encryptAES128(String masterKey, String message) {
		try {
			SecretKeySpec skeySpec = new SecretKeySpec(hexToByteArray(masterKey.substring(0, 32)), "AES");
			IvParameterSpec iv = new IvParameterSpec(hexToByteArray(masterKey.substring(32, 64)));

			Cipher cipher = Cipher.getInstance("AES/CBC/PKCS5Padding");
			cipher.init(Cipher.ENCRYPT_MODE, skeySpec, iv);
			byte[] encrypted = cipher.doFinal(message.getBytes());

			//return new String(Base64.encodeBase64(encrypted, true, true));
			return Base64.encodeBase64URLSafeString(encrypted);
		} catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
			
			return null;
		}
	}

	/**
	 * 대칭키 복호화(AES-128)
	 * @param key
	 * @param message
	 * @return
	 */
	public String decryptAES128(String masterKey, String message) {
		try {
			SecretKeySpec skeySpec = new SecretKeySpec(hexToByteArray(masterKey.substring(0, 32)), "AES");
			IvParameterSpec iv = new IvParameterSpec(hexToByteArray(masterKey.substring(32, 64)));

			Cipher cipher = Cipher.getInstance("AES/CBC/PKCS5Padding");
			cipher.init(Cipher.DECRYPT_MODE, skeySpec, iv);
			byte[] base64decodded = Base64.decodeBase64(message.getBytes());
			byte[] decrypted = cipher.doFinal(base64decodded);

			String result = new String(decrypted, "UTF-8");

			return result;
		} catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
			
			return null;
		}
	}

	public String decryptAES128Etc(String masterKey, String message) {
		try {
			SecretKeySpec skeySpec = new SecretKeySpec(hexToByteArray(masterKey.substring(0, 32)), "AES");
			IvParameterSpec iv = new IvParameterSpec(hexToByteArray(masterKey.substring(32, 64)));

			Cipher cipher = Cipher.getInstance("AES/CBC/PKCS5Padding");
			cipher.init(Cipher.DECRYPT_MODE, skeySpec, iv);
			byte[] base64decodded = Base64.decodeBase64(message.getBytes());
			byte[] decrypted = cipher.doFinal(base64decodded);

			String result = new String(decrypted, "EUC-KR");

			return result;
		} catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
			
			return null;
		}
	}

	private String byteArrayToHex(byte[] encrypted) {
		if (encrypted == null || encrypted.length == 0) {
			return null;
		}

		StringBuffer sb = new StringBuffer(encrypted.length * 2);
		String hexNumber;

		for (int x = 0; x < encrypted.length; x++) {
			hexNumber = "0" + Integer.toHexString(0xff & encrypted[x]);
			sb.append(hexNumber.substring(hexNumber.length() - 2));
		}

		return sb.toString();
	}

	private byte[] hexToByteArray(String hex) {
		if (hex == null || hex.length() == 0) {
			return null;
		}

		// 16진수 문자열을 byte로 변환
		byte[] byteArray = new byte[hex.length() / 2];

		for (int i = 0; i < byteArray.length; i++) {
			byteArray[i] = (byte) Integer.parseInt(hex.substring(2 * i, 2 * i + 2), 16);
		}
		return byteArray;
	}

}
