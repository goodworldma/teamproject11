package kr.co.common.utils;

import java.awt.image.BufferedImage;
import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.InputStream;
import java.util.Calendar;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.UUID;

import javax.imageio.ImageIO;
import javax.servlet.ServletContext;

import org.apache.commons.io.IOUtils;
import org.imgscalr.Scalr;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.util.FileCopyUtils;
import org.springframework.web.multipart.MultipartFile;

public class UploadFileUtils {
	
	
	
	
	public static String uploadFile(String uploadPath, 
									MultipartFile file,
									ServletContext sc) throws Exception{
		
		String originalFilename = file.getOriginalFilename();
		
		String filename = makeFilename(originalFilename);
		
		byte[] arr  = file.getBytes();
		
		
		// uploadPath = changeToAbsolutePath(uploadPath, sc);
		
		String datePath = makePath(uploadPath); // /2023/01/05 
		
		
		File target = new File(uploadPath+datePath, filename);
		//D:/upload/2023/01/05 
		
		FileCopyUtils.copy(arr, target);
		
		String formatName = getFormatName(filename);
		MediaType mType = getMediaType(formatName);
		
		String uploadedFilename = null;
		
		if(mType == null) {
			uploadedFilename = makeIcon(datePath, filename);
			//  /2023/01/05/uuid_홍길동이력서.xlx
		}else {
			uploadedFilename = makeThumbnail(datePath, filename, uploadPath);
			// /2023/01/05/s_uuid_flower.png
		}
		
		
		return uploadedFilename;
		
	}
	
	public static String makeThumbnail(String datePath, String filename, String uploadPath) throws Exception {
		
		String thumbnailName = "s_"+filename;
		File tFile = new File(uploadPath+datePath, thumbnailName);
		
		String formatName = getFormatName(filename);
		
		BufferedImage sourceImg = ImageIO.read(new File(uploadPath+datePath, filename));
		BufferedImage destImg= Scalr.resize(sourceImg, Scalr.Method.AUTOMATIC, 
										Scalr.Mode.FIT_EXACT, 100);
		
		ImageIO.write(destImg, formatName, tFile);
		
		String uploadedFilename = datePath + File.separator + thumbnailName; 
		uploadedFilename = uploadedFilename.replace(File.separatorChar, '/');
		
		
		return uploadedFilename;
	}
	
	
	public static String makeIcon(String datePath, String filename) {
		String uploadedFilename = datePath +File.separator+ filename;

		uploadedFilename = uploadedFilename.replace(File.separatorChar, '/');
		
		return uploadedFilename;
	}
	
	






	public static String getOriginalFilename(String filename) {
		int idx = filename.indexOf("_")   + 1 ;
		String originalFilename = filename.substring(idx);
		
		return originalFilename;
	}
	
	public static String makeFilename(String filename) {
		UUID uid = UUID.randomUUID();
		String savedName = uid.toString() +"_"+filename;
		return savedName;
	}
	
	
	public static String changeToAbsolutePath(String uploadPath, ServletContext sc) {
		
		return sc.getRealPath(uploadPath);
	}
	
	
	
	public static MediaType getMediaType(String formatName) {
		formatName = formatName.toLowerCase();
		
		Map<String, MediaType> map = new HashMap<String, MediaType>();
		
		
		map.put("png", MediaType.IMAGE_PNG);
		map.put("gif", MediaType.IMAGE_GIF);
		map.put("jpeg", MediaType.IMAGE_JPEG);
		map.put("jpg", MediaType.IMAGE_JPEG);
		
		return map.get(formatName);
	}
	
	
	public static String getFormatName(String filename) {
		
		int idx = filename.lastIndexOf(".") + 1;
		String formatName = filename.substring(idx);
		return formatName;
		
	}
	
	
	
	
	public static String makePath(String uploadPath) {
		
		Calendar cal = Calendar.getInstance();
		
		String yearPath = File.separator+ cal.get(Calendar.YEAR);
		
		int month = cal.get(Calendar.MONTH)+1;
		String sMonth = month < 10? "0"+month : month+"";
		String monthPath = yearPath +File.separator+ sMonth;
		
		int date = cal.get(Calendar.DATE);
		String sDate = date < 10 ? "0"+date : date+"";
		
		String datePath = monthPath +File.separator+ sDate;
		
		makeDir(yearPath, monthPath, datePath, uploadPath);
		
		
		return datePath;
	}

	public static void makeDir(String yearPath, String monthPath, String datePath, String uploadPath) {
		File fy = new File(uploadPath, yearPath);
		
		if(!fy.exists()) {
			fy.mkdir();
		}
		
		
		File fm = new File(uploadPath, monthPath);
		if(!fm.exists()) {
			fm.mkdir();
		}
		
		File fd = new File(uploadPath, datePath);
		if(!fd.exists()) {
			fd.mkdir();
		}
		
	}

	public static void deleteUploadFiles(String uploadPath, 
									List<String> uploadedFileList) 
											throws Exception {
		
		for(int i=0;i<uploadedFileList.size();i++) {
			String uploadedFilename = uploadedFileList.get(i);
			File deleteFile = new File(uploadPath, uploadedFilename);
			
			if(deleteFile.exists()) {
				deleteFile.delete();
			}
			
			
			
			int idx = uploadedFilename.indexOf("s_");
			
			if(idx != -1) {
				String prefix = uploadedFilename.substring(0, idx);
				String suffix = uploadedFilename.substring(idx + 2);
				
				String filename = prefix + suffix;
				
				deleteFile = new File(uploadPath, filename);
				
				if(deleteFile.exists()) {
					deleteFile.delete();
				}
			}
			
			Thread.sleep(50);
		}
		
	}

	public static ResponseEntity<byte[]> showOrDownload(String uploadPath, String filename) {
		ResponseEntity<byte[]> entity = null;
		
		String formatName = getFormatName(filename);
		MediaType mType = getMediaType(formatName);
		
		HttpHeaders headers = new HttpHeaders();
		
		InputStream in = null;
		
		try {
			
			if(mType != null) {
				String prefix = filename.substring(0, 12);
				String suffix = filename.substring(14);
				
				filename = prefix + suffix;
				
				in = new FileInputStream(uploadPath+filename);
				
				headers.setContentType(mType);
			}else {
				
				in = new FileInputStream(uploadPath+filename);
				
				headers.setContentType(MediaType.APPLICATION_OCTET_STREAM);
				
				int idx = filename.indexOf("_") + 1;
				String originalFilename = filename.substring(idx);
				originalFilename = new String(originalFilename.getBytes("UTF-8"), "ISO-8859-1");
				
				headers.add("Content-Disposition",  "attachment;filename=\""+originalFilename+"\"");
			}
			
			byte[] arr = IOUtils.toByteArray(in);
			
			entity = new ResponseEntity<byte[]>(arr, headers, HttpStatus.OK);
			
		} catch (Exception e) {
			e.printStackTrace();
			entity = new ResponseEntity<byte[]>(HttpStatus.BAD_REQUEST);
		} finally {
			if (in != null) {
				try {
					in.close();
				} catch (IOException e) {
					e.printStackTrace();
				}
			}
		}
		
		return entity;
	}

	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
}
