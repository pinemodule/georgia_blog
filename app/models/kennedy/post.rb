module Kennedy
  class Post < Georgia::Page

    has_and_belongs_to_many :categories

    scope :recent, order(:published_at)

    searchable do
      text :title, stored: true do
        contents.map(&:title).join(', ')
      end
      text :excerpt, stored: true do
        contents.map(&:excerpt).join(', ')
      end
      text :text do
        contents.map(&:text).join(', ')
      end
      text :keywords do
        contents.map(&:keyword_list).flatten.join(', ')
      end
      text :tags do
        tag_list.join(', ')
      end
      text :url
      text :template
      text :status_name
      string :type
      string :title
      string :excerpt
      string :text
      string :url
      string :template
      string :status_name
      string :keywords, stored: true, multiple: true do
        contents.map(&:keyword_list).flatten
      end
      string :tag_list, stored: true, multiple: true #Facets (multiple)
      string :tags do #Ordering (single list)
        tag_list.join(', ')
      end
      string :month, stored: true
      string :categories, multiple: true, stored: true do
        categories.map(&:name)
      end
    end

    def month
      @month ||= published_at.strftime('%B %Y')
    end

    class << self
      def extra_search_params
        Proc.new {
          facet :month, :categories
          with(:month, params[:m]) unless params[:m].blank?
          with(:categories, params[:c]) unless params[:t].blank?
        }
      end
    end

  end

end