# Uncomment the next line to define a global platform for your project
platform :ios, '13.0'
use_frameworks!

post_install do |installer|
  installer.generated_projects.each do |project|
    project.targets.each do |target|
      target.build_configurations.each do |config|
        config.build_settings['IPHONEOS_DEPLOYMENT_TARGET'] = '13.0'
      end
    end
  end
end

target 'SkinCareList' do
  # Comment the next line if you don't want to use dynamic frameworks
  use_frameworks!
  pod 'Alamofire'
  pod 'Firebase/Analytics', '~> 10.7.0'
  pod 'Firebase/Crashlytics', '~> 10.7.0'
  pod 'lottie-ios','~> 4.1.3'
  # Pods for SkinCareList
  
  target 'SkinCareListTests' do
    inherit! :search_paths
    # Pods for testing
  end
  
  target 'SkinCareListUITests' do
    # Pods for testing
  end
end
