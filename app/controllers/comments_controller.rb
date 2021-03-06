class CommentsController < ApplicationController
  before_action :set_comment, only: %i[edit update destroy]
  before_action :require_user, only: %i[edit update destroy]
  before_action :require_same_user, only: %i[edit update destroy]

  def new
    @article_id = params[:article_id]
    @comment = Comment.new
  end

  def show; end

  def create
    @comment = Comment.new(comment_params)
    @comment.user_id = current_user.id
    @comment.article_id = params[:article_id]

    if @comment.save
      redirect_to article_path(@comment.article)
    else
      flash[:notice] = 'Something Went Wrong.'
      render 'new'
    end
  end

  def edit; end

  def update
    if @comment.update(comment_params)
      flash[:notice] = 'Comment was updated successfully.'
      redirect_to @article
    else
      render 'edit'
    end
  end

  def destroy
    @comment.destroy
    redirect_to article_path(@article)
  end

  private

  def comment_params
    params.require(:comment).permit(:comment)
  end

  def set_comment
    @comment = Comment.find(params[:id])
    @article = Article.find(@comment.article_id)
  end

  def require_same_user
    if current_user != @comment.user
      flash[:alert] = 'You can only edit or delete your own comment.'
      redirect_to @article
    end
  end
end
