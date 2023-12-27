package com.bn.controller;

import java.io.BufferedReader;
import java.io.InputStreamReader;
import java.net.HttpURLConnection;
import java.net.URL;
import java.net.URLEncoder;
import java.nio.charset.StandardCharsets;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.bn.model.ContentVo;
import com.bn.service.TourInfoService;
import com.google.gson.JsonArray;
import com.google.gson.JsonObject;
import com.google.gson.JsonParser;

import lombok.extern.log4j.Log4j;

@Log4j
@Controller
public class TourInfoController {
	
	@Autowired
	private TourInfoService ti;
	
	@RequestMapping("/tourInfo")
	public List<ContentVo> tourInfo(@RequestParam String title, Model model) {
		
		List<ContentVo> vo=null;
		vo=ti.getCityData(title);
		
		model.addAttribute("vo",vo);
		log.info(vo);
		
		return vo;
	}

	@ResponseBody
	@RequestMapping("/overviewdown")
	private String overviewfill() {
		try {
			String contentId;
			
			String pkey="g+INH4ICelRYTwvUPjujUIt/O1i9eSZAmhiCR9xJLT3v4P4aNkdXnRnDCkDGMKIdpXvJPsGJ9I5HTG6T2lmjkg==";
			String key = URLEncoder.encode(pkey, "UTF-8");
			String apiURL="https://apis.data.go.kr/B551011/KorService1/detailCommon1?MobileOS=ETC&MobileApp=2clipse&_type=json&contentId=127480&defaultYN=Y&firstImageYN=Y&areacodeYN=Y&catcodeYN=Y&addrinfoYN=Y&mapinfoYN=Y&overviewYN=Y&serviceKey="+key;
			URL url = new URL(apiURL);
			HttpURLConnection conn = (HttpURLConnection) url.openConnection();
			conn.setUseCaches(false);
			conn.setDoOutput(true);
			conn.setDoInput(true);
			conn.setRequestProperty("Content-Type", "text/plain");
			int responseCode = conn.getResponseCode();
			if (responseCode == 200) {
				BufferedReader in = new BufferedReader(new InputStreamReader(conn.getInputStream(),StandardCharsets.UTF_8));
				String inputLine;
				StringBuilder response = new StringBuilder();
				while ((inputLine = in.readLine()) != null) {
					response.append(inputLine);
				}
				in.close();
				
				JsonObject jsonResponse = JsonParser.parseString(response.toString()).getAsJsonObject();
				JsonObject responseHeader = jsonResponse.getAsJsonObject("response").getAsJsonObject("header");
				log.info(responseHeader.get("resultCode").toString());
				if ("0000".equals(responseHeader.get("resultCode").getAsString())) {
					JsonObject responseBody = jsonResponse.getAsJsonObject("response").getAsJsonObject("body");
					JsonArray items = responseBody.getAsJsonObject("items").getAsJsonArray("item");
					if (items.size() > 0) {
						for (int i = 0; i < items.size(); i++) {
							JsonObject item = items.get(i).getAsJsonObject();
							String overview = item.get("overview").getAsString();
							
							ContentVo vo=new ContentVo();
							vo.setFirstimage(overview);
							
							if(contentid!=null) {
								int n= ti.insertOverview(vo);
								System.out.println(n);
							}else {
								System.out.println("�����Ͱ� �����ϴ�.");
								
							}
						}
					} else {
						System.out.println("�����Ͱ� �����ϴ�.");
					}
				} else {
					System.out.println("API ��û�� �����߽��ϴ�.");
				}
			} else {
				System.out.println("API ��û�� �����߽��ϴ�. ���� �ڵ�: " + responseCode);
			}
		}catch(Exception e){
			log.error("error: {}",e.getMessage());
			
		}
	return "���¹ٺ���û�̾�";
	}
	
}
