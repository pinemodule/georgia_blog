module Kennedy
  class Category < ActiveRecord::Base

    paginates_per 20

    attr_accessible :name, :slug

    acts_as_tree orphan_strategy: :rootify

    has_and_belongs_to_many :posts

    validates :name, presence: true
    validates :slug, presence: true

    before_validation on: :create do
      self.slug ||= self.name.try(:parameterize)
    end

  end
end