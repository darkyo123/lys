package egovframework.com.utl.fcc.service;

import java.io.UnsupportedEncodingException;
import java.security.InvalidAlgorithmParameterException;
import java.security.InvalidKeyException;
import java.security.Key;
import java.security.NoSuchAlgorithmException;
import java.security.spec.KeySpec;

import javax.crypto.BadPaddingException;
import javax.crypto.Cipher;
import javax.crypto.IllegalBlockSizeException;
import javax.crypto.NoSuchPaddingException;
import javax.crypto.SecretKey;
import javax.crypto.SecretKeyFactory;
import javax.crypto.spec.IvParameterSpec;
import javax.crypto.spec.SecretKeySpec;
import javax.crypto.spec.PBEKeySpec;

import org.apache.commons.codec.binary.Base64;
import org.apache.commons.codec.binary.Hex;

public class EgovAESDecoder {
	//private String iv;
    private Key keySpec;
    private static final int iterationCount = 10000;
    private static final int keySize = 128;
    private static String salt = "79752f1d3fd2432043c48e45b35b24645eb826a25c6f1804e9152665c345a552";
    private static String iv = "2fad5a477d13ecda7f718fbd8a9f0443";
    private static final String passPhrase = "passPhrase";

    public EgovAESDecoder(String key) throws UnsupportedEncodingException {
        /*this.iv = key.substring(0, 16);
        
        byte[] keyBytes = new byte[16];
        byte[] b = key.getBytes("UTF-8");
        int len = b.length;
        if (len > keyBytes.length) {
            len = keyBytes.length;
        }
        System.arraycopy(b, 0, keyBytes, 0, len);
        SecretKeySpec keySpec = new SecretKeySpec(keyBytes, "AES");
        
        this.keySpec = keySpec;*/
    }

    private SecretKey generateKey(String salt, String passPhrase) throws Exception {
        SecretKeyFactory factory = SecretKeyFactory.getInstance("PBKDF2WithHmacSHA1");
        KeySpec spec = new PBEKeySpec(passPhrase.toCharArray(), decodeHex(salt), iterationCount, keySize);
        SecretKey key = new SecretKeySpec(factory.generateSecret(spec).getEncoded(), "AES");
        return key;
    }

    // 암호화
    public String aesEncode(String str) throws java.io.UnsupportedEncodingException, 
                                                    NoSuchAlgorithmException, 
                                                    NoSuchPaddingException, 
                                                    InvalidKeyException, 
                                                    InvalidAlgorithmParameterException, 
                                                    IllegalBlockSizeException, 
                                                    BadPaddingException {
        Cipher c = Cipher.getInstance("AES/CBC/PKCS5Padding");
        c.init(Cipher.ENCRYPT_MODE, keySpec, new IvParameterSpec(iv.getBytes()));
 
        byte[] encrypted = c.doFinal(str.getBytes("UTF-8"));
        String enStr = new String(Base64.encodeBase64(encrypted));
 
        return enStr;
    }
 
    //복호화
    public String aesDecode(String str) throws java.io.UnsupportedEncodingException,
                                                        NoSuchAlgorithmException,
                                                        NoSuchPaddingException, 
                                                        InvalidKeyException, 
                                                        InvalidAlgorithmParameterException,
                                                        IllegalBlockSizeException, 
                                                        BadPaddingException {
        Cipher c = Cipher.getInstance("AES/CBC/PKCS5Padding");

        SecretKey key = null;
        byte[] decrypted = null;

        try {
			key = generateKey(salt, passPhrase);
			decrypted = doFinal(c, Cipher.DECRYPT_MODE, key, iv, Base64.decodeBase64(str));
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}

/*        c.init(Cipher.DECRYPT_MODE, keySpec, new IvParameterSpec(iv.getBytes("UTF-8")));
 
        byte[] byteStr = Base64.decodeBase64(str.getBytes());
        */
        
        return new String(decrypted,"UTF-8");
    }

    private static byte[] decodeHex(String str) throws Exception {
        return Hex.decodeHex(str.toCharArray());
    }

    private byte[] doFinal(Cipher c, int encryptMode, SecretKey key, String iv, byte[] bytes) throws Exception {
        c.init(encryptMode, key, new IvParameterSpec(decodeHex(iv)));
        return c.doFinal(bytes);
    }

}
