package egovframework.com.utl.fcc.service;

import org.jasypt.contrib.org.apache.commons.codec_1_3.binary.Base64;

import egovframework.rte.fdl.cryptography.EgovPasswordEncoder;
import egovframework.rte.fdl.cryptography.impl.EgovARIACryptoServiceImpl;

public class EgovAriaDecoder {

	public static byte[] decode(String value, String key) {
		EgovPasswordEncoder egovPasswordEncoder = new EgovPasswordEncoder();
		EgovARIACryptoServiceImpl egovARIACryptoServiceImpl = new EgovARIACryptoServiceImpl();

		String hasedPassword = egovPasswordEncoder.encryptPassword(key);
		egovPasswordEncoder.setHashedPassword(hasedPassword);
		egovPasswordEncoder.setAlgorithm("SHA-256");
		egovARIACryptoServiceImpl.setPasswordEncoder(egovPasswordEncoder);
		egovARIACryptoServiceImpl.setBlockSize(1025);
		
		byte[] decrypted = egovARIACryptoServiceImpl.decrypt(Base64.decodeBase64(value.getBytes()), key);
		return decrypted;
	}

	public static byte[] encode(String value, String key) {
		EgovPasswordEncoder egovPasswordEncoder = new EgovPasswordEncoder();
		EgovARIACryptoServiceImpl egovARIACryptoServiceImpl = new EgovARIACryptoServiceImpl();
		
		String hasedPassword = egovPasswordEncoder.encryptPassword(key);
		egovPasswordEncoder.setHashedPassword(hasedPassword);
		egovPasswordEncoder.setAlgorithm("SHA-256");
		egovARIACryptoServiceImpl.setPasswordEncoder(egovPasswordEncoder);
		egovARIACryptoServiceImpl.setBlockSize(1025);
		
		byte[] encrypted = egovARIACryptoServiceImpl.encrypt(value.getBytes(), key);
		return encrypted;
	}

}