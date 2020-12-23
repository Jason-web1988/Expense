package Expense.mapper;

import java.util.HashMap;
import java.util.List;

import Expense.dto.Expense;


public interface ExpenseMapper {
	 List<Expense> SelectExpenseByAll();
	 
	 List<Expense> selectExpenseByProcess(HashMap<String, Object> paramMap);
	
	 Expense selectExpenseById(int id);
	 
	 int insertExpense(Expense expense);
	 
	 int updateExpense(Expense expense);
	 
	 int deleteExpense(int expense_no);
	 
	 int countTotal(); 
}
