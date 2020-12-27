package Expense.service;

import java.util.HashMap;
import java.util.List;

import javax.servlet.http.HttpServletResponse;

import Expense.dto.ExpenseDto;

public interface ExpenseService {
	List<ExpenseDto> getList();
	
	List<ExpenseDto> getProcessList(HashMap<String, Object> paramMap);
	
	ExpenseDto selectExpenseById(int id);
	
	int insertExpense(ExpenseDto expense);
	
	int updateExpense(ExpenseDto expense);
	
	int deleteExpense(int expense_no);
	
	int countList();
	
	
}
