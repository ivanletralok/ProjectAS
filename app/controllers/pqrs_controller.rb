class PqrsController < ApplicationController
  before_action :set_pqr, only: [:show, :edit, :update, :destroy]

  # GET /pqrs
  # GET /pqrs.json
  def index 
    if usuario_actual 
      if usuario_actual.dependencium.descripcion == "usuarioNormal"
          @pqrs = Pqr.where(usuario: usuario_actual.id)
      elsif usuario_actual.rol.descripcion == "Super Admin"
        @pqrs = Pqr.all
      else
        @pqrs = Pqr.where(dependencium: usuario_actual.dependencium)
      end

      if usuario_actual.dependencium.descripcion == "Juridica"
        @pqrs = Pqr.where(dependencium: usuario_actual.dependencium)
      end

      if usuario_actual.dependencium.descripcion == "Financiera"
        @pqrs = Pqr.where(dependencium: usuario_actual.dependencium)
      end

      if usuario_actual.dependencium.descripcion == "Administrativa"
        @pqrs = Pqr.where(dependencium: usuario_actual.dependencium)
      end
      
      else
      redirect_to root_url, notice: "Debes loguearte o no tienes permisos"
    end
  end

  

  # GET /pqrs/1
  # GET /pqrs/1.json
  def show
    @comentario = Comentario.new
  end

  # GET /pqrs/new
  def new
    if usuario_actual
      @pqr = Pqr.new
    else
      redirect_to root_url, notice: "Debes loguearte!"
    end
  end

  # GET /pqrs/1/edit
  def edit
  end

  # POST /pqrs
  # POST /pqrs.json
  def create
    @pqr = Pqr.new(pqr_params)
   
    #asignar a todos los pqr por defecto al director 
    if  @pqr.dependencium == nil
        @pqr.dependencium = Dependencium.find_by(descripcion: "Director")
    end

    @pqr.estado = false

    name = pqr_params["archivo"].original_filename
    path = File.join("public", "archivos", "upload", name)
    File.open(path, "wb") { |f| f.write( pqr_params["archivo"].read ) }

    @pqr.archivo = "archivos/upload/"+name

    respond_to do |format|
      if @pqr.save
       
        format.html { redirect_to @pqr, notice: 'Pqr was successfully created.' }
        format.json { render :show, status: :created, location: @pqr }
      else
        format.html { render :new }
        format.json { render json: @pqr.errors, status: :unprocessable_entity }
      end
    end
    
  end

  def prueba
    p = Pqr.find(params["pqr_id"])
    dep = Dependencium.find(params["dependencium_id"])
    ant = p.dependencium_id
    p.dependencium_id = dep.id
    p.save

    enviar = {
      id: params[:pqr_id],
      depAc: params[:dependencium_id],
      depAn: ant    }
    Rails.logger.debug "****************"
    redirect_to new_comentario_path(enviar)
    Rails.logger.debug "****************"
  end


  def prueba_comentario
    c = Comentario.new
    c.comentario = params['comentario']
    c.depactual	= params['depactual']
    c.depanterior	= params['depanterior']
    c.fecha	= params['fecha']
    c.pqr_id	= params['pqr_id']
    c.save

    p = Pqr.find(params["pqr_id"])
    dep = Dependencium.find(params["dependencium_id"])
    ant = p.dependencium_id
    p.dependencium_id = dep.id

    enviar = {
      id: params[:pqr_id],
      depAc: params[:dependencium_id],
      depAn: ant  
    }

    comentarios_path(enviar)
    
    # render :json => c
  end

  def respuesta
    r = Pqr.find(params[:pqr_id])
    r.respuesta = params[:respuesta]
    r.estado = true
    r.save

    render :json => r
  end

  def coment
  end
  # PATCH/PUT /pqrs/1
  # PATCH/PUT /pqrs/1.json
  def update
    respond_to do |format|
      if @pqr.update(pqr_params)
        format.html { redirect_to @pqr, notice: 'Pqr was successfully updated.' }
        format.json { render :show, status: :ok, location: @pqr }
      else
        format.html { render :edit }
        format.json { render json: @pqr.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /pqrs/1
  # DELETE /pqrs/1.json
  def destroy
    @pqr.destroy
    respond_to do |format|
      format.html { redirect_to pqrs_url, notice: 'Pqr was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_pqr
      @pqr = Pqr.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def pqr_params
      params.require(:pqr).permit(:fecha, :descripcion, :archivo, :estado, :usuario_id, :dependencium_id, :respuesta)
    end

end
