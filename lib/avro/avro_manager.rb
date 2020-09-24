# frozen_string_literal: true

module Avro
  class AvroManager
    def initialize
      @avro = AvroTurf.new(schemas_path: 'lib/avro/')
    end

    def encode_data(data)
      @avro.encode(data, schema_name: 'schemas')
    end

    def decode_data(data)
      @avro.decode(data, schema_name: 'schemas')
    end
  end
end
