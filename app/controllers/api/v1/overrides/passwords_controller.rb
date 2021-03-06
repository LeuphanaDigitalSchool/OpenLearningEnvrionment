# frozen_string_literal: true
module Api
  module V1
    module Overrides
      class PasswordsController < DeviseTokenAuth::ApplicationController
        before_action :set_user_by_token, only: [:update]
        skip_after_action :update_auth_header, only: [:create, :edit]

        # this action is responsible for generating password reset tokens and
        # sending emails
        def create
          return render_create_error_missing_email unless resource_params[:email]

          # give redirect value from params priority
          @redirect_url = params[:redirect_url]

          # fall back to default value if provided
          @redirect_url ||= DeviseTokenAuth.default_password_reset_url

          return render_create_error_missing_redirect_url unless @redirect_url

          # if whitelist is set, validate redirect_url against whitelist
          if DeviseTokenAuth.redirect_whitelist
            unless DeviseTokenAuth::Url.whitelisted?(@redirect_url)
              return render_create_error_not_allowed_redirect_url
            end
          end

          # honor devise configuration for case_insensitive_keys
          @email = if resource_class.case_insensitive_keys.include?(:email)
                     resource_params[:email].downcase
                   else
                     resource_params[:email]
                   end

          q = "uid = ? AND provider='email'"

          # fix for mysql default case insensitivity
          if ActiveRecord::Base.connection.adapter_name.downcase.starts_with? 'mysql'
            q = "BINARY uid = ? AND provider='email'"
          end

          @resource = resource_class.where(q, @email).first

          @errors = nil
          @error_status = 400

          if @resource
            if @resource.invitation_token.present?
              @errors = [I18n.t('devise_token_auth.passwords.not_accepted_invitation')]
              @error_status = 401
            else
              yield @resource if block_given?
              @resource.send_reset_password_instructions(email: @email,
                                                         provider: 'email',
                                                         redirect_url: @redirect_url,
                                                         client_config: params[:config_name])

              if @resource.errors.empty?
                return render_create_success
              else
                @errors = @resource.errors
              end
            end
          else
            @errors = [I18n.t('devise_token_auth.passwords.user_not_found', email: @email)]
            @error_status = 404
          end

          return render_create_error if @errors
        end

        # this is where users arrive after visiting the password reset confirmation link
        def edit
          @resource = resource_class.reset_password_by_token(reset_password_token: resource_params[:reset_password_token])

          if @resource && @resource.id
            client_id  = SecureRandom.urlsafe_base64(nil, false)
            token      = SecureRandom.urlsafe_base64(nil, false)
            token_hash = BCrypt::Password.create(token)
            expiry     = (Time.now + DeviseTokenAuth.token_lifespan).to_i

            @resource.tokens[client_id] = {
              token:  token_hash,
              expiry: expiry
            }

            # ensure that user is confirmed
            @resource.skip_confirmation! if @resource.devise_modules.include?(:confirmable) && !@resource.confirmed_at

            # allow user to change password once without current_password
            @resource.allow_password_change = true

            @resource.save!
            yield @resource if block_given?
            render json: { client_id: client_id, token: token, uid: @resource.uid,
                           reset_password: true, config: params[:config] }, status: :ok
          else
            # render_edit_error
            render json: { errors: 'Wrong' }, status: 404
          end
        end

        def update
          # make sure user is authorized
          return render_update_error_unauthorized unless @resource

          # make sure account doesn't use oauth2 provider
          unless @resource.provider == 'email'
            return render_update_error_password_not_required
          end

          # ensure that password params were sent
          unless password_resource_params[:password] && password_resource_params[:password_confirmation]
            return render_update_error_missing_password
          end

          if @resource.send(resource_update_method, password_resource_params)
            @resource.allow_password_change = false

            yield @resource if block_given?
            return render_update_success
          else
            return render_update_error
          end
        end

        protected

        def resource_update_method
          if DeviseTokenAuth.check_current_password_before_update == false || @resource.allow_password_change == true
            'update_attributes'
          else
            'update_with_password'
          end
        end

        def render_create_error_missing_email
          render json: {
            success: false,
            errors: [I18n.t('devise_token_auth.passwords.missing_email')]
          }, status: 401
        end

        def render_create_error_missing_redirect_url
          render json: {
            success: false,
            errors: [I18n.t('devise_token_auth.passwords.missing_redirect_url')]
          }, status: 401
        end

        def render_create_error_not_allowed_redirect_url
          render json: {
            status: 'error',
            data:   resource_data,
            errors: [I18n.t('devise_token_auth.passwords.not_allowed_redirect_url', redirect_url: @redirect_url)]
          }, status: 422
        end

        def render_create_success
          render json: {
            success: true,
            data: resource_data,
            message: I18n.t('devise_token_auth.passwords.sended', email: @email)
          }
        end

        def render_create_error
          render json: {
            success: false,
            errors: @errors
          }, status: @error_status
        end

        def render_edit_error
          raise ActionController::RoutingError, 'Not Found'
        end

        def render_update_error_unauthorized
          render json: {
            success: false,
            errors: ['Unauthorized']
          }, status: 401
        end

        def render_update_error_password_not_required
          render json: {
            success: false,
            errors: [I18n.t('devise_token_auth.passwords.password_not_required', provider: @resource.provider.humanize)]
          }, status: 422
        end

        def render_update_error_missing_password
          render json: {
            success: false,
            errors: [I18n.t('devise_token_auth.passwords.missing_passwords')]
          }, status: 422
        end

        def render_update_success
          render json: {
            success: true,
            data: resource_data,
            message: I18n.t('devise_token_auth.passwords.successfully_updated')
          }
        end

        def render_update_error
          render json: {
            success: false,
            errors: resource_errors
          }, status: 422
        end

        private

        def resource_params
          params.permit(:email, :password, :password_confirmation, :current_password, :reset_password_token)
        end

        def password_resource_params
          params.permit(*params_for_resource(:account_update))
        end
      end
    end
  end
end
