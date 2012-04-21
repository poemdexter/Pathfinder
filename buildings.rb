class Buildings
  
  @@plans = {}
  
  def self.init
    config = YAML.load(File.open('buildings.yaml'))
    @@plans.merge! :hut => config['buildings']['hut']
  end
  
  def self.get_plans(name)
    @@plans[name]
  end
end