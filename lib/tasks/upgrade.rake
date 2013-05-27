namespace :kennedy do

  desc "Convert old blog posts on kennedy_posts to georgia_pages"
  task upgrade: :environment do
    puts 'Fetching old blog posts from legacy table and recreating them'
    posts = Kennedy::Post.find_by_sql('select * from kennedy_posts')
    posts.each do |p|
      post = Kennedy::Post.new()
      p.attributes.each do |k,v|
        post.send("#{k}=", v) unless k == 'id'
      end
      post.contents = Georgia::Content.where(contentable_id: p.id).where(contentable_type: 'Kennedy::Post')
      post.save!
      puts "#{post.title} recreated."
    end
  end

end