package com.bn.controller;



import java.io.BufferedReader;
import java.io.InputStreamReader;
import java.net.HttpURLConnection;
import java.net.URL;
import java.net.URLEncoder;
import java.nio.charset.StandardCharsets;

import javax.inject.Inject;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.context.annotation.PropertySource;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.bn.model.ContentVo;
import com.bn.service.DbService;
import com.google.gson.JsonArray;
import com.google.gson.JsonObject;
import com.google.gson.JsonParser;

@Controller
@PropertySource("classpath:/config/props/apiKey.properties")
public class DbController {
	
	private Logger log=LoggerFactory.getLogger(getClass());
	
	@Inject
	private DbService dService;

	@GetMapping("/dbbutton")
	private String download() {
		
		return "dbbutton";
	}
	@ResponseBody
	@RequestMapping("/jdgdown")
	private String dbfill() {
		
		try {
			String pkey="${tourapikey}";
			String key = URLEncoder.encode(pkey, "UTF-8");
			String apiURL="https://apis.data.go.kr/B551011/KorService1/areaBasedList1?numOfRows=100000&pageNo=1&MobileOS=ETC&MobileApp=test&_type=json&serviceKey="+key;
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
				log.info("API 응답: " + response.toString());
				JsonObject jsonResponse = JsonParser.parseString(response.toString()).getAsJsonObject();
				JsonObject responseHeader = jsonResponse.getAsJsonObject("response").getAsJsonObject("header");
				if ("0000".equals(responseHeader.get("resultCode").getAsString())) {
					JsonObject responseBody = jsonResponse.getAsJsonObject("response").getAsJsonObject("body");
					JsonArray items = responseBody.getAsJsonObject("items").getAsJsonArray("item");

					if (items.size() > 0) {
						for (int i = 0; i < items.size(); i++) {
							JsonObject item = items.get(i).getAsJsonObject();
							String contentid=item.get("contentid").getAsString();
							String contenttypeid=item.get("contenttypeid").getAsString();
							String code = item.get("cat3").getAsString();
							String title = item.get("title").getAsString();
							String tel = item.get("tel").getAsString();
							String addr1 = item.get("addr1").getAsString();
							String addr2 = item.get("addr2").getAsString();
							String firstimage = item.get("firstimage").getAsString();
							String addr=addr1+addr2;
							String mapx=item.get("mapx").getAsString();
							String mapy=item.get("mapy").getAsString();
							
							
							ContentVo vo=new ContentVo(contentid,contenttypeid,code,title,tel,addr,firstimage,mapx,mapy);
							int n= dService.insertdb(vo);
						}
					} else {
						System.out.println("데이터가 없습니다.");
					}
				} else {
					System.out.println("API 요청이 실패했습니다.");
				}
			
		} else {
			System.out.println("API 요청이 실패했습니다. 응답 코드: " + responseCode);
		}
				


				
		}catch(Exception e){
			log.error("error: {}",e.getMessage());
			
		}
		
		return "나는바보멍청이야";
	}
	
}
