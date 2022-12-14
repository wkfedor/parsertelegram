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
    @mygroupsdop=[]
    mygroupsdop=Mygroup.joins(:dopmygroup).where(dopmygroups:{tme:nil}).limit(30)
    mygroupsdop.each do |x|
      y= x.dopmygroup.countuser.try(:empty?) ? 1 : x.dopmygroup.countuser
      #data= findoldmessagesver2 "#{x.username.delete "@" }", y.to_i*30
      #data=rand(1...10000)
      Resque.enqueue(SimpleJob, ["#{x.username.delete "@" }", y] )

      # p x.dopmygroup.update('tme'=>data)

       @mygroupsdop << "'#{x.username}'"
    end
     @mygroupsdop=@mygroupsdop.join(',')
    #@mygroupsdop.gsub!( /"/, '')
    @mygroupsdop= "SELECT id, countuser, comment, mygroup_id, created_at, updated_at, tme
	FROM public.dopmygroups
	where mygroup_id in (	SELECT id
	FROM public.mygroups where username in (#{@mygroupsdop}))"
  end

  def debug103
    @mygroupsdop="debug103
получая имя группы вывожу из нее сообщения до значений указанных в енв
типа енв1 = 100 енв2=200 енв3=300 енв4=500 енв5=1000 енв6=все
чем больше енв, тем приоритетнее группа
"
    mas={}
    mygroupsdop=Mygroup.joins(:dopmygroup).where.not(dopmygroups:{tme:nil}).limit(3)
    #@data = mygroupsdop.first.dopmygroup.tme
     mygroupsdop.each do |x|
       mas[x.id]=[]
       mas[x.id] << x.username
       mas[x.id] << x.dopmygroup.tme
       log=Math::log(x.dopmygroup.tme == 0 ? 1 : x.dopmygroup.tme).floor
       mas[x.id] << log    # натуралный логарифм от нуля равен бесконечности
       y=rand(0...1000)
       # после преноса кода ниже в джобу, раскоментируй
       #Resque.enqueue(MessageJob, ["#{x.username.delete "@" }", y] )
       # после преноса кода ниже в джобу, раскоментируй
       # данный оператор использую для наглядности


       ############################################# этот блок перенеси в джобу
       # заглушка для работы не в джобе
       mass=[]
       mass[0]= "#{x.username.delete "@" }"
       # заглушка для работы не в джобе
       #parsed = JSON.parse(data)
       #puts parsed.inspect
       @mygroup=Mygroup.find_by_username("@"+mass[0])
       log=Math::log(@mygroup.dopmygroup.tme == 0 ? 1 : @mygroup.dopmygroup.tme).floor
       endnew= @mygroup.dopmygroup.tme - log*log
       @mygroup.dopmygroup.update('endnow'=>endnew) if @mygroup.dopmygroup.endnow.to_s == '' && endnew>0
       mas[x.id] << endnew
       # !!!!!!!!!!!!!! у меня нет поиска последнего сообщения,
       # так и надо или я забыл??????????????????????????????????? 11.11.2022
       #запускаю поиск последнего сообщения
       # если оно не находиться добавляем КОНСТАНТУ сообщений для каждого типа групп
       # тип групп имею ввиду логорифм от колличества сообщений в группе
       #
       #на основании массива заполняю таблицу месседж.
       # не забываю записать данные в допмайгрупп.
       (log*log).times  do |z|   # перебераем колличество сообщений которые нужно добавить в базу
         if Message.indata(x.id,x.dopmygroup.tme.to_i + z).first.nil?  # если в базе есть в меседжах запись о этой группе и этом сообщении то пропускаем
         myurl="https://t.me/#{x.username.delete "@"}/#{x.dopmygroup.tme.to_i + z}?embed=1"
         dataurl=datapars2(myurl)
         if dataurl.code == '200'
           mas[x.id] << "ok"
           dopid=x.dopmygroup.tme.to_i + z
           doc= Nokogiri::HTML(dataurl.body)
           notdara=doc.xpath(".//*[@class='tgme_widget_message_error']//text()").count > 0 ? true : false

           if notdara== false
           messages=doc.xpath(".//*[@class='tgme_widget_message_text js-message_text']//text()").text
           usernametext=doc.xpath(".//*[@class='tgme_widget_message_owner_name']//text()").text
           usernamelink=doc.xpath(".//*[@class='tgme_widget_message_owner_name']/@href").text
           img=doc.xpath(".//a[@class='tgme_widget_message_photo_wrap']/@href").text     # не работает, нужно искать по части имени класса
           videoimg=doc.xpath(".//i[@class='tgme_widget_message_video_thumb']/@style").text.match(/(background-image:url\(\')(.*)(\')/) #ссылка на превью видео картинку
           otvet=doc.xpath(".//*[@class='tgme_widget_message_forwarded_from accent_color']//text()").text #ответ на сообщение
           date=doc.xpath(".//time[@class='datetime']/@datetime").text
           look=doc.xpath(".//*[@class='tgme_widget_message_views']//text()").text
           temp={:messages=>messages,:usernametext=>usernametext,:usernamelink=>usernamelink,:img=>img,:videoimg=>videoimg.nil? ? nil: videoimg[2],:otvet=>otvet,:date=>date,:look=>look, :dopid=>dopid, :mygroup_id=>x.id}
           mas[x.id] <<temp
           else
             temp={:dopid=>dopid, :mygroup_id=>x.id, :error=>"Post not found"}
           end
           Message.new(temp).save
         else
           mas[x.id] << dataurl.code
         end
         mas[x.id] << myurl

         else # если в базе есть в меседжах запись о этой группе и этом сообщении то пропускаем
           # обработай состояние если было записано пустое сообщение todo
           p "error"
         end

       end
       #
       ####### ###################################### этот блок перенеси в джобу
     end
    @data=mas.inspect
    #@data= Math::log(234504).floor
  end


  def findoldmessages group # метод ищет номер последнего сообщения в группе на сайте t.me
    # с запросом колличества пользователей, устарелая версия
     p=Mywork.mygropdata(group)
     p p.inspect
     temp=p['extra'].match(/([0-9 ]*)members,/)
     p "-------#{temp[0]}-------"
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

  def findoldmessagesver2 group, poznow # метод ищет номер последнего сообщения в группе на сайте t.me
    i=10      # ограничу поиск размера группы 15 запросами
    left=0
    right=poznow
    stop=0
    t={}
    t['messages']=[]
    t['poznow']=[]
    t['poznow'] << poznow
    masrand=[rand(1...100),rand(100...200),rand(400...700)]
    myurllam = lambda{|x,y| "https://t.me/#{x}/#{y}?embed=1"}
    while  i > 0 do
      return 1 if poznow==0
      
      p myurl = "https://t.me/#{group}/#{poznow}?embed=1"
      masurl = myurllam.call(group,(poznow+masrand[2]))
      doc=datapars myurl
      if datapars?(myurl)
        unless datapars?(masurl)
          poznow=poznow+masrand[2]
          next
        end
        stop=poznow    # позицию в значении stop не пересекаем, дальше ничего нет
        poznow=left+(right-left)/2
        right=poznow
        t['messages'] << ""
      else
        t['messages'] << doc.xpath(".//*[@class='tgme_widget_message_text js-message_text']//text()").text
        left=poznow
        if stop <= poznow*2 && stop!=0
          poznow=poznow+(stop-poznow)/2
        else
          poznow=poznow*2
        end
        right=poznow
      end
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


  def datapars2 myurl
    uri = URI.parse(myurl)
    http = Net::HTTP.new(uri.host, uri.port)
    http.use_ssl = true
    http.verify_mode = OpenSSL::SSL::VERIFY_NONE
    request = Net::HTTP::Get.new(uri.request_uri)
    http.request(request)
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
