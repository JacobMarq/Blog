class CommentsController < ApplicationController
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
