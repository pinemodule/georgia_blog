module Kennedy
  class CategoryDecorator < Georgia::ApplicationDecorator

    def url
      "/#{(ancestors.map(&:slug) + [slug]).compact.join('/')}"
    end

  end
end