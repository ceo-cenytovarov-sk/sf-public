/**
 * @Author       Jozef Birka
 * @Date         12/26/2023
 * @description  Generic class for integration. Provides methods to obtain token, make callout and return response etc.
 **/
global with sharing class NN_IntegrationHelper {
	/**
	 * @Author       Jozef Birka
	 * @Date         12/26/2023
	 * @description  private method for data preprocessing.
	 **/
	private static HttpRequest buildHttpRequest(
		String url,
		Map<String, String> headerData,
		Map<String, String> formData,
		String method,
		String path
	) {
		HttpRequest req = new HttpRequest();
		req.setMethod(method);

		for (String key : headerData.keySet()) {
			String value = EncodingUtil.urlEncode(headerData.get(key), 'UTF-8');
			req.setHeader(key, value);
		}

		String parameters = '';
		for (String key : formData.keySet()) {
			String value = EncodingUtil.urlEncode(formData.get(key), 'UTF-8');
			if (parameters != '') {
				parameters += '&';
			}
			parameters += key + '=' + value;
		}
		switch on method {
			when 'POST' {
				req.setEndpoint(url + path);
				req.setBody(parameters);
			}
			when 'GET' {
				req.setEndpoint(url + path + '?' + parameters);
			}
		}
		return req;
	}

	/**
	 * @Author       Jozef Birka
	 * @Date         12/26/2023
	 * @input		 integrationCustomSetting: DeveloperName of custom settings for system
	 * @input		 headerData: key/value pairs
	 * @input		 formData: key/value pairs. If method is POST, it will be send as body, if GET, it will be appended to endpoint
	 * @input		 method: GET, POST ...
	 * @input		 path: to be appended after endpoint. It should begin with / or leave empty.
	 * @description  Method for getting string response from request call.
	 **/
	public static String calloutAndGetResponse(
		String url,
		Map<String, String> headerData,
		Map<String, String> formData,
		String method,
		String path
	) {
		String responseBody = '';
		try {
			HttpRequest req = buildHttpRequest(url, headerData, formData, method, path);

			Http http = new Http();
			HttpResponse response = http.send(req);

			if (response.getStatusCode() == 200) {
				responseBody = response.getBody();
			} else {
				//custom logging will go here
				system.debug('IntegrationHelper calloutAndGetResponse statusCode: ' + response.getStatusCode());
			}
		} catch (Exception e) {
			//custom logging will go here
			system.debug('IntegrationHelper calloutAndGetResponse error: ' + e);
		} finally {
			//custom processing
		}
		return responseBody;
	}
}
