module UsersHelper
  
  def user_name_chenge(book)
    User.find_by(id: book.user_id).name
  end
end
