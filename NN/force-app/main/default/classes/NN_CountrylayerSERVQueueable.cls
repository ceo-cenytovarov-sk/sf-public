/**
 * @Author       Jozef Birka
 * @Date         12/26/2023
 * @description  Queueable class for NN_CountrylayerSERV
 **/

public class NN_CountrylayerSERVQueueable implements Queueable, Database.AllowsCallouts {
	public void execute(QueueableContext context) {
		NN_CountrylayerSERV countryLayerSERV = new NN_CountrylayerSERV();
		countryLayerSERV.calloutAll();
	}
}
