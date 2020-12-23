package Expense.controller;

import java.sql.Timestamp;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import Expense.dto.Expense;
import Expense.service.ExpenseService;

@RestController					//Spring MVC Controller에 @ResponseBody가 추가된것, 주용도로 JSON형태로 객체 데이터를 반환
@RequestMapping("/api")			//api만들기
public class RestExpenseController {
	
	@Autowired
	private ExpenseService service;
	
	@GetMapping("/list")
	public ResponseEntity<Object> Expense(){
		System.out.println("Expense()");
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
	public ResponseEntity<Object> getExpense(@RequestParam("date") Timestamp use_date
						 , @RequestParam("name") String name
						 , @RequestParam("processStatus") String process_status){
		// TODO use_date에 Timestamp로 매핑될 수 있는지 확인, 안되면 String으로 받아서 new Date형탤 casting 해줘야된다
		System.out.println("getExpense() : " + use_date + ", " + name + ", " + process_status);
		List<Expense> expense = service.getProcessList(use_date, name, process_status);
		if(expense == null) {
			return ResponseEntity.status(HttpStatus.NOT_FOUND).build();
		}
		return ResponseEntity.ok(expense);

	}
}
