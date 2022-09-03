class TwoloadfilesController < ApplicationController
  before_action :set_twoloadfile, only: %i[ show edit update destroy workdbpage ]
  require 'mywork'
  # GET /twoloadfiles or /twoloadfiles.json
  def index
    @twoloadfiles = Twoloadfile.all
  end

  def workdbpage   # метод стрницы запуска прогона по временной базе статусов 1, 429
    Wfile.where("flag in ('1','429')").order("id DESC").limit(2).each do |x|
      #p x.word
      # проверить есть ли имя в основной базе групп.
      if Mywork.findgroup(x.word) == true
        t=Mywork.mygropdata(x.word)
        puts t
        sleep 1
      end
      #
      #

    end
  end

  def onlinestatupdatedb
    mas= %w{1 2 3 4 5 6 7 8 9}
    render json:{success: mas.sample.to_s }
  end




  # GET /twoloadfiles/1 or /twoloadfiles/1.json
  def show
    # +разбить по регулярке, получаю файл выдаю массив
    # проверить есть ли в основной базе              должно быть false
    # проверить есть ли в базе проверки с файлами     должно быть false
    # записать в базу
    #require 'mywork'
     Mywork.myreq(@twoloadfile.lfilename.read.to_s.force_encoding("UTF-8")).each do |x|

     savedata(x) if Mywork.findgroupfilter(x) && Mywork.findgroup(x)



    #p  TwoloadfilesController::Myworks
    #mydata.myreg
     end
  end
  # GET /twoloadfiles/new
  def new
    @twoloadfile = Twoloadfile.new
  end

  # GET /twoloadfiles/1/edit
  def edit
  end

  # POST /twoloadfiles or /twoloadfiles.json
  def create

    @twoloadfile = Twoloadfile.new(twoloadfile_params)
    savedata @twoloadfile
    respond_to do |format|
      if @twoloadfile.save
        format.html { redirect_to twoloadfile_url(@twoloadfile), notice: "Twoloadfile was successfully created." }
        format.json { render :show, status: :created, location: @twoloadfile }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @twoloadfile.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /twoloadfiles/1 or /twoloadfiles/1.json
  def update
    respond_to do |format|
      if @twoloadfile.update(twoloadfile_params)
        format.html { redirect_to twoloadfile_url(@twoloadfile), notice: "Twoloadfile was successfully updated." }
        format.json { render :show, status: :ok, location: @twoloadfile }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @twoloadfile.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /twoloadfiles/1 or /twoloadfiles/1.json
  def destroy
    @twoloadfile.destroy

    respond_to do |format|
      format.html { redirect_to twoloadfiles_url, notice: "Twoloadfile was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  def savedata data
      time=Time.now
      @Wf=Wfile.new('word'=>data, 'flag'=>1, 'dateold'=>time, 'created_at'=>time, 'updated_at'=>time, 'fileid'=>params[:id])
      @Wf.save
  end



  private
    # Use callbacks to share common setup or constraints between actions.
    def set_twoloadfile
    begin
      @twoloadfile = Twoloadfile.find(params[:id])
    rescue
      @twoloadfile=''
    end
    end

    # Only allow a list of trusted parameters through.
    def twoloadfile_params
      params.require(:twoloadfile).permit(:lfilename, :comment)
    end
end
