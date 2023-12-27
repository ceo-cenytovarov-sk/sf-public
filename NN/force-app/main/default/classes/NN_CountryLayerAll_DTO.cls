/**
 * @Author       Jozef Birka
 * @Date         12/26/2023
 * @description  Countrylayer class for parsing repsonse for All endpoint
 **/
public with sharing class NN_CountryLayerAll_DTO {
	public String name { get; set; }
	public String alpha2Code { get; set; }
	public String alpha3Code { get; set; }
	public String capital { get; set; }
	public String region { get; set; }
	public Boolean success { get; set; }
	public List<NN_RegionalBlock_DTO> regionalBlocs { get; set; }
}
