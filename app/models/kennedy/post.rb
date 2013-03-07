module Kennedy
  class Post < ActiveRecord::Base

    include Georgia::Publishable
    include Georgia::Revisionable
    include Georgia::Contentable
    include Georgia::Previewable
    include Georgia::Searchable
    include Georgia::Taggable
    include Georgia::Slugable
    include Georgia::Templatable
    # include Georgia::Orderable Do no scope by parent, no parent_id, why is this scoped anyway?

    has_ancestry orphan_strategy: :rootify

    belongs_to :updated_by, class_name: Georgia::User
    belongs_to :created_by, class_name: Georgia::User

    paginates_per 20

    attr_accessible :category_ids
    has_and_belongs_to_many :categories

    has_many :comments

    belongs_to :updated_by, class_name: Georgia::User
    scope :latest, order('updated_at DESC')

    acts_as_list
    attr_accessible :position

    scope :ordered, order(:position)

  end
end