require 'active_support/concern'

module Georgia
  module Indexer
    module SolrAdapter
      module GeorgiaPostExtension
        extend ActiveSupport::Concern

        included do
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

          def self.search_index model, params
            model.search(:include => [current_revision: :contents]) do
              fulltext params[:query] do
                fields(:title, :excerpt, :text, :keywords, :tags, :url, :template)
                boost_fields title: 5.0
              end
              facet :state, :template, :tag_list, :month, :tags
              with(:class_name, model.to_s)
              with(:state, params[:s]) unless params[:s].blank?
              with(:template, params[:t]) unless params[:t].blank?
              with(:tag_list).all_of(params[:tg]) unless params[:tg].blank?
              order_by (params[:o] || :updated_at), (params[:dir] || :desc)
              paginate(page: params[:page], per_page: (params[:per] || 25))
              with(:month, params[:m]) unless params[:m].blank?
              with(:tags, params[:c]) unless params[:t].blank?
            end
          end

        end
      end
    end
  end
end