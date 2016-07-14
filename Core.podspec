Pod::Spec.new do |s|
  GITHUB_USER = "tulapps"
  s.name             = 'Core'
  s.version          = '0.0.1'
  s.summary          = 'Core components used for our projects'
  s.description      = <<-DESC
Set of Core components, including Networking, Persistence, .. that are used in our apps.s
                       DESC

  s.homepage         = "https://github.com/#{GITHUB_USER}/Core"
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'Pedro Piñera' => 'pepibumur@gmail.com', 'Sergi Gracia' => 'sergigram@gmail.com', 'Isaac Roldán' => "isaac.roldan@gmail.com" }
  s.source           = { :git => "https://github.com/#{GITHUB_USER}/Core.git", :tag => s.version.to_s }
  # s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'
  s.ios.deployment_target = '8.0'
  s.osx.deployment_target = '10.9'
  s.tvos.deployment_target = '9.0'
  s.watchos.deployment_target = '2.0'
  
  s.subspec "Foundation" do |sp|
    sp.source_files = 'Core/Classes/Foundation/**/*'
    sp.dependency 'RxSwift', '~> 2.6'
    sp.dependency 'SwiftyJSON', '~> 2.3'
  end

  s.subspec "Networking" do |sp|
    sp.dependency 'Core/Foundation'
    sp.source_files = 'Core/Classes/Networking/**/*'
  end

  s.subspec "Persistence" do |sp|
    sp.dependency 'Core/Foundation'
    sp.source_files = 'Core/Classes/Persistence/**/*'
  end

end
