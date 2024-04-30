# app/controllers/users/confirmations_controller.rb
class Users::ConfirmationsController < Devise::ConfirmationsController
    protected
  
    # The path used after confirmation.
    def after_confirmation_path_for(resource_name, resource)
      # Set your custom redirect path here
      your_custom_redirect_path = "http://localhost:3000/login"
    end
  end
  