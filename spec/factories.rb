# -*- coding: utf-8 -*-
FactoryGirl.define do
=begin
  factory :user do
    name     "Michael Hartl"
    email    "michael@example.com"
    password "foobar"
    password_confirmation "foobar"
  end
=end
  factory :user do
    sequence(:name) { |n| "Person #{n}" }  # sequence 方法会生成一系列不重复的 user
    sequence(:email) { |n| "person_#{n}@example.com"}
    password "foobar"
    password_confirmation "foobar"
    factory :admin do
      admin true
    end
  end
end
