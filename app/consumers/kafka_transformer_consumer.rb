class KafkaTransformerConsumer < Racecar::Consumer
  subscribes_to RAW_DATA_TOPIC, start_from_beginning: false

  def process(message)
    p 'KafkaTransformerConsumer received'
    updated_data = append_timestamp(message.value)
    produce(updated_data, topic: TRANSFORMED_DATA_TOPIC, key: 'kafka_transformer_key')
  end

  def append_timestamp(data)
    decoded_data = AVRO_MANAGER.decode_data(data)
    decoded_data.merge!(timestamp: Time.now)
    AVRO_MANAGER.encode_data(decoded_data)
  end
end
