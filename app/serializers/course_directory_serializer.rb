# frozen_string_literal: true
# CourseDirectorySerializer
class CourseDirectorySerializer < ActiveModel::Serializer
  attributes :id, :firstname, :lastname, :email, :title, :gender, :country, :age, :educational_attainment, :profession,
             :avatar, :interests, :introduction, :role
end
