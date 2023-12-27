/**
 * @author      Jozef Birka
 * @date        12/26/2023
 * @description NN_CountrylayerSERVSchedulable test class
 */

@IsTest
public with sharing class NN_CountrylayerSERVSchedulableTest {
	@IsTest
	static void calloutSchedule() {
		String CRON_EXP = '0 0 1 ? * * *';
		Test.startTest();
		String jobId = System.schedule('Countrylayer callout', CRON_EXP, new NN_CountrylayerSERVSchedulable());
		CronTrigger ct = [SELECT Id, CronExpression, TimesTriggered, NextFireTime FROM CronTrigger WHERE id = :jobId];
		System.assertEquals(CRON_EXP, ct.CronExpression);
		System.assertEquals(0, ct.TimesTriggered);
		Test.stopTest();
	}
}
