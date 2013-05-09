module Kennedy
  class Post < Georgia::Page

    attr_accessible :category_ids
    has_and_belongs_to_many :categories

    searchable do
      string :month, stored: true
      string :categories, multiple: true, stored: true do
        categories.map(&:name)
      end
    end

    def month
      @month ||= published_at.strftime('%B %Y')
    end

  end
end