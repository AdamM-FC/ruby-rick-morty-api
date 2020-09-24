class AvroManager
  def initialize
    @avro = AvroTurf.new(schemas_path: 'app/avro/')
  end

  def encode_data(data)
    @avro.encode(data, schema_name: 'schemas')
  end

  def decode_data(data)
    @avro.decode(data, schema_name: 'schemas')
  end
end
