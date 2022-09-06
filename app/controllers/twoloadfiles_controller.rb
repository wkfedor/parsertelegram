class TwoloadfilesController < ApplicationController
  before_action :set_twoloadfile, only: %i[ show edit update destroy workdbpage ]
  require 'mywork'
  # GET /twoloadfiles or /twoloadfiles.json
  def index
    @twoloadfiles = Twoloadfile.all
  end



  def workdbpage   # метод стрницы запуска прогона по временной базе статусов 1, 429
    Wfile.where("flag in ('1','429')").order("id DESC").limit(5).each do |x|
      # проверить есть ли имя в основной базе групп.
      if Mywork.findgroup(x.word) == true
        t=Mywork.mygropdata(x.word)
        #вернул что группы нет
        p "-------------------#{t['error']}-------------------"
        if t['error']!='200'
          # пропустить цикл
          # 302 редирект, почемуто группа не доступна с сайта происходит редирект на главную страницу телеграмм
          if t['error']=='302'
            p "update flag 302 #{x.word}"
            x.update('flag'=>302)
          else
            p "flag!= 302 #{x.word}"
          end
           next
          else
            #получили инфу о группе, она или есть или нет
            if t['description'].include? "If you have Telegram, you can contact #{x.word} right away."
              #группа есть записываем ее в базу
              puts "401"
              x.update('flag'=>401)
              sleep 1
            else
              puts "201"
              x.update('flag'=>201)
              result={}
              time=Time.now
              result.store("username", x.word)
              t['title'].strip!
              t['description'].strip!
              result.store("title", t['title'])
              result.store("description", t['description'])
              result.store("datein", time)
              p result
              p "------------------------------------------------------"
              @mygroup = Mygroup.new(result)
              @mygroup.save
            end
        end
      end
    end
  end


  def workdbavto   # метод стрницы запуска прогона по временной базе статусов 1, 429
    Wfile.where("flag in ('1','429')").order("id DESC").limit(5).each do |x|
      # проверить есть ли имя в основной базе групп.
      if Mywork.findgroup(x.word) == true
        t=Mywork.mygropdata(x.word)
        #вернул что группы нет
        p "-------------------#{t['error']}-------------------"
        if t['error']!='200'
          # пропустить цикл
          # 302 редирект, почемуто группа не доступна с сайта происходит редирект на главную страницу телеграмм
          if t['error']=='302'
            p "update flag 302 #{x.word}"
            x.update('flag'=>302)
          else
            p "flag!= 302 #{x.word}"
          end
          next
        else
          #получили инфу о группе, она или есть или нет
          if t['description'].include? "If you have Telegram, you can contact #{x.word} right away."
            #группа есть записываем ее в базу
            puts "401"
            x.update('flag'=>401)
            sleep 1
          else
            puts "201"
            x.update('flag'=>201)
            result={}
            time=Time.now
            result.store("username", x.word)
            t['title'].strip!
            t['description'].strip!
            result.store("title", t['title'])
            result.store("description", t['description'])
            result.store("datein", time)
            p result
            p "------------------------------------------------------"
            @mygroup = Mygroup.new(result)
            @mygroup.save
          end
        end
      end
    end
  end




  def onlinestatupdatedb
    @connection = ActiveRecord::Base.connection
    resultstart = @connection.exec_query("SELECT count(id) FROM public.wfiles   where flag in ('1', '429')")    #
    resultok = @connection.exec_query("SELECT count(id) FROM public.wfiles   where flag in ('200', '201')")     #
    resulterror = @connection.exec_query("SELECT count(id) FROM public.wfiles   where flag in ('400', '401')")  #
    tengropadd =[]
    tengropwork =[]

    Mygroup.order("updated_at desc").limit(5).each do |x|
      tengropadd << {"username":x.username, "title":x.title, "description":x.description, "updated_at":x.updated_at}
    end

    Wfile.order("updated_at desc").limit(5).each do |x|
      tengropwork << {"word":x.word, "flag":x.flag, "updated_at":x.updated_at}
    end

      #Wfile.where("flag in ('1','429')").order("id DESC").limit(5).each do |x|
      # последние 10 групп которые добавили в базу. табличка
     # последние 10 груп из wfiles которые учавствовали в проверки

    mas= %w{1 2 3 4 5 6 7 8 9}
    render json:{
      "a": resultstart.rows[0][0],
      "b": resultok.rows[0][0],
      "c": resulterror.rows[0][0],
      "d": tengropadd,
      "e": tengropwork}
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
