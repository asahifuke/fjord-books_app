# frozen_string_literal: true

FactoryBot.define do
  factory :user do
    sequence(:name) { |n| "Test_name#{n}" }
    sequence(:email) { |n| "Test#{n}@gmail.com" }
    sequence(:password) { 'password' }
  end
end
