package Expense.mapper;

import java.util.List;

import org.apache.ibatis.logging.Log;
import org.apache.ibatis.logging.LogFactory;
import org.junit.After;
import org.junit.Assert;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import Expense.config.ControllerConfig;
import Expense.dto.ExpenseDto;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(classes = {ControllerConfig.class})
public class ExpenseMapperTest {
	protected static final Log log = LogFactory.getLog(ExpenseMapperTest.class);
	
	@Autowired
	private ExpenseMapper mapper;
	
	@After
	public void tearDown() throws Exception{
		System.out.println();
	}

	@Test
	public void testSelectExpenseByAll() {
		log.debug(Thread.currentThread().getStackTrace()[1].getMethodName()+"()");
		
		List<ExpenseDto> list = mapper.SelectExpenseByAll();
		Assert.assertNotNull(list);
		list.forEach(Expense -> log.debug(Expense.toString()));
	}

}
