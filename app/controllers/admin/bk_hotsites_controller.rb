class Admin::BkHotsitesController < ApplicationController
  def new
    @bk_hotsite = BkHotsite.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @bk_hotsite }
    end
  end
  
  def create
    @bk_hotsite = BkHotsite.new(params[:bk_hotsite])

    respond_to do |format|
      if @bk_hotsite.save
        format.html { redirect_to(admin_bk_hotsite_path(@bk_hotsite), :notice => 'BkHotsite was successfully created.') }
        format.xml  { render :xml => @bk_hotsite, :status => :created, :location => @bk_hotsite }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @bk_hotsite.errors, :status => :unprocessable_entity }
      end
    end
  end

end