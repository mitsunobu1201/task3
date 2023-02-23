class BooksController < ApplicationController
    def index
    @book = Book.new
    @books = Book.all
    @user = current_user
    end

  def show
    @book = Book.find(params[:id])
  end
  
  def create
    @book = Book.new(post_book)
    @book.save
    redirect_to '/books'
  end


  def post_book
    params.require(:book).permit(:title, :opinion)
  end

end
