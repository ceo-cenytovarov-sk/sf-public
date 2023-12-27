/**
 * @Author       Jozef Birka
 * @Date         12/26/2023
 * @description  Mock class for NN_Countrylayer - negative outcome.
 **/
@isTest
global class NN_CountrylayerMockFailed implements HttpCalloutMock {
	global HTTPResponse respond(HTTPRequest req) {
		HttpResponse res = new HttpResponse();
		res.setHeader('Content-Type', 'application/json');
		res.setBody(
			'{"success":false,"error":{"code":104,"type":"monthly_limit_reached","info":"Your monthly API request volume has been reached. Please upgrade your plan."}}'
		);
		res.setStatusCode(200);
		return res;
	}
}
