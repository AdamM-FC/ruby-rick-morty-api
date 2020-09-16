require 'rails_helper'

RSpec.describe 'Kafka', type: :request do
  describe 'transform_json' do
    let!(:client) { KafkaTransformer.new }
    transformed_json = ''

    before do
      json_example = { name: 'test' }.to_json
      transformed_json = client.transform_json(json_example)
    end

    it 'returns the JSON updated with the timestamp' do
      expect(transformed_json['timestamp']).to_not be_empty
    end
  end
end
