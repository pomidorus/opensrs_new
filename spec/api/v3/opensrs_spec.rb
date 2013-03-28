#encoding: utf-8
require "spec_helper"

describe "OpenSRSClient" do
  it 'should do something'
end


describe "OpenSRSResponse as OpenSRSRequestHash" do
  it 'should do something'
end

describe OpenSRSRequestParse do

  let(:xml_getOrderInfo) {"<?xml version=\"1.0\"?>\n<OPS_envelope><header/><version/>0.9<body/><data_block/><dt_assoc><item key=\"protocol\">XCP</item><item key=\"action\">GET_ORDER_INFO</item><item key=\"object\">DOMAIN</item><item key=\"attributes\"><dt_assoc><item key=\"order_id\">34342323</item></dt_assoc></item></dt_assoc></OPS_envelope>\n"}

  it "is valid with xml" do
    xml = ""
    parse = OpenSRSRequestParse.new(xml)
    parse.xml.should == ""
  end

  it "is valid with correct xml" do
    xml = "<?xml version=\"1.0\"?>\n<OPS_envelope><header/><version/>0.9<body/><data_block/><dt_assoc><item key=\"protocol\">XCP</item><item key=\"action\">GET_ORDER_INFO</item><item key=\"object\">DOMAIN</item><item key=\"attributes\"><dt_assoc><item key=\"order_id\">34342323</item></dt_assoc></item></dt_assoc></OPS_envelope>\n"
    parse = OpenSRSRequestParse.new(xml)
    parse.xml.should == xml
  end

  it "request_hash is valid" do
    rh = {"protocol"=>"XCP", "action"=>"GET_ORDER_INFO", "object"=>"DOMAIN", "order_id"=>"34342323"}
    OpenSRSRequestParse.new(xml_getOrderInfo).request_hash.should == rh
  end

end
