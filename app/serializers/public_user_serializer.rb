# frozen_string_literal: true
# PublicUserSerializer
class PublicUserSerializer < ActiveModel::Serializer
  attributes :id, :firstname, :lastname, :email, :gender, :country, :birthdate, :age, :educational_attainment,
             :avatar, :role
end
