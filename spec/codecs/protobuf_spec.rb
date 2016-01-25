require "logstash/devutils/rspec/spec_helper"
require "logstash/codecs/protobuf"
require "logstash/event"
require 'protocol_buffers' # https://github.com/codekitchen/ruby-protocol-buffers
require "insist"

describe LogStash::Codecs::Protobuf do

  context "#decode" do

    let(:plugin) { LogStash::Codecs::Protobuf.new("class_name" => "Animal::Unicorn", "include_path" => ['spec/helpers/unicorn.pb.rb'])  }
    before do
        plugin.register
    end

    it "should return an event from protobuf encoded data" do
    
      data = {:colour => 'rainbow', :horn_length => 18, :last_seen => 1420081471}
      unicorn = Animal::Unicorn.new(data)
        
      plugin.decode(unicorn.serialize_to_string) do |event|

        expect(event["colour"] ).to eq(data[:colour] )
        expect(event["horn_length"] ).to eq(data[:horn_length] )
      end
    end
  end
end
