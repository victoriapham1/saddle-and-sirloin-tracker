class Admins::OmniauthCallbacksController < Devise::OmniauthCallbacksController
# created a different google_oauth2 to contain all the required columns for the admin like refresh_token, access_token, and expires_at
  def google_oauth2
    @admin = Admin.from_omniauth(request.env["omniauth.auth"])
    if @admin.persisted?
      flash[:notice] = I18n.t "devise.omniauth_callbacks.success", :kind => "Google"
      auth = request.env["omniauth.auth"]
      @admin.access_token = auth.credentials.token
      @admin.expires_at = auth.credentials.expires_at
      @admin.refresh_token = auth.credentials.refresh_token
      @admin.save!
      sign_in(@admin)
      redirect_to events_path
    else
      session["devise.google_data"] = request.env["omniauth.auth"]
      redirect_to new_admin_session_path
    end
  end
    # def google_oauth2
    #   admin = Admin.from_google(**from_google_params)

    #   if admin.present?
    #     sign_out_all_scopes
    #     flash[:success] = t 'devise.omniauth_callbacks.success', kind: 'Google'
    #     sign_in_and_redirect admin, event: :authentication
    #   else
    #     flash[:alert] = t 'devise.omniauth_callbacks.failure', kind: 'Google', reason: "#{auth.info.email} is not authorized."
    #     redirect_to new_admin_session_path
    #   end
    # end

    protected

    def after_omniauth_failure_path_for(_scope)
      new_admin_session_path
    end

    def after_sign_in_path_for(resource_or_scope)
      stored_location_for(resource_or_scope) || root_path
    end

    private

    def from_google_params
      @from_google_params ||= {
        uid: auth.uid,
        email: auth.info.email,
        full_name: auth.info.name,
        avatar_url: auth.info.image
      }
    end

    def auth
      @auth ||= request.env['omniauth.auth']
    end
  end
