//
//  ViewController.swift
//  RongyunIM
//
//  Created by cen on 18/5/15.
//  Copyright (c) 2015 cen. All rights reserved.
//

import UIKit

let RONGCLOUD_IM_APPKEY = "0vnjpoadn51tz"
let SECRET = "BItzA3xnuUY"
let TOKEN  = "vBnB541sl0nnJqqGeaiel5E/5bdhTP0LFYPGfeRoPvPtx5/dnYqHaoILzj5bBOKs06QzbX6kU9sTsErf6SWVLwmtq504qa7S"
let TOKEN2 = "yHf6E9oTNu6xoyltsYO1JTTqU1XLHMf/ktCwYhwiyAKlr5v0jl9MHftQzoraSU6KRe6sJjTyt8rf/QJdGczurbtvYC5sLa8n"
let TOKEN_C = "5WMcHP/0h/WJk1bNvjiyfDTqU1XLHMf/ktCwYhwiyAKlr5v0jl9MHYKczJaabmoPKX88MhQiLJHf/QJdGczurceIyRIwYROT"
class ViewController: UIViewController ,RCIMUserInfoFetcherDelegagte{

    var targetName = "aaa"
    var targetId = "asd"
    var token = ""
    
    @IBAction func check(sender: AnyObject) {
        RCIM.sharedKit().initWithAppKey(RONGCLOUD_IM_APPKEY, deviceToken: TOKEN)
        
        RCIM.sharedKit().connectWithToken(TOKEN, success: { (userId) -> Void in
            println("userId \(userId)")
            let count = RCIMClient.sharedClient().getUnreadCount(RCConversationType.ConversationType_PRIVATE, targetId: "402880ef4a")
            println("count \(count)")
            }) { (status) -> Void in
                println("status \(status)")
        }
    }
    
    @IBAction func kefu(sender: AnyObject) {
        token = TOKEN
        targetId = "AlnkVmuTDY8="
        targetName = "客服"
        connect()
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view, typically from a nib.
//hello
//        RCIMClient.sharedRCIMClient()
        getUserInfo()
        CJWHttpUtils.manager().requestUrl("http://app.cenjiawen.com:8008/yfg?uid=100000&name=cjw", param: nil, shouldCache: false, success: { (resp) -> Void in
            println("\(resp)")
            if let info = resp["result"] as? String {
                println("\(info)")
            }else{
                println("error")
            }
        }) { () -> Void in
            //
        }
        
        var bt1 = UIButton(frame: CGRectMake(20, 300, 100, 30))
        bt1.addTarget(self, action: "user1", forControlEvents: UIControlEvents.TouchUpInside)
        bt1.setTitle("用户1", forState: UIControlState.Normal)
        
        var bt2 = UIButton(frame: CGRectMake(20, 350, 100, 30))
        bt2.addTarget(self, action: "user2", forControlEvents: UIControlEvents.TouchUpInside)
        bt2.setTitle("用户2", forState: UIControlState.Normal)
        
        self.view.addSubview(bt1)
        self.view.addSubview(bt2)
    }
    
    @IBAction func chatList(sender: AnyObject) {
        showChatList()
    }
    
    func user1(){
        token = TOKEN
        targetId = "402880ef4c"
        targetName = "ccc"
        connect()
    }
    
    @IBAction func loginUser1(sender: AnyObject) {
        user1()
    }
    @IBAction func loginUser2(sender: AnyObject) {
        user2()
    }
    
    func user2(){
        token = TOKEN2
        targetId = "402880ef4c"
        targetName = "ccc"
        connect()
    }
    
    func getUserInfo(){
        RCIM.sharedKit().setUserInfoFetcherWithDelegate(self)
        
    }
    
    func getUserInfoWithUserId(userId: String!, completion: ((RCUserInfo!) -> Void)!) {
        var user = RCUserInfo()
        user.userId = userId;
        
        if userId == "402880ef4b" {
            user.name = "bbb";
            //http://avatar.wolaizuo.com/100000_avatar_lOHMcaS8Pv.jpg
            user.portraitUri = "https://ss0.baidu.com/73t1bjeh1BF3odCf/it/u=1756054607,4047938258&fm=96&s=94D712D20AA1875519EB37BE0300C008"
        }else if userId == "AlnkVmuTDY8="{
            user.name = "客服";
            user.portraitUri = "http://avatar.wolaizuo.com/100030_avatar_uKW7mtOjXT.jpg";
        }
        else{
            user.name = "aaa";
            user.portraitUri = "http://avatar.wolaizuo.com/100000_avatar_lOHMcaS8Pv.jpg";
//            user.portraitUri = "https://ss0.baidu.com/73t1bjeh1BF3odCf/it/u=1756054607,4047938258&fm=96&s=94D712D20AA1875519EB37BE0300C008"


        }
        return completion(user);
    }

    func dissmiss(){
        conversationVC.dismissViewControllerAnimated(true, completion: { () -> Void in
            //
        })
    }
    
    let conversationVC = ChatViewController()

    func showChatView(){
        conversationVC.conversationType = RCConversationType.ConversationType_PRIVATE //会话类型，这里设置为 PRIVATE 即发起单聊会话。
        conversationVC.targetId = targetId; // 接收者的 targetId，这里为举例。
        conversationVC.targetName = targetName; // 接受者的 username，这里为举例。
        conversationVC.title = targetName; // 会话的 title。
        conversationVC.setMessageAvatarStyle(RCUserAvatarStyle.Cycle)
        
        let bar = UIBarButtonItem(title: "取消", style: UIBarButtonItemStyle.Plain, target: self, action: "dissmiss")
        conversationVC.navigationItem.leftBarButtonItem = bar
        
        let navi = UINavigationController(rootViewController: conversationVC)

        self.presentViewController(navi, animated: true) { () -> Void in
            //
        }
    }
    let chatListVC = ChatListViewController()
    
    func dismissChatList(){
        chatListVC.dismissViewControllerAnimated(true, completion: { () -> Void in
            //
        })
    }
    
    func showChatList(){
        RCIM.sharedKit().initWithAppKey(RONGCLOUD_IM_APPKEY, deviceToken: TOKEN2)
        
        RCIM.sharedKit().connectWithToken(TOKEN2, success: { (userId) -> Void in
            println("userId \(userId)")
            self.getUserInfo()
            let bar = UIBarButtonItem(title: "取消", style: UIBarButtonItemStyle.Plain, target: self, action: "dismissChatList")
            self.chatListVC.navigationItem.leftBarButtonItem = bar
            
            let navi = UINavigationController(rootViewController: self.chatListVC)
            
            self.presentViewController(navi, animated: true) { () -> Void in
                //
            }
            }) { (status) -> Void in
                println("status \(status)")
        }
        
    }
    
    func connect(){
        RCIM.sharedKit().initWithAppKey(RONGCLOUD_IM_APPKEY, deviceToken: token)

        RCIM.sharedKit().connectWithToken(token, success: { (userId) -> Void in
            println("userId \(userId)")
            self.showChatView()
            }) { (status) -> Void in
                println("status \(status)")
        }
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
//        let vc = ChatListViewController()
//        self.presentViewController(vc, animated: true) { () -> Void in
//            //
//        }

        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

