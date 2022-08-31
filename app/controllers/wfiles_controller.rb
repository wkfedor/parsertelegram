class WfilesController < ApplicationController
  before_action :set_wfile, only: %i[ show edit update destroy ]



  # GET /wfiles or /wfiles.json
  def index
    @wfiles = Wfile.search(params).paginate(page: params[:page], per_page: 50)
    #@wfiles = Wfile.all

    begin

      @temp = params[:wfile][:mfile].read.inspect

    rescue
      p "исключение"
    end

    # wfile_params[:file].inspect if wfile_params[:file]!=nil
  end

  # GET /wfiles/1 or /wfiles/1.json
  def show
  end

  def savefile
      uploaded_file = params[:file]
      file_content = uploaded_file.read
      render plain: uploaded_file.inspect
      return


  end

  # GET /wfiles/new
  def new
    @wfile = Wfile.new
  end

  # GET /wfiles/1/edit
  def edit
  end

  # POST /wfiles or /wfiles.json
  def create
    @wfile = Wfile.new(wfile_params)

    respond_to do |format|
      if @wfile.save
        format.html { redirect_to wfile_url(@wfile), notice: "Wfile was successfully created." }
        format.json { render :show, status: :created, location: @wfile }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @wfile.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /wfiles/1 or /wfiles/1.json
  def update
    respond_to do |format|
      if @wfile.update(wfile_params)
        format.html { redirect_to wfile_url(@wfile), notice: "Wfile was successfully updated." }
        format.json { render :show, status: :ok, location: @wfile }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @wfile.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /wfiles/1 or /wfiles/1.json
  def destroy
    @wfile.destroy

    respond_to do |format|
      format.html { redirect_to wfiles_url, notice: "Wfile was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_wfile
      @wfile = Wfile.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def wfile_params
      params.require(:wfile).permit(:word, :flag, :dateold ,:myfile)
    end
  def wfile_params_file
    params.require(:wfile).permit(:mfile)
  end
end
