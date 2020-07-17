class CommentsController < ApplicationController
    before_filter :require_login, except: [:create]

    def create
        @comment = Comment.new(comment_params)
        @comment.article_id = params[:article_id]
        @comment.save
        
        flash.notice = "Comment Created!"

        redirect_to article_path(@comment.article)
    end

    def destroy
        @article = Article.find(params[:article_id])
        @comment = @article.comments.find(params[:id])
        @comment.destroy

        flash.notice = "Comment Deleted!"
        
        redirect_back_or_to article_path(@article)
    end

    def comment_params
        params.require(:comment).permit(:author_name, :body)
    end
end
