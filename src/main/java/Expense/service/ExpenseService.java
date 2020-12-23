package Expense.service;

import java.util.HashMap;
import java.util.List;

import Expense.dto.Expense;

public interface ExpenseService {
	List<Expense> getList();
	
	List<Expense> getProcessList(HashMap<String, Object> paramMap);
	
	Expense selectExpenseById(int id);
	
	int insertExpense(Expense expense);
	
	int updateExpense(Expense expense);
	
	int deleteExpense(int expense_no);
	
	int countList();

}
