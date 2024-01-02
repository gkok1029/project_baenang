package com.bn.controller;


import java.util.Collections;
import java.util.Comparator;
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
	public String plan(@RequestParam String search,Model model,HttpSession session) {
		model.addAttribute("NAVER_MAPS_KEY", NAVER_MAPS_KEY);
		model.addAttribute("NAVER_MAPS_SECRET_KEY", NAVER_MAPS_SECRET_KEY);
		cityvo=pservice.cityloc(search);
		session.setAttribute("cityvo", cityvo);
		return "plan";
	}
	@PostMapping("/plan")
	public String saveplan(@RequestBody PlanVo vo,Model model) {
		int n=pservice.insert(vo);
		return "NewFile";
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
	        // 占쎈떭占쎌쁽 癰귨옙占쎌넎 餓ο옙 占쎌굙占쎌뇚 獄쏆뮇源� 占쎈뻻 筌ｌ꼶�봺
	        map.addAttribute("error", "Invalid coordinates. Please provide valid numeric values for x and y.");
	        e.printStackTrace(); // 占쎌굙占쎌뇚 嚥≪뮄�젃 �빊�뮆�젾 (揶쏆뮆而� 餓λ쵐肉됵쭕占� 占쎄텢占쎌뒠, 占쎌뒲占쎌겫占쎈퓠占쎄퐣占쎈뮉 嚥≪뮄�돪 占쎈뻻占쎈뮞占쎈�� 占쎌넞占쎌뒠)
	    } catch (Exception e) {
	        // 占쎈뼄�몴占� 占쎌굙占쎌뇚 獄쏆뮇源� 占쎈뻻 筌ｌ꼶�봺
	        map.addAttribute("error", "An unexpected error occurred.");
	        e.printStackTrace(); // 占쎌굙占쎌뇚 嚥≪뮄�젃 �빊�뮆�젾 (揶쏆뮆而� 餓λ쵐肉됵쭕占� 占쎄텢占쎌뒠, 占쎌뒲占쎌겫占쎈퓠占쎄퐣占쎈뮉 嚥≪뮄�돪 占쎈뻻占쎈뮞占쎈�� 占쎌넞占쎌뒠)
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
    	return "redirect:/main";
    }
    
    
    @GetMapping("/dpretrieve")
    public String dtailplanretrieve(@RequestParam String p_id,Model model) {
    		List<DtailPlanVo>Lvo=pservice.dpretrieve(p_id);
    		 System.out.println(Lvo.size());
    		 model.addAttribute("dplvo",Lvo);
    	return "detail";
    }
    
    @GetMapping("/NewFile")
    public String go(Model model,HttpSession session) {
    	model.addAttribute("p_id",pservice.seq());
    	model.addAttribute("m_id",session.getAttribute("m_id"));
    	model.addAttribute("hotels",session.getAttribute("hotels"));
    	model.addAttribute("places",session.getAttribute("places"));
    	model.addAttribute("startday",session.getAttribute("startday"));
    	model.addAttribute("endday",session.getAttribute("endday"));    	
    	model.addAttribute("pname",session.getAttribute("pname"));
    	return "/NewFile";
    }

    @PostMapping("/NewFile")
    public String view4(@RequestBody PlaceDTO mydata, HttpSession session) {
       String si=(String)session.getAttribute("userEmail");
       mvo=mService.getProfile(si);
       session.setAttribute("m_id",mvo.getM_ID());
       session.setAttribute("pname", mydata.getPname());
       session.setAttribute("hotels",mydata.getHotel());
       session.setAttribute("places",mydata.getPlace());
       session.setAttribute("startday",mydata.getStartdate());
       session.setAttribute("endday",mydata.getEnddate());
       return "redirect:/NewFile";
    }
    @ResponseBody
    @RequestMapping("/countup")
    public void countup(@RequestParam String contentid) {
    	
    	dService.countup(contentid);
    }
    @ResponseBody
    @GetMapping("/contentload")
    public ContentVo contentload(@RequestParam String contentid) {
    	System.out.println(contentid);
    	cvo=dService.contentload(contentid);
    	System.out.println(cvo);
    	return cvo;
    }

}
