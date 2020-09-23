HOST = 'http://localhost:3000'.freeze

KAFKA_SEED_BROKERS = ['localhost:9092'].freeze

RAW_DATA_TOPIC = 'raw-data-topic'.freeze
TRANSFORMED_DATA_TOPIC = 'transform-topic'.freeze

AVRO_MANAGER = AvroManager.new 
RAW_DATA_PRODUCER = RawDataProducer.new 