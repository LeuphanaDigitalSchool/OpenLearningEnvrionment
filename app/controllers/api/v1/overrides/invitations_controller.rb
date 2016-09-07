# frozen_string_literal: true
module Api
  module V1
    module Overrides
      # InvitationsController
      class InvitationsController < Devise::InvitationsController
        include InvitableMethods
        before_action :authenticate_user!, only: :create
        before_action :resource_from_invitation_token, only: [:edit, :update]

        def create
          User.invite!(invite_params, current_api_v1_user)
          render json: { success: ['User created.'] }, status: :created
        end

        def edit
          render json: { invitation_token: params[:invitation_token] }, status: :ok
        end

        def update
          user = User.accept_invitation!(accept_invitation_params)
          if @user.errors.empty?
            render json: { success: ['User updated.'] }, status: :accepted
          else
            render json: { errors: user.errors.full_messages },
                   status: :unprocessable_entity
          end
        end

        private

        def invite_params
          params.require(:user).permit(:email, :invitation_token, :provider, :skip_invitation)
        end

        def accept_invitation_params
          params.require(:user).permit(:password, :password_confirmation, :invitation_token, :interests, :gender,
                                       :title, :country, :educational_attainment, :introducion, :avatar, :data_privacy,
                                       :terms_and_conditions, :honor_code, :birthdate, :profession, :introduction)
        end
      end
    end
  end
end
