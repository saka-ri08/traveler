class PostsController < ApplicationController
  def new
    @post = Post.new
  end

  def create
    post = Post.new(post_params)
    post.save
    redirect_to '/top'
  end
  # データ新規登録のため空のインスタンスを作成
  # データを保存、トップ画面に移動

  private
  def post_params
    params.require(:post).permit(:location, :text)
  end
  # post_paramsにはいるデータを定義するストロングパラメータ

end
