FactoryGirl.define do
  factory :kennedy_post, class: Kennedy::Post do
    template 'one-column'
    sequence(:slug) {|n| "post#{n}"}
    association :status, factory: :georgia_status
  end
end