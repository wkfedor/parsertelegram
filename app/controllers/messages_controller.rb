class MessagesController < ApplicationController
  before_action :set_message, only: %i[ show edit update destroy ]
  require 'mywork'
  # GET /messages or /messages.json
  def index
    @messages = Message.all
  end

  # GET /messages/1 or /messages/1.json
  def show
  end

  # GET /messages/new
  def new
    @message = Message.new
  end

  # GET /messages/1/edit
  def edit
  end

  def debug100 #метод тестовой страници отработки механизмов чтения постов из групп
    #тесттрую запись сообщений в группу
    #у нас 1000000 гурппы, на основании чего принимать решение заходить в группу или нет?
    # в одной группе 1000 сообщений в день в другой 10, нужна таблица со статистикой
    # как с быстрым доступом так и расширенная
    @data= findoldmessages "rubyschool"
    @data2= findoldmessages "logistics1520com"

  end

  def debug101 # тестирую микросервис на синатре, поадаю группу получаю число
    myurl="http://localhost:4567/rubyschool"
    @data=dataparshttp(myurl).body
    #@data="rubyschool"
    #@data2="logistics1520com"

  end

  def debug102 # тестирую микросервис и очереди resque
    # сколько групп с пустым связанным поелм?
    #@mygroupsdop = Mygroup.find(237).dopmygroup.countuser
    #@mygroupsdop =Mygroup.last.try(:dopmygroup).try(:countuser)
    #@mygroupsdop=Mygroup.where(id: Dopmygroup.pluck(:mygroup_id).uniq)
    #@mygroupsdop=@mygroupsdop.first.dopmygroup.inspect
    @mygroupsdop=Mygroup.joins(:dopmygroup).where(dopmygroups:{tme:nil})
    @mygroupsdop.each do |x|

        if x.dopmygroup.countuser.empty?
          p "пусто"
        else
          p "ок"
        end
        p x.dopmygroup.countuser
    end
  end

  def findoldmessages group # метод ищет номер последнего сообщения в группе на сайте t.me

     p=Mywork.mygropdata(group)

     temp=p['extra'].match(/([0-9 ]*)members,/)
     p['extra']=temp[1].gsub!(/\s+/, '').to_i
     # колличество пользователей умножаем на 50, далее в тесте на группы подберем коэфициент
     i=10      # ограничу поиск размера группы 15 запросами
     poznow=p['extra']*30
     left=0
     right=poznow
     stop=0
     t={}
     #t['status']=[]
     t['messages']=[]
     t['poznow']=[]
     t['poznow'] << poznow
     #t['url']=[]
     masrand=[rand(1...100),rand(100...200),rand(400...700)]
     myurllam = lambda{|x,y| "https://t.me/#{x}/#{y}?embed=1"}
     while  i > 0 do
       myurl = "https://t.me/#{group}/#{poznow}?embed=1"
       masurl = myurllam.call(group,(poznow+masrand[2]))
       doc=datapars myurl
       if datapars?(myurl)
         unless datapars?(masurl)
           poznow=poznow+masrand[2]
           next
           #else
           # p "--------------------ERROR FIND false------start=   #{myurl}   povtor=  #{masurl}       -----------------------------------"
         end
         #t['status'] << "нужно меньше" #  получили сообщения пост не найден
         stop=poznow    # позицию в значении stop не пересекаем, дальше ничего нет
         poznow=left+(right-left)/2
         right=poznow
         t['messages'] << ""
       else
             t['messages'] << doc.xpath(".//*[@class='tgme_widget_message_text js-message_text']//text()").text
             #t['status'] << "нужно больше"
             left=poznow
             if stop <= poznow*2 && stop!=0
               poznow=poznow+(stop-poznow)/2
             else
               poznow=poznow*2
             end
             right=poznow
         #  end
       end
       #t['url'] << myurl
       t['poznow'] << poznow
       i-=1
     end
     return left




  end


  # POST /messages or /messages.json
  def create
    @message = Message.new(message_params)

    respond_to do |format|
      if @message.save
        format.html { redirect_to message_url(@message), notice: "Message was successfully created." }
        format.json { render :show, status: :created, location: @message }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @message.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /messages/1 or /messages/1.json
  def update
    respond_to do |format|
      if @message.update(message_params)
        format.html { redirect_to message_url(@message), notice: "Message was successfully updated." }
        format.json { render :show, status: :ok, location: @message }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @message.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /messages/1 or /messages/1.json
  def destroy
    @message.destroy

    respond_to do |format|
      format.html { redirect_to messages_url, notice: "Message was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_message
      @message = Message.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def message_params
      params.require(:message).permit(:maintext, :user, :img, :dopid, :mygroup_id)
    end
  def datapars myurl
    uri = URI.parse(myurl)
    http = Net::HTTP.new(uri.host, uri.port)
    http.use_ssl = true
    http.verify_mode = OpenSSL::SSL::VERIFY_NONE
    request = Net::HTTP::Get.new(uri.request_uri)
    response = http.request(request)
    content=response.body
    Nokogiri::HTML(content)
  end

  def dataparshttp myurl
    uri = URI.parse(myurl)
    http = Net::HTTP.new(uri.host, uri.port)
    #http.use_ssl = true
    #http.verify_mode = OpenSSL::SSL::VERIFY_NONE
    request = Net::HTTP::Get.new(uri.request_uri)
    response = http.request(request)
    response
    #Nokogiri::HTML(content)
  end


  def datapars? myurl    # если тру то пост не нашли
    doc=datapars myurl
    doc.xpath(".//*[@class='tgme_widget_message_error']//text()").count > 0 ? true : false
  end


end
