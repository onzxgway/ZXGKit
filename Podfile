# CocoaPods为多个 具备多个target的project  添加依赖库
platform :ios, '9.0'

workspace 'ZXGKit.xcworkspace'

# ruby语法
# target数组 如果有新的target直接加入该数组
# Third.project
thirdArray = ['SDWebimage', 'Third', 'LearnFMDB']
thirdArray.each do |t|
    target t do
    	project 'Third/Third.project'
        pod 'FMDB'
        pod 'MJExtension'
        pod 'YYKit', '~> 1.0.9'
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
ProjectDemoArray = ['NetEase','JDShopCart','SinaWBFrameModel','SinaWBAutoCal']
ProjectDemoArray.each do |t|
    target t do
        project 'ProjectDemo/ProjectDemo.project'
        pod 'YYKit', '~> 1.0.9'
        #pod 'SDWebImage'
        #pod 'SVProgressHUD', '~> 2.2.2'
        #pod 'MBProgressHUD', '~> 1.1.0'
    end
end
