# ruby语法
# CocoaPods为多个 具备多个target的project  添加依赖库
platform :ios, '9.0'
workspace 'ZXGKit.xcworkspace'

def pods
    pod 'ZXGCommontKit', :path => '../ZXGCommontKit'
    pod 'YYKit', '~> 1.0.9'
    pod 'MJExtension'
    pod 'Masonry'
end

# target数组 如果有新的target直接加入该数组
KnowledgePointDemoArray = ['Packaging','OCAndJS','CoreTextDemo', 'ZXGDatePickView']
KnowledgePointDemoArray.each do |t|
    target t do
        project '封装/KnowledgePointDemo.project'
        pods
        pod 'AFNetworking', '~> 3.0'
        pod 'NJKWebViewProgress'
    end
end

# target数组 如果有新的target直接加入该数组
KnowledgePointArray = ['UIWindow']
KnowledgePointArray.each do |t|
    target t do
        project 'KnowledgePoint/KnowledgePoint.project'
        pods
    end
end

# Third.project
thirdArray = ['SDWebimage', 'Third', 'LearnFMDB', 'LearnYYKit', 'LearnMJRefresh']
thirdArray.each do |t|
    target t do
    	project 'Third/Third.project'
        #pod 'FMDB'
        pods
    end
end


# CustomView.project
#MacroArray = ['ZXGCustomView']
#MacroArray.each do |t|
#    target t do
#    project 'Categorys/CustomView.project'
#        pods
#    end
#end

# PerformanceOptimization.project
POArray = ['TablePerformanceOptimization']
POArray.each do |t|
    target t do
    project 'PerformanceOptimization/PerformanceOptimization.project'
    
    end
end

# ProjectDemo.project
ProjectDemoArray = ['NetEase','JDShopCart','SinaWBFrameModel','SinaWBAutoCal','Moments','SinaWeibo']
ProjectDemoArray.each do |t|
    target t do
        project 'ProjectDemo/ProjectDemo.project'
        pods
        pod 'SDWebImage'
        pod 'SVProgressHUD'
        pod 'MBProgressHUD'
        pod 'MJRefresh'
    end
end

# KNPArray = ['OCAndJS']
# KNPArray.each do |t|
#     target t do
#         project 'KnowledgePoint/KnowledgePoint.project'
#         pods
#         pod 'NJKWebViewProgress'
#     end
# end



