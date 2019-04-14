# Uncomment the next line to define a global platform for your project
# platform :ios, '9.0'
# 忽略引入库的所有警告（强迫症者的福音啊）
inhibit_all_warnings!

def base_pods
    pod 'AFNetworking'
    pod 'pop'
    pod 'SDWebImage'
    pod 'Masonry'
    pod "ReactiveObjC"
    pod 'MJExtension'
    pod 'MJRefresh'
    pod 'FLAnimatedImage'
    pod 'Aspects'
    pod 'MLeaksFinder', :configuration => 'Debug'
    pod 'BRPickerView'
end

target 'ShowTestDome' do

  base_pods

  target 'ShowTestDomeTests' do
    inherit! :search_paths
    # Pods for testing
  end

  target 'ShowTestDomeUITests' do
    inherit! :search_paths
    # Pods for testing
  end

end
