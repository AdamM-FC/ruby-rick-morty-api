module Kafka
  module Producer
    def producer
      config = { "bootstrap.servers": 'localhost:9092' }
      @producer = Rdkafka::Config.new(config).producer
    end

    def produce(data, topic)
      encoded_data = AVRO_MANAGER.encode_data(data)
      producer.produce(topic: topic, payload: encoded_data)
    end
  end
end
