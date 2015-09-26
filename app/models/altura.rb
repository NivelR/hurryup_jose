class Altura < ActiveRecord::Base
  attr_accessible :fecha, :medicion, :puerto_id
  belongs_to :puerto

  validates :puerto_id, :uniqueness => {:scope => :fecha}

  scope :por_fecha, order('fecha DESC')

  scope :semana, por_fecha.first(7)


  def todo_ok?
  	true if puerto.altura_alerta > medicion
  end
  
  def alerta?
  	true if puerto.altura_alerta <= medicion && puerto.altura_evacuacion > medicion
  end

  def evacuacion?
  	true if puerto.altura_evacuacion <= medicion
  end

  def diferencia_alerta
    (medicion - puerto.altura_alerta).round(2)
  end

  def diferencia_evacuacion
    (medicion - puerto.altura_evacuacion).round(2)
  end

  def self.ultima
    por_fecha.first
  end




  def actualizacion
  	unless fecha.blank?
  	  fecha.strftime("%d/%m/%Y %H:%M:%S")
    else
      "-"
    end
  end

end
