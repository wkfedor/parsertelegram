class DopmygroupsController < ApplicationController
  before_action :set_dopmygroup, only: %i[ show edit update destroy ]

  # GET /dopmygroups or /dopmygroups.json
  def index
    @dopmygroups = Dopmygroup.search(params).paginate(page: params[:page], per_page: 50)
    #@dopmygroups = Dopmygroup.all
  end

  # GET /dopmygroups/1 or /dopmygroups/1.json
  def show
     @mygroups = Mygroup.find(Dopmygroup.find(params[:id]).mygroup_id).username
  end

  # GET /dopmygroups/new
  def new
    @dopmygroup = Dopmygroup.new
  end

  # GET /dopmygroups/1/edit
  def edit
  end

  # POST /dopmygroups or /dopmygroups.json
  def create
    @dopmygroup = Dopmygroup.new(dopmygroup_params)

    respond_to do |format|
      if @dopmygroup.save
        format.html { redirect_to dopmygroup_url(@dopmygroup), notice: "Dopmygroup was successfully created." }
        format.json { render :show, status: :created, location: @dopmygroup }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @dopmygroup.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /dopmygroups/1 or /dopmygroups/1.json
  def update
    respond_to do |format|
      if @dopmygroup.update(dopmygroup_params)
        format.html { redirect_to dopmygroup_url(@dopmygroup), notice: "Dopmygroup was successfully updated." }
        format.json { render :show, status: :ok, location: @dopmygroup }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @dopmygroup.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /dopmygroups/1 or /dopmygroups/1.json
  def destroy
    @dopmygroup.destroy

    respond_to do |format|
      format.html { redirect_to dopmygroups_url, notice: "Dopmygroup was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_dopmygroup
      @dopmygroup = Dopmygroup.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def dopmygroup_params
      params.require(:dopmygroup).permit(:countuser, :comment, :mygroup_id)
    end
end
