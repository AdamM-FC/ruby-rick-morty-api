HOST = 'http://localhost:3000'.freeze

KAFKA_SEED_BROKERS = [ENV.fetch('KAFKA_SEED_BROKER', 'kafka:9092')]

RAW_DATA_TOPIC = 'raw-data-topic'
TRANSFORMED_DATA_TOPIC = 'transform-topic'

RAW_DATA_PRODUCER = RawDataTopicProducer.new
TRANSFORMER_DATA_CONSUMER = TransformerTopicConsumer.new