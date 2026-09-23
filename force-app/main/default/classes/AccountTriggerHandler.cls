public class AccountTriggerHandler {
    
    public static void handleBeforeInsert(List<Account> newAccounts) {
        // Call utility method to format details
        AccountUtility.formatAccountDetails(newAccounts);
        
        for (Account acc : newAccounts) {
            if (String.isBlank(acc.Description)) {
                acc.Description = 'Default description added during deployment practice.';
            }
        }
    }
}