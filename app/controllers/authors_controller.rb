class AuthorsController < ApplicationController
  before_action :set_author, only: %i[ show edit update destroy ]

  def index
    @authors = Author.all
  end

  def show
    @author = Author.find(params[:id])
  end

  def edit
  end

  def search
    @authors = Author.containing(params[:query])
  end

  def new
    @author = Author.new
  end

  def create
    @author = Author.new(author_params)

    respond_to do |format|
      if @author.save
        format.html { redirect_to @author, notice: "Author was successfully created." } 
        format.turbo_stream
      else
        format.html { render :new, status: :unprocessable_entity }
      end
    end
  end
  # PATCH/PUT /authors/1
  def update
    respond_to do |format|
      if @author.update(author_params)
        format.html { redirect_to author_url(@author), notice: "Author was successfully updated." }
      else
        format.html { render :edit, status: :unprocessable_entity }
      end
    end
  end
  
  # DELETE /authors/1
  def destroy
    @author.destroy

    respond_to do |format|
      format.turbo_stream { render turbo_stream: turbo_stream.remove(@author) }
      format.html         { redirect_to authors_url, notice: "Author was successfully destroyed." }
    end
  end


  private

    def set_author
      @author = Author.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def author_params
      params.require(:author).permit(:name, :birth, :death, :image)
    end
end
