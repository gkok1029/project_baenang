package com.bn.controller;

import java.io.BufferedReader;
import java.io.InputStreamReader;
import java.net.HttpURLConnection;
import java.net.URL;
import java.net.URLEncoder;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.inject.Inject;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.context.annotation.PropertySource;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.ui.ModelMap;
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
public class ScheduleController {

	private Logger log = LoggerFactory.getLogger(getClass());

	@Value("${NAVER_MAPS_KEY}")
	private String NAVER_MAPS_KEY;

	@Value("${NAVER_MAPS_SECRET_KEY}")
	private String NAVER_MAPS_SECRET_KEY;
	
   
	
	@RequestMapping("/showMap")
	public String showMap(Model model) {
	
		
		Map<String,String>map=new HashMap<>();
		map.put("clientId", NAVER_MAPS_KEY);
		map.put("clientSecret", NAVER_MAPS_SECRET_KEY);
		model.addAttribute("apikey",map);
		return "plan";
	}
	@Inject
	private DbService dService;
	
	
	private ContentVo vo;
	
	@ResponseBody
	@RequestMapping("/search")
	public ModelMap search(@RequestParam String addr) {
		ModelMap map = new ModelMap();
		try {
			String text = URLEncoder.encode(addr, "UTF-8");
			log.info(addr);

			String apiURL = "https://naveropenapi.apigw.ntruss.com/map-geocode/v2/geocode?query=" + text;
			URL url = new URL(apiURL);
			HttpURLConnection conn = (HttpURLConnection) url.openConnection();
			conn.setUseCaches(false);
			conn.setDoOutput(true);
			conn.setDoInput(true);
			conn.setRequestProperty("Content-Type", "text/plain");
			conn.setRequestProperty("X-NCP-APIGW-API-KEY-ID", NAVER_MAPS_KEY);
			conn.setRequestProperty("X-NCP-APIGW-API-KEY", NAVER_MAPS_SECRET_KEY);
			int responseCode = conn.getResponseCode();
			if (responseCode == 200) {
				BufferedReader in = new BufferedReader(new InputStreamReader(conn.getInputStream()));
				String inputLine;
				StringBuilder response = new StringBuilder();
				while ((inputLine = in.readLine()) != null) {
					response.append(inputLine);
				}
				in.close();

				JsonObject jsonResponse = JsonParser.parseString(response.toString()).getAsJsonObject();
				JsonArray addresses = jsonResponse.getAsJsonArray("addresses");

				if (addresses.size() > 0) {
					JsonObject firstAddress = addresses.get(0).getAsJsonObject();
					String x = firstAddress.get("x").getAsString();
					String y = firstAddress.get("y").getAsString();
					map.addAttribute("x", x);
					map.addAttribute("y", y);
				} else {
					String x = jsonResponse.get("x").getAsString();
					String y = jsonResponse.get("y").getAsString();
					map.addAttribute("x", x);
					map.addAttribute("y", y);
				}
			}
		} catch (Exception e) {
			log.error("search error: {}", e.getMessage());
			map.addAttribute("error", "Error occurred");
		}
		
		return map;
	}
	@ResponseBody
	@RequestMapping("/tour")
	public ModelMap showinfo (@RequestParam String x,@RequestParam String y) {
		ModelMap map=new ModelMap();
		try {
		Map<String,Double> cd=new HashMap<>();
		double mapx=Double.parseDouble(x);
		double mapy=Double.parseDouble(y);
		cd.put("mapx",mapx);
		cd.put("mapy",mapy);
		List<ContentVo>nd=dService.searchInRange(cd);
		map.addAttribute("contentList",nd);
		//cd.put("contentList.get(ContentVo).size", map.get(ContentVo));
		System.out.println(map.toString());
		}catch (NumberFormatException e) {
	        // ���� ��ȯ �� ���� �߻� �� ó��
	        map.addAttribute("error", "Invalid coordinates. Please provide valid numeric values for x and y.");
	        e.printStackTrace(); // ���� �α� ��� (���� �߿��� ���, ������� �α� �ý��� Ȱ��)
	    } catch (Exception e) {
	        // �ٸ� ���� �߻� �� ó��
	        map.addAttribute("error", "An unexpected error occurred.");
	        e.printStackTrace(); // ���� �α� ��� (���� �߿��� ���, ������� �α� �ý��� Ȱ��)
	    }
		return map;
	}
	
	
}