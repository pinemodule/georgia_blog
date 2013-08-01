module Kennedy
  class Post < Georgia::MetaPage
    include Kennedy::Concerns::Blogable
  end
end