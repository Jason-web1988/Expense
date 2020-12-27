package Expense.service.impl;

import java.util.HashMap;
import java.util.List;

import org.apache.ibatis.logging.Log;
import org.apache.ibatis.logging.LogFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import Expense.dto.ExpenseDto;
import Expense.mapper.ExpenseMapper;
import Expense.service.ExpenseService;

@Service
public class ExpenseServiceImp implements ExpenseService {
	protected static final Log log = LogFactory.getLog(ExpenseServiceImp.class);
	
	@Autowired
	private ExpenseMapper mapper;
	
	@Override
	public List<ExpenseDto> getList() {
		List<ExpenseDto> list = mapper.SelectExpenseByAll();
		log.debug("service - getList() > " + list.size());
		System.out.println("list >> " + list);
		
		//list.stream().forEach(System.out::println);
		return list;
	}

	@Override
	public int countList() {
		int countList = mapper.countTotal();
		log.debug("service - countList() > " + countList);
		return countList;
	}

	@Override
	public List<ExpenseDto> getProcessList(HashMap<String, Object> paramMap) {
		System.out.println("paramMap getProcessList >> " + paramMap.toString());
		
		List<ExpenseDto> processList = mapper.selectExpenseByProcess(paramMap);
		System.out.println("paramMap getProcessList2 >> ");
		processList.stream().forEach(System.out::println);

		
		System.out.println("processList3 >> " + processList);
		processList.stream().forEach(System.out::println);
		
		return processList;
	}

	@Override
	public ExpenseDto selectExpenseById(int id) {
		log.debug("service - selectExpenseById() > " + id);
		return mapper.selectExpenseById(id);
	}

	@Override
	public int insertExpense(ExpenseDto expense) {
		log.debug("service - insertExpense() > " + expense);
		return mapper.insertExpense(expense);
	}

	@Override
	public int updateExpense(ExpenseDto expense) {
		log.debug("service - updateExpense() > " + expense);
		return mapper.updateExpense(expense);
	}

	@Override
	public int deleteExpense(int expense_no) {
		log.debug("service - deleteExpense() > " + expense_no);
		return mapper.deleteExpense(expense_no);
	}

	
}