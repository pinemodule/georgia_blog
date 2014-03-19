module Georgia
  class Post < Georgia::Page

    Georgia::Indexer.register_extension(:solr, Georgia::Post)
    Georgia::Indexer.register_extension(:tire, Georgia::Post)
    include Georgia::Indexer::Adapter

    has_one :post_data, foreign_key: :post_id
    accepts_nested_attributes_for :post_data
    attr_accessible :post_data_attributes

    delegate :published_at, :month, :year, to: :post_data, prefix: false, allow_nil: true

    scope :recent, joins(:post_data).order("georgia_post_data.published_at DESC")
    class << self
      alias_method :latest, :recent
    end
  end
end