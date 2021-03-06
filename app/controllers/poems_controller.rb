require "google-search"
require "marky_markov"
require "sanitize"
require "wikipedia"
class PoemsController < ApplicationController
  include PoemsHelper
  before_action :set_poem, only: [:show, :edit, :update, :destroy]

  # GET /poems
  # GET /poems.json
  def index
    @poems = Poem.all.paginate(page: params[:page], per_page: 5)
  end

  # GET /poems/1
  # GET /poems/1.json
  def show
  end

  # GET /poems/new
  def new
    @poem = Poem.new
  end

  # GET /poems/1/edit
  def edit
  end

  # POST /poems
  # POST /poems.json
  def create
      poem_params = generate_poem
      if poem_params
        @poem = Poem.new(poem_params)

        respond_to do |format|
          if @poem.save
            format.html { redirect_to @poem, notice: 'Poem was successfully created.' }
            format.json { render :show, status: :created, location: @poem }
          else
            format.html { render :new }
            format.json { render json: @poem.errors, status: :unprocessable_entity }
          end
        end
      else
        @poem = Poem.new
        respond_to do |format|
          format.html { render :new }
          format.json { render json: "Search returned nothing", status: :unprocessable_entity }
        end
      end
  end

  # PATCH/PUT /poems/1
  # PATCH/PUT /poems/1.json
  def update
    respond_to do |format|
      if @poem.update(poem_params)
        format.html { redirect_to @poem, notice: 'Poem was successfully updated.' }
        format.json { render :show, status: :ok, location: @poem }
      else
        format.html { render :edit }
        format.json { render json: @poem.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /poems/1
  # DELETE /poems/1.json
  def destroy
    @poem.destroy
    respond_to do |format|
      format.html { redirect_to poems_url, notice: 'Poem was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_poem
      @poem = Poem.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def poem_params
      params.require(:poem).permit(:lexicon, :poem, :search, :second_search, :ss, :deep)
    end
end
