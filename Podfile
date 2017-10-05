# Uncomment the next line to define a global platform for your project
# platform :ios, '9.0'

target 'eSponsorship' do
  # Comment the next line if you're not using Swift and don't want to use dynamic frameworks
  use_frameworks!

# Pods for eSponsorship
pod ‘Firebase/Core’
pod ‘Firebase/Database’
pod 'Firebase/Storage’
pod ‘Firebase/Auth’
pod 'Onboard'

source 'https://github.com/CocoaPods/Specs.git'
use_frameworks!

pod 'SideMenu'
pod 'PageMenu'
pod 'Eureka', :git => 'https://github.com/xmartlabs/Eureka.git'

# Eureka pod install is here, don't touch
post_install do |installer|
    installer.pods_project.targets.each do |target|
        
        if  target.name == 'Eureka'
            target.build_configurations.each do |config|
                config.build_settings['SWIFT_VERSION'] = '4.0'
            end
        end
    end
end


end
