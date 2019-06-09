# This Controllers allows for Grams actions
# in this project
class GramsController < ApplicationController
  def new
    @gram = Gram.new
  end

  def index
    # placeholder to build the index page
  end

  def create
    @gram = Gram.create(gram_params)
    if @gram.valid?
      redirect_to root_path
    else
      render :new, status: :unprocessable_entity
    end
  end

  private

  def gram_params
    params.require(:gram).permit(:message)
  end
end
