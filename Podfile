platform :ios, '10.0'
use_frameworks!

target 'SegmentView' do
   pod 'Masonry'
end

post_install do |pi|
    pi.pods_project.targets.each do |t|
        t.build_configurations.each do |config|
            config.build_settings['IPHONEOS_DEPLOYMENT_TARGET'] = '14.0'
        end
    end
end
