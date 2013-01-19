module Kennedy
  class PostDecorator < ApplicationDecorator

    PUBLISHED = 'Published'
    PENDING = 'Pending'
    UNDER_REVIEW = 'Waiting for Review'
    NOT_TRANSLATED = 'Missing Translation'
    SEO_INCOMPLETE = 'SEO Incomplete'

    def title
      content.title
    end

    def text
      content.text.html_safe
    end

    def url
      "/#{[categories.first.try(:slug), slug].compact.join('/')}"
    end

    def slug_tag
      h.content_tag :span, parent.present? ? "/#{parent.slug}/#{model.slug}" : model.slug, class: 'light'
    end

    def status_tag
      h.content_tag(:span, class: "label label-#{status.try(:label)}") do
        h.raw(h.icon_tag("icon-white #{status.try(:icon)}") + ' ' + status.try(:name))
      end
    end

  end
end