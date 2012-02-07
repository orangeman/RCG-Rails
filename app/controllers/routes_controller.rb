require "rcg"

class RoutesController < ApplicationController
  
  @@RCG = Rails.cache.read('rcg')
  
  protect_from_forgery :only => [:create, :update, :destroy]
  
  def auto_complete_for_route_from
    render :text => Rails.cache.read(params[:route][:from].first.upcase)
  end
  def auto_complete_for_route_to
    render :text => Rails.cache.read(params[:route][:to].first.upcase)
  end
  

  # GET /routes
  # GET /routes.xml
  def index
    if params[:route] && params[:route][:from] != "" && params[:route][:to] != ""
      start = Time.now
      if params[:wie] == "RCG"
        @routes = @@RCG.search params[:route][:from], params[:route][:to], params[:nmb].to_i
      else  
        @routes = brute_force params[:route][:from], params[:route][:to], params[:nmb].to_i
      end  
      @time = Time.now - start
    else  
      @routes =[]
    end

    respond_to do |format|
      format.html { render :partial => "index" if params[:commit]}
      format.xml  { render :xml => @routes }
    end
  end

  def brute_force(from, to, nmb)
    query = Route.lookUp(from, to)
    puts "#{query}"
    res = []
    Rails.cache.read('sim').cars.each do |car|
      det = car.route.detour_via query
      # res << [route, det] if det*100/route.dist < $THRESHOLD #&& route.from == query.from
      res << [car, det] if det < $MAX_DETOUR #&& route.from == query.from
    end 
    res.sort! { |a, b| if a[1]!=b[1]; a[1] <=> b[1] else a[0].route.dist <=> b[0].route.dist end}
    puts "da"
    res[0..nmb].map { |r| r[0] }
    # res.map { |e| e[0]}
  end

  # GET /routes/1
  # GET /routes/1.xml
  def show
    @route = Route.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @route }
    end
  end

  # GET /routes/new
  # GET /routes/new.xml
  def new
    @route = Route.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @route }
    end
  end

  # GET /routes/1/edit
  def edit
    @route = Route.find(params[:id])
  end

  # POST /routes
  # POST /routes.xml
  def create
    @route = Route.new(params[:route])

    respond_to do |format|
      if @route.save
        flash[:notice] = 'Route was successfully created.'
        format.html { redirect_to(@route) }
        format.xml  { render :xml => @route, :status => :created, :location => @route }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @route.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /routes/1
  # PUT /routes/1.xml
  def update
    @route = Route.find(params[:id])

    respond_to do |format|
      if @route.update_attributes(params[:route])
        flash[:notice] = 'Route was successfully updated.'
        format.html { redirect_to(@route) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @route.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /routes/1
  # DELETE /routes/1.xml
  def destroy
    @route = Route.find(params[:id])
    @route.destroy

    respond_to do |format|
      format.html { redirect_to(routes_url) }
      format.xml  { head :ok }
    end
  end
end
