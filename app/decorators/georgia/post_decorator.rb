module Georgia
  class PostDecorator < Georgia::PageDecorator

    def template_path
      "posts/templates/#{model.template}"
    end

    def url options={}
      localized_slug(options) + blog_slug + categorized_url
    end

    def localized_slug options={}
      if options[:locale].present?
        "/#{options[:locale]}/"
      else
        (I18n.available_locales.length > 1) ? "/#{I18n.locale.to_s}/" : '/'
      end
    end

    def categorized_url options={}
      category = options[:category] || source.categories.first
      [category.try(:slug), source.slug].compact.join('/')
    end

    def blog_slug
      'blog/'
    end

  end
end