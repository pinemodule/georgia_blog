module Georgia
  module Blog
    class Post < Georgia::Page

      has_one :post_data, foreign_key: :post_id
      accepts_nested_attributes_for :post_data

      acts_as_taggable_on :categories

      delegate :published_at, :month, :year, to: :post_data, prefix: false, allow_nil: true

      scope :recent, joins(:post_data).order("georgia_post_data.published_at DESC")
      class << self
        alias_method :latest, :recent
      end

      scope :by_tag, -> (tags) {tagged_with(tags, on: :tags)}
      scope :by_category, -> (categories) {tagged_with(categories, on: :categories)}
      scope :not_postponed, -> (time) { joins(:post_data).where(["georgia_post_data.published_at <= ?", time]).order("georgia_post_data.published_at DESC") }
      scope :by_year_and_month, -> (year, month) { joins(:post_data).where(["georgia_post_data.published_at >= ? AND georgia_post_data.published_at <= ?", Time.new(year, month), Time.new(year, month)+1.month]).order("georgia_post_data.published_at DESC") }

      def self.policy_class
        Georgia::PagePolicy
      end

    end
  end
end