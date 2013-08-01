module Georgia
  class Post < Georgia::MetaPage
    include Georgia::Concerns::Blogable
  end
end