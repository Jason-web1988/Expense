package Expense.dto;

import java.sql.Timestamp;

public class Expense {
	private int expense_no;					//순번
	private String use_date;				//사용일
	private String name;					//사용내역
	private int use_price;				//사용금액
	private int approve_price;			//승인금액		
	private String process_status;			//처리상태			
	private String registration_date;	//등록일
	private String receipt;					//영수증			
	private String process_date; 		//처리일시				
	private String remark;					//비고
	
	
	public Expense() {}

	
	public Expense(int expense_no) {
		super();
		this.expense_no = expense_no;
	}


	public Expense(int expense_no, String use_date, String name, int use_price, int approve_price,
			String process_status, String registration_date, String receipt, String process_date, String remark) {
		super();
		this.expense_no = expense_no;
		this.use_date = use_date;
		this.name = name;
		this.use_price = use_price;
		this.approve_price = approve_price;
		this.process_status = process_status;
		this.registration_date = registration_date;
		this.receipt = receipt;
		this.process_date = process_date;
		this.remark = remark;
	}


	public int getExpense_no() {
		return expense_no;
	}


	public void setExpense_no(int expense_no) {
		this.expense_no = expense_no;
	}


	public String getUse_date() {
		return use_date;
	}


	public void setUse_date(String use_date) {
		this.use_date = use_date;
	}


	public String getName() {
		return name;
	}


	public void setName(String name) {
		this.name = name;
	}


	public int getUse_price() {
		return use_price;
	}


	public void setUse_price(int use_price) {
		this.use_price = use_price;
	}


	public int getApprove_price() {
		return approve_price;
	}


	public void setApprove_price(int approve_price) {
		this.approve_price = approve_price;
	}


	public String getProcess_status() {
		return process_status;
	}


	public void setProcess_status(String process_status) {
		this.process_status = process_status;
	}


	public String getRegistration_date() {
		return registration_date;
	}


	public void setRegistration_date(String registration_date) {
		this.registration_date = registration_date;
	}


	public String getReceipt() {
		return receipt;
	}


	public void setReceipt(String receipt) {
		this.receipt = receipt;
	}


	public String getProcess_date() {
		return process_date;
	}


	public void setProcess_date(String process_date) {
		this.process_date = process_date;
	}


	public String getRemark() {
		return remark;
	}


	public void setRemark(String remark) {
		this.remark = remark;
	}


	@Override
	public String toString() {
		return String.format(
				"Expense [expense_no=%s, use_date=%s, name=%s, use_price=%s, approve_price=%s, process_status=%s, registration_date=%s, receipt=%s, process_date=%s, remark=%s]",
				expense_no, use_date, name, use_price, approve_price, process_status, registration_date, receipt,
				process_date, remark);
	}





	





	

	
	
}
