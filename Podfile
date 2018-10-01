# Uncomment the next line to define a global platform for your project
platform :ios, '10.0'

target 'GADemo' do
  # Comment the next line if you're not using Swift and don't want to use dynamic frameworks
  use_frameworks!

  # Pods for GADemo
  pod 'SnapKit', '~> 4.0.0'
  pod 'Siesta', '~> 1.0'
  pod 'Siesta/UI', '~> 1.0'
  pod 'Kingfisher', '~> 4.0'



  target 'GADemoTests' do
    inherit! :search_paths
    # Pods for testing
    pod 'Siesta', '~> 1.0'
  end

post_install do |installer|
  installer.pods_project.targets.each do |target|
      if ['Siesta', 'SnapKit', 'Siesta.default-UI'].include? target.name
          target.build_configurations.each do |config|
              config.build_settings['SWIFT_VERSION'] = '4.0'
          end
      end
  end
end


end
