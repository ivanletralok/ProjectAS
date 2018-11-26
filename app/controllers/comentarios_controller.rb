class ComentariosController < ApplicationController
  before_action :set_comentario, only: [:show, :edit, :update, :destroy]

  # GET /comentarios
  # GET /comentarios.json
  def index
    @comentarios = Comentario.all
  end

  # GET /comentarios/1
  # GET /comentarios/1.json
  def show
  end

  # GET /comentarios/new
  def new
    @comentario = Comentario.new
  end

  # GET /comentarios/1/edit
  def edit
  end

  # POST /comentarios
  # POST /comentarios.json
  def create
    @comentario = Comentario.new(comentario_params)


    respond_to do |format|
      if @comentario.save
        format.html { redirect_to @comentario, notice: 'Comentario was successfully created.' }
        format.json { render :show, status: :created, location: @comentario }
      else
        format.html { render :new }
        format.json { render json: @comentario.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /comentarios/1
  # PATCH/PUT /comentarios/1.json
  def update
    respond_to do |format|
      if @comentario.update(comentario_params)
        format.html { redirect_to @comentario, notice: 'Comentario was successfully updated.' }
        format.json { render :show, status: :ok, location: @comentario }
      else
        format.html { render :edit }
        format.json { render json: @comentario.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /comentarios/1
  # DELETE /comentarios/1.json
  def destroy
    @comentario.destroy
    respond_to do |format|
      format.html { redirect_to comentarios_url, notice: 'Comentario was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def prueba
    p = Pqr.find(params["pqr_id"])
    dep = Dependencium.find(params["dependencium_id"])
    p.dependencium_id = dep.id
    p.save
    render :json => p
  end

  def prueba_comentario
    c = Comentario.new
    c.comentario = params['comentario']
    c.depactual	= params['depactual']
    c.depanterior	= params['depanterior']
    c.fecha	= params['fecha']
    c.pqr_id	= params['pqr_id']
    c.save
    
    render :json => c
  end

  def comentario
  end
  private
    # Use callbacks to share common setup or constraints between actions.
    def set_comentario
      @comentario = Comentario.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def comentario_params
      params.require(:comentario).permit(:fecha, :comentario, :depactual, :depanterior, :pqr_id)
    end
end
