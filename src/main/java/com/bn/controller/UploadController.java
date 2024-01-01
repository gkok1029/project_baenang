package com.bn.controller;
import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.net.http.HttpHeaders;
import java.nio.file.Files;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.UUID;
import javax.servlet.ServletContext;
import javax.servlet.http.HttpSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.*;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.util.FileCopyUtils;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.context.annotation.RequestScope;
import org.springframework.web.multipart.MultipartFile;
import com.bn.model.AttachFileDto;
import com.bn.service.PostService;
import lombok.extern.log4j.Log4j;
import net.coobird.thumbnailator.Thumbnailator;
@Controller
@Log4j
public class UploadController {
	
	@Autowired
	private PostService postservice;
	
	@GetMapping("/upload")
	public void upload() {
		log.info("upload");
	}
	
	private boolean checkImageType(File file) {
		try {
			String contentType = Files.probeContentType(file.toPath());
			
			return contentType.startsWith("image");
		} catch (IOException e) {
			e.printStackTrace();
		}
		return false;
	}
	
	private String getFolder() {
	    SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
	    Date date = new Date();
	    String str = sdf.format(date);
	    return str.replace("-", File.separator);
	}
	
	@PostMapping(value = "/uploadAction", produces = MediaType.APPLICATION_JSON_UTF8_VALUE)
	@ResponseBody
	public ResponseEntity<List<AttachFileDto>> uploadPost(MultipartFile[] uploadFile, HttpSession session) {
		log.info("update post...");
		
		List<AttachFileDto> list = new ArrayList<>();
		ServletContext app=session.getServletContext();
		String upDir=app.getRealPath("/resources/postImage");
		
		File uploadPath = new File(upDir);
		log.info("upload path: " + upDir);
	
		if (uploadPath.exists() == false) {
			uploadPath.mkdirs();
		}//날짜별 폴더 생성
		
		
		
		for (MultipartFile multipartFile : uploadFile) {
			
			AttachFileDto attachDTO = new AttachFileDto();
			String uploadFileName = multipartFile.getOriginalFilename();
			String extension = uploadFileName.substring(uploadFileName.lastIndexOf(".") + 1);
			UUID uuid = UUID.randomUUID();
			uploadFileName = uuid.toString() + "_" + uploadFileName;
			attachDTO.setI_name(uploadFileName);
			attachDTO.setI_name2(extension);
			attachDTO.setI_path(upDir);
			postservice.imgInsert(attachDTO);
			postservice.imgDirInsert(attachDTO);
			
			System.out.println(attachDTO);
			try {
				File saveFile = new File(upDir, uploadFileName);
				multipartFile.transferTo(saveFile);
				
				attachDTO.setI_name(uuid.toString());
				attachDTO.setI_path(upDir);
				
				
//				if(checkImageType(saveFile)) {
//					FileOutputStream thumbnail = new FileOutputStream(new File(uploadPath, "s_" + uploadFileName));
//					
//					Thumbnailator.createThumbnail(multipartFile.getInputStream(), thumbnail, 100, 100);
//					
//					thumbnail.close();
//				}
				list.add(attachDTO);
				}catch (Exception e) {
				log.error(e.getMessage());
			}
		}
		return new ResponseEntity<>(list, HttpStatus.OK);
	}
}

//package com.bn.controller;
//
//import java.io.File;
//import java.io.FileOutputStream;
//import java.io.IOException;
//import java.net.http.HttpHeaders;
//import java.nio.file.Files;
//import java.text.SimpleDateFormat;
//import java.util.ArrayList;
//import java.util.Date;
//import java.util.List;
//import java.util.UUID;
//
//import org.springframework.beans.factory.annotation.Autowired;
//import org.springframework.http.*;
//import org.springframework.http.MediaType;
//import org.springframework.http.ResponseEntity;
//import org.springframework.stereotype.Controller;
//import org.springframework.util.FileCopyUtils;
//import org.springframework.web.bind.annotation.GetMapping;
//import org.springframework.web.bind.annotation.PostMapping;
//import org.springframework.web.bind.annotation.RequestBody;
//import org.springframework.web.bind.annotation.ResponseBody;
//import org.springframework.web.context.annotation.RequestScope;
//import org.springframework.web.multipart.MultipartFile;
//
//import com.bn.model.AttachFileDto;
//import com.bn.service.PostService;
//
//import lombok.extern.log4j.Log4j;
//import net.coobird.thumbnailator.Thumbnailator;
//
//@Controller
//@Log4j
//public class UploadController {
//	
//	@Autowired
//	private PostService postservice;
//	
//	@GetMapping("/upload")
//	public void upload() {
//		log.info("upload");
//	}
//	
//	private boolean checkImageType(File file) {
//		try {
//			String contentType = Files.probeContentType(file.toPath());
//			
//			return contentType.startsWith("image");
//		} catch (IOException e) {
//			e.printStackTrace();
//		}
//		return false;
//	}
//	
////	private String getFolder() {
////	    SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
////
////	    Date date = new Date();
////	    String str = sdf.format(date);
////	    return str.replace("-", File.separator);
////	}
//	
//	
//
//	@PostMapping(value = "/uploadAction", produces = MediaType.APPLICATION_JSON_UTF8_VALUE)
//	@ResponseBody
//	public ResponseEntity<List<AttachFileDto>> uploadPost(MultipartFile[] uploadFile) {
//		log.info("update post...");
//		
//		List<AttachFileDto> list = new ArrayList<>();
//		String uploadFolder = "/resources/upload";
//		
//		//String uploadFolderPath = getFolder();
//		
//		File uploadPath = new File(uploadFolder);
//		log.info("upload path: " + uploadPath);
//		
//		if (uploadPath.exists() == false) {
//			uploadPath.mkdirs();
//		}//날짜별 폴더 생성
//		
//		
//		
//		for (MultipartFile multipartFile : uploadFile) {
//			
//			AttachFileDto attachDTO = new AttachFileDto();
//			String uploadFileName = multipartFile.getOriginalFilename();
//			String extension = uploadFileName.substring(uploadFileName.lastIndexOf(".") + 1);
//			UUID uuid = UUID.randomUUID();
//			uploadFileName = uuid.toString() + "_" + uploadFileName;
//			attachDTO.setI_name(uploadFileName);
//			attachDTO.setI_name2(extension);
//			attachDTO.setI_path(uploadFolder);
//			postservice.imgInsert(attachDTO);
//			postservice.imgDirInsert(attachDTO);
//			
//			System.out.println(attachDTO);
//			try {
//				File saveFile = new File(uploadPath, uploadFileName);
//				multipartFile.transferTo(saveFile);
//				
//				attachDTO.setI_name(uuid.toString());
//				//attachDTO.setI_path(uploadFolderPath);
//				
//				
////				if(checkImageType(saveFile)) {
////					FileOutputStream thumbnail = new FileOutputStream(new File(uploadPath, "s_" + uploadFileName));
////					
////					Thumbnailator.createThumbnail(multipartFile.getInputStream(), thumbnail, 100, 100);
////					
////					thumbnail.close();
////				}
//				list.add(attachDTO);
//				}catch (Exception e) {
//				log.error(e.getMessage());
//			}
//		}
//		return new ResponseEntity<>(list, HttpStatus.OK);
//	}
//}