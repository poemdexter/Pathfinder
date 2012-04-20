class Buildings
  
  
  def self.init
    config = YAML.load(File.open('buildings.yaml'))
    @@plans = {}
    @@plans.merge! :hut => config['buildings']['hut']
  end
  
  def get_plans(name)
    @@plans[name]
  end
end