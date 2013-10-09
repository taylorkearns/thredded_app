class RegistrationsController < Devise::RegistrationsController
  def update
    self.resource = resource_class.to_adapter.get!(send(:"current_#{resource_name}").to_key)

    if update_status
      if is_navigational_format?
        set_flash_message :notice, flash_key
      end

      sign_in resource_name, resource, bypass: true
      respond_with resource, location: after_update_path_for(resource)
    else
      clean_up_passwords resource
      respond_with resource
    end
  end

  private

  def sign_up_params
    params
      .require(:user)
      .permit(:name, :email, :password, :password_confirmation)
  end

  def resource_params
    params
      .require(:user)
      .permit(
        :name,
        :time_zone,
        :password,
        :password_confirmation,
        :current_password
      )
  end

  def update_status
    password_set? ?
      resource.update_with_password(resource_params) :
      resource.update_without_password(resource_params)
  end

  def flash_key
    if resource.respond_to?(:unconfirmed_email)
      prev_unconfirmed_email = resource.unconfirmed_email
    end

    update_needs_confirmation?(resource, prev_unconfirmed_email) ?
      :update_needs_confirmation :
      :updated
  end

  def password_set?
    resource_params['password'].present? &&
      resource_params['password_confirmation'].present?
  end
end
