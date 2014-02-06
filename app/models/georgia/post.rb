module Georgia
  class Post < Georgia::Page

    Georgia::Indexer.register_extension(:solr, Georgia::Post)
    Georgia::Indexer.register_extension(:tire, Georgia::Post)
    include Georgia::Indexer::Adapter

    has_one :post_data
    delegate :published_at, :month, :year, to: :post_data, prefix: false, allow_nil: true

    scope :recent, order("post_data.published_at DESC")
    class << self
      alias_method :latest, :recent
    end
  end
end