module Kennedy
  class Post < ActiveRecord::Base

    paginates_per 20

    attr_accessible :template, :slug, :published_at, :published_by_id, :category_ids

    validates :template, inclusion: {in: Kennedy.templates, message: "%{value} is not a valid template" }
    validates :slug, uniqueness: true

    acts_as_revisionable associations: :contents
    belongs_to :current_revision, class_name: ActsAsRevisionable::RevisionRecord, foreign_key: :revision_id

    belongs_to :published_by, class_name: Georgia::User
    belongs_to :updated_by, class_name: Georgia::User
    belongs_to :status, class_name: Georgia::Status
    delegate :published?, :draft?, :pending_review?, to: :status

    has_many :contents, class_name: Georgia::Content, as: :contentable, dependent: :destroy
    accepts_nested_attributes_for :contents
    attr_accessible :contents_attributes

    has_and_belongs_to_many :categories
    has_many :comments

    # TODO: make these polymorphic to use accross the board for Georgia & Kennedy
    # has_many :ui_associations, dependent: :destroy
    # has_many :ui_sections, through: :ui_associations
    # has_many :widgets, through: :ui_associations

    include PgSearch
    pg_search_scope :text_search, using: {tsearch: {dictionary: 'english', prefix: true, any_word: true}},
    associated_against: { contents: [:title, :text, :excerpt, :keywords, :slug] }

    default_scope includes(:contents)
    scope :published, joins(:status).where('georgia_statuses' => {name: Georgia::Status::PUBLISHED})
    scope :latest, order('updated_at DESC')

    def self.search query
      query.present? ? text_search(query) : scoped
    end

    def wait_for_review
      self.status = Georgia::Status.pending_review.first
      self
    end

    def publish(user)
      self.published_by = user
      self.status = Georgia::Status.published.first
      self.create_revision!
      self.current_revision = self.last_revision
      self
    end

    def unpublish
      self.published_by = nil
      self.current_revision = nil
      self.status = Georgia::Status.draft.first
      self
    end

    def load_current_revision!
      return self if self.current_revision.blank? or self.current_revision == self.last_revision
      self.class.new().load_raw_attributes! self.current_revision.revision_attributes.symbolize_keys!
    end

    def preview! attributes
      self.load_raw_attributes! attributes
    end

    before_save do
      self.status ||= Georgia::Status.draft.first
    end

    before_validation on: :create do
      self.slug ||= self.contents.map(&:title).compact.first.try(:parameterize) rescue 'undefined'
    end

    protected

    def load_raw_attributes! attributes
      attributes.delete(:contents).each do |content|
        self.contents << Georgia::Content.new(content, without_protection: true)
      end
      self.assign_attributes(attributes, without_protection: true)
      self
    end

  end
end