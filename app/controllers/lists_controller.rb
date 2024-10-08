class ListsController < ApplicationController
  def index
    @lists = List.all
  end

  def show
    # @list = List.find(params[:list_id])
    @list = List.find(params[:id])
    @bookmark = Bookmark.new
    @movies = Movie.where.not(id: @list.movies)
    @bookmarks = Bookmark.where(list_id: @list.id)
  end

  def new
    @list = List.new
  end

  def create
    @list = List.new(list_params)
    if @list.save
      redirect_to list_path(@list)
    else
      render 'new', status: :unprocessable_entity
    end
  end

  private

  def list_params
    params.require(:list).permit(:name, :photo)
  end
end
