require_relative '../config/constants'
require 'json'
require 'kafka'

module Transformer
  class KafkaTransformer
    def initialize
      @client = Kafka.new(KAFKA_SEED_BROKERS, connect_timeout: 10)
      @producer = @client.producer
      subscribe
    end

    def subscribe
      @consumer = @client.consumer(group_id: DEFAULT_KAFKA_CONSUMER)
      @consumer.subscribe(RAW_DATA_TOPIC)
      @consumer.each_message do |message|
        json = transform_json(message.value)
        p json
        produce(json)
      end
    end

    def transform_json(json)
      hash_map = JSON.parse(json)
      hash_map.merge!(timestamp: Time.now)
      hash_map.to_json
    end

    def produce(json)
      @producer.produce(json, topic: TRANSFORMED_DATA_TOPIC)
      @producer.deliver_messages
      @producer.shutdown
    end
  end
end
