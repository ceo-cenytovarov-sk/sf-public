/**
 * @Author       Jozef Birka
 * @Date         12/26/2023
 * @description  Testing class covering XLI_IntegrationHelper.
 **/
@isTest
public class XLI_IntegrationUtilityTest {
	@TestSetup
	static void setup() {
		XLI_IntegrationSettings__c isOAuthProvider = new XLI_IntegrationSettings__c(
			Name = XLI_GlobalConstants.OAUTH_PROVIDER_GENERIC_CUSTOM_SETTING,
			GrantType__c = 'client_credentials',
			ClientId__c = 'abc123',
			ClientSecret__c = '123abc',
			Url__c = 'https://login.microsoftonline.com',
			CurrencyIsoCode = 'USD'
		);
		XLI_IntegrationSettings__c cdi = new XLI_IntegrationSettings__c(
			Name = XLI_GlobalConstants.CDI_CUSTOM_SETTING,
			Url__c = 'https://proxy.cdi.com',
			Scope__c = 'api://abcd/.default',
			OAuthProvider__c = XLI_GlobalConstants.OAUTH_PROVIDER_GENERIC_CUSTOM_SETTING,
			CurrencyIsoCode = 'USD'
		);
		List<XLI_IntegrationSettings__c> isList = new List<XLI_IntegrationSettings__c>();
		isList.add(isOAuthProvider);
		isList.add(cdi);
		insert isList;
	}

	@isTest
	static void getAccessTokenTest() {
		Test.startTest();
		Test.setMock(HttpCalloutMock.class, new XLI_IntegrationHelperGetAccessTokenMock());
		String res = new XLI_IntegrationUtility().getOAuthToken(XLI_GlobalConstants.CDI_CUSTOM_SETTING);
		Assert.areEqual('eyJ0eXAiOiJKV1QiLCJhbGciOiJSUz', res);
		Test.stopTest();
	}

	@isTest
	static void getAccessTokenTest400() {
		Test.startTest();
		Test.setMock(HttpCalloutMock.class, new XLI_IntegrationHelperGetAccessTokenMockE());
		String res = new XLI_IntegrationUtility().getOAuthToken(XLI_GlobalConstants.CDI_CUSTOM_SETTING);
		Assert.areNotEqual('eyJ0eXAiOiJKV1QiLCJhbGciOiJSUz', res);
		Test.stopTest();
	}

	@isTest
	static void calloutAndGetResponseTest() {
		Test.startTest();
		Test.setMock(HttpCalloutMock.class, new XLI_IntegrationHelperGetResponseMock());
		Map<String, String> headerData = new Map<String, String>();
		headerData.put('Ocp-Apim-Subscription-Key', '581ba1a512ad4164b97ccd2b0f268caa');
		Map<String, String> formData = new Map<String, String>();
		formData.put('globalTrackingId', 'c06ff0b6-7311-46de-8679-d73f3002f10f');
		formData.put('systemOfOrigin', 'IWB');
		formData.put('xlNameId', 'X50615698');
		formData.put('specificRole', 'Insured');
		XLI_IntegrationSettings__c cmdtCDI = XLI_IntegrationSettings__c.getValues(
			XLI_GlobalConstants.CDI_CUSTOM_SETTING
		);
		String res = new XLI_IntegrationUtility()
			.calloutAndGetResponse(XLI_GlobalConstants.CDI_CUSTOM_SETTING, cmdtCDI, headerData, formData, 'GET', '');
		Assert.isTrue(res.length() > 100);
		Test.stopTest();
	}

	@isTest
	static void calloutAndGetResponseTest401() {
		Test.startTest();
		Test.setMock(HttpCalloutMock.class, new XLI_IntegrationHelperGetResponseMock401());
		Map<String, String> headerData = new Map<String, String>();
		Map<String, String> formData = new Map<String, String>();
		XLI_IntegrationSettings__c cmdtCDI = XLI_IntegrationSettings__c.getValues(
			XLI_GlobalConstants.CDI_CUSTOM_SETTING
		);
		String res = new XLI_IntegrationUtility()
			.calloutAndGetResponse(XLI_GlobalConstants.CDI_CUSTOM_SETTING, cmdtCDI, headerData, formData, 'GET', '');
		Assert.isTrue(res.length() < 100);
		Test.stopTest();
	}

	@isTest
	static void calloutAndGetResponseTest400() {
		Test.startTest();
		Test.setMock(HttpCalloutMock.class, new XLI_IntegrationHelperGetResponseMock400());
		Map<String, String> headerData = new Map<String, String>();
		Map<String, String> formData = new Map<String, String>();
		XLI_IntegrationSettings__c cmdtCDI = XLI_IntegrationSettings__c.getValues(
			XLI_GlobalConstants.CDI_CUSTOM_SETTING
		);
		String res = new XLI_IntegrationUtility()
			.calloutAndGetResponse('dummy', cmdtCDI, headerData, formData, 'GET', '');
		Assert.isTrue(res.length() < 100);
		Test.stopTest();
	}
	//Overriden methods:
	@isTest
	static void calloutAndGetRespTest() {
		Test.startTest();
		Test.setMock(HttpCalloutMock.class, new XLI_IntegrationHelperGetResponseMock());
		Map<String, String> headerData = new Map<String, String>();
		headerData.put('Ocp-Apim-Subscription-Key', '581ba1a512ad4164b97ccd2b0f268caa');
		Map<String, String> formData = new Map<String, String>();
		formData.put('globalTrackingId', 'c06ff0b6-7311-46de-8679-d73f3002f10f');
		formData.put('systemOfOrigin', 'IWB');
		formData.put('xlNameId', 'X50615698');
		formData.put('specificRole', 'Insured');
		String res = new XLI_IntegrationUtility()
			.calloutAndGetResponse(XLI_GlobalConstants.CDI_NAMED_CREDENTIAL, headerData, formData, 'GET', '');
		Assert.isTrue(res.length() > 100);
		Test.stopTest();
	}

	@isTest
	static void calloutAndGetRespTest401() {
		Test.startTest();
		Test.setMock(HttpCalloutMock.class, new XLI_IntegrationHelperGetResponseMock401());
		Map<String, String> headerData = new Map<String, String>();
		Map<String, String> formData = new Map<String, String>();
		String res = new XLI_IntegrationUtility()
			.calloutAndGetResponse(XLI_GlobalConstants.CDI_NAMED_CREDENTIAL, headerData, formData, 'GET', '');
		Assert.isTrue(res.length() < 100);
		Test.stopTest();
	}

	@isTest
	static void calloutAndGetRespTest400() {
		Test.startTest();
		Test.setMock(HttpCalloutMock.class, new XLI_IntegrationHelperGetResponseMock400());
		Map<String, String> headerData = new Map<String, String>();
		Map<String, String> formData = new Map<String, String>();
		String res = new XLI_IntegrationUtility().calloutAndGetResponse('dummy', headerData, formData, 'GET', '');
		Assert.isTrue(res.length() < 100);
		Test.stopTest();
	}
}
