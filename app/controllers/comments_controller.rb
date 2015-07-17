class CommentsController < ApplicationController
  layout :determine_layout
  before_action :set_comment, only: [:show, :destroy]

  respond_to :html
  def index
    @comments = Kaminari.paginate_array(Comment.all).page(params[:page])
    respond_with @comments
  end

  def show
    respond_with @comment
  end

  def new
    @comment = Comment.new
    respond_with @comment
  end

  def create
    meal = Meal.where(meal_date: Date.parse(params[:comment][:meal_date])).first
    params[:comment][:user_id] = current_user.id
    @comment = meal.comments.create(comment_params)
    respond_with @comment
  end

  def destroy
    @comment.destroy
    respond_with @comment
  end

  private
  def set_comment
    @comment = Comment.find(params[:id])
  end

  def comment_params
    params.require(:comment).permit(:title, :comment, :user_id)
  end
end
