Pod::Spec.new do |s|
  s.name             = 'CarambaKit'
  s.version          = '1.0.5'
  s.summary          = 'Core components used for our projects'
  s.description      = <<-DESC
Set of Core components, including Networking, Persistence and much more that are used in our apps
                       DESC

  s.homepage         = "https://github.com/carambalabs/CarambaKit"
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'Caramba.io' => 'hello@caramba.io' }
  s.source           = { :git => "https://github.com/carambalabs/CarambaKit.git", :tag => s.version.to_s }
  s.ios.deployment_target = '8.0'
  s.osx.deployment_target = '10.10'
  s.tvos.deployment_target = '9.0'
  s.watchos.deployment_target = '2.0'

  s.subspec "Foundation" do |sp|
    sp.source_files = 'CarambaKit/Classes/Foundation/**/*'
    sp.dependency "Result", "~> 3.0"
    sp.dependency 'SwiftyJSON', '~> 3.0'
  end

  s.subspec "Networking" do |sp|
    sp.dependency 'CarambaKit/Foundation'
    sp.dependency 'KeychainSwift', '~> 6.0'
    sp.source_files = 'CarambaKit/Classes/Networking/Base/**/*'
  end

end
