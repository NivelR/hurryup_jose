require 'watir'
require 'pry'

desc 'Baja los datos de la prefectura.gob.ar'
task :actualizar_alturas => :environment do
  url = "http://200.41.238.203:8889/resumen_agua.aspx"

  agent = Watir::Browser.new

  puts "Bajando los datos..."
  agent.goto url

  sleep(3)
  
  html = Nokogiri::HTML.parse(agent.html)

  tabla = html.css("table#GridViewAlturas")
  # binding.pry
  tr = tabla.css("tr")
  line = 0
  tr.each do |t|
    agent.goto url
    sleep(1)
    if td = t.search("td")
      if td[1]
        nombre_puerto       = td[1].text
        medicion_alerta     = td[11].text.gsub(",",".").to_f
        medicion_evacuacion = td[12].text.gsub(",",".").to_f

        puerto = Puerto.where(nombre: nombre_puerto).first

        if puerto.present?
          puerto.altura_alerta     = medicion_alerta
          puerto.altura_evacuacion = medicion_evacuacion
          puerto.save

        end

        begin
          
          agent.execute_script("__doPostBack('GridViewAlturas','Select$#{line}')")
          sleep(1)

          agent.radio(:id=> 'RadioButtonList1_3').click
          sleep(3)
          html = Nokogiri::HTML.parse(agent.html)

          h_table = tabla = html.css("table#GridView_history")


          regs = h_table.css("tr")

          regs.each do |reg|
            med = reg.search('td')
            if !med.empty?
              nombre_puerto = med[0].text
              fecha = med[1].text.to_datetime
              altura = med[2].text.gsub(',','.').to_f

              puerto = Puerto.where(nombre: nombre_puerto).first

              puerto.alturas << Altura.new(medicion: altura, fecha: fecha)

            end
          end

        rescue Exception => e
          
        end


        line += 1
      end
    end
  end
end
