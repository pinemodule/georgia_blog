namespace :kennedy do

  desc "Convert old blog posts on kennedy_posts to georgia_pages"
  task upgrade: :environment do
    posts = Kennedy::Post.find_by_sql('select * from kennedy_posts')
    posts.each do |p|
      post = Kennedy::Post.new()
      p.attributes.each do |k,v|
        post.send("#{k}=", v) unless k == 'id'
      end
      post.contents = p.contents
      post.save!
    end
  end

end