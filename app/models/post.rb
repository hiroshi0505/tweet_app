class Post < ApplicationRecord
  # contentカラムに対して、文字数を制限するためのバリデーションを追加してください
  validates :content, {presence: true, length: {maximum: 140}}
  validates :user_id, {presence: true}

  # Postモデル内にその投稿に紐付いたuserインスタンスを戻り値として返すuserメソッドを定義しましょう。
  def user
    return User.find_by(id: self.user_id)
  end

end
