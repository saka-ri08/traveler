class PostsController < ApplicationController
  def new
    @post = Post.new
  end

  def create
   @post = current_user.posts.new(post_params)

   if @post.save
      redirect_to @post
    else
     render :new
    end
  end

  def index
    @posts = Post.page(params[:page]).reverse_order # 1ページ分だけポストを取得
  end

  def show
    @post = Post.find(params[:id])
    @comment = Comment.new
    @comments = @post.comments.page(params[:page]).per(7).reverse_order
  end
  # findメソッドで1つのidを指定してデータを1つとってきて@postに入れる
  # 1ページに7コメントまで表示、最新コメントを上に表示
  
  def edit
    @post = Post.find(params[:id])
  end

  def update
    post = Post.find(params[:id])
    post.update(post_params)
    redirect_to post_path(post.id)
  end

  def destroy
    post = Post.find(params[:id])
    post.destroy
    redirect_to posts_path
  end

  private
  def post_params
    params.require(:post).permit(:user_id, :location, :text, :image)
  end
  # post_paramsにはいるデータを定義するストロングパラメータ

end
