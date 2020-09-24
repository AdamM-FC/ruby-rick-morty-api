class RawDataProducer
  include Kafka::Producer

  def call(action, object, params, object_id = nil)
    data_hashmap = {
      action: action,
      controller_name: object,
      data: params
    }

    data_hashmap.merge!(id: object_id) if object_id

    produce(data_hashmap, RAW_DATA_TOPIC)
  end
end
