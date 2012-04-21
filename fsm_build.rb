class FSMBuild
  
  state_machine :initial => :chill do
  
    event :building_needed do
      transition :chill => :searching_mat
    end
  
    event :path_found do
      transition :searching_mat => :walking_mat, :searching_buildspot => :walking_buildspot
    end
    
    event :path_not_found do
      transition :searching_mat => same, :searching_buildspot => same
    end
    
    event :arrived do
      transition :walking_mat => :taking_mat, :walking_buildspot => :placing_mat
    end
    
    event :got_mat do
      transition :taking_mat => :searching_buildspot
    end
    
    event :need_more_mats do
      transition :placing_mat => :searching_mat
    end
    
    event :have_all_mats do
      transition :placing_mat => :building
    end
    
    event :tick_building do
      transition :building => same
    end
    
    event :building_done do
      transition :building => :chill
    end
  end
  
  def initialize
    super
  end
  
  def set_building(building)
    @plans = Buildings.get_plans(building)
    @construction_time = @plans["time"]
  end
  
  def placed_mat(mat)
    i = @plans["mats"].index(mat)
    @plans["mats"].delete_at(i)
  end
  
  def got_all_mats?
    @plans["mats"] == []
  end
  
  def tick_construction_time
    @construction_time -= 1
  end
end