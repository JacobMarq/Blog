class ArticlesController < ApplicationController
  before_action :authenticate_user!, except: [:index,  :show]
    
  def like
      @article = Article.find(params[:id])
      if @article.liked?(current_user)
          @like = @article.select_user_like(current_user)
          @like.destroy
          return
      elsif @article.disliked?(current_user)
          @dislike = @article.select_user_dislike(current_user)
          @dislike.destroy
      end
      Like.create(user_id: current_user.id, article_id: @article.id)
  end
  
  def dislike
      @article = Article.find(params[:id])
      if @article.disliked?(current_user)
          @dislike = @article.select_user_dislike(current_user)
          @dislike.destroy
          return
      elsif @article.liked?(current_user)
          @like = @article.select_user_like(current_user)
          @like.destroy
      end
      Dislike.create(user_id: current_user.id, article_id: @article.id)
  end
  
  def favorite
    @article = Article.find(params[:id])
    UserArticle.create(user_id: current_user.id, article_id: @article.id)
  end

  def unfavorite
    @article = Article.find(params[:id])
    @favorite = UserArticle.select{|favorite| favorite.user_id == current_user.id && favorite.article_id == @article.id}
    @favorite.each do |fave|
      fave.destroy
    end
  end
  
  def index(sorting = :id)
    @articles = Article.paginate(page: params[:page], per_page: 4)
  end

  def show
    @article = Article.find(params[:id])
  end

  def new
    @article = Article.new
  end

  def create
    @article = Article.new(article_params)

    if @article.save
      flash[:success] = "Article created successfully"
      redirect_to @article
    else
      flash.now[:error] = "Article was not created"
      render :new
    end
  end

  def edit
    @article = Article.find(params[:id])
  end

  def update
    @article = Article.find(params[:id])
    
    if @article.update(article_params)
      redirect_to @article
    else
      render :edit
    end
  end

  def destroy
    @article = Article.find(params[:id])
    @article.destroy

    redirect_to articles_path
  end

  private
    def article_params
      params.require(:article).permit(:title, :body, :status, :cover, :user_id)
    end

end
