package com.project.k51star.service;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.net.HttpURLConnection;
import java.net.URL;

import org.json.simple.JSONObject;
import org.json.simple.parser.JSONParser;
import org.json.simple.parser.ParseException;
import org.springframework.stereotype.Service;

@Service("com.project.k51star.parser")
public class Parser{
	private static URL url;
	private static BufferedReader br;
	private static HttpURLConnection con;
	
	public static void main(String[] args) throws IOException {
		
	}
	public static JSONObject parsing(String requesturl) throws IOException {
		url = new URL(requesturl);
		con = (HttpURLConnection) url.openConnection();
		con.setRequestMethod("GET");
		br = new BufferedReader(new InputStreamReader(con.getInputStream(),"UTF-8"));
		
		String tmp = "";
		while(true) {
			String temp = br.readLine();
			if(temp ==null) break;
			tmp += temp;
		}
//		System.out.println(tmp);
		JSONParser parser = new JSONParser();
		Object obj = null;

		try {
			obj = parser.parse(tmp);
		} catch (ParseException e) {
			e.printStackTrace();
		}
		JSONObject jsonObj = (JSONObject) obj;
//		System.out.println(jsonObj);
		br.close();
		
		return jsonObj;
	}
}