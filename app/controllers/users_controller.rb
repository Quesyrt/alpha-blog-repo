class UsersController < ApplicationController
   def new
       @user = User.new
   end
   
   def create
       @user = User.new(user_params)
       if @user.save
           flash[:success] = "Compte de #{@user.username} bien créé !"
           redirect_to articles_path #pas pertinent mais pas d'autre page je crois
       else
           render 'new'
       end
   end
   
   private
   def user_params
       params.require(:user).permit(:username, :email, :password)
   end
end