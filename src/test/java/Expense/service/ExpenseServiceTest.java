package Expense.service;

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
import Expense.service.ExpenseService;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(classes = {ControllerConfig.class})
public class ExpenseServiceTest {
	protected static final Log log = LogFactory.getLog(ExpenseServiceTest.class);
	
	@Autowired
	private ExpenseService service;
	
	@After
	public void tearDown() throws Exception{
		System.out.println();
	}

	@Test
	public void testGetList() {
		log.debug(Thread.currentThread().getStackTrace()[1].getMethodName()+"()");
		
		List<ExpenseDto> list = service.getList();
		Assert.assertNotNull(list);
		list.forEach(Expense -> log.debug(Expense.toString()));
	}

}
