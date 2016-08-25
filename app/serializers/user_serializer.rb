# frozen_string_literal: true
# CourseManagerSerializer
class UserSerializer < ActiveModel::Serializer
  attributes :id, :firstname, :lastname, :email, :title, :gender, :country, :birthdate, :age, :educational_attainment,
             :profession, :avatar, :interests, :introduction, :role, :role_id, :invitation

  def invitation
    object.invitation_token.present? ? 'Send invitation' : 'Profile created'
  end
end
