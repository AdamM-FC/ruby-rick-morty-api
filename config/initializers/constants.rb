HOST = 'http://localhost:3000'.freeze

KAFKA_SEED_BROKERS = ['localhost:9092']

RAW_DATA_TOPIC = 'raw-data-topic'
TRANSFORMED_DATA_TOPIC = 'transform-topic'

RAW_DATA_PRODUCER = V1::RawDataTopicProducer.new
TRANSFORMER_DATA_CONSUMER = V1::TransformerTopicConsumer.new

KAFKA_TRANSFORMER = KafkaTransformer.new 