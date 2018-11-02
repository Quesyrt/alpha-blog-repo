class UsersController < ApplicationController
   before_action :set_user, only: [:show, :edit, :update]
   before_action :require_same_user, only: [:edit, :update, :destroy]
   
   def index
      @users = User.paginate(:page => params[:page], :per_page => 5)
   end
   
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
   
   def edit
   end
   
   def update
      if @user.update(user_params)
         flash[:success] = "Mise à jour de compte effectuée"
         redirect_to articles_path
      else
         render 'edit'
      end
   end
   
   def show
      @user_articles = @user.articles.paginate(:page => params[:page], :per_page => 5)
   end
   
   private
   
   def user_params
       params.require(:user).permit(:username, :email, :password)
   end
   
   def set_user
      @user = User.find(params[:id])
   end
   
   def require_same_user
      if current_user != @user
         flash[:danger] = "Oh tu fais quoi ? C'est pas ton compte alors bouge de là !"
         redirect_to root_path
      end
   end
end