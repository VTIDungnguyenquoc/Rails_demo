class BookCategoriesController < ApplicationController
  before_action :set_book_category, only: %i[ show edit update destroy ]

  # GET /book_categories or /book_categories.json
  def index
    @keyword = params[:keyword].to_s.strip
    @userId = Current.session[:user_id]
    @book_categories = if @keyword.present?
      # Search name (case-insensitive). Parameterized to avoid injection.
      BookCategory.where("LOWER(name) LIKE :keyword AND user_id = :user_id", keyword: "%#{@keyword.downcase}%", user_id: @userId).order(:name)
    else
      BookCategory.where("user_id = :user_id", user_id: @userId).order(:name)
    end
  end

  # GET /book_categories/1 or /book_categories/1.json
  def show
  end

  # GET /book_categories/new
  def new
    @book_category = BookCategory.new
  end

  # GET /book_categories/1/edit
  def edit
  end

  # POST /book_categories or /book_categories.json
  def create
    @book_category = BookCategory.new(book_category_params)
    @book_category.user_id = Current.session[:user_id]

    respond_to do |format|
      if @book_category.save
        format.html { redirect_to @book_category, notice: "Book category was successfully created." }
        format.json { render :show, status: :created, location: @book_category }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @book_category.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /book_categories/1 or /book_categories/1.json
  def update
    respond_to do |format|
      if @book_category.update(book_category_params)
        format.html { redirect_to @book_category, notice: "Book category was successfully updated.", status: :see_other }
        format.json { render :show, status: :ok, location: @book_category }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @book_category.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /book_categories/1 or /book_categories/1.json
  def destroy
    @book_category.destroy!

    respond_to do |format|
      format.html { redirect_to book_categories_path, notice: "Book category was successfully destroyed.", status: :see_other }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_book_category
      @book_category = BookCategory.find(params.expect(:id))
    end

    # Only allow a list of trusted parameters through.
    def book_category_params
      params.require(:book_category).permit(:name, :description, :image_url)
    end
end

