class KafkaTransformerConsumer < Racecar::Consumer
  subscribes_to TRANSFORMED_DATA_TOPIC, start_from_beginning: false

  def process(message)
    hash_map = AVRO_MANAGER.decode_data(message.value)
    hash_map.transform_keys!(&:to_sym)

    data = hash_map[:data]
    object = object_type(hash_map[:controller_name].to_sym)
    action = hash_map[:action].to_sym
    id = hash_map[:id] unless action == :POST
    handle_action(data, action, object, id)
  end

  def produce(action, object, params, object_id = nil)
    data_hashmap = {
      action: action,
      controller_name: object,
      data: params
    } 

    data_hashmap.merge!(id: object_id) if object_id
    encoded_data = AVRO_MANAGER.encode_data(data_hashmap)

    produce(encoded_data, topic: RAW_DATA_TOPIC, key: 'kafka_transformer_key')
  end
  
  private

  def handle_action(data, action, object, id = nil)
    case action
    when :POST
      create(data, object)
    when :PUT
      update(data, object, id)
    when :DELETE
      destroy(object, id)
    else
      p 'Message not supported'
    end
  end

  def create(data, object)
    object.create!(data)
  end

  def update(data, object, id)
    object_to_update = object.find(id)
    object_to_update.update(data)
  end

  def destroy(object, id)
    object.destroy(id)
  end

  def object_type(controller_name)
    case controller_name
    when :characters
      Character
    when :episodes
      Episode
    when :locations
      Location
    end
  end
end
