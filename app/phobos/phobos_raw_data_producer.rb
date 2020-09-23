class PhobosRawDataProducer
  include Phobos::Producer

  def initialize(action, object, params, object_id = nil)
    data_hashmap = {
      action: action,
      controller_name: object,
      data: params
    }

    data_hashmap.merge!(id: object_id) if object_id

    encoded_data = AVRO_MANAGER.encode_data(data_hashmap)
    producer.publish(RAW_DATA_TOPIC, encoded_data)
  end
end
