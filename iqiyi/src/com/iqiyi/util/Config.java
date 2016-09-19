package com.iqiyi.util;

import java.io.FileNotFoundException;
import java.io.IOException;
import java.util.Properties;

/**
 * 类名称：PropertyConfig
 * 修改备注：
 * 
 * @version 1.0.0
 */
public class Config {
	public Config() {
	}

	private static Properties props = new Properties();
	static {
		try {
			props = PropertiesUtils.loadProperties("application.properties");
		} catch (FileNotFoundException e) {
			e.printStackTrace();
		} catch (IOException e) {
			e.printStackTrace();
		}
	}

	public static String getValue(String key) {
		return props.getProperty(key).trim();
	}

	public static void updateProperties(String key, String value) {
		props.setProperty(key, value);
	}
}
