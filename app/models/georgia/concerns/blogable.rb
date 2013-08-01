require 'active_support/concern'

module Georgia
  module Concerns
    module Blogable
      extend ActiveSupport::Concern

      included do
        attr_accessible :post_data_attributes
        has_one :post_data, class_name: 'Georgia::PostData', foreign_key: :post_id

        accepts_nested_attributes_for :post_data

        scope :recent, order(:published_at)

        class << self
          alias_method :latest, :recent
        end

        def month
          @month ||= published_at.strftime('%B %Y') if published_at.present?
        end

        def year
          @year ||= published_at.year if published_at.present?
        end

        def published_at
          if post_data && post_data.published_at
            post_data.published_at
          else
            read_attribute :published_at
          end
        end

        searchable do
          instance_eval &Georgia::Post.indexable_fields
        end
      end

      module ClassMethods
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
            text :state
            string :title
            string :excerpt
            string :text
            string :url
            string :template
            string :state
            string :type, stored: true # To indexes the subclasses' names of Georgia::Post, i.e. Event, Press Releases, etc.
            string :keywords, stored: true, multiple: true do
              contents.map(&:keyword_list).flatten
            end
            string :tag_list, stored: true, multiple: true # Array for facets
            string :tags, stored: true do # Single list for ordering
              tag_list.join(', ')
            end
            string :month, stored: true
            string :year, stored: true
            string :published_at
          }
        end
      end

    end
  end
end