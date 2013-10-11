module Georgia
  class Post < Georgia::Page

    attr_accessible :published_at

    scope :recent, order("published_at DESC")
    class << self
      alias_method :latest, :recent
    end

    def month
      @month ||= published_at.strftime('%B %Y') if published_at.present?
    end

    def year
      @year ||= published_at.year if published_at.present?
    end

    searchable do
      text :title, stored: true do
        revisions.map{|r| r.contents.map(&:title)}.flatten.uniq.join(', ')
      end
      text :excerpt, stored: true do
        revisions.map{|r| r.contents.map(&:excerpt)}.flatten.uniq.join(', ')
      end
      text :text do
        revisions.map{|r| r.contents.map(&:text)}.flatten.uniq.join(', ')
      end
      text :keywords do
        revisions.map{|r| r.contents.map(&:keyword_list)}.flatten.uniq.join(', ')
      end
      text :tags do
        tag_list.join(', ')
      end
      text :url
      text :template
      string :title
      string :excerpt
      string :text
      string :url
      string :template
      string :state do
        public? ? 'public' : 'private'
      end
      string :class_name do
        self.class.name
      end
      string :keywords, stored: true, multiple: true do
        revisions.map{|r| r.contents.map(&:keyword_list)}.flatten.uniq
      end
      string :tag_list, stored: true, multiple: true # Array for facets
      string :tags, stored: true do # Single list for ordering
        tag_list.join(', ')
      end
      string :month, stored: true
      string :year, stored: true
      time :published_at
      time :updated_at # default order
    end

    class << self

      def extra_search_params
        Proc.new {
          facet :month, :tags
          with(:month, params[:m]) unless params[:m].blank?
          with(:tags, params[:c]) unless params[:t].blank?
        }
      end

    end
  end
end