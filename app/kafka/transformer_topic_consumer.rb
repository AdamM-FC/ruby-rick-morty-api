class TransformerTopicConsumer
  def initialize
    @client = Kafka.new(KAFKA_SEED_BROKERS)

    Thread.new { subscribe }
  end

  def subscribe
    @consumer = @client.consumer(group_id: 'rick-morty-transformer')
    @consumer.subscribe(TRANSFORMED_DATA_TOPIC)
    @consumer.each_message do |message|
      json = JSON.parse(message.value, { symbolize_names: true })

      next if json[:timestamp].nil?

      data = json[:data]
      action = json[:action].to_sym
      handle_action(data, action)
    end
  end

  private

  def handle_action(data, action)
    case action
    when :POST
      create(data)
    when :PATCH
      update(data)
    when :DELETE
      destroy(data)
    else
      p 'Message not supported'
    end
  end

  def create(data)
    @character = Character.create!(data)
  end

  def update(data)
    id = data[:id]
    character = Character.find(id)
    data.except[:id]
    character.update(data)
  end

  def destroy(data)
    id = data[:id]
    Character.destroy(id)
  end
end
