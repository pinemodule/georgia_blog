module Kennedy
  class Post < Georgia::Page

    attr_accessible :category_ids
    has_and_belongs_to_many :categories

  end
end