module Kennedy
  class CommentsController < Kennedy::ApplicationController

    load_and_authorize_resource class: Kennedy::Comment

    def index
      @comments = CommentDecorator.decorate(Comment.order('updated_at DESC').page(params[:comment]))
    end

    def search
      @comments = CommentDecorator.decorate(Comment.search(params[:query]).page(params[:comment]))
      render :index
    end

    def show
      @comment = CommentDecorator.decorate(Comment.find(params[:id]))
    end

    def destroy
      @comment = Comment.find(params[:id])

      if @comment.destroy
        redirect_to comments_url, notice: 'Comment was successfully deleted.'
      else
        redirect_to comments_url, alert: 'Oups. Something went wrong.'
      end
    end

    def publish
      @comment = CommentDecorator.decorate(Comment.find(params[:id]))
      @comment.publish current_user
      if @comment.save
        # Notifier.notify_users(@comment, "#{current_user.name} has published the job '#{@comment.title}'").deliver
        redirect_to :back, notice: "'#{@comment.title}' was successfully published."
      else
        render :edit, alert: "Oups. Something went wrong."
      end
    end

    def unpublish
      @comment = CommentDecorator.decorate(Comment.find(params[:id]))
      @comment.unpublish
      if @comment.save
        # Notifier.notify_users(@comment, "#{current_user.name} has unpublished the job '#{@comment.title}'").deliver
        redirect_to :back, notice: "'#{@comment.title}' was successfully unpublished."
      else
        render :edit
      end
    end

  end

end