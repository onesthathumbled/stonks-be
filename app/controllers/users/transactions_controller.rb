class Users::TransactionsController < ApplicationController
    include RackSessionFix
    respond_to :json

    private

    def set_user
        @user = current_user
    end
end