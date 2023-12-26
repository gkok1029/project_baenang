package com.bn.controller;

import java.io.File;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.multipart.MultipartFile;

import lombok.extern.log4j.Log4j;

@Controller
@Log4j
public class UploadController {
	
	@GetMapping("/upload")
	public void upload() {
		log.info("upload");
	}
	
	@PostMapping("/uploadAction")
	public void uploadPost(MultipartFile[] uploadFile) {
		log.info("update post...");
		
		String uploadFolder = "C:\\upload";
		
		for (MultipartFile multipartFile : uploadFile) {
			log.info("-------------");
			log.info("uploaded file name: " + multipartFile.getOriginalFilename());
			log.info("uploaded file size: " + multipartFile.getSize());
		
			String uploadFileName = multipartFile.getOriginalFilename();
			
			//IE case
			uploadFileName = uploadFileName.substring(uploadFileName.lastIndexOf("\\") + 1);
			File saveFile = new File(uploadFolder, uploadFileName);
			
			try {
				multipartFile.transferTo(saveFile);
				
			}catch (Exception e) {
				log.error(e.getMessage());
			}
		}
		
	}
}
