package com.bn.controller;



import java.io.BufferedReader;
import java.io.InputStreamReader;
import java.net.HttpURLConnection;
import java.net.URL;
import java.net.URLEncoder;
import java.nio.charset.StandardCharsets;

import javax.inject.Inject;

import org.apache.ibatis.reflection.SystemMetaObject;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.context.annotation.PropertySource;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
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
			String pkey="g+INH4ICelRYTwvUPjujUIt/O1i9eSZAmhiCR9xJLT3v4P4aNkdXnRnDCkDGMKIdpXvJPsGJ9I5HTG6T2lmjkg==";
			String key = URLEncoder.encode(pkey, "UTF-8");
			String apiURL="https://apis.data.go.kr/B551011/KorService1/areaBasedList1?serviceKey="+key+"&numOfRows=100000&pageNo=1&MobileOS=ETC&MobileApp=test&_type=json";
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
							String contentid=item.get("contentid").getAsString();
							log.info(contentid);
							String contenttypeid=item.get("contenttypeid").getAsString();
							log.info(contenttypeid);
							String code = item.get("cat3").getAsString();
							log.info(code);
							String title = item.get("title").getAsString();
							String tel = item.get("tel").getAsString();
							String addr1 = item.get("addr1").getAsString();
							String addr2 = item.get("addr2").getAsString();
							String firstimage = item.get("firstimage").getAsString();
							String addr=addr1+addr2;
							String mapx=item.get("mapx").getAsString();
							String mapy=item.get("mapy").getAsString();
							
							ContentVo vo=new ContentVo();
							vo.setContentid(contentid);
							vo.setContenttypeid(contenttypeid);
							vo.setCode(code);
							vo.setTitle(title);
							vo.setTel(tel);
							vo.setAddr(addr);
							vo.setFirstimage(firstimage);
							vo.setMapx(mapx);
							vo.setMapy(mapy);
							if(contentid!=null) {
							int n= dService.insertdb(vo);
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
	
	@ResponseBody
	@RequestMapping("/jdgdown")
	private String dbuserfill(@RequestParam ModelMap map) {
		
		try {
			
			String contentid=map.getAttribute("contentid").toString();
			log.info(contentid);
			String contenttypeid=map.getAttribute("contenttypeid").toString();
			log.info(contenttypeid);
			String code = map.getAttribute("cat3").toString();
			log.info(code);
			String title = map.getAttribute("title").toString();
			String tel = map.getAttribute("tel").toString();
			String addr1 = map.getAttribute("addr1").toString();
			String addr2 = map.getAttribute("addr2").toString();
			String firstimage = map.getAttribute("firstimage").toString();
			String addr=addr1+addr2;
			String mapx=map.getAttribute("mapx").toString();
			String mapy=map.getAttribute("mapy").toString();
			
			ContentVo vo=new ContentVo();
			vo.setContentid(contentid);
			vo.setContenttypeid(contenttypeid);
			vo.setCode(code);
			vo.setTitle(title);
			vo.setTel(tel);
			vo.setAddr(addr);
			vo.setFirstimage(firstimage);
			vo.setMapx(mapx);
			vo.setMapy(mapy);
			System.out.println(vo);
			if(contentid!=null) {
			int n= dService.insertdb(vo);
			System.out.println(n);
			}else {
				System.out.println("�����Ͱ� �����ϴ�.");
				
			}
				
		}catch(Exception e){
			log.error("error: {}",e.getMessage());
			
		}
		
		return "���¹ٺ���û�̾�";
	}
	
}
