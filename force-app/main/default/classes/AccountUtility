public class AccountUtility {
    
    // Formats the account name to uppercase and appends a default rating if blank
    public static void formatAccountDetails(List<Account> accountList) {
        for (Account acc : accountList) {
            if (String.isNotBlank(acc.Name)) {
                acc.Name = acc.Name.trim();
            }
            if (String.isBlank(acc.Rating)) {
                acc.Rating = 'Warm';
            }
        }
    }
}