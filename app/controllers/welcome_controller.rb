class WelcomeController < ApplicationController

  def index
    nombre_puerto = subdomain || params[:puerto] || 'Corrientes'
    @puerto = Puerto.where("nombre ilike ?", nombre_puerto).first

    if @puerto
      @rio    = @puerto.rio
      @altura = @puerto.ultima_altura
      @semana = @puerto.ultima_semana
    else
      render :file => "#{Rails.root}/public/404", :layout => false, :status => :not_found
    end
  end

  def prueba_widget
    respond_to do |format|
      format.html#{render :layout=>false}
    end
  end

  private
  def subdomain
    request.subdomain if request.subdomain.present?
  end
end
