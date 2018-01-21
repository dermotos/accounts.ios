

def base_pods 
    pod 'SwiftyJSON'
end

def testing_pods 
    pod 'Nimble', '~> 7.0.3'
    pod 'Quick', '~> 1.2.0'
end

target 'accounts.iosTests' do
    platform :ios, '11.0'

    source 'https://github.com/CocoaPods/Specs.git'
    use_frameworks!
    
    testing_pods
    
end


target 'AccountKitTests' do
    platform :ios, '11.0'

    source 'https://github.com/CocoaPods/Specs.git'
    use_frameworks!

    testing_pods
    base_pods
end

target 'AccountKit' do
    platform :ios, '11.0'

    source 'https://github.com/CocoaPods/Specs.git'
    use_frameworks!
    base_pods
end

target 'AccountKit.WatchOS' do
    platform :watchos, '4.0'

    source 'https://github.com/CocoaPods/Specs.git'
    use_frameworks!
    base_pods
end