class TransformerTopicConsumer
  def initialize
    @client = Kafka.new(KAFKA_SEED_BROKERS)

    Thread.new { subscribe }
  end

  def subscribe
    @consumer = @client.consumer(group_id: 'rick-morty-raw-data')
    @consumer.subscribe(TRANSFORMED_DATA_TOPIC)
    @consumer.each_message do |message|
      json = JSON.parse(message.value, { symbolize_names: true })

      next if json[:timestamp].nil?

      data = json[:data]
      object = object_type(json[:controller_name].to_sym)
      action = json[:action].to_sym
      handle_action(data, action, object)
    end
  end

  private

  def handle_action(data, action, object)
    case action
    when :POST
      create(data, object)
    when :PUT
      update(data, object)
    when :DELETE
      destroy(data, object)
    else
      p 'Message not supported'
    end
  end

  def create(data, object)
    object.create!(data)
  end

  def update(data, object)
    id = data[:id]
    object_to_update = object.find(id)
    data.except[:id]
    object_to_update.update(data)
  end

  def destroy(data, object)
    id = data[:id]
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
