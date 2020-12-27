package Expense.service.impl;

import java.util.HashMap;
import java.util.List;

import org.apache.ibatis.logging.Log;
import org.apache.ibatis.logging.LogFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import Expense.dto.Expense;
import Expense.mapper.ExpenseMapper;
import Expense.service.ExpenseService;

@Service
public class ExpenseServiceImp implements ExpenseService {
	protected static final Log log = LogFactory.getLog(ExpenseServiceImp.class);
	
	@Autowired
	private ExpenseMapper mapper;
	
	@Override
	public List<Expense> getList() {
		List<Expense> list = mapper.SelectExpenseByAll();
		log.debug("service - getList() > " + list.size());
//		System.out.println("list >> " + list);
		list.stream().forEach(System.out::println);
		return list;
	}

	@Override
	public int countList() {
		int countList = mapper.countTotal();
		log.debug("service - countList() > " + countList);
		return countList;
	}

	@Override
	public List<Expense> getProcessList(HashMap<String, Object> paramMap) {
		System.out.println("paramMap getProcessList >> " + paramMap.toString());
		
		List<Expense> processList = mapper.selectExpenseByProcess(paramMap);
		System.out.println("paramMap getProcessList2 >> ");
		processList.stream().forEach(System.out::println);

		
		System.out.println("processList3 >> " + processList);
		processList.stream().forEach(System.out::println);
		
		return processList;
	}

	@Override
	public Expense selectExpenseById(int id) {
		log.debug("service - selectExpenseById() > " + id);
		return mapper.selectExpenseById(id);
	}

	@Override
	public int insertExpense(Expense expense) {
		log.debug("service - insertExpense() > " + expense);
		return mapper.insertExpense(expense);
	}

	@Override
	public int updateExpense(Expense expense) {
		log.debug("service - updateExpense() > " + expense);
		return mapper.updateExpense(expense);
	}

	@Override
	public int deleteExpense(int expense_no) {
		log.debug("service - deleteExpense() > " + expense_no);
		return mapper.deleteExpense(expense_no);
	}



}