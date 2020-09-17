module V1
  require 'kafka'
  require 'json'

  class RawDataTopicProducer
    def initialize
      seed_brokers = ['localhost:9092']
      @topic_name = 'raw-data-topic'
      client = Kafka.new(seed_brokers)
      @producer = client.producer
    end

    def produce(action, params)
      json = [
        :action => action,
        :data => params.as_json
      ].to_json

      @producer.produce(json, topic: @topic_name)
      @producer.deliver_messages
    end
  end
end
