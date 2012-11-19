module Kennedy
  class CategoriesController < Kennedy::ApplicationController

    load_and_authorize_resource class: Kennedy::Category

    def index
      @categories = CategoryDecorator.decorate(Category.order('updated_at DESC').page(params[:category]))
    end

    def show
      redirect_to edit_category_path(params[:id])
    end

    def new
      @category = CategoryDecorator.decorate(Category.new)
    end

    def edit
      @category = CategoryDecorator.decorate(Category.find(params[:id]))

    end

    def create
      @category = CategoryDecorator.decorate(Category.new(params[:category]))

      if @category.save
        redirect_to [:edit, @category], notice: 'Category was successfully created.'
      else
        render :new
      end
    end

    def update
      @category = CategoryDecorator.decorate(Category.find(params[:id]))

      if @category.update_attributes(params[:category])
        redirect_to [:edit, @category], notice: 'Category was successfully updated.'
      else
        render :edit
      end
    end

    def destroy
      @category = Category.find(params[:id])

      if @category.destroy
        redirect_to categories_url, notice: 'Category was successfully deleted.'
      else
        redirect_to categories_url, alert: 'Oups. Something went wrong.'
      end
    end

    def sort
      if params[:category]
        params[:category].each_with_index do |id, index|
          Category.update_all({position: index+1}, {id: id})
        end
      end
      render nothing: true
    end

  end

end