class Puerto < ActiveRecord::Base
  attr_accessible :altura_alerta, :altura_evacuacion, :nombre, :rio_id

  has_many   :alturas
  belongs_to :rio

  delegate :nombre, to: :rio, prefix: true

  def ultima_semana
    alturas.where(fecha: Date.today - 7..Date.today).order('fecha DESC')
  end

  def ultima_altura
    alturas.order("fecha DESC").first
  end
end
