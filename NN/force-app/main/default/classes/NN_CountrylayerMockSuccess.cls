/**
 * @Author       Jozef Birka
 * @Date         12/26/2023
 * @description  Mock class for NN_Countrylayer - positive outcome.
 **/
@isTest
global class NN_CountrylayerMockSuccess implements HttpCalloutMock {
	global HTTPResponse respond(HTTPRequest req) {
		HttpResponse res = new HttpResponse();
		res.setHeader('Content-Type', 'application/json');
		res.setBody(
			'[{"name":"Afghanistan","topLevelDomain":[".af"],"alpha2Code":"AF","alpha3Code":"AFG","callingCodes":["93"],"capital":"Kabul","altSpellings":["AF","Afġānistān"],"region":"Asia","regionalBlocs":[{"acronym":"TU"},{"acronym":"NOPEC"}]},{"name":"Zimbabwe","topLevelDomain":[".zw"],"alpha2Code":"ZW","alpha3Code":"ZWE","callingCodes":["263"],"capital":"Harare","altSpellings":["ZW","Republic of Zimbabwe"],"region":"Africa","regionalBlocs":[{"acronym":"AU"},{"acronym":"NOPEC"}]}]'
		);
		res.setStatusCode(200);
		return res;
	}
}
