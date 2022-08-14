class MygroupsController < ApplicationController
  before_action :set_mygroup, only: %i[ show edit update destroy ]

  # GET /mygroups or /mygroups.json
  def index
    @mygroups = Mygroup.all
  end

  # GET /mygroups/1 or /mygroups/1.json
  def show
  end

  # GET /mygroups/new
  def new
    @mygroup = Mygroup.new
  end

  # GET /mygroups/1/edit
  def edit
  end

  # POST /mygroups or /mygroups.json
  def create
    @mygroup = Mygroup.new(mygroup_params)

    respond_to do |format|
      if @mygroup.save
        format.html { redirect_to mygroup_url(@mygroup), notice: "Mygroup was successfully created." }
        format.json { render :show, status: :created, location: @mygroup }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @mygroup.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /mygroups/1 or /mygroups/1.json
  def update
    respond_to do |format|
      if @mygroup.update(mygroup_params)
        format.html { redirect_to mygroup_url(@mygroup), notice: "Mygroup was successfully updated." }
        format.json { render :show, status: :ok, location: @mygroup }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @mygroup.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /mygroups/1 or /mygroups/1.json
  def destroy
    @mygroup.destroy

    respond_to do |format|
      format.html { redirect_to mygroups_url, notice: "Mygroup was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_mygroup
      @mygroup = Mygroup.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def mygroup_params
      params.require(:mygroup).permit(:iid, :username, :title, :description, :countuser, :datein)
    end
end
