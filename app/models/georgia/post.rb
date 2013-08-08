module Georgia
  class Post < Georgia::Page
    include Georgia::Concerns::Blogable
  end
end