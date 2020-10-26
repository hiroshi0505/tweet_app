class PostsController < ApplicationController
  before_action :authenticate_user
  before_action :ensure_correct_user, {only: [:edit, :update, :destroy]}

  def index
    # order(カラム名: 並び替えの順序）昇順（:asc）降順（:desc）
    @posts = Post.all.order(created_at: :desc)
  end

  def show
    @id = params[:id]
    # find_byを用いてpostsテーブルから「params[:id]」に対応するデータを取り出し、変数@postに代入
    @post = Post.find_by(id: params[:id])
    # Postモデル内に定義したuserメソッドから対応するデータを取り出し、変数@userに代入
    @user = @post.user
    # Likesテーブルからpost_idカラムが@post.idのデータ数をカウントし、変数@likes_countに代入
    @likes_count = Like.where(post_id: @post.id).count
  end

  def new
    # newメソッドを用いて、Postクラスのインスタンスを作成し、変数@postに代入してください
    @post = Post.new
  end

  def create
    # フォームから送信されたデータを受け取り、保存する処理を追加してください
    @post = Post.new(content: params[:content], user_id: @current_user.id)
    if @post.save
      flash[:notice] = "投稿を作成しました"
      # redirect_to("URL")
      redirect_to("/posts/index")
    else
      # renderメソッドを用いて、newアクションを経由せず、posts/new.html.erbが表示されるようにしてください
      render("posts/new")
    end
  end

  def edit
    @post = Post.find_by(id: params[:id])
  end

  def update
    @post = Post.find_by(id: params[:id])
    @post.content = params[:content]
    if @post.save
      flash[:notice] = "投稿を編集しました"
      # redirect_to("URL")
      redirect_to("/posts/index")
    else
      # renderメソッドを用いて、editアクションを経由せず、posts/edit.html.erbが表示されるようにしてください
      render("posts/edit")
    end
  end

  def destroy
    @post = Post.find_by(id: params[:id])
    @post.destroy
    flash[:notice] = "投稿を削除しました"
      # redirect_to("URL")
    redirect_to("/posts/index")
  end

  def ensure_correct_user
    @post = Post.find_by(id: params[:id])
    if @post.user_id != @current_user.id
      flash[:notice] = "権限がありません"
      redirect_to("/posts/index")
    end
  end

end