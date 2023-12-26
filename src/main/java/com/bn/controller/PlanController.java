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

import org.springframework.beans.factory.annotation.Value;
import org.springframework.context.annotation.PropertySource;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.bn.model.ContentVo;
import com.bn.model.DtailPlanVo;
import com.bn.model.PlanVo;
import com.bn.service.DbService;
import com.bn.service.PlanService;
import com.google.gson.JsonArray;
import com.google.gson.JsonObject;
import com.google.gson.JsonParser;

import lombok.extern.log4j.Log4j;



@Controller
@Log4j
@PropertySource("classpath:/config/props/apiKey.properties")
public class PlanController {
	
	@Inject
	private PlanService pservice;
	
	@Value("${NAVER_MAPS_KEY}")
	private String NAVER_MAPS_KEY;
	
	@Value("${NAVER_MAPS_SECRET_KEY}")
	private String NAVER_MAPS_SECRET_KEY;
	
	@Inject
	private DbService dService;
	
	private PlanVo pvo;
	
	private ContentVo cvo;

	@GetMapping("/plan")
	public String plan(Model model) {
		model.addAttribute("NAVER_MAPS_KEY", NAVER_MAPS_KEY);
		model.addAttribute("NAVER_MAPS_SECRET_KEY", NAVER_MAPS_SECRET_KEY);
		return "plan";
	}
	
	@ResponseBody
	@RequestMapping("/plan")
	public String saveplan(@RequestBody PlanVo vo) {
		System.out.println(vo);
		int n=pservice.insert(vo);
		String x="plan";
	
		
		return x;
	}
	@ResponseBody
	@RequestMapping("/myplan")
	public ModelMap myplan(@RequestParam("p_id") int p_id) {
		System.out.println(p_id);
		ModelMap map=new ModelMap();
		pvo=pservice.selectPlan(p_id);
		map.addAttribute("vo",pvo);
		return map;
	}
	@ResponseBody
	@RequestMapping("/memberplan")
	public ModelMap memberplan(@RequestParam("m_id") int m_id) {
		System.out.println(m_id);
		ModelMap map=new ModelMap();
		List<PlanVo> lvo=pservice.selectAll(m_id);
		map.addAttribute("lvo",lvo);
		return map;
	}
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
			log.error("search error: "+e);
			map.addAttribute("error", "Error occurred");
		}
		
		return map;
	}
	@ResponseBody
	@RequestMapping("/tour")
	public ModelMap showinfo (@RequestParam String x,@RequestParam String y, @RequestParam(required = false) String ctype,@RequestParam(required=false)String cat) {
		ModelMap map=new ModelMap();
		try {
		Map<String,Object> cd=new HashMap<>();
		double mapx=Double.parseDouble(x);
		double mapy=Double.parseDouble(y);
		cd.put("mapx",mapx);
		cd.put("mapy",mapy);
		cd.put("ctype", ctype);
		cd.put("cat", cat);
		List<ContentVo>nd=dService.searchInRange(cd);
		map.addAttribute("contentList",nd);
		System.out.println("controller:" +nd.size());
		//cd.put("contentList.get(ContentVo).size", map.get(ContentVo));
		}catch (NumberFormatException e) {
	        // �닽�옄 蹂��솚 以� �삁�쇅 諛쒖깮 �떆 泥섎━
	        map.addAttribute("error", "Invalid coordinates. Please provide valid numeric values for x and y.");
	        e.printStackTrace(); // �삁�쇅 濡쒓렇 異쒕젰 (媛쒕컻 以묒뿉留� �궗�슜, �슫�쁺�뿉�꽌�뒗 濡쒓퉭 �떆�뒪�뀥 �솢�슜)
	    } catch (Exception e) {
	        // �떎瑜� �삁�쇅 諛쒖깮 �떆 泥섎━
	        map.addAttribute("error", "An unexpected error occurred.");
	        e.printStackTrace(); // �삁�쇅 濡쒓렇 異쒕젰 (媛쒕컻 以묒뿉留� �궗�슜, �슫�쁺�뿉�꽌�뒗 濡쒓퉭 �떆�뒪�뀥 �솢�슜)
	    }
		return map;
	}
	
	


	
    @ResponseBody
    @PostMapping("/registercontent")
	public int registcontent(@RequestParam ContentVo cvo) {
    	int n=dService.insertdb(cvo);
    	
    	return n;
    }
    @ResponseBody
    @PostMapping("/dpsave")
    public int dtailplan(@RequestParam DtailPlanVo vo) {
    	int n=pservice.insertdp(vo);
    	
    	return n;
    }
    @ResponseBody
    @PostMapping("/dpretrieve")
    public int dtailplanretrieve(@RequestParam DtailPlanVo vo) {
    	int n=pservice.insertdp(vo);
    	
    	return n;
    }
    
}
