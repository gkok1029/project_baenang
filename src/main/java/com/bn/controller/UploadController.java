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

import lombok.extern.log4j.Log4j;
import net.coobird.thumbnailator.Thumbnailator;

@Controller
@Log4j
public class UploadController {
	
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
	
//	@GetMapping("/display")
//	@ResponseBody
//	public ResponseEntity<byte[]> getFile(String fileName) {
//	    
//	    log.info("filename: " + fileName);
//	    
//	    File file = new File("C:\\upload\\" + fileName);
//	    
//	    log.info("file: " + file);
//	    
//	    ResponseEntity<byte[]> result = null;
//	    
//	    try {
//	        HttpHeaders header = new HttpHeaders();
//	        
//	        header.add("Content-Type", Files.probeContentType(file.toPath()));
//	        result = new ResponseEntity<>(FileCopyUtils.copyToByteArray(file), header, HttpStatus.OK);
//	    } catch (IOException e) {
//	        e.printStackTrace();
//	    }
//	    return result;
//	}
	
	@PostMapping(value = "/uploadAction", produces = MediaType.APPLICATION_JSON_UTF8_VALUE)
	@ResponseBody
	public ResponseEntity<List<AttachFileDto>> uploadPost(MultipartFile[] uploadFile) {
		log.info("update post...");
		
		List<AttachFileDto> list = new ArrayList<>();
		String uploadFolder = "C:\\upload";
		
		String uploadFolderPath = getFolder();
		
		File uploadPath = new File(uploadFolder, uploadFolderPath);
		log.info("upload path: " + uploadPath);
		
		if (uploadPath.exists() == false) {
			uploadPath.mkdirs();
		}//날짜별 폴더 생성
		
		for (MultipartFile multipartFile : uploadFile) {
			
			AttachFileDto attachDTO = new AttachFileDto();
			
			String uploadFileName = multipartFile.getOriginalFilename();
			
			//IE case
			uploadFileName = uploadFileName.substring(uploadFileName.lastIndexOf("\\") + 1);
			
			attachDTO.setI_name(uploadFileName);
			
			UUID uuid = UUID.randomUUID();
			
			uploadFileName = uuid.toString() + "_" + uploadFileName;
			
			try {
				File saveFile = new File(uploadPath, uploadFileName);
				multipartFile.transferTo(saveFile);
				
				attachDTO.setI_name(uuid.toString());
				attachDTO.setI_path(uploadFolderPath);
				
				if(checkImageType(saveFile)) {
					FileOutputStream thumbnail = new FileOutputStream(new File(uploadPath, "s_" + uploadFileName));
					
					Thumbnailator.createThumbnail(multipartFile.getInputStream(), thumbnail, 100, 100);
					
					thumbnail.close();
				}
				list.add(attachDTO);
				}catch (Exception e) {
				log.error(e.getMessage());
			}
		}
		return new ResponseEntity<>(list, HttpStatus.OK);
	}
}
