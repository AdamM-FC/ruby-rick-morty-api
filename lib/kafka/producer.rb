module Kafka
  module Producer
    def producer
      @producer ||= Kafka.new(KAFKA_SEED_BROKERS).producer
    end

    def produce(data, topic)
      encoded_data = AVRO_MANAGER.encode_data(data)
      producer.produce(encoded_data, topic: topic)
      producer.deliver_messages
    end
  end
end
