class UserMailer < ApplicationMailer
    def trader_approved_email(user)
        @user = user
        mail(to: @user.email, subject: 'Your trader account has been approved')
    end
end
