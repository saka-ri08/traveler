class PostsController < ApplicationController
  def new
    @post = Post.new
  end

  def create
    post = Post.new(post_params) # データ新規登録のために空のインスタンスを作成
    post.save # データを保存
    redirect_to '/top' # トップ画面へ移動
  end

  private # データ送信の安全性担保のためのストロングパラメータ
  def post_params # post_paramsに入るデータを定義
    params.require(:post).permit(:location, :text)
  end
end
