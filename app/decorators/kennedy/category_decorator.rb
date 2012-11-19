module Kennedy
  class CategoryDecorator < ApplicationDecorator
    decorates :category, class: Kennedy::Category

    def url
      "/#{(ancestors.map(&:slug) + [slug]).compact.join('/')}"
    end

  end
end