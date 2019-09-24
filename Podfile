# Uncomment the next line to define a global platform for your project
# platform :ios, '9.0'

target 'iOSTechnicalTest' do
  # Comment the next line if you're not using Swift and don't want to use dynamic frameworks
  use_frameworks!

  # Pods for iOSTechnicalTest
  pod 'Alamofire', '~> 4.8.0'
  pod 'SwiftyJSON', '~> 4.2.0'
  pod 'Kingfisher', '~> 5.0.0'

end

post_install do |installer|
    swift42Targets = ['Kingfisher']
    
    installer.pods_project.targets.each  do |target|
        if swift42Targets.include? target.name
            target.build_configurations.each  do |config|
                config.build_settings['ENABLE_BITCODE'] = 'NO'
                config.build_settings['SWIFT_VERSION'] = '4.2'
            end
            else
            target.build_configurations.each  do |config|
                config.build_settings['ENABLE_BITCODE'] = 'NO'
            end
        end
    end
end
