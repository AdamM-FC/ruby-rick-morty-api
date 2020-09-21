class KafkaTransformer
    def initialize
        seed_brokers = ['localhost:9092']
        @client = Kafka.new(seed_brokers)
        @producer = @client.producer
        @producer_topic = 'transform-topic'
        @subscriber_topic = 'raw-data-topic'
    end
    
    def subscribe
        @consumer = @client.consumer(group_id: 'rick-morty-transformer')
        @consumer.subscribe(@subscriber_topic)
        @consumer.each_message do |message| 
            json = transform_json(message.value)
            produce(json)
        end
    end
    
    def transform_json(json)
        hash_map = JSON.parse(json)
        hash_map.merge!(timestamp: Time.now)
        hash_map.to_json
    end

    def produce(json)
        @producer.produce(json, topic: @producer_topic)
        @producer.deliver_messages
        @producer.shutdown
    end
end