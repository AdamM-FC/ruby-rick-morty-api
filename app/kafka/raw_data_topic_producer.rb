class RawDataTopicProducer
  def initialize
    client = Kafka.new(KAFKA_SEED_BROKERS)
    @producer = client.producer
  end

  def produce(action, object, params, object_id = nil)
    data_hashmap = {
      action: action,
      controller_name: object,
      data: params
    } 

    data_hashmap.merge!(id: object_id) if object_id
    encoded_data = AVRO_MANAGER.encode_data(data_hashmap)
    @producer.produce(encoded_data, topic: RAW_DATA_TOPIC)
    @producer.deliver_messages
  end
end
