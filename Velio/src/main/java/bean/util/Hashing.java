package bean.util;

import java.security.MessageDigest;

public class Hashing {
	private final static String SALT = "salt";
	
	public static String encodeSHA256(String source) {
		String result = "";
		
		byte[] temp = source.getBytes();
		byte[] salt = SALT.getBytes();
		byte[] bytes = new byte[temp.length + salt.length];
		
		System.arraycopy(temp, 0, bytes, 0, temp.length);
		System.arraycopy(salt, 0, bytes, temp.length, salt.length);
		
		try {
			MessageDigest md = MessageDigest.getInstance("SHA-256");
			md.update(bytes);
			
			byte[] byteData = md.digest();
			
			StringBuilder sb = new StringBuilder();
			for(int i=0;i<byteData.length;i++) {
				sb.append(Integer.toString((byteData[i] & 0xFF) + 256, 16).substring(1));
			}
			
			result = sb.toString();
		} catch(Exception e) {
			e.printStackTrace();
		}
		return result;
	}
}
