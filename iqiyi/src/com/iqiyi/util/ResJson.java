package com.iqiyi.util;

import java.util.Map;
import java.util.TreeMap;

import net.sf.json.JSONObject;

/**
 * 返回json 封装
 * 
 */
public class ResJson {
	private Integer code = 200;

	private Map<String, Object> data = new TreeMap<String, Object>();

	public Map<String, Object> getData() {
		return data;
	}

	public void setData(Map<String, Object> data) {
		this.data = data;
	}

	public void putData(String key, Object value) {
		this.data.put(key, value);
	}

	public Integer getCode() {
		return code;
	}

	public void setCode(Integer code) {
		this.code = code;
	}

	@Override
	public String toString() {
		JSONObject json = JSONObject.fromObject(this);
		return json.toString();
	}
}
