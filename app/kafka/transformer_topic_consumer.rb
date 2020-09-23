class TransformerTopicConsumer
  def initialize
    @client = Kafka.new(KAFKA_SEED_BROKERS)

    Thread.new { subscribe }
  end

  def avro
    AvroTurf.new(schemas_path: 'app/avro/')
  end

  def subscribe
    @consumer = @client.consumer(group_id: 'rick-morty-raw-data')
    @consumer.subscribe(TRANSFORMED_DATA_TOPIC)
    @consumer.each_message do |message|
      hash_map = AVRO_MANAGER.decode_data(message.value)
      hash_map.transform_keys!(&:to_sym)

      data = hash_map[:data]
      object = object_type(hash_map[:controller_name].to_sym)
      action = hash_map[:action].to_sym
      id = hash_map[:id] unless action == :POST
      handle_action(data, action, object, id)
    end
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