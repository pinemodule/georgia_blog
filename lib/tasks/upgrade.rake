namespace :kennedy do

  desc "Convert old blog posts on Kennedy::Post to Georgia::Post"
  task upgrade: :environment do
    puts 'Converting Kennedy::Post to Georgia::Post'
    Kennedy::Post.update_all(type: 'Georgia::Post')
    Georgia::Post.reindex
    puts 'Converting Kennedy::Post to Georgia::Post. Done.'
  end

end