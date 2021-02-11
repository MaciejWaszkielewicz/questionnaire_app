require 'faker'

FactoryBot.define do
  factory :survey do
    title { Faker::Lorem.sentence }
  end

  factory :section do
    association :survey
    title { Faker::Lorem.sentence }
  end

  factory :question do
    association :section
    query { Faker::Lorem.sentence }
    value_type { Answer.descendants.map{ |type| type.to_s }.sample }
    required { false }
    max_characters { 0 }
  end

  factory :option do
    association :question
    answer_text { Faker::Lorem.sentence }
  end

  factory :approach do
    association :survey
  end

  factory :text_answer do
    association :approach
    association :question
    value { nil }
  end

  factory :date_answer do
    association :approach
    association :question
    value { nil }
  end

  factory :select_answer do
    association :approach
    association :question
    value { nil }
  end
end