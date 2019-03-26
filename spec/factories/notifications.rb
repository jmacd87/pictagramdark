FactoryBot.define do
  factory :notification do
    user { nil }
    subscribed_user { nil }
    post { "" }
    identifier { 1 }
    type { "" }
    read { false }
  end
end
