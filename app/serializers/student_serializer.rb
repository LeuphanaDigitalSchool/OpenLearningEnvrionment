# frozen_string_literal: true
# TeacherSerializer
class StudentSerializer < ActiveModel::Serializer
  attributes :id, :firstname, :lastname, :email, :title, :gender, :country, :birthdate, :age, :educational_attainment,
             :profession, :avatar, :interests, :introduction, :role
end
