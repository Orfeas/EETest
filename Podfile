platform :ios, '12.0'

source 'https://github.com/CocoaPods/Specs.git'


target 'FootballLeague' do
  project 'FootballLeague.xcodeproj'
  
  use_frameworks!
  inhibit_all_warnings!

  # Pods for SafeToNet
  pod 'Alamofire', '5.1.0'
  pod 'AlamofireImage', '4.0.3'
  pod 'SVGKit', :git => 'https://github.com/SVGKit/SVGKit.git', :branch => '3.x'
  pod 'SVProgressHUD', '2.2.5'

  target 'FootballLeagueTests' do
      inherit! :search_paths
      
  end

end
 
post_install do |installer|
    installer.pods_project.build_configurations.each do |config|
        config.build_settings['CODE_SIGNING_ALLOWED'] = 'NO'
        config.build_settings['CODE_SIGNING_REQUIRED'] = 'NO'
        config.build_settings.delete('CODE_SIGNING_ALLOWED')
        config.build_settings.delete('CODE_SIGNING_REQUIRED')
    end
    installer.pods_project.targets.each do |target|
        target.build_configurations.each do |config|
            config.build_settings['CODE_SIGNING_ALLOWED'] = 'NO'
            config.build_settings['CODE_SIGNING_REQUIRED'] = 'NO'
            config.build_settings.delete('CODE_SIGNING_ALLOWED')
            config.build_settings.delete('CODE_SIGNING_REQUIRED')
        end
    end
  end
