class User < ApplicationRecord
  validates :name, {presence: true}
  validates :email, {presence: true, uniqueness: true}
  validates :password, {presence: true}
  
   # ユーザーに紐付いたPostインスタンスを戻り値として返すpostsメソッドを定義しましょう。
   def posts
    return Post.where(user_id: self.id)
  end
end
