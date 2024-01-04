package com.bn.controller;

import java.io.BufferedReader;
import java.io.InputStreamReader;
import java.net.HttpURLConnection;
import java.net.URL;
import java.net.URLEncoder;
import java.nio.charset.StandardCharsets;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.bn.model.CityVo;
import com.bn.model.ContentVo;
import com.bn.service.InfoService;
import com.google.gson.JsonArray;
import com.google.gson.JsonObject;
import com.google.gson.JsonParser;

import lombok.extern.log4j.Log4j;

@Log4j
@Controller
public class InfoController {
	
	@Autowired
	private InfoService is;
	
	private ContentVo convo;
	private CityVo civo;
	
	//------------------------ main.jsp �룄�떆 紐⑸줉�쓽 info踰꾪듉 �겢由��떆 �슂泥��쓣 諛쏅룄濡� �꽕怨� -----------------------------
	@RequestMapping("/cityInfo")
	public String cityInfo(@RequestParam String cityname, Model model) {
		
		civo=null;
		civo=is.getCityData(cityname);
		String cname=civo.getCityname();
		//select overview from content where contentid=${contentid} �쓽 諛섑솚媛�(�슂泥��맂 contentid�쓽 overview�씠 �엳�뒗吏� �솗�씤�븯�뒗 �븿�닔)
		if(cname==null) {
			System.out.println("CITYNAME is empty!! Check your DB");
		}else {
		}
		model.addAttribute("civo",civo);
		
		return "cityInfo";
	}
	//----------------------------------------------------------------------------------------------------
	
	//---------------------- plan�뿉�꽌 寃��깋�맂 愿�愿묒� 紐⑸줉�쓽 info踰꾪듉 �겢由��떆 �슂泥��쓣 諛쏅룄濡� �꽕怨� -------------------------
	@RequestMapping("/tourInfo")
	public String tourInfo(@RequestParam String contentid, Model model) {
		
		convo=null;
		convo=is.getTourData(contentid);
		
		//select overview from content where contentid=${contentid} �쓽 諛섑솚媛�(�슂泥��맂 contentid�쓽 overview�씠 �엳�뒗吏� �솗�씤�븯�뒗 �븿�닔)
		String exist = is.existOverview(contentid);
		if(exist==null) {
			System.out.println("Overview is empty!! I'll bring it from API");
			overviewfill(contentid);
		}else {
		}
		model.addAttribute("convo",convo);
		
		return "tourInfo";
	}
	//-------------------------------------------------------------------------------------------------
	
	// --------------- db�뿉�꽌 overview而щ읆�쓽 �뜲�씠�꽣媛� 議댁옱�븯吏� �븡�떎硫� api�뿉�꽌 �뜲�씠�꽣瑜� �궡�젮諛쏅뒗 湲곕뒫�쓣 �떎�뻾 --------------
	private String overviewfill(String contentid) {
		
		String result="";
		
		try {
			String pkey="g+INH4ICelRYTwvUPjujUIt/O1i9eSZAmhiCR9xJLT3v4P4aNkdXnRnDCkDGMKIdpXvJPsGJ9I5HTG6T2lmjkg==";
			String key = URLEncoder.encode(pkey, "UTF-8");
			String apiURL="https://apis.data.go.kr/B551011/KorService1/detailCommon1?MobileOS=ETC&MobileApp=2clipse&_type=json&contentId="+contentid+"&defaultYN=Y&firstImageYN=Y&areacodeYN=Y&catcodeYN=Y&addrinfoYN=Y&mapinfoYN=Y&overviewYN=Y&serviceKey="+key;
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
							
							convo.setOverview(overview);
							
							log.info("vo.setOverview(overview) : "+convo);
							
							result = convo.toString();
							
							if(overview!=null) {
								int n= is.insertOverview(convo);
							}else {
								System.out.println("占쏙옙占쏙옙占싶곤옙 占쏙옙占쏙옙占싹댐옙.");
							}
						}
					} else {
						System.out.println("占쏙옙占쏙옙占싶곤옙 占쏙옙占쏙옙占싹댐옙.");
					}
				} else {
					System.out.println("API 占쏙옙청占쏙옙 占쏙옙占쏙옙占쌩쏙옙占싹댐옙.");
				}
			} else {
				System.out.println("API 占쏙옙청占쏙옙 占쏙옙占쏙옙占쌩쏙옙占싹댐옙. 占쏙옙占쏙옙 占쌘듸옙: " + responseCode);
			}
		}catch(Exception e){
			e.printStackTrace();
		}
	return result;
	}
	//-------------------------------------------------------------------------------------------------
	
	/*
	//TourInfo.jsp �럹�씠吏�媛� �샇異쒕맂 吏곹썑 �떎�뻾�릺�뒗 function(contentid)�쓣 �넻�빐 /existOverview?contentid=#{contentid} �쓽 �삎�떇�쑝濡� �뙆�씪誘명꽣瑜� 諛쏆븘
	@ResponseBody
	@RequestMapping("/existOverview")
	private String existOverview(String contentid) {
		String exist = ti.existOverview(contentid);
		if(exist==null) {
			overviewfill(contentid);
		}
		System.out.println("Overview data is already exist!! I'll show you Tourinfo");
		return "";
	}
	*/
	
}
