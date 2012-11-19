module Kennedy
  class PostsController < Kennedy::ApplicationController

    load_and_authorize_resource class: Kennedy::Post

    def index
      @posts = PostDecorator.decorate(Post.order('updated_at DESC').page(params[:post]))
    end

    def search
      @posts = PostDecorator.decorate(Post.search(params[:query]).page(params[:post]))
      render :index
    end

    def show
      redirect_to edit_post_path(params[:id])
    end

    def new
      @post = PostDecorator.decorate(Post.new)
      build_associations
    end

    def edit
      @post = PostDecorator.decorate(Post.find(params[:id]))
      build_associations
    end

    def create
      @post = PostDecorator.decorate(Post.new(params[:post]))

      if @post.save
        redirect_to [:edit, @post], notice: 'Post was successfully created.'
      else
        build_associations
        render action: :new
      end
    end

    def update
      @post = PostDecorator.decorate(Post.find(params[:id]))

      @post.store_revision do
        @post.update_attributes(params[:post])
        @post.updated_by = current_user
      end

      if @post.save!
        redirect_to [:edit, @post], notice: 'Post was successfully updated.'
      else
        build_associations
        render :edit
      end
    end

    def destroy
      @post = Post.find(params[:id])

      if @post.destroy
        redirect_to posts_url, notice: 'Post was successfully deleted.'
      else
        redirect_to posts_url, alert: 'Oups. Something went wrong.'
      end
    end

    def publish
      @post = PostDecorator.decorate(Post.find(params[:id]))
      @post.publish current_user
      if @post.save
        # Notifier.notify_users(@post, "#{current_user.name} has published the job '#{@post.title}'").deliver
        redirect_to :back, notice: "'#{@post.title}' was successfully published."
      else
        render :edit, alert: "Oups. Something went wrong."
      end
    end

    def unpublish
      @post = PostDecorator.decorate(Post.find(params[:id]))
      @post.unpublish
      if @post.save
        # Notifier.notify_users(@post, "#{current_user.name} has unpublished the job '#{@post.title}'").deliver
        redirect_to :back, notice: "'#{@post.title}' was successfully unpublished."
      else
        render :edit
      end
    end

    def ask_for_review
      @post = PostDecorator.decorate(Post.find(params[:id]))
      @post.wait_for_review
      if @post.save
        # Notifier.notify_editors(@post, "#{current_user.name} is asking you to review job '#{@post.title}'").deliver
        respond_to do |format|
          format.html {redirect_to :back, notice: "You have succesfully asked for a review."}
          format.js { render layout: false }
        end
      else
        respond_to do |format|
          format.html {redirect_to :back, error: "Something went wrong."}
          format.js { render layout: false }
        end
      end
    end

    def sort
      if params[:post]
        params[:post].each_with_index do |id, index|
          Post.update_all({position: index+1}, {id: id})
        end
      end
      render nothing: true
    end

    protected

    def build_associations
      I18n.available_locales.map(&:to_s).each do |locale|
        @post.contents << Georgia::Content.new(locale: locale) unless @post.contents.find_by_locale(locale).present?
      end
    end

  end

end