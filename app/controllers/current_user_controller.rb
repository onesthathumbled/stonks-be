class CurrentUserController < ApplicationController
  def index
    render json: UserSerialzier.new(current_user).serializeable_hash[:data][:attributes], status: :ok
  end
end