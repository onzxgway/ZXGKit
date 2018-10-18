//
//  ViewController.m
//  XML解析
//
//  Created by 朱献国 on 19/09/2017.
//  Copyright © 2017 huakala. All rights reserved.
//

#import "ViewController.h"
#import "Model.h"
#import "GDataXMLNode.h"

@interface ViewController ()

@end

@implementation ViewController {
    Model *_model;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self demo];
}
- (IBAction)push:(id)sender {
}

- (void)demo {
    //1,拿到文件
    NSString *path = [[NSBundle mainBundle] pathForResource:@"a" ofType:@"xml"];
    //2,根据路径拿到数据
    NSData *data = [NSData dataWithContentsOfFile:path];
    //3,创建解析对象
    GDataXMLDocument *document = [[GDataXMLDocument alloc] initWithData:data options:0 error:nil];
    //4,获取根节点
    GDataXMLElement *rootElement = document.rootElement;
    //5,获取根节点下的 所有子节点
    NSArray *childrenElement = rootElement.children;
    //6，遍历每一个子节点
    for (GDataXMLElement *element in childrenElement) {
        //每遍历一次就 创建一个模型
        Model *model = [[Model alloc] init];
        //7，遍历子节点
        for (GDataXMLElement *subElement in element.children) {
            //8，对模型对象进行赋值
            //使用KVC的方式 对模型对象进行复制
            [model setValue:subElement.stringValue forKey:subElement.name];
            
            NSLog(@"%@ %@",subElement.name,subElement.stringValue);//打印
//            if ([subElement.name isEqualToString:@"formatted_address"]) {
//                model.formatted_address = subElement.stringValue;
//            }
        }
    }
}

@end
