/**
 * @Author       Jozef Birka
 * @Date         12/26/2023
 * @description  Touchpoint class for integration.
 **/
public with sharing class NN_IntegrationUtility {
	public String calloutAndGetResponse(
		String url,
		Map<String, String> headerData,
		Map<String, String> formData,
		String method,
		String path
	) {
		return NN_IntegrationHelper.calloutAndGetResponse(url, headerData, formData, method, path);
	}
}
