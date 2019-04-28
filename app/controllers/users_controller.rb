require 'json'
require 'net/http'

class UsersController < ApplicationController

  def show
    @user = User.find(params[:id])
    # @vehicle_stats =  VehicleStatus.first()
    source = "http://47.218.218.78:8080/car_info.json"
    rsp = Net::HTTP.get_response(URI.parse(source))
    car_info = JSON.parse(rsp.body)
    
    # data.each do |key, value|
    #   if value.is_a?(Integer)
    #     data[key] = value.to_s
    #   end
    # end
    
    @vehicle_stats = {:location => car_info['LLA'], :time => car_info['time'], :tire_pressure => car_info['tire pressure'], :battery_level => car_info['battery'], :lidar_status => car_info['lidar status']}
    return @user, @vehicle_stats
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      log_in @user
      redirect_to checklist_path
    else
      render 'new'
    end
  end
  
  def edit
    @user = User.find(params[:id])
  end
  
  def update
    @user = User.find(params[:id])
    if @user.update_attributes(user_params)
      flash[:success] = "Profile updated"
      redirect_to @user
    else
      render 'edit'
    end
  end

  def show_stats
    # @vehicle_stats =  VehicleStatus.first()
    # @vehicle_stats = {:tire_pressure => "60Pa", :battery_level => "70%", :lidar_status => "Ok"}
  end  


  private

    def user_params
      params.require(:user).permit(:firstname, :lastname, :email, :password,
                                   :password_confirmation)
    end
    
   
end