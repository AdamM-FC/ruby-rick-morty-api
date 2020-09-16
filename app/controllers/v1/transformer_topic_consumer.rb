module V1
    require 'kafka'

    class TransformerTopicConsumer
        def initialize
            seed_brokers = ['localhost:9092']
            @topic_name = 'transform-topic'
            client = Kafka.new(seed_brokers)
            records = client.fetch_messages(topic: topic_name, partition: 0, offset: :earliest)
        end

        def create
            # @character = Character.create!(character_params)
            # json_response(@character, :created)
        end

        def update
            # @character.update(character_params)
        end

        def destroy
            # @character.destroy
        end
    end
end