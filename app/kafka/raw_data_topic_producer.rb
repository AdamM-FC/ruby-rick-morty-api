require 'avro'

class RawDataTopicProducer
  def initialize
    client = Kafka.new(KAFKA_SEED_BROKERS)
    @producer = client.producer

    # timezones = JSON.parse(File.read('./data/timezones.json'))
    # schema_json = JSON.parse(File.read('./data/TimeZone.avsc')).to_json
    # schema = Avro::Schema.parse(schema_json)
    # writer = Avro::IO::DatumWriter.new(schema)

    # buffer = StringIO.new
    # encoder = Avro::IO::BinaryEncoder.new(buffer)
    # writer.write(timezone, encoder)
    # client.produce(buffer.string)
  end

  def produce(action, object, params)
    json = {
      action: action,
      controller_name: object,
      data: params.as_json
    }.to_json

    # Avro thing: begin
    schema_json = JSON.parse(File.read('./avro/HTTPMessage.avsc')).to_json
    schema = Avro::Schema.parse(schema_json)
    writer = Avro::IO::DatumWriter.new(schema)

    buffer = StringIO.new
    encoder = Avro::IO::BinaryEncoder.new(buffer)
    writer.write(json, encoder)
    
    @producer.produce(buffer.string, topic: RAW_DATA_TOPIC)
    @producer.deliver_messages
    # Avro thing: end

    # @producer.produce(json, topic: RAW_DATA_TOPIC)
    # @producer.deliver_messages
  end
end
