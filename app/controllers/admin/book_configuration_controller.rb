class Admin::BookConfigurationController < Admin::BaseController
	def index
		if params[:id]
			@prefs = Preference.where('owner_id='+params[:id])
		else
			@prefs = Preference.all
		end
		@confs = Configuration.all
	end
	
	def add
		p = Preference.new
		p.name = params[:name]
		p.value = params[:value]
		p.group_type = params[:group_type]
		p.owner_id = params[:owner_id]
		p.owner_type = "Configuration"
		p.save!
		render :text => "<tr id='id_#{p.id}'><td>#{p.id}</td><td>#{p.name}</td><td>#{p.value}</td><td>#{p.owner_id}</td><td>#{p.owner_type}</td><td><a onclick=\"edit_config('#{p.id}', '#{p.name}', '#{p.value}')\">Edit</a></td>"
	end
	
	def update
		p = Preference.find(params[:id])
		p.name = params[:name]
		p.value = params[:value]
		p.group_type = params[:group_type]
		p.owner_id = params[:owner_id]
		p.owner_type = "Configuration"
		p.save!
		render :text => "<tr id='id_#{p.id}'><td>#{p.id}</td><td>#{p.name}</td><td>#{p.value}</td><td>#{p.owner_id}</td><td>#{p.owner_type}</td><td><a onclick=\"edit_config('#{p.id}', '#{p.name}', '#{p.value}')\">Edit</a></td>"
	end
end