module V1
  require 'kafka'

  class TransformerTopicConsumer
    def initialize
      @client = Kafka.new(KAFKA_SEED_BROKERS)
      subscribe
    end

    def subscribe
      @consumer = @client.consumer(group_id: 'rick-morty-transformer')
      @consumer.subscribe(TRANSFORMED_DATA_TOPIC)
      @consumer.each_message do |message|
        json = transform_json(message.value)
        next if json[:timestamp].nil?

        action = json[:action]
        data = json[:data]

        case action
        when :CREATE
          create(data)
        when :UPDATE
          update(data)
        when :DESTROY
          destroy(data)
        else
          p 'Message not supported'
        end
      end
    end

    def create(data)
      # @character = Character.create!(character_params)
      # json_response(@character, :created)
    end

    def update(data)
      # @character.update(character_params)
    end

    def destroy(data)
      # @character.destroy
    end
  end
end
