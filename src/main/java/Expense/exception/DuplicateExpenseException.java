package Expense.exception;

@SuppressWarnings("serial")
public class DuplicateExpenseException extends RuntimeException {
	public DuplicateExpenseException(String message) {
		super(message);
	}
}
