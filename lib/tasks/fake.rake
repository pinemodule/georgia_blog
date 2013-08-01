namespace :kennedy do

  desc "Fake lorem ipsum posts # requires gem 'faker'"
  task fake: :environment do
    current_user = Georgia::User.first
    10.times do
      title = Faker::Lorem.sentence
      Georgia::Post.new(slug: title.parameterize) do |post|
        post.contents << Georgia::Content.new(locale: 'en',
          title: title,
          excerpt: Faker::Lorem.paragraph,
          text: Faker::Lorem.paragraphs(4).join(' '))
      end.publish(current_user).save!
    end
    Georgia::Post.reindex
  end

end