class FSMBuild
  
  state_machine :initial => :searching_mat do
  
    event :path_found do
      transition :searching_mat => :walking_mat, :searching_buildspot => :walking_buildspot
    end
    
    event :path_not_found do
      transition :searching_mat => same, :searching_buildspot => same
    end
    
    event :arrived do
      transition :walking_mat => :taking_mat, :walking_buildspot => :placing_mat
    end
    
    event :need_more_mats do
      transition :placing_mat => :searching_mat
    end
    
    event :have_all_mats do
      transition :placing_mat => :building
    end
    
    event :building_done
      transition :building => :done
    end
  end
  
  def initialize
    super
  end
  
end