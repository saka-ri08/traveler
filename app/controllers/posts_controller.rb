class PostsController < ApplicationController
  def new
    @post = Post.new
  end

  def create
    post = Post.new(post_params) # データ新規登録のために空のインスタンスを作成
    post.save # データを保存
    redirect_to post_path(post.id) # 移動
  end

  def index # postをすべて取得して@postsに代入
    @posts = Post.all
  end

  def show
    @post = Post.find(params[:id]) # postから1つのidを取得
  end

  private # データ送信の安全性担保のためのストロングパラメータ
  def post_params # post_paramsに入るデータを定義
    params.require(:post).permit(:location, :text)
  end
end
