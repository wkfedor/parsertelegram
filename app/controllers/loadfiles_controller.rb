class LoadfilesController < ApplicationController
  before_action :set_loadfile, only: %i[ show edit update destroy ]

  # GET /loadfiles or /loadfiles.json
  def index
    @loadfiles = Loadfile.all
    @myreg='todo'
    #render plain: @loadfiles.length
    #return

  end

  # GET /loadfiles/1 or /loadfiles/1.json
  def show
    #if @filename==nil
    #render plain:  @model.inspect
    # return
      #end

    @myreg=@loadfile.lfilename.read.to_s.force_encoding("UTF-8").scan(/@[a-z1-9]*/).uniq - ["@","@id"]
    #получаем список групп из сохранного на сервер файла
    #+создаем миграцию поле id_file для связи с файлом
    @myreg.each do |x|

      #render plain: Wfile.find_by_word(x)
      #return
      time=Time.now
      if Wfile.find_by_word(x).nil?
        #+проверяем есть ли запись о моей группе в базе
        #+если нет то записываем в базу
        @Wf=Wfile.new('word'=>x, 'flag'=>1, 'dateold'=>time, 'created_at'=>time, 'updated_at'=>time, 'fileid'=>params[:id])
        @Wf.save
        p  loadgroup(x)  if findgroup(x)  #&& findgroupfilter(x)
      else
        if Wfile.find_by_word(x).flag.to_s=='1'
        p  loadgroup(x)  if findgroup(x)  #&& findgroupfilter(x)
        end
      end
      #render plain: Wfile.find_by_word(x.to_s)
      #return
    end
    #-выдаем статитстику, в файле 100 групп все 100 в базе||в файле 100 групп 20 в базе||в файле нет групп
    #temp=[]
    #temp << (loadgroup "@olegderipaska")
    #temp << (loadgroup "@bloodysx")

    #temp <<  (findgroupfilter "@olegderipaska")
    #test="@egorkreed"
  end

  def loadgroup word   # через апи проверяем есть ли группе
    require 'open-uri'
    require 'nokogiri'
    require "net/https"
    require 'uri'
    sleep 1
    myurl = "https://api.telegram.org/#{ENV['TOKEN']}/getChat?chat_id=#{word}"
    p "myurl=#{myurl}"
    uri = URI.parse(myurl)
    http = Net::HTTP.new(uri.host, uri.port)
    http.use_ssl = true
    http.verify_mode = OpenSSL::SSL::VERIFY_NONE
    request = Net::HTTP::Get.new(uri.request_uri)
    response = http.request(request)
    content=response.body
    @msql=Wfile.find_by_word(word)
    p "code=#{response.code}"
    if response.code == '200'
      result={}
      time=Time.now
      parsed = JSON.parse(content)
      result.store("iid", parsed.dig('result', 'id'))
      result.store("username", word)
      result.store("title", parsed.dig('result', 'title'))
      result.store("description", parsed.dig('result', 'description'))
      result.store("caption", parsed.dig('result', 'pinned_message', 'caption'))
      result.store("datein", time)
      saveloadgroup result
      @msql.update('flag'=>200)   # после сохранения в основную базу изменяю флаг в базе поиска по файлу
    elsif response.code == '400'
      @msql.update('flag'=>400)
    elsif response.code == '429'
      @msql.update('flag'=>429)
      abort "Телеграмм нас забанил"
    else
      @msql.update('flag'=>response.code)
    end
    # статус 1 загнужено во временную
    # 2 отработали норм
    # 4 400 ошибка, группы нет
  end

  def saveloadgroup  word #  сохраняем ранее найденную группу
    #mygroups
    # Mygroup

    @mygroup = Mygroup.new(word)
    p @mygroup.save
    #render plain: word
    #return
  end

  def findgroupfilter word # проверяем есть ли группа в базе первого фильтра
    Wfile.find_by_word(word) ? false : true
  end

  def findgroup word # проверяем есть ли группа в основной базе
    Mygroup.find_by_username(word) ? false : true
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
