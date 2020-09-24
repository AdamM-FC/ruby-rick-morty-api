# frozen_string_literal: true

HOST = 'http://localhost:3000'

KAFKA_SEED_BROKERS = 'localhost:9092'

RAW_DATA_TOPIC = 'raw-data-topic'
TRANSFORMED_DATA_TOPIC = 'transform-topic'

AVRO_MANAGER = Avro::AvroManager.new
RAW_DATA_PRODUCER = RawDataProducer.new
