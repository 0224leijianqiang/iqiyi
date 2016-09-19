package com.iqiyi.util;

import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.UUID;
/**
 * UUID生成
 * @author Herbert
 *
 */
public class UuidUtil {

	public static String get32UUID() {
		String uuid = UUID.randomUUID().toString().trim().replaceAll("-", "");
		return uuid;
	}
	public static String getTIMEUUID(){
		SimpleDateFormat sdf =new SimpleDateFormat("yyyyMMddHHmmssSSSS");
		return sdf.format(new Date());
	}
	public static void main(String[] args) {
		System.out.println(get32UUID());
		System.err.println(getTIMEUUID());
	}
}

