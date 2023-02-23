class UsersController < ApplicationController

    def index
      @book = Book.new
      @users = User.all
      @user = current_user
    end
    
    def show
      @user = User.find(params[:id])
      @book = Book.new
      @books = @user.books
    end
    
    def edit
      @users = User.all
      @user = User.find(params[:id])
      #ログインユーザーと編集しようとしているユーザーが一致するか。一致しなければindexへ転送
      if @user == current_user
         @user = User.find(params[:id])
      else
        redirect_to user_path(current_user)
      end
    end  
    
    def update
      @user = User.find(params[:id])
      #ユーザーフォームに空がないかチェック。もし空があれば再度編集画面へ転送し、エラーメッセージ表示。(バリデーションの設定参照)
      if @user.update(user_params)
        redirect_to user_path(@user.id)
        flash[:notice] = "You have updated user successfully."
      else
        render :edit
      end
    end
    
    private
      def user_params
        params.require(:user).permit(:name, :introduction, :profile_image)
      end
    
end
