/**
 * @Author       Jozef Birka
 * @Date         12/26/2023
 * @description  Schedulable class for NN_CountrylayerSERV
 **/

global class NN_CountrylayerSERVSchedulable implements Schedulable {
	global void execute(SchedulableContext ctx) {
		System.enqueueJob(new NN_CountrylayerSERVQueueable());
	}
}
