# frozen_string_literal: true
# SupportSerializer
class SupportSerializer < ActiveModel::Serializer
  attributes :id, :firstname, :lastname, :email, :title, :gender, :country, :age, :educational_attainment, :profession,
             :avatar, :interests, :introduction, :role
end
