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

  def findoldmessages group # метод ищет номер последнего сообщения в группе на сайте t.me

     p=Mywork.mygropdata(group)

     temp=p['extra'].match(/([0-9 ]*)members,/)
     p['extra']=temp[1].gsub!(/\s+/, '').to_i
     # колличество пользователей умножаем на 50, далее в тесте на группы подберем коэфициент
     #16831 - 1568931  =   93
     #2400 - 296123   =  123
     #8700 - 250791  =  30
     i=15      # ограничу поиск размера группы 15 запросами
     debit=0
     credit=0
     poznow=p['extra']*50
     while  i > 0 do
       i=0


       myurl = "https://t.me/#{group}/#{poznow}?embed=1"
       uri = URI.parse(myurl)
       http = Net::HTTP.new(uri.host, uri.port)
       http.use_ssl = true
       http.verify_mode = OpenSSL::SSL::VERIFY_NONE
       request = Net::HTTP::Get.new(uri.request_uri)
       response = http.request(request)
       content=response.body
       t={}
       doc = Nokogiri::HTML(content)
        t['url'] = myurl
       #t['description'] = doc.xpath(".//*[@class='tgme_page_description']//text()").text  #описание
       #t['extra'] = doc.xpath(".//*[@class='tgme_page_extra']//text()").text         #чел
       #t['title'] = doc.xpath(".//*[@class='tgme_page_title']//text()").text        #title
       #t['error']=response.code
       #div[@class='tgme_widget_message_error']//text()       #пост не найден
       # .//*[@class='tgme_widget_message_user']//a/@href     # ссылка на автора
       # .//*[@class='tgme_widget_message_text js-message_text']//text() # текст сообщения
       #
       #=begin
       p "----------"
       p t['url']
       my= doc.xpath(".//*[@class='tgme_widget_message_error'][contains(text(), 'Post not found')]")
       p my.count
       p my.inspect
       p  my.text
       p  my.text.nil?
       p "----------"

       if doc.xpath(".//*[@class='tgme_widget_message_error']//text()").count > 0
         p "нужно меньше"
         #  p doc.xpath(".//*[@class='tgme_widget_message_error']//text()").text
       else
         p "нужно больше"
         # p doc.xpath(".//*[@class='tgme_widget_message_error']//text()").text
       end
#=end
       # doc.xpath(".//*[@class='tgme_widget_message_error']")

     end

     return t
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
end
