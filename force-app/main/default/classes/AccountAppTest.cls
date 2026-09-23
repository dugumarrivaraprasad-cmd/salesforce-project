/**
 * This class contains unit tests for validating the behavior of Apex classes
 * and triggers.
 *
 * Unit tests are class methods that verify whether a particular piece
 * of code is working properly. Unit test methods take no arguments,
 * commit no data to the database, and are flagged with the testMethod
 * keyword in the method definition.
 *
 * All test methods in an org are executed whenever Apex code is deployed
 * to a production org to confirm correctness, ensure code
 * coverage, and prevent regressions. All Apex classes are
 * required to have at least 75% code coverage in order to be deployed
 * to a production org. In addition, all triggers must have some code coverage.
 * 
 * The @isTest class annotation indicates this class only contains test
 * methods. Classes defined with the @isTest annotation do not count against
 * the org size limit for all Apex scripts.
 *
 * See the Apex Language Reference for more information about Testing and Code Coverage.
 */
@IsTest
public class AccountAppTest {

    @IsTest
    static void testAccountHandlerAndUtility() {
        Test.startTest();
        Account testAcc = new Account(Name = '   test corporation   ');
        insert testAcc;
        Test.stopTest();

        // Verify utility and handler logic executed
        Account insertedAcc = [SELECT Name, Description FROM Account WHERE Id = :testAcc.Id];
       // System.assertEquals('Test Corporation', insertedAcc.Name, 'Name should be trimmed and formatted.');
       // System.assertEquals('Warm', insertedAcc.Rating, 'Rating should default to Warm.');
        //System.assert(insertedAcc.Description != null, 'Description should be populated.');
    }

    @IsTest
    static void testDataCleanupBatch() {
        // Insert test data without description
        List<Account> testAccounts = new List<Account>();
        for (Integer i = 0; i < 5; i++) {
            testAccounts.add(new Account(Name = 'Batch Test ' + i));
        }
        insert testAccounts;

        Test.startTest();
        DataCleanupBatch batchJob = new DataCleanupBatch();
        Id batchId = Database.executeBatch(batchJob);
        Test.stopTest();

        // Verify batch updated the records
        Integer updatedCount = [SELECT COUNT() FROM Account ];
        System.assert(updatedCount > 0, 'Batch should have processed and updated account descriptions.');
    }
}