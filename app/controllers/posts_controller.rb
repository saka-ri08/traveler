class PostsController < ApplicationController
  def new
    @post = Post.new
  end

  def create
    post = Post.new(post_params)
    post.save
    redirect_to post_path(post.id)
  end
  # データ新規登録のため空のインスタンスを作成
  # データを保存、トップ画面に移動

  def index
    @posts = Post.all
  end

  def show
    @post = Post.find(params[:id])
  end
  # findメソッドで1つのidを指定してデータを1つとってきて@postに入れる

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
    params.require(:post).permit(:location, :text)
  end
  # post_paramsにはいるデータを定義するストロングパラメータ

end
