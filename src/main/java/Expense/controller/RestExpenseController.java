package Expense.controller;

import java.net.URI;
import java.sql.Timestamp;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpRequest;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.RestController;

import Expense.dto.Expense;
import Expense.exception.DuplicateExpenseException;
import Expense.service.ExpenseService;

@RestController					//Spring MVC Controller에 @ResponseBody가 추가된것, 주용도로 JSON형태로 객체 데이터를 반환
@RequestMapping("/api")			//api만들기
public class RestExpenseController {
	
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
		System.out.println("getExpense() : " + params.toString() + ", " + params.get("date"));
		
		Timestamp dateToTimestamp = Timestamp.valueOf((String)params.get("date") + " 00:00:00");
		
		HashMap<String, Object> paramMap = new HashMap<>();
		paramMap.put("date", dateToTimestamp);
		paramMap.put("name", params.get("name"));
		paramMap.put("processStatus", params.get("process_status"));
		
		List<Expense> expense = service.getProcessList(paramMap);
		
		if(expense == null) {
			return ResponseEntity.status(HttpStatus.NOT_FOUND).build();
		}
		return ResponseEntity.ok(expense);

	}
	
	@GetMapping("/getNo/{id}")
	public ResponseEntity<Object> getExpenseNo(@PathVariable int id) {
		System.out.println("getExpenseNo");
		Expense expense = service.selectExpenseById(id);

		if (expense == null) {
			return ResponseEntity.status(HttpStatus.NOT_FOUND).build();
		}
		return ResponseEntity.ok(expense);
	}
	
	@PostMapping("/newExpense/")
    public ResponseEntity<Object> newExpense(@RequestBody Expense expense){
		System.out.println("test");
		try {
			service.insertExpense(expense);
			URI uri = URI.create("/api/newExpense/" + expense.getExpense_no());
			return ResponseEntity.created(uri).body(expense.getExpense_no());
		}catch (DuplicateExpenseException e) {
			return ResponseEntity.status(HttpStatus.CONFLICT).build();
		}
	}
	/*
	@RequestMapping(value="/newExpense", method = {RequestMethod.GET, RequestMethod.POST})
	public ResponseEntity<Object> newExpense(@RequestBody Expense expense, HttpRequest request){
		System.out.println("test");
		try {
			service.insertExpense(expense);
			URI uri = URI.create("/api/newExpense/" + expense.getExpense_no());
			return ResponseEntity.created(uri).body(expense.getExpense_no());
		}catch (DuplicateExpenseException e) {
			return ResponseEntity.status(HttpStatus.CONFLICT).build();
		}
	}
	*/
	@PutMapping("/update/{id}")
	public ResponseEntity<Object> updateExpense(@PathVariable int id, @RequestBody Expense expense){
		System.out.println("updateExpense >> " + expense);
		return ResponseEntity.ok(service.updateExpense(expense));
	}
	
	@DeleteMapping("/delete/{id}")
	public ResponseEntity<Object> deleteExpense(@PathVariable int id){
		System.out.println("deleteExpense >> " + id);
		return ResponseEntity.ok(service.deleteExpense(id));
	}
}