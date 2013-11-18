class <%= controller_class %> < ApplicationController
  
  #before_filter :require_user
  #authorize_actions_for Item, :actions => {:index => :delete}
  before_filter :set_navs, :parse_pagination_params, :only=>:index
  
  # GET /<%= instances_name %>
  # GET /<%= instances_name %>.js
  # GET /<%= instances_name %>.json
  def index
    
    get_collections
    
    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @<%= instances_name %> }
      format.js {}
    end
  end

  # GET /<%= instances_name %>/1
  # GET /<%= instances_name %>/1.js
  # GET /<%= instances_name %>/1.json
  def show
    ## Creating the <%= instance_name %> object  
    @<%= instance_name %> = <%= model_class %>.find(params[:id])
    
    respond_to do |format|
      format.html { get_collections and render :index }
      format.json { render json: @<%= instance_name %> }
      format.js {}
    end
  end

  # GET /<%= instances_name %>/new
  # GET /<%= instances_name %>/new.json
  def new
    ## Intitializing the <%= instance_name %> object 
    @<%= instance_name %> = <%= model_class %>.new
    
    respond_to do |format|
      format.html { get_collections and render :index }
      format.json { render json: @<%= instance_name %> }
      format.js {}
    end
  end

  # GET /<%= instances_name %>/1/edit
  def edit
    ## Fetching the <%= instance_name %> object 
    @<%= instance_name %> = <%= model_class %>.find(params[:id])
    
    respond_to do |format|
      format.html { get_collections and render :index }
      format.json { render json: @<%= instance_name %> }
      format.js {}
    end
  end

  # POST /<%= instances_name %>
  # POST /<%= instances_name %>.js
  # POST /<%= instances_name %>.json
  def create
    ## Creating the <%= instance_name %> object  
    @<%= instance_name %> = <%= model_class %>.new(params[:<%= instance_name %>])
    
    ## Validating the data
    @<%= instance_name %>.valid?
    
    respond_to do |format|
      if @<%= instance_name %>.errors.blank?
        
        # Saving the <%= instance_name %> object
        @<%= instance_name %>.save
        
        # Setting the flash message
        message = translate("forms.created_successfully", :item => "<%= instance_name.titleize %>")
        store_flash_message(message, :success)
        
        format.html { 
          redirect_to <%= resource_link('show','url') %>(@<%= instance_name %>), notice: message
        }
        format.json { render json: @<%= instance_name %>, status: :created, location: @<%= instance_name %> }
        format.js {}
      else
        
        # Setting the flash message
        message = @<%= instance_name %>.errors.full_messages.to_sentence
        store_flash_message(message, :alert)
        
        format.html { render action: "new" }
        format.json { render json: @<%= instance_name %>.errors, status: :unprocessable_entity }
        format.js {}
      end
    end
  end

  # PUT /<%= instances_name %>/1
  # PUT /<%= instances_name %>/1.js
  # PUT /<%= instances_name %>/1.json
  def update
    ## Fetching the <%= instance_name %>
    @<%= instance_name %> = <%= model_class %>.find(params[:id])
    
    ## Updating the @<%= instance_name %> object with params
    @<%= instance_name %>.assign_attributes(params[:<%= instance_name %>])
    
    ## Validating the data
    @<%= instance_name %>.valid?
    
    respond_to do |format|
      if @<%= instance_name %>.errors.blank?
        
        # Saving the <%= instance_name %> object
        @<%= instance_name %>.save
        
        # Setting the flash message
        message = translate("forms.updated_successfully", :item => "<%= instance_name.titleize %>")
        store_flash_message(message, :success)
        
        format.html { 
          redirect_to <%= resource_link('show','url') %>(@<%= instance_name %>), notice: message 
        }
        format.json { head :no_content }
        format.js {}
        
      else
        
        # Setting the flash message
        message = @<%= instance_name %>.errors.full_messages.to_sentence
        store_flash_message(message, :alert)
        
        format.html { 
          render action: "edit" 
        }
        format.json { render json: @<%= instance_name %>.errors, status: :unprocessable_entity }
        format.js {}
        
      end
    end
  end

  # DELETE /<%= instances_name %>/1
  # DELETE /<%= instances_name %>/1.js
  # DELETE /<%= instances_name %>/1.json
  def destroy
    ## Fetching the <%= instance_name %>
    @<%= instance_name %> = <%= model_class %>.find(params[:id])
    
    respond_to do |format|
      ## Destroying the <%= instance_name %>
      @<%= instance_name %>.destroy
      @<%= instance_name %> = <%= model_class %>.new

      # Fetch the <%= instances_name %> to refresh ths list and details box
      get_collections
      @<%= instance_name %> = @<%= instances_name %>.first if @<%= instances_name %> and @<%= instances_name %>.any?
      
      # Setting the flash message
      message = translate("forms.destroyed_successfully", :item => "<%= instance_name.titleize %>")
      store_flash_message(message, :success)
      
      format.html { 
        redirect_to <%= resource_link('index', 'url') %> notice: message
      }
      format.json { head :no_content }
      format.js {}
        
    end
  end
  
  private
  
  def set_navs
    set_nav("<%= model_class %>")
  end
  
  def get_collections
    # Fetching the <%= instances_name %>
    relation = <%= model_class %>.where("")
    @filters = {}
    
    if params[:query]
      @query = params[:query].strip
      relation = relation.search(@query) if !@query.blank?
    end
    
    @<%= instances_name %> = relation.order("created_at desc").page(@current_page).per(@per_page)
    
    ## Initializing the @<%= instance_name %> object so that we can render the show partial
    @<%= instance_name %> = @<%= instances_name %>.first unless @<%= instance_name %>
    
    return true
    
  end
  
end
