KAFKA_SEED_BROKERS = [ENV.fetch('KAFKA_SEED_BROKER', 'kafka:9092')]

DEFAULT_KAFKA_CONSUMER = 'rick-morty-transformer'
RAW_DATA_TOPIC = 'raw-data-topic'
TRANSFORMED_DATA_TOPIC = 'transform-topic'