# frozen_string_literal: true

module Kafka
  module Producer
    def producer
      config = { "bootstrap.servers": KAFKA_SEED_BROKERS }
      @producer = Rdkafka::Config.new(config).producer
    end

    def produce(data, topic)
      encoded_data = AVRO_MANAGER.encode_data(data)
      producer.produce(topic: topic, payload: encoded_data)
    end
  end
end
