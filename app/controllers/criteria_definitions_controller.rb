class CriteriaDefinitionsController < ApplicationController
  before_action :set_criteria_definition, only: [:show, :edit, :update, :destroy]

  # GET /criteria_definitions
  def index
    @criteria_definitions = CriteriaDefinition.all
  end

  # GET /criteria_definitions/1
  def show
  end

  # GET /criteria_definitions/new
  def new
    @criteria_definition = CriteriaDefinition.new
  end

  # GET /criteria_definitions/1/edit
  def edit
  end

  # POST /criteria_definitions
  def create
    @criteria_definition = CriteriaDefinition.new(enforced_params)

    if @criteria_definition.save
      redirect_to @criteria_definition, notice: 'Criteria definition was successfully created.'
    else
      flash[:error] = @criteria_definition.errors[:base][0] if @criteria_definition.errors[:base].any?
      render :new
    end
  end

  # PATCH/PUT /criteria_definitions/1
  def update
    if @criteria_definition.update(enforced_params)
      redirect_to @criteria_definition, notice: 'Criteria definition was successfully updated.'
    else
      render :edit
    end
  end

  # DELETE /criteria_definitions/1
  def destroy
    @criteria_definition.destroy
    redirect_to criteria_definitions_url, notice: 'Criteria definition was successfully destroyed.'
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_criteria_definition
      @criteria_definition = CriteriaDefinition.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def criteria_definition_params
      @criteria_definition_params ||= params.require(:criteria_definition).permit(
        { references: [] },
        { categories: [] },
        :max_product_price,
        :destination
      )
    end

    def enforced_params
      cdp = criteria_definition_params
      %i[references categories].each do |attr|
        val = cdp[attr].reject(&:blank?)
        cdp[attr] = val.any? ? val[0].split(',') : val
      end
      cdp
    end
end
