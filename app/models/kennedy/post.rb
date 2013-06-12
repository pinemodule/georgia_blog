module Kennedy
  class Post < Georgia::Page

    has_and_belongs_to_many :categories

    scope :recent, order(:published_at)

    class << self
      alias_method :latest, :recent
    end

    def month
      @month ||= published_at.strftime('%B %Y') if published_at.present?
    end

    class << self

      def extra_search_params
        Proc.new {
          facet :month, :tags
          with(:month, params[:m]) unless params[:m].blank?
          with(:tags, params[:c]) unless params[:t].blank?
        }
      end

      def indexable_fields
        Proc.new {
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
          string :title
          string :excerpt
          string :text
          string :url
          string :template
          string :status_name
          string :type, stored: true # To indexes the subclasses' names of Kennedy::Post, i.e. Event, Press Releases, etc.
          string :keywords, stored: true, multiple: true do
            contents.map(&:keyword_list).flatten
          end
          string :tag_list, stored: true, multiple: true # Array for facets
          string :tags, stored: true do # Single list for ordering
            tag_list.join(', ')
          end
          string :month, stored: true
        }
      end

    end

    searchable do
      Kennedy::Post.indexable_fields
    end

  end

end