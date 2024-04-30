class Users::AdminsController < ApplicationController
    include RackSessionFix
    respond_to :json
    before_action :authorize_admin

    def create_new_trader
        @user = User.new(user_params)
            if @user.save
                render json: {
                  status: { code: 200, message: "Signed up successfully." },
                  data: UserSerializer.new(current_user).serializable_hash[:data][:attributes]
                }, status: :ok
            else
                render json: {
                  status: { code: 422, message: "User couldn't be created successfully.", errors: current_user.errors.full_messages }
                }, status: :unprocessable_entity
            end
    end

    def update_trader
        @trader = User.find(params[:id])
        
        if @trader.update(user_params) 
            render json: {
                status: {code: 200, message: "Trader updated successfully."},
                data: UserSerializer.new(@trader).serializable_hash[:data][:attributes]
            }, status: :ok
        else
            render json: {
                status: {code: 422, message: "Failed to updated trader.", errors: @trader.errors.full_messages}
            }, status: :unprocessable_entity
        end
    end
    
    def show_trader
        @user = User.find(params[:id])
        render json: @user
    end

    def show_traders
        @traders = User.where(roles: 0, status: true).order(updated_at: :desc)
        render json: @traders
    end

    def show_pending_traders
        @traders = User.where(roles: 0, status: false).order(created_at: :desc)
        render json: @traders
    end

    # def approve_trader
    #     @trader = User.find(params[:id])
        
    #     if @trader.update(status_param) 
    #         render json: {
    #             status: {code: 200, message: "Trader approved successfully."},
    #             data: UserSerializer.new(@trader).serializable_hash[:data][:attributes]
    #         }, status: :ok
    #     else
    #         render json: {
    #             status: {code: 422, message: "Failed to approve trader.", errors: @trader.errors.full_messages}
    #         }, status: :unprocessable_entity
    #     end
    # end

    def approve_trader
        @trader = User.find(params[:id])
        
        if @trader.update(status_param) 
          UserMailer.trader_approved_email(@trader).deliver_now
      
          render json: {
            status: { code: 200, message: "Trader approved successfully." },
            data: UserSerializer.new(@trader).serializable_hash[:data][:attributes]
          }, status: :ok
        else
          render json: {
            status: { code: 422, message: "Failed to approve trader.", errors: @trader.errors.full_messages }
          }, status: :unprocessable_entity
        end
    end

    def show_transactions
        @transactions = Transaction.joins(:user).select("transactions.*, users.email AS user_email").order(updated_at: :desc)
        render json: @transactions
    end

    def show_admin
        @admin = User.find(params[:id])
        render json: @admin
    end
    
    def show_admins
        @admins = User.where(roles: 1).order(updated_at: :desc)
        render json: @admins
    end

    private

    def status_param
        params.require(:user).permit(:status)
    end

    def user_params
        params.require(:user).permit(:name, :email, :password, :password_confirmation, :id, :status)
    end

    def authorize_admin
        unless current_user && current_user.roles === 1
            render json: {
                status: { code: 403, message: "This feature is only available for administrators." }
            }, status: :forbidden 
        end
    end
end
