module FavoritesHelper
  
  def chenge_book(favorite)
    Book.find_by(id: favorite.book_id)
  end
  
  def chenge_user(favorite)
    User.find_by(id: favorite.user_id)
  end
end
