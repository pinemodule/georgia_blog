module Kennedy
  class CategoryDecorator < ApplicationDecorator

    def url
      "/#{(ancestors.map(&:slug) + [slug]).compact.join('/')}"
    end

  end
end