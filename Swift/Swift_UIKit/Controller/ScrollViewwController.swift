//
//  ScrollViewwController.swift
//  Swift_UIKit
//
//  Created by 朱献国 on 2018/10/8.
//  Copyright © 2018年 朱献国. All rights reserved.
//

import UIKit

private class ScrollView: UIScrollView {
    
    fileprivate weak var superVC: UIViewController?
    
    // override points for subclasses to control delivery of touch events to subviews of the scroll view
    // called before touches are delivered to a subview of the scroll view. if it returns NO the touches will not be delivered to the subview
    // this has no effect on presses
    // default returns YES
    override func touchesShouldBegin(_ touches: Set<UITouch>, with event: UIEvent?, in view: UIView) -> Bool {
//        return super.touchesShouldBegin(touches, with: event, in: view)
        return false
    }
    
    // called before scrolling begins if touches have already been delivered to a subview of the scroll view. if it returns NO the touches will continue to be delivered to the subview and scrolling will not occur
    // not called if canCancelContentTouches is NO. default returns YES if view isn't a UIControl
    // this has no effect on presses
    override func touchesShouldCancel(in view: UIView) -> Bool {
//        return super.touchesShouldCancel(in: view)
        return false
    }
    
}

class ScrollViewwController: BaseController {

    private lazy var scrollView: ScrollView = {
        let scrollView = ScrollView(frame: .zero)
        scrollView.backgroundColor = .green
        scrollView.superVC = self
        view.addSubview(scrollView)
        return scrollView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        automaticallyAdjustsScrollViewInsets = false
    }
    
    deinit {
        print("ScrollViewwController 释放了！！！")
    }

}


/**
 scrollView上，显示内容的区域被称为contentView.一般情况下，我们对scrollView的操作，例如 addSubview 这样的操作都是在 contentView 上进行的。
 */
extension ScrollViewwController: UIScrollViewDelegate {
    override func setAttribute() {
        
        scrollView.frame = CGRect(x: 0, y: 0, width: view.bounds.width, height: view.bounds.height - 128)
        
        let v = UIView(frame: CGRect(x: 0, y: 0, width: view.bounds.width * 2, height: scrollView.frame.size.height))
        v.backgroundColor = .red
        let tf: UITextField = UITextField(frame: CGRect(x: 20, y: 60, width: 88, height: 22))
        tf.borderStyle = .roundedRect
        v.addSubview(tf)
        v.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(clicked)))
        scrollView.addSubview(v)
        
        // contentSize 是指 contentView 的大小 默认是CGSizeZero。它一般超过屏幕大小，是整个 UIScrollView 实际内容的大小。假如小于或等于滚动视图的frame.size，这时候滚动视图是不可以滚动的，连橡皮筋效果都没有
        scrollView.contentSize = v.bounds.size
        
        // contentOffset 是当前 contentView 浏览位置左上角点的坐标。它是相对于整个 UIScrollView 左上角为左边原点而言。默认为 CGPointZero。 只有在视图可滚动的前提下 此属性才生效。
//        scrollView.contentOffset = CGPoint(x: 100, y: 100)
        
        // contentInset 是指 contentView 与 UIScrollView 的边界。与网页开发的 padding 类似，分别指 contentView 的四条边到 UIScrollView 的对应边的距离，分别为 top，bottom，left，right。
        scrollView.contentInset = UIEdgeInsets(top: 100, left: 80, bottom: 0, right: 0) // default UIEdgeInsetsZero. add additional scroll area around content

        
        /**
         三者之间是互相影响的：
         1、 设置contentInset = UIEdgeInsets(top: 100, left: 80, bottom: 0, right: 0), 这时候 contentOffset = CGPoint(x: 0, y: 0) 并不会变化，因为添加这个inset，是相当于contentView顶部多了 100，左边多了80 的可滚动区域，偏移量在{-left, -top} 到 {contentSize.width - scrollView.frame.size.width, contentSize.height - scrollView.frame.size.height} 都是合法的
         
         这边换算过来是 {-80.0, -100.0} 到 {375.0, 0.0} 因此当前偏移量（0，0）在这个范围内，是合法的，所以系统不会调整其偏移量
         
         2、 这时候我们设置contentInset = UIEdgeInsets(top: -100, left: -80, bottom: 0, right: 0), 按照上面的算法换算过来合法区域是 {80.0, 100.0} 到 {375.0, 0.0} 注意换算时是要带正负号的
             这边我们可以看到两个区域的y值冲突了，在实际验证过程中发现真正可滚动区域是 {80.0, 100.0} 到 {375.0, 100.0}, 也就是说当两者Y值冲突会以Inset的top为准，默认scrollView的默认contentOffset是（0，0）不在其区域内，系统默认会调整其偏移量为 {80.0, 100.0} 并且回调一次scrollViewDidScroll：方法回调时偏移量已经被调整过了
         */
        print(scrollView.contentOffset)
        print("偏移量在 {-\(scrollView.contentInset.left), -\(scrollView.contentInset.top)} 到 {\(scrollView.contentSize.width - scrollView.frame.size.width), \(scrollView.contentSize.height - scrollView.frame.size.height)} 都是合法的")
        
//        /* When contentInsetAdjustmentBehavior allows, UIScrollView may incorporate
//         its safeAreaInsets into the adjustedContentInset.
//         */
//        @available(iOS 11.0, *)
//        open var adjustedContentInset: UIEdgeInsets { get }
//
//
//        /* Also see -scrollViewDidChangeAdjustedContentInset: in the UIScrollViewDelegate protocol.
//         */
//        @available(iOS 11.0, *)
//        open func adjustedContentInsetDidChange()
//
//
//        /* Configure the behavior of adjustedContentInset.
//         Default is UIScrollViewContentInsetAdjustmentAutomatic.
//         */
//        @available(iOS 11.0, *)
//        open var contentInsetAdjustmentBehavior: UIScrollView.ContentInsetAdjustmentBehavior
//
//
//        /* contentLayoutGuide anchors (e.g., contentLayoutGuide.centerXAnchor, etc.) refer to
//         the untranslated content area of the scroll view.
//         */
//        @available(iOS 11.0, *)
//        open var contentLayoutGuide: UILayoutGuide { get }
//
//
//        /* frameLayoutGuide anchors (e.g., frameLayoutGuide.centerXAnchor) refer to
//         the untransformed frame of the scroll view.
//         */
//        @available(iOS 11.0, *)
//        open var frameLayoutGuide: UILayoutGuide { get }


        scrollView.delegate = self // default nil. weak reference

        // AAAA
        scrollView.isDirectionalLockEnabled = false // default NO. if YES, try to lock vertical or horizontal scrolling while dragging 方向锁

        // AAAA
        scrollView.bounces = true // default YES. if YES, bounces past edge of content and back again
        scrollView.alwaysBounceVertical = true // default NO. if YES and bounces is YES, even if content is smaller than bounds, allow drag vertically
        scrollView.alwaysBounceHorizontal = true // default NO. if YES and bounces is YES, even if content is smaller than bounds, allow drag horizontally

        
        scrollView.isPagingEnabled = false // default NO. if YES, stop on multiples of view bounds

        scrollView.isScrollEnabled = true // default YES. turn off any dragging temporarily

        scrollView.showsHorizontalScrollIndicator = true // default YES. show indicator while we are tracking. fades out after tracking

        scrollView.showsVerticalScrollIndicator = true // default YES. show indicator while we are tracking. fades out after tracking

        // AAAA
        scrollView.scrollIndicatorInsets = UIEdgeInsets(top: -2, left: 0, bottom: -2, right: -2) // default is UIEdgeInsetsZero. adjust indicators inside of insets

        scrollView.indicatorStyle = .black // default is UIScrollViewIndicatorStyleDefault

        scrollView.decelerationRate = .fast // 减速比

//        scrollView.indexDisplayMode = .automatic TVOS 使用

//        open func scrollRectToVisible(_ rect: CGRect, animated: Bool) // scroll so rect is just visible (nearest edges). nothing if rect completely visible
//
//
//        open func flashScrollIndicators() // displays the scroll indicators for a short time. This should be done whenever you bring the scroll view to front.

        
        // When the user taps the status bar, the scroll view beneath the touch which is closest to the status bar will be scrolled to top, but only if its `scrollsToTop` property is YES, its delegate does not return NO from `-scrollViewShouldScrollToTop:`, and it is not already at the top.
        // On iPhone, we execute this gesture only if there's one on-screen scroll view with `scrollsToTop` == YES. If more than one is found, none will be scrolled.
        scrollView.scrollsToTop = true // default is YES. 点击状态栏回到最顶部

        scrollView.delaysContentTouches = true // default is YES. if NO, we immediately call -touchesShouldBegin:withEvent:inContentView:. this has no effect on presses

//        open var canCancelContentTouches: Bool // default is YES. if NO, then once we start tracking, we don't try to drag if the touch moves. this has no effect on presses

        
        /*
         the following properties and methods are for zooming. as the user tracks with two fingers, we adjust the offset and the scale of the content. When the gesture ends, you should update the content
         as necessary. Note that the gesture can end and a finger could still be down. While the gesture is in progress, we do not send any tracking calls to the subview.
         the delegate must implement both viewForZoomingInScrollView: and scrollViewDidEndZooming:withView:atScale: in order for zooming to work and the max/min zoom scale must be different
         note that we are not scaling the actual scroll view but the 'content view' returned by the delegate. the delegate must return a subview, not the scroll view itself, from viewForZoomingInScrollview:
         */

//        open var minimumZoomScale: CGFloat // default is 1.0
//
//        open var maximumZoomScale: CGFloat // default is 1.0. must be > minimum zoom scale to enable zooming
//
//
//        @available(iOS 3.0, *)
//        open var zoomScale: CGFloat // default is 1.0
//
//        @available(iOS 3.0, *)
//        open func setZoomScale(_ scale: CGFloat, animated: Bool)
//
//        @available(iOS 3.0, *)
//        open func zoom(to rect: CGRect, animated: Bool)
//
//
//        open var bouncesZoom: Bool // default is YES. if set, user can go past min/max zoom while gesturing and the zoom will animate to the min/max value at gesture end
//
//
//        open var isZooming: Bool { get } // returns YES if user in zoom gesture
//
//        open var isZoomBouncing: Bool { get } // returns YES if we are in the middle of zooming back to the min/max value

        // Use these accessors to configure the scroll view's built-in gesture recognizers.
        // Do not change the gestures' delegates or override the getters for these properties.

        // Change `panGestureRecognizer.allowedTouchTypes` to limit scrolling to a particular set of touch types.
//        @available(iOS 5.0, *)
//        open var panGestureRecognizer: UIPanGestureRecognizer { get }

        // `pinchGestureRecognizer` will return nil when zooming is disabled.
//        @available(iOS 5.0, *)
//        open var pinchGestureRecognizer: UIPinchGestureRecognizer? { get }

        // `directionalPressGestureRecognizer` is disabled by default, but can be enabled to perform scrolling in response to up / down / left / right arrow button presses directly, instead of scrolling indirectly in response to focus updates.
//        open var directionalPressGestureRecognizer: UIGestureRecognizer { get }

        scrollView.keyboardDismissMode = .onDrag // default is UIScrollViewKeyboardDismissModeNone

//        @available(iOS 10.0, *)
//        open var refreshControl: UIRefreshControl?
    }
    
    // 偏移量在 {-left, -top} 到 {contentSize.width - scrollView.frame.size.width, contentSize.height - scrollView.frame.size.height} 都是合法的
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        print("偏移量\(scrollView.contentOffset)")
        
        print(scrollView.isTracking)        // returns YES if user has touched. may not yet have started dragging
        print(scrollView.isDragging)        // returns YES if user has started scrolling. this may require some time and or distance to move to initiate dragging
        print(scrollView.isDecelerating)    // returns YES if user isn't dragging (touch up) but scroll view is still moving
    }
    
    @objc private func clicked(ges: UITapGestureRecognizer) -> Void {
        print("Hello, world!")
    }
    
}
