//
//  MainViewController.swift
//  Sideslip&TabbarLikeQQDemo
//
//  Created by 刘旭东 on 15/12/26.
//  Copyright © 2015年 刘旭东. All rights reserved.
//

import UIKit

class MainViewController: UIViewController,UIGestureRecognizerDelegate {
    //声明各个controller
    //mainTabbar视图控制器
    var mainTabbarController : MainTabbarController!
    //左侧滑视图控制器
    var sideViewController : SideViewController!
    
    //滑动手势
    var panGenture : UIPanGestureRecognizer!
    //点击手势
    var tapGenture : UITapGestureRecognizer!
    
    //侧滑参数
    //屏占比例，向右滑动完后左视图占整个屏幕的80%
    let Proportion:CGFloat = 0.8
    //屏幕的宽度和高度
    var frameWidth:CGFloat!
    var frameHeight:CGFloat!
    //动态纪录每次手势滑动时候tabbarView和sideView的view.center.x坐标
    var tabbarBeginCenterX:CGFloat!
    var sideBeginCenterX:CGFloat!

    override func viewDidLoad() {
        super.viewDidLoad()
        initView()
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    //初始化View
    func initView(){
        //初始化屏幕的宽度高度
        frameWidth = self.view.frame.width
        frameHeight = self.view.frame.height
        //添加背景图片，
        let bgView = UIImageView(frame: self.view.frame)
        bgView.image = UIImage(named: "bgsky")
        self.view.addSubview(bgView)
        
        //从storyboard读取Identifier为SideViewController的左视图的controller
        sideViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewControllerWithIdentifier("SideViewController") as! SideViewController
        //左视图的宽度只有整个屏幕宽度的0.8，且初始位置偏左
        sideViewController.view.frame = CGRectMake(-frameWidth*0.2, 0, frameWidth*0.8, frameHeight)
        //设置透明
        sideViewController.view.backgroundColor = UIColor.clearColor()
        self.view.addSubview(sideViewController.view)
        
        //添加mainTabbar视图到主视图
        mainTabbarController = UIStoryboard(name: "Main", bundle: nil).instantiateViewControllerWithIdentifier("MainTabbarController") as! MainTabbarController
        self.view.addSubview(mainTabbarController.view)
        
        //添加手势，滑动手势对整个视图都有效，触点手指只对tabar视图有效
        panGenture = UIPanGestureRecognizer(target: self, action: "pan:")
        self.view.addGestureRecognizer(panGenture)
        tapGenture = UITapGestureRecognizer(target: self, action: "tap")
        //tapGenture现在不需要添加到视图上，因为添加到视图上之后会影响视图正常使用时候的点触效果，所以在maintabbar靠到最后时候再添加到maintabbar上，点触动作执行完之后就移除
        //设置滑动钱tabbar视图和side视图的中心点x坐标
        tabbarBeginCenterX = self.view.center.x
        sideBeginCenterX = frameWidth*0.8*0.5 - frameWidth*0.2
        
    }
    //mainViewController滑动手势
    func pan(recongnizer: UIPanGestureRecognizer){
        //手指滑动的距离，向右为正向左为负
        var translatedX:CGFloat = recongnizer.translationInView(self.view).x
        //当滑动结束时根据滑动位置判断往左还是往右停靠
        let translatedProportion = translatedX / frameWidth
        
        //滑动至最大比例后停止滑动
        if translatedProportion < 0.8 {
            //往左滑动时候最多只能多滑动0.3个frameWidth
            if mainTabbarController.view.center.x >= self.view.center.x - frameWidth*0.3{
                mainTabbarController.view.center = CGPointMake(tabbarBeginCenterX + translatedX, self.view.center.y)
                //side视图的滑动距离只有tabbar视图的四分之一
                sideViewController.view.center = CGPointMake(sideBeginCenterX + translatedX/4, self.view.center.y)
            }
        }
        
        if recongnizer.state == .Ended{
            //滑动超过0.4个屏幕自动向右停靠，否则往左停靠
            if mainTabbarController.view.center.x > self.view.center.x + frameWidth*0.4{
                showSideView()
            }else {
                showMainTabberView()
            }
            tabbarBeginCenterX = mainTabbarController.view.center.x
            sideBeginCenterX = sideViewController.view.center.x
            //每次手势移动完后，下次移动时translatedX的初始值是上次移动时候的末值，然后才会从0开始，所以要手势结束之后要设为初始值0
            translatedX = 0
        }
    }
    //mainTabbarController点击手势，点击显示tabbar视图
    func tap(){
        showMainTabberView()
        //回到tabber视图后纪录tabbar视图和side视图的中心点x坐标
        tabbarBeginCenterX = mainTabbarController.view.center.x
        sideBeginCenterX = frameWidth*0.8*0.5 - frameWidth*0.2
        mainTabbarController.view.removeGestureRecognizer(tapGenture)
    }
    //左停靠显示maintabbar视图
    func showMainTabberView(){
        //采用动画形式跳回初始视图状态
        UIView.animateWithDuration(0.3, delay: 0, usingSpringWithDamping: 0.4, initialSpringVelocity: 2, options: .CurveEaseInOut, animations: { () -> Void in
            self.mainTabbarController.view.center = self.view.center
            self.mainTabbarController.view.transform = CGAffineTransformMakeTranslation(0, 0)
            }, completion:nil)
        sideViewController.view.center = CGPointMake(frameWidth*0.8*0.5 - frameWidth*0.2, self.view.center.y)
    }
    //右停靠显示左边视图
    func showSideView(){
        //添加点触手势
        mainTabbarController.view.addGestureRecognizer(tapGenture)
        mainTabbarController.view.center = CGPointMake(self.view.center.x + frameWidth * 0.8, self.view.center.y)
        sideViewController.view.center = CGPointMake(frameWidth*0.8*0.5, self.view.center.y)
    }
}
