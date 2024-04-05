class Admins::AdminsController < ApplicationController
    include RackSessionFix
    respond_to :json

    def create_new_trader
        @user = User.new(user_params)

        if @user.save
            render json: {
            status: {code: 200, message: "Signed up sucessfully."},
            data: UserSerializer.new(resource).serializable_hash[:data][:attributes]
        }, status: :ok
        else
            render json: {
            status: {code: 422, message: "User couldn't be created successfully. #{user_errors}"}
        }, status: :unprocessable_entity
        end
    end

    def edit_trader

    end 

    def show_trader

    end

    def show_all_traders

    end

    def pending_traders

    end

    def approve_trader

    end

    def show_transactions

    end

    private

    def user_params
        params.require(:user).permit(:name, :email, :password, :password_confirmation)
    end
end
