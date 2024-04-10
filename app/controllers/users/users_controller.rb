class Users::UsersController < ApplicationController
    include RackSessionFix
    respond_to :json

    def portfolio
        @stocks = current_user.stocks
        render json: @stocks
    end

end
