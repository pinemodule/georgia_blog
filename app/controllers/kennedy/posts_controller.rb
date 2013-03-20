module Kennedy
  class PostsController < Kennedy::ApplicationController

    load_and_authorize_resource class: Kennedy::Post

    before_filter :prepare_new_post, only: [:index, :search]

    def index
      @posts = Kennedy::Post.latest.page(params[:post]).decorate
    end

    def search
      @posts = Kennedy::Post.search(params[:query]).page(params[:post]).decorate
      render :index
    end

    def show
      redirect_to edit_post_path(params[:id])
    end

    def edit
      @post = Kennedy::Post.find(params[:id]).decorate
      build_associations
    end

    def create
      @post = Kennedy::Post.new(params[:post])
      @post.slug = @post.decorate.title.try(:parameterize)
      @post.created_by = current_user
      @post.save
    end

    def update
      @post = Kennedy::Post.find(params[:id]).decorate
      @post.update_attributes(params[:post])

      if @post.valid?
        @post.updated_by = current_user
        @post.save!
        redirect_to [:edit, @post], notice: "#{@post.decorate.title} was successfully updated."
      else
        build_associations
        render :edit
      end
    end

    def destroy
      @post = Kennedy::Post.find(params[:id])

      if @post.destroy
        unless (request.referer == post_url(@post)) or (request.referer == edit_post_url(@post))
          redirect_to :back, notice: "#{@post.decorate.title} was successfully deleted."
        else
          redirect_to posts_url, notice: "#{@post.decorate.title} was successfully deleted."
        end
      else
        redirect_to posts_url, alert: 'Oups. Something went wrong.'
      end
    end

    def publish
      @post = Kennedy::Post.find(params[:id]).decorate
      @post.store_revision do
        @post.publish current_user
        @post.save!
      end
      # Notifier.notify_users(@post, "#{current_user.name} has published the job '#{@post.title}'").deliver
      redirect_to :back, notice: "'#{@post.title}' was successfully published."
    end

    def unpublish
      @post = Kennedy::Post.find(params[:id]).decorate
      @post.unpublish
      if @post.save
        # Notifier.notify_users(@post, "#{current_user.name} has unpublished the job '#{@post.title}'").deliver
        redirect_to :back, notice: "'#{@post.title}' was successfully unpublished."
      else
        render :edit
      end
    end

    def ask_for_review
      @post = Kennedy::Post.find(params[:id]).decorate
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
          Kennedy::Post.update_all({position: index+1}, {id: id})
        end
      end
      render nothing: true
    end

    protected

    def build_associations
      I18n.available_locales.map(&:to_s).each do |locale|
        @post.contents << Georgia::Content.new(locale: locale) unless @post.contents.select{|c| c.locale == locale}.any?
      end
    end

    def prepare_new_post
      @post = Kennedy::Post.new
      @post.contents = [Georgia::Content.new(locale: I18n.default_locale)]
    end

  end

end