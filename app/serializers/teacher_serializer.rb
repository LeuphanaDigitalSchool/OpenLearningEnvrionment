# frozen_string_literal: true
# TeacherSerializer
class TeacherSerializer < ActiveModel::Serializer
  attributes :id, :firstname, :lastname, :email, :title, :gender, :country, :birthdate, :age, :educational_attainment,
             :profession, :avatar, :interests, :introduction, :role, :role_id
end
