# CocoaPods为多个 具备多个target的project  添加依赖库
platform :ios, '9.0'

workspace 'ZXGKit.xcworkspace'

def pods
    #pod 'ZXGCommonsKit', :path => '../ZXGCommonsKit'
    pod 'YYKit', '~> 1.0.9'
    pod 'MJExtension'
end

# ruby语法
# target数组 如果有新的target直接加入该数组
fengzhuangArray = ['Packaging']
fengzhuangArray.each do |t|
    target t do
        project '封装/封装.project'
        pods
        pod 'AFNetworking', '~> 3.0'
    end
end

# Third.project
thirdArray = ['SDWebimage', 'Third', 'LearnFMDB']
thirdArray.each do |t|
    target t do
    	project 'Third/Third.project'
        #pod 'FMDB'
        pods
    end
end


# Macro_And_Categorys.project
MacroArray = ['Macro_And_Categorys']
MacroArray.each do |t|
    target t do
    project 'Categorys/Macro_And_Categorys.project'
        
    end
end

# PerformanceOptimization.project
POArray = ['TablePerformanceOptimization']
POArray.each do |t|
    target t do
    project 'PerformanceOptimization/PerformanceOptimization.project'
    
    end
end

# ProjectDemo.project
ProjectDemoArray = ['NetEase','JDShopCart','SinaWBFrameModel','SinaWBAutoCal','Moments']
ProjectDemoArray.each do |t|
    target t do
        project 'ProjectDemo/ProjectDemo.project'
        pods
        pod 'SDWebImage'
        pod 'SVProgressHUD'
        pod 'MBProgressHUD'
        pod 'Masonry'
        pod 'MJRefresh'
    end
end
