class CommentsController < ApplicationController
  def new
    @article_id = params[:article_id]
    @comment = Comment.new
  end

  def edit; end

  def create
    @comment = Comment.new(comment_params)
    @comment.user_id = current_user.id
    @comment.article_id = params[:article_id]

    if @comment.save
      current_user.comments << @comment
      @article = Article.find(params[:article_id])
      @article.comments << @comment
      redirect_to article_path(@article)
    else
      flash[:notice] = 'Something Went Wrong.'
      render 'new'
    end
  end

  private

  def comment_params
    params.require(:comment).permit(:comment)
  end
end
