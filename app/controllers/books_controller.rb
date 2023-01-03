class BooksController < ApplicationController
  before_action :correct_user, only: [:edit, :update, :destroy]

  def show
    @comment = BookComment.new
    @book_new = Book.new
    @book = Book.find(params[:id])
  end

  def index
    @books = Book.all

    if params[:sort] == "0"
      @books = Book.all.order('created_at DESC')
    elsif params[:sort] == "1"
      @books = Book.all.order('star DESC')
    end
    @book = Book.new
  end

  def create
    @book = Book.new(book_params)
    @book.user_id = current_user.id
    tags = params[:book][:tag_name].split(',')
    if @book.save
      #book.rbに記載したインスタントメソッドを実行
      @book.save_tag(tags)
      redirect_to book_path(@book), notice: "You have created book successfully."
    else
      @books = Book.all
      render 'index'
    end
  end

  def edit
    @book = Book.find(params[:id])
    @book.tags.each do |tag|
      tag_names = tag.tag_name
      if @tag_names == nil
        @tag_names ||= tag_names
      else
        @tag_names <<= ',' + tag_names
      end
    end
  end

  def update
    @book = Book.find(params[:id])
    tags = params[:book][:tag_name].split(',')
    if @book.update(book_params)
      #book.rbに記載したインスタントメソッドを実行
      @book.save_tag(tags)
      redirect_to book_path(@book), notice: "You have updated book successfully."
    else
      render "edit"
    end
  end

  def destroy
    @book = Book.find(params[:id])
    @book.destroy
    redirect_to books_path
  end

  private

  def book_params
    params.require(:book).permit(:title, :body, :star)
  end

  def correct_user
    @book = Book.find(params[:id])
    @user = @book.user
    unless @user == current_user
      redirect_to books_path
    end
  end
end
