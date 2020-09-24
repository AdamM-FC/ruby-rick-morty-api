require_relative 'kafka_transformer'
module Transformer
    class Main
        def initialize
            p 'Starting Transformer app'
            KafkaTransformer.new
        end
    end
end
