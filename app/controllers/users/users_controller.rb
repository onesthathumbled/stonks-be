class Users::UsersController < ApplicationController
    include RackSessionFix
    respond_to :json

end
