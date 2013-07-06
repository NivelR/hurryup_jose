class WelcomeController < ApplicationController
  def index

  	@puerto = Puerto.where("nombre ilike ?", request.subdomain).first || Puerto.where(nombre: "CORRIENTES").first

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

end
