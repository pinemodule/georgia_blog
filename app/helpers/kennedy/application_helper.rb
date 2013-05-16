module Kennedy
  module ApplicationHelper

    def link_to_preview(post, options={})
      options[:method] = :post
      options[:target] = '_blank'
      link_to "#{icon_tag('icon-eye-open')} Preview".html_safe, main_app.preview_post_path(post, post: post.attributes.merge(contents: post.contents.map(&:attributes))), options
    end

  end
end
