package com.bn.controller;


import java.io.BufferedReader;
import java.io.InputStreamReader;
import java.net.HttpURLConnection;
import java.net.URL;
import java.net.URLEncoder;
import java.util.ArrayList;
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
		System.out.println(nd.toString());
		//cd.put("contentList.get(ContentVo).size", map.get(ContentVo));
		}catch (NumberFormatException e) {
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
    @ResponseBody
    @RequestMapping("/makeschedule")
    public String[] makeschedule() {
    	String[] result={"126.4946032358,33.2620894948","126.7640945189,33.4734065616", "126.5238756154,33.5118484611",
                "126.5867476162,33.5255451704", "126.3809026350,33.4810246035"};
    	 //List<List<String>> permutations = generateAllPermutations(xy);
    	System.out.println("ㅎㅇ");
    	 toselectschedule("126.4946032358,33.2620894948","126.7640945189,33.4734065616");
		System.out.println("gd");	
    	 /*
			 * for (List<String> permutation : permutations) { // 각 순열에서 mapx와 mapy 값을 분리하여
			 * 출력 for (String destination : permutation) { String[] parts =
			 * destination.split(", "); toselectschedule(parts[0],parts[1]);
			 * toselectschedule(parts[1],parts[2]); toselectschedule(parts[2],parts[3]);
			 * toselectschedule(parts[3],parts[4]);
			 * 
			 * }
			 * 
			 * }
			 */
     
    	
    	return result;
    }
    public static List<List<String>> generateAllPermutations(String[] destinations) {
        List<List<String>> result = new ArrayList<>();
        generatePermutations(destinations, 0, result);
        return result;
    }
    private static void generatePermutations(String[] destinations, int currentIndex, List<List<String>> result) {
        if (currentIndex == destinations.length - 1) {
            // 배열의 끝에 도달하면 현재 상태를 결과에 추가
            List<String> permutation = new ArrayList<>();
            for (String destination : destinations) {
                permutation.add(destination);
            }
            result.add(permutation);
            return;
        }

        for (int i = currentIndex; i < destinations.length; i++) {
            // 배열의 각 요소와 현재 위치의 요소를 교환하지 않고 그대로 사용
            // 재귀적으로 다음 위치의 순열을 생성
            generatePermutations(destinations, currentIndex + 1, result);
        }
    }
    public int toselectschedule(String part1,String part2){
    	try {
    		System.out.println("part1:"+part1);
    		System.out.println("part2:"+part2);
			String text = URLEncoder.encode(part1, "UTF-8");
			String text2 = URLEncoder.encode(part2, "UTF-8");
    		System.out.println("ㅎㅇ1");
			String apiURL = "https://naveropenapi.apigw.ntruss.com/map-direction/v1/driving?start={"+part1+"}&goal={"+part2+"}";
			System.out.println(apiURL);
			URL url = new URL(apiURL);
			HttpURLConnection conn = (HttpURLConnection)url.openConnection();
			conn.setUseCaches(false);
			conn.setDoOutput(true);
			conn.setDoInput(true);
			conn.setRequestProperty("Content-Type", "text/plain");
			conn.setRequestProperty("X-NCP-APIGW-API-KEY-ID", NAVER_MAPS_KEY);
			conn.setRequestProperty("X-NCP-APIGW-API-KEY", NAVER_MAPS_SECRET_KEY);
			int responseCode = conn.getResponseCode();
			System.out.println(responseCode);
			if (responseCode == 200) {
				BufferedReader in = new BufferedReader(new InputStreamReader(conn.getInputStream()));
				String inputLine;
				StringBuilder response = new StringBuilder();
				while ((inputLine = in.readLine()) != null) {
					response.append(inputLine);
				}
				in.close();

				JsonObject jsonResponse = JsonParser.parseString(response.toString()).getAsJsonObject();
				System.out.println("gd2");
				System.out.println(jsonResponse.toString());
				JsonArray addresses = jsonResponse.getAsJsonArray("addresses");

				if (addresses.size() > 0) {
					JsonObject firstAddress = addresses.get(0).getAsJsonObject();
					String x = firstAddress.get("x").getAsString();
					String y = firstAddress.get("y").getAsString();
					
				} else {
					
				}
			}
		} catch (Exception e) {
			log.error("search error: "+e);
		}
    	
    	
    return 1;	
    }
    
}
