package Expense.controller;

import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.util.Arrays;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletResponse;

import org.apache.poi.hssf.usermodel.HSSFWorkbook;
import org.apache.poi.hssf.util.HSSFColor.HSSFColorPredefined;
import org.apache.poi.ss.usermodel.BorderStyle;
import org.apache.poi.ss.usermodel.Cell;
import org.apache.poi.ss.usermodel.CellStyle;
import org.apache.poi.ss.usermodel.FillPatternType;
import org.apache.poi.ss.usermodel.HorizontalAlignment;
import org.apache.poi.ss.usermodel.Row;
import org.apache.poi.ss.usermodel.Sheet;
import org.apache.poi.ss.usermodel.Workbook;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.multipart.MultipartFile;

import Expense.dto.ExpenseDto;
import Expense.service.ExpenseService;

@RestController					//Spring MVC Controller에 @ResponseBody가 추가된것, 주용도로 JSON형태로 객체 데이터를 반환
@RequestMapping("/api")			//api만들기
public class RestExpenseController {
	
	final static String UPLOADED_FOLDER="C:\\workspace\\test\\";
	
	@Autowired
	private ExpenseService service;
	
	@GetMapping("/list")
	public ResponseEntity<Object> Expense(){
		System.out.println("Expense() index");
		return ResponseEntity.ok(service.getList());
	}

	
	/*
	 * @GetMapping("/getList/{use_date, name, process_status}") public
	 * ResponseEntity<Object> getExpense(@RequestParam Timestamp
	 * use_date, @RequestParam String name, @RequestParam String process_status) {
	 * System.out.println("getExpense()"); List<Expense> expense =
	 * service.getProcessList(use_date, name, process_status); if (expense == null)
	 * { return ResponseEntity.status(HttpStatus.NOT_FOUND).build(); } return
	 * ResponseEntity.ok(expense); }
	 */
	
	@GetMapping("/getList")
	public ResponseEntity<Object> getExpense(@RequestParam Map<String, Object> params) {
		System.out.println("getExpense() : " + params.toString() + ", " + params.get("registration_date"));
		
		//Timestamp dateToTimestamp = Timestamp.valueOf((String)params.get("date") + " 00:00:00");
		
		HashMap<String, Object> paramMap = new HashMap<>();
		//paramMap.put("date", dateToTimestamp);
		paramMap.put("registration_date", params.get("registration_date"));
		paramMap.put("name", params.get("name"));
		paramMap.put("process_status", params.get("process_status"));
		
		//System.out.println("paramMap >> " + paramMap.toString());

		List<ExpenseDto> expense = service.getProcessList(paramMap);
		
		if(expense == null) {
			return ResponseEntity.status(HttpStatus.NOT_FOUND).build();
		}
		return ResponseEntity.ok(expense);

	}
	
	@GetMapping("/getNo/{id}")
	public ResponseEntity<Object> getExpenseNo(@PathVariable int id) {
		System.out.println("getExpenseNo");
		ExpenseDto expense = service.selectExpenseById(id);

		if (expense == null) {
			return ResponseEntity.status(HttpStatus.NOT_FOUND).build();
		}
		return ResponseEntity.ok(expense);
	}
	
	//@PostMapping("/newExpense/")
	//@PostMapping(value ="/newExpense/", consumes = MediaType.APPLICATION_JSON_VALUE, produces = MediaType.APPLICATION_JSON_VALUE)
    //public ResponseEntity<Object> newExpense(@RequestBody Expense expense){
	//	System.out.println("newExpense >>" + expense);
	//	try {
	//		service.insertExpense(expense);
	/*
	 * URI uri = URI.create("/api/newExpense/" + expense.getExpense_no()); return
	 * ResponseEntity.created(uri).body(expense.getExpense_no()); }catch
	 * (DuplicateExpenseException e) { return
	 * ResponseEntity.status(HttpStatus.CONFLICT).build(); } }
	 */
	
    @PostMapping("/newExpense")
    public ResponseEntity<?> uploadFileMulti(
    		//@RequestParam Map<String, Object> params,
            //@RequestParam("extraField") String extraField,
    		@RequestParam("use_history") String useHistory,
    		@RequestParam("use_date") String useDate,
    		@RequestParam("use_price") int usePrice,
            @RequestParam("receipt") MultipartFile[] uploadfiles
            //@ModelAttribute ExpenseModel model
            ) throws IOException {

        System.out.println("Multiple file upload!  " + useDate + ", " + usePrice);
        
        //System.out.println(model.getUsePrice() + ", " + model.getUseDate());

        try {
            saveUploadedFiles(Arrays.asList(uploadfiles));
        } catch (IOException e) {
            return new ResponseEntity<>(HttpStatus.BAD_REQUEST);
        }
        
        // TODO 여기서 이제 로직을 짜야되는데 
        
        // 1. DB에 데이터를 insert 한다.
        ExpenseDto expense = new ExpenseDto();
        
        expense.setName(useHistory);
        expense.setUse_date(useDate);
        expense.setUse_price(usePrice);
        System.out.println("hs : " + uploadfiles[0].getBytes().length);
        expense.setReceipt(uploadfiles[0].getBytes());
        
       int res =  service.insertExpense(expense);
        return ResponseEntity.ok(res);

    }
    
    

	@PutMapping("/update/{id}")
	public ResponseEntity<Object> updateExpense(@PathVariable int id, @RequestBody ExpenseDto expense){
		System.out.println("updateExpense >> " + expense);
		return ResponseEntity.ok(service.updateExpense(expense));
	}
	
	@DeleteMapping("/delete/{id}")
	public ResponseEntity<Object> deleteExpense(@PathVariable int id){
		System.out.println("deleteExpense >> " + id);
		return ResponseEntity.ok(service.deleteExpense(id));
	}

	/*
	 * @RequestMapping(value="/excelDown", produces =
	 * "application/text; charset = utf8") public void excelDownload(
	 * HttpServletRequest request ,HttpServletResponse response ,HttpSession
	 * session, VO param) throws Exception {
	 * 
	 * }
	 */
	
//	@ResponseStatus(HttpStatus.OK)
	@ResponseBody
	@RequestMapping(value = "/excelDown",  produces = "application/text; charset = utf8")
	public void excelDown(HttpServletResponse response) throws Exception {
		System.out.println("excelDown");
	    // 게시판 목록조회
	    List<ExpenseDto> list = service.getList();


	    // 워크북 생성
	    Workbook wb = new HSSFWorkbook();
	    Sheet sheet = wb.createSheet("경비관리");
	    Row row = null;
	    Cell cell = null;
	    int rowNo = 0;

	    // 테이블 헤더용 스타일
	    CellStyle headStyle = wb.createCellStyle();

	    // 가는 경계선을 가집니다.
	    headStyle.setBorderTop(BorderStyle.THIN);
	    headStyle.setBorderBottom(BorderStyle.THIN);
	    headStyle.setBorderLeft(BorderStyle.THIN);
	    headStyle.setBorderRight(BorderStyle.THIN);

	    // 배경색은 노란색입니다.
	    headStyle.setFillForegroundColor(HSSFColorPredefined.YELLOW.getIndex());
	    headStyle.setFillPattern(FillPatternType.SOLID_FOREGROUND);

	    // 데이터는 가운데 정렬합니다.
	    headStyle.setAlignment(HorizontalAlignment.CENTER);

	    // 데이터용 경계 스타일 테두리만 지정
	    CellStyle bodyStyle = wb.createCellStyle();

	    bodyStyle.setBorderTop(BorderStyle.THIN);
	    bodyStyle.setBorderBottom(BorderStyle.THIN);
	    bodyStyle.setBorderLeft(BorderStyle.THIN);
	    bodyStyle.setBorderRight(BorderStyle.THIN);



	    // 헤더 생성
	    row = sheet.createRow(rowNo++);

	    cell = row.createCell(0);
	    cell.setCellStyle(headStyle);
	    cell.setCellValue("순번");

	    cell = row.createCell(1);
	    cell.setCellStyle(headStyle);
	    cell.setCellValue("사용일");

	    cell = row.createCell(2);
	    cell.setCellStyle(headStyle);
	    cell.setCellValue("사용내역");
	    
	    cell = row.createCell(3);
	    cell.setCellStyle(headStyle);
	    cell.setCellValue("사용금액");

	    cell = row.createCell(4);
	    cell.setCellStyle(headStyle);
	    cell.setCellValue("처리상태");
	    
	    cell = row.createCell(5);
	    cell.setCellStyle(headStyle);
	    cell.setCellValue("등록일");

	    cell = row.createCell(6);
	    cell.setCellStyle(headStyle);
	    cell.setCellValue("처리일시");
	    
	    cell = row.createCell(7);
	    cell.setCellStyle(headStyle);
	    cell.setCellValue("비고");


	    // 데이터 부분 생성

	    for(ExpenseDto expense : list) {

	        row = sheet.createRow(rowNo++);

	        cell = row.createCell(0);
	        cell.setCellStyle(bodyStyle);
	        cell.setCellValue(expense.getExpense_no());

	        cell = row.createCell(1);
	        cell.setCellStyle(bodyStyle);
	        cell.setCellValue(expense.getName());

	        cell = row.createCell(2);
	        cell.setCellStyle(bodyStyle);
	        cell.setCellValue(expense.getUse_price());

	        cell = row.createCell(3);
	        cell.setCellStyle(bodyStyle);
	        cell.setCellValue(expense.getApprove_price());
	        
	        cell = row.createCell(4);
	        cell.setCellStyle(bodyStyle);
	        cell.setCellValue(expense.getProcess_status());
	        
	        cell = row.createCell(5);
	        cell.setCellStyle(bodyStyle);
	        cell.setCellValue(expense.getRegistration_date());
	        
	        cell = row.createCell(6);
	        cell.setCellStyle(bodyStyle);
	        cell.setCellValue(expense.getProcess_date());
	        
	        cell = row.createCell(7);
	        cell.setCellStyle(bodyStyle);
	        cell.setCellValue(expense.getRemark());
	        
	 }

	    // 컨텐츠 타입과 파일명 지정
	    response.setContentType("ms-vnd/excel");
	    response.setHeader("Content-Disposition", "attachment;filename=test.xls");

	    // 엑셀 출력
	    wb.write(response.getOutputStream());
	    wb.close();
	}
	
	private void saveUploadedFiles(List<MultipartFile> files) throws IOException {
		System.out.println("files length : " + files.size());
        for (MultipartFile file : files) {

            if (file.isEmpty()) {
                continue; //next pls
            }

            byte[] bytes = file.getBytes();
            Path path = Paths.get(UPLOADED_FOLDER + file.getOriginalFilename());
            System.out.println(path.toString());
            Files.write(path, bytes);

        }

    }
}