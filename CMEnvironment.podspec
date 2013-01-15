Pod::Spec.new do |s|
  s.name         = "CMEnvironment"
  s.version      = "1.0.0"
  s.summary      = "Environment variables to your iOS project in a nicely way"
  s.homepage     = "https://github.com/lucasmedeirosleite/CMEnvironment"

  s.license      = { :type => 'MIT', :file => 'LICENCE' }
  
  s.author       = { "Lucas Medeiros" => "lucastoc@gmail.com" }
  
  s.source       = { :git => "https://github.com/lucasmedeirosleite/CMEnvironment.git", :tag => "1.0.0" }
  
  s.platform     = :ios, '5.0'
  s.platform     = :ios

  s.source_files = 'CMEnvironmentExample/CMEnvironment'
  
  s.requires_arc = true

  s.dependency 'NSDictionary+TRVSUnderscoreCamelCaseAdditions', '~> 0.1.0'

end
