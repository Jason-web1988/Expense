package Expense.mapper;

import java.util.HashMap;
import java.util.List;

import Expense.dto.ExpenseDto;


public interface ExpenseMapper {
	 List<ExpenseDto> SelectExpenseByAll();
	 
	 List<ExpenseDto> selectExpenseByProcess(HashMap<String, Object> paramMap);
	
	 ExpenseDto selectExpenseById(int id);
	 
	 int insertExpense(ExpenseDto expense);
	 
	 int updateExpense(ExpenseDto expense);
	 
	 int deleteExpense(int expense_no);
	 
	 int countTotal(); 
	 
}
