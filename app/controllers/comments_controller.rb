class CommentsController < ApplicationController
    def like
        @article = Article.find(params[:id])
        @comment = @article.comments.find(params[:id])
        Like.create(user_id: current_user.id, comment_id: @comment.id)
    end
    
    def dislike
        @article = Article.find(params[:id])
        @comment = @article.comments.find(params[:id])
        Dislike.create(user_id: current_user.id, comment_id: @comment.id)
    end
    
    def create
        @article = Article.find(params[:article_id])
        @comment = @article.comments.create(comment_params)
        redirect_to article_path(@article)
    end

    def destroy
        @article = Article.find(params[:article_id])
        @comment = @article.comments.find(params[:id])
        
        if @comment.replies.nil?
            @comment.destroy
        else
            @comment.replies.each do |reply|
                reply.update(:subject_id => @comment.subject_id)
            end

            @comment.destroy
        end

        redirect_to article_path(@article)
    end

    def update
        @article = Article.find(params[:article_id])
        @comment = @article.comments.find(params[:id])
        
        if @comment.update(comment_params)
          redirect_to @article
        else
          render :edit
        end
    end

    private
        def comment_params
            params.require(:comment).permit(:commenter, :body, :status, :subject_id)
        end
end
