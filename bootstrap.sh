#!/bin/bash

rails s &
bundle exec racecar RawDataConsumer &
bundle exec racecar TransformerConsumer