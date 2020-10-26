class LikesController < ApplicationController
  # likes_controllerのアクションは、ログインしているユーザーのみにアクセスを制限しましょう
  before_action :authenticate_user
  
  def create
    @like = Like.new(user_id: @current_user.id, post_id: params[:post_id])
    @like.save
    # 投稿詳細ページにリダイレクトしてください
    redirect_to("/posts/#{params[:post_id]}")
    
  end

  def destroy
    @like = Like.find_by(user_id: @current_user.id, post_id: params[:post_id])
    @like.destroy
    redirect_to("/posts/#{params[:post_id]}")
  end
  
end
