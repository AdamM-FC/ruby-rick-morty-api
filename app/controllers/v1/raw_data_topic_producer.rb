module V1
  require 'kafka'
  require 'json'

  class RawDataTopicProducer
    def initialize
      client = Kafka.new(KAFKA_SEED_BROKERS)
      @producer = client.producer
    end

    def produce(action, params)
      json = [
        action: action,
        data: params.as_json
      ].to_json

      @producer.produce(json, topic: RAW_DATA_TOPIC)
      @producer.deliver_messages
    end
  end
end
