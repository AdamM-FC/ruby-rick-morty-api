class KafkaTransformer
  def initialize
    @client = Kafka.new(KAFKA_SEED_BROKERS)
    @producer = @client.producer
    Thread.new { subscribe }
  end

  def subscribe
    @consumer = @client.consumer(group_id: 'rick-morty-transformer')
    @consumer.subscribe(RAW_DATA_TOPIC)
    @consumer.each_message do |message|
      updated_data = append_timestamp(message.value)
      produce(updated_data)
    end
  end

  def append_timestamp(data)
    decoded_data = AVRO_MANAGER.decode_data(data)
    decoded_data.merge!(timestamp: Time.now)
    AVRO_MANAGER.encode_data(decoded_data)
  end

  def produce(data)
    @producer.produce(data, topic: TRANSFORMED_DATA_TOPIC)
    @producer.deliver_messages
    @producer.shutdown
  end
end