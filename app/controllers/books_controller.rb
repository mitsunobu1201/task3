class BooksController < ApplicationController
  
    def index
      @book = Book.new
      @books = Book.all
      @user = current_user
    end

    def show
      @book = Book.new
      @books = Book.find(params[:id])
      @user = @books.user
    end
    
    def edit
      @book = Book.find(params[:id])
        #投稿ユーザーと現在のユーザーが一致するか。一致しなければindexへ転送
      if @book.user == current_user
        render :edit
      else
        redirect_to books_path
      end
    end
    
    def create
      @user = current_user
      @books = Book.all
      @book = Book.new(post_book)
      
      @book.user_id = current_user.id
      #投稿フォームに空がないかチェック。もし空があればindexへ転送し、エラーメッセージ表示。(バリデーションの設定参照)
      if @book.save
       flash[:notice] = "You have created book successfully."
       redirect_to book_path(@book.id)
      else
       render :index
      end
    end
    
    def update
      @book = Book.find(params[:id])
      #投稿フォームに空がないかチェック。もし空があれば再度編集画面へ転送し、エラーメッセージ表示。(バリデーションの設定参照)
      if @book.update(post_book)
      redirect_to book_path(@book.id)
      flash[:notice] = "You have updated book successfully."
      else 
        render :edit
      end
    end
    
    def destroy
      @book = Book.find(params[:id])
      @book.destroy
      redirect_to books_path
      flash[:notice] = "You have delete book successfully."
    end
  
    def post_book
      params.require(:book).permit(:title, :body)
    end

end
