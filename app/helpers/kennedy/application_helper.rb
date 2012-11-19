module Kennedy
  module ApplicationHelper

    def render_template template, record
      begin
        render "Kennedy/posts/templates/#{template}", template: template, record: record
      rescue
        render "kennedy/posts/templates/custom", template: template, record: record
      end
    end

    def link_to_preview(post, options={})
      options[:method] = :post
      options[:target] = '_blank'
      link_to "#{icon_tag('icon-eye-open')} Preview".html_safe, preview_post_path(post, post: post.attributes.merge(contents: post.contents.map(&:attributes))), options
    end

  end
end
