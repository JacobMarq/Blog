class ArticlesController < ApplicationController
  def favorite
    @article = Article.find(params[:id])
    UserArticle.create(user_id: current_user.id, article_id: @article.id)
  end
  
  def like
    @article = Article.find(params[:id])
    Like.create(user_id: current_user.id, article_id: @article.id)
  end

  def dislike
    @article = Article.find(params[:id])
    Dislike.create(user_id: current_user.id, article_id: @article.id)
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
      params.require(:article).permit(:title, :body, :status, :cover)
    end

end
