module Georgia
  class Post < Georgia::Page

    include Georgia::Indexer::Adapter
    is_searchable({
      solr: Georgia::Concerns::SolrGeorgiaPostExtension,
      tire: Georgia::Concerns::TireGeorgiaPostExtension
    })

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
  end
end