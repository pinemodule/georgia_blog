module Kennedy
  class Post < Georgia::Page

    has_and_belongs_to_many :categories

    scope :recent, order(:published_at)

    def month
      @month ||= published_at.strftime('%B %Y')
    end

  end

end