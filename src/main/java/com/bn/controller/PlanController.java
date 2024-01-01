package com.bn.controller;


import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.inject.Inject;
import javax.servlet.http.HttpSession;

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

import com.bn.model.CityVo;
import com.bn.model.ContentVo;
import com.bn.model.DtailPlanVo;
import com.bn.model.MemberVo;
import com.bn.model.PlaceDTO;
import com.bn.model.PlanVo;
import com.bn.service.DbService;
import com.bn.service.MemberService;
import com.bn.service.PlanService;

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
	
	@Inject
	private MemberService mService;
	
	private PlanVo pvo;
	
	private ContentVo cvo;
	
	private DtailPlanVo dvo;
	
	private CityVo cityvo;
	
	private MemberVo mvo;

	@GetMapping("/plan")
	public String plan(@RequestParam String search,Model model) {
		model.addAttribute("NAVER_MAPS_KEY", NAVER_MAPS_KEY);
		model.addAttribute("NAVER_MAPS_SECRET_KEY", NAVER_MAPS_SECRET_KEY);
		cityvo=pservice.cityloc(search);
		model.addAttribute("cityvo",cityvo);
		return "plan";
	}
	@PostMapping("/plan")
	public String saveplan(@RequestBody PlanVo vo,Model model) {
		int n=pservice.insert(vo);
		return "NewFile";
	}


	@RequestMapping("/date")
	public String saan() {
		
	
		
		return "drag";
	}
	
	@PostMapping("/date2")
	public void saa(@RequestBody Map<String,String> date) {
		System.out.println(date);
		
		
		
	}
	
	
	@ResponseBody
	@RequestMapping("/myplan")
	public ModelMap myplan(@RequestParam("p_id") int p_id) {
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
	@RequestMapping("/tour")
	public ModelMap showinfo (@RequestParam String x,@RequestParam String y,@RequestParam(required=false)String cat, @RequestParam(required=false)String ctype,HttpSession session) {
		ModelMap map=new ModelMap();
		try {
		Map<String,Object> cd=new HashMap<>();
		double mapx=Double.parseDouble(x);
		double mapy=Double.parseDouble(y);
		cd.put("mapx",mapx);
		cd.put("mapy",mapy);
		cd.put("cat", cat);
		cd.put("ctype", ctype);
		List<ContentVo>nd=dService.searchInRange(cd);
		map.addAttribute("contentList",nd);
		session.setAttribute("contentList",nd);
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
    
    
    
    @PostMapping("/dpsave")
    public String dtailplan(@RequestBody List<DtailPlanVo> Lvo) {
    	int n =0;
    	for(int i=0;i<Lvo.size();i++) {
    		dvo=Lvo.get(i);
    		n=pservice.insertDp(dvo);
    	}
    	return "forward:/main.jsp";
    }
    
    
    @PostMapping("/dpretrieve")
    public List<DtailPlanVo> dtailplanretrieve(@RequestParam String p_id) {
    		List<DtailPlanVo>Lvo=pservice.dpretrieve(p_id);
    	
    	
    	return Lvo;
    }
    	
    
    @GetMapping("/NewFile")
    public String go(Model model,HttpSession session) {
    	String si=(String)session.getAttribute("userEmail");
    	mvo=mService.getProfile(si);
        model.addAttribute("m_id",mvo.getM_ID()); 
        model.addAttribute("p_id",pservice.seq());
    	return "NewFile";
    }

    
    @PostMapping("/NewFile")
    public String view4(@RequestBody PlaceDTO mydata,Model model, HttpSession session) {
       model.addAttribute("mydata",mydata);
       String si=(String)session.getAttribute("userEmail");
       mvo=mService.getProfile(si);
       model.addAttribute("m_id",mvo.getM_ID()); 
       return "/NewFile";
    }
    @ResponseBody
    @RequestMapping("/countup")
    public void countup(@RequestParam String contentid) {
    	
    	dService.countup(contentid);
    }
    

}
