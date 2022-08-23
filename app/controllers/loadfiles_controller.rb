class LoadfilesController < ApplicationController
  before_action :set_loadfile, only: %i[ show edit update destroy ]

  # GET /loadfiles or /loadfiles.json
  def index
    @loadfiles = Loadfile.all

    @myreg=@loadfiles.first.lfilename.read.to_s.force_encoding("UTF-8").scan(/@[a-z1-9]*/).uniq - ["@","@id"]
  end

  # GET /loadfiles/1 or /loadfiles/1.json
  def show
  end

  # GET /loadfiles/new
  def new
    @loadfile = Loadfile.new
  end

  # GET /loadfiles/1/edit
  def edit
  end

  # POST /loadfiles or /loadfiles.json
  def create
    @loadfile = Loadfile.new(loadfile_params)

    respond_to do |format|
      if @loadfile.save
        format.html { redirect_to loadfile_url(@loadfile), notice: "Loadfile was successfully created." }
        format.json { render :show, status: :created, location: @loadfile }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @loadfile.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /loadfiles/1 or /loadfiles/1.json
  def update
    respond_to do |format|
      if @loadfile.update(loadfile_params)
        format.html { redirect_to loadfile_url(@loadfile), notice: "Loadfile was successfully updated." }
        format.json { render :show, status: :ok, location: @loadfile }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @loadfile.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /loadfiles/1 or /loadfiles/1.json
  def destroy
    @loadfile.destroy

    respond_to do |format|
      format.html { redirect_to loadfiles_url, notice: "Loadfile was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_loadfile
      @loadfile = Loadfile.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def loadfile_params
      params.require(:loadfile).permit(:lfilename, :comment)
    end
end
