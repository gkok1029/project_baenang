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

import org.apache.ibatis.reflection.SystemMetaObject;
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
	private PlanService pService;

	@Value("${NAVER_MAPS_KEY}")
	private String NAVER_MAPS_KEY;

	@Value("${NAVER_MAPS_SECRET_KEY}")
	private String NAVER_MAPS_SECRET_KEY;

	@Inject
	private DbService dService;

	private PlanVo pvo;

	private ContentVo cvo;
	
	private DtailPlanVo dpvo;

	@GetMapping("/plan")
	public String plan(Model model) {
		model.addAttribute("NAVER_MAPS_KEY", NAVER_MAPS_KEY);
		model.addAttribute("NAVER_MAPS_SECRET_KEY", NAVER_MAPS_SECRET_KEY);
		return "plan";
	}

	@ResponseBody
	@PostMapping("/plan")
	public String saveplan(@RequestBody PlanVo vo) {
		System.out.println(vo);
		int n = pService.insert(vo);
		String x = "plan";

		return x;
	}

	@ResponseBody
	@RequestMapping("/myplan")
	public ModelMap myplan(@RequestParam("p_id") int p_id) {
		System.out.println(p_id);
		ModelMap map = new ModelMap();
		pvo = pService.selectPlan(p_id);
		map.addAttribute("vo", pvo);
		return map;
	}

	@ResponseBody
	@RequestMapping("/memberplan")
	public ModelMap memberplan(@RequestParam("m_id") int m_id) {
		System.out.println(m_id);
		ModelMap map = new ModelMap();
		List<PlanVo> lvo = pService.selectAll(m_id);
		map.addAttribute("lvo", lvo);
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
			log.error("search error: " + e);
			map.addAttribute("error", "Error occurred");
		}

		return map;
	}

	@ResponseBody
	@RequestMapping("/tour")
	public ModelMap showinfo(@RequestParam String x, @RequestParam String y,
			@RequestParam(required = false) String ctype, @RequestParam(required = false) String cat) {
		ModelMap map = new ModelMap();
		try {
			Map<String, Object> cd = new HashMap<>();
			double mapx = Double.parseDouble(x);
			double mapy = Double.parseDouble(y);
			cd.put("mapx", mapx);
			cd.put("mapy", mapy);
			cd.put("ctype", ctype);
			cd.put("cat", cat);
			List<ContentVo> nd = dService.searchInRange(cd);
			map.addAttribute("contentList", nd);
				
			// cd.put("contentList.get(ContentVo).size", map.get(ContentVo));
		} catch (NumberFormatException e) {
			// 숫자 변환 중 예외 발생 시 처리
			map.addAttribute("error", "Invalid coordinates. Please provide valid numeric values for x and y.");
			e.printStackTrace(); // 예외 로그 출력 (개발 중에만 사용, 운영에서는 로깅 시스템 활용)
		} catch (Exception e) {
			// 다른 예외 발생 시 처리
			map.addAttribute("error", "An unexpected error occurred.");
			e.printStackTrace(); // 예외 로그 출력 (개발 중에만 사용, 운영에서는 로깅 시스템 활용)
		}
		return map;
	}

	@ResponseBody
	@PostMapping("/registercontent")
	public int registcontent(@RequestBody ContentVo cvo) {
		int n = dService.insertdb(cvo);

		return n;
	}

	/*
	 * @ResponseBody//요청을 보낼때 DtailPlan단위로 한번씩 호출
	 * 
	 * @PostMapping("/dpsave") public int dtailplan(@RequestBody DtailPlanVo vo) {
	 * int n = pService.insertdp(vo);
	 * 
	 * return n; }
	 */
	@ResponseBody//요청을 보낼때 한방에 가져와서 한번에 처리
	@PostMapping("/dpsave")
	public int dtailplan(@RequestBody List<DtailPlanVo> vo) {
		int n =0;
		int m=0;
		for(int i=0;i<vo.size()-1;i++) {
			n=pService.insertdp(vo.get(i));
			m+=n;
		}
		return m;
	}
	

	@GetMapping("/count")
	public void count(@RequestParam int contentid) {
		int n=dService.count(contentid);
		
	}
	
	@ResponseBody
	@GetMapping("/requestcat")
	public String reqcat(@RequestParam String string) {
		String a=dService.reqstring(string);
		
		
		
		return a;
	}
}