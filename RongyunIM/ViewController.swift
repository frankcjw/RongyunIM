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

let kefuID = "AlnkVmuTDY8="
let hostID = "402880ef4a"
class ViewController: UIViewController ,RCIMUserInfoFetcherDelegagte{

//    var targetName = "aaa"
//    var targetId = "asd"
//    var token = ""
    
    typealias TokenBlock = (token:String) -> ()
    typealias ConnectBlock = () -> ()

    func connect(userId:String,block:ConnectBlock){
        getToken(userId, block: { (token) -> () in
            RCIM.sharedKit().initWithAppKey(RONGCLOUD_IM_APPKEY, deviceToken: token)
            RCIM.sharedKit().connectWithToken(token, success: { (userId) -> Void in
                    block()
                }) { (status) -> Void in
                    println("status \(status)")
            }

        })
    }
    
    func chat(userID:String,targetID:String,targetName:String){
        connect(userID, block: { () -> () in
//            self.showChatView(targetID, targetName: targetName)
            self.showChatView(userID, targetId: targetID, targetName: targetName)
        })
    }
    
    func getToken(userId:String,block:TokenBlock){var url = "http://localhost:8080/yangfaguan?uid=\(userId)&name=cjw"
        url = "http://app.cenjiawen.com:8008/yfg?uid=\(userId)&name=cjw"
        CJWHttpUtils.manager().requestUrl(url, param: nil, shouldCache: false, success: { (resp) -> Void in
            if let info = resp["result"] as? NSString {
                let dict: AnyObject! = info.objectFromJSONString()
                if let token = dict["token"] as? String {
                    block(token: token)
                }
            }else{
                println("error")
            }
            }) { () -> Void in
                //
        }

    }
    
    @IBAction func check(sender: AnyObject) {
        checkMessage(hostID, targetId: kefuID, messageCount: 10,type: RCConversationType.ConversationType_PRIVATE)
        return
    }
    
    func checkMessage(userId:String,targetId:String,messageCount:Int,type:RCConversationType){
        connect(userId, block: { () -> () in
            let client = RCIMClient.sharedClient()
            let msgs = client.getLatestMessages(type, targetId: targetId, count: 10)
            println("msgs \(msgs.count)")
            var txt = ""
            for msg in msgs {
                if msg is RCMessage {
                    let message:RCMessage = msg as! RCMessage
                    
                    NSTimeIntervalSince1970
                    let time:Double = Double(message.sentTime) / 1000
                    let date = NSDate(timeIntervalSince1970: time)
                    var fmt = NSDateFormatter()
                    fmt.dateFormat = "yyyy-MM-dd HH:mm"
                    let timeString = fmt.stringFromDate(date)
                    let data = message.content.encode()
                    let str:NSString = NSString(data: data, encoding: NSUTF8StringEncoding)!

                    let objectName = message.objectName
                    if objectName == "RC:ImgMsg" {
                        println("iiimg")
                        let imgContent = message.content as! RCImageMessage
                        self.imgv.sd_setImageWithURL(NSURL(string: "\(imgContent.imageUrl)"))
                    }else if objectName == "RC:TxtMsg" {
                        let txtMsg = message.content as! RCTextMessage
                        if let dict = message.content.encode().objectFromJSONData() as? NSDictionary {
                            let sender = message.senderUserId
                            var who = "[我]"
                            if sender == targetId {
                                who = "[客服]"
                            }
                            if let content = dict["content"] as? String {
//                                println("\(timeString) content \(content)")
                                txt = txt + "\(timeString) \(who)\n\(txtMsg.content)\n"
                            }
                        }
                    }
                }
            }
            var alert = UIAlertView(title: "客服消息", message: txt, delegate: nil, cancelButtonTitle: "确定")
            alert.show()
            client.disconnect()
        })
    }
    
    @IBAction func kefu(sender: AnyObject) {
//        token = TOKEN
//        targetId = kefuID
//        targetName = "客服"
//        connect()
        chat(hostID, targetID: kefuID, targetName: "客服")
    }
    
    var imgv = UIImageView(frame: CGRectMake(100, 100, 300, 300))

    override func viewDidLoad() {
        super.viewDidLoad()

        imgv.sd_setImageWithURL(NSURL(string: "http://ww4.sinaimg.cn/bmiddle/62f87eb4gw1esarnsg3aug20bv06o4qt.gif"))
        imgv.backgroundColor = UIColor.blueColor()
        self.view.addSubview(imgv)
        // Do any additional setup after loading the view, typically from a nib.

        
        //RCIMClient.sharedRCIMClient()
        getUserInfo()
        
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
    
    
    
    @IBAction func loginUser1(sender: AnyObject) {
        user1()
    }
    @IBAction func loginUser2(sender: AnyObject) {
        user2()
    }
    
    func user1(){
//        token = TOKEN
//        targetId = "402880ef4b"
//        targetName = "ccc"
//        connect()
//        connect("402880ef4a", block: { () -> () in
//            self.showChatView()
//        })
        var tgId = "402880ef4b"
//        tgId = kefuID
        chat("402880ef4a", targetID: tgId, targetName: tgId)
        
    }
    
    func user2(){
//        token = TOKEN2
//        targetId = "402880ef4a"
//        targetName = "ccc"
//        connect("402880ef4b", block: { () -> () in
//            self.showChatView()
//        })
        let tgId = "100021"
        chat("402880ef4b", targetID: tgId, targetName: tgId)

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
            RCIM.sharedKit().disconnect()
        })
    }
    
    let conversationVC = ChatViewController()

//    func showChatView(){
//        conversationVC.conversationType = RCConversationType.ConversationType_PRIVATE //会话类型，这里设置为 PRIVATE 即发起单聊会话。
//        conversationVC.targetId = targetId; // 接收者的 targetId，这里为举例。
//        conversationVC.targetName = targetName; // 接受者的 username，这里为举例。
//        conversationVC.title = targetName; // 会话的 title。
//        conversationVC.setMessageAvatarStyle(RCUserAvatarStyle.Cycle)
//        
//        let bar = UIBarButtonItem(title: "取消", style: UIBarButtonItemStyle.Plain, target: self, action: "dissmiss")
//        conversationVC.navigationItem.leftBarButtonItem = bar
//        
//        let navi = UINavigationController(rootViewController: conversationVC)
//
//        self.presentViewController(navi, animated: true) { () -> Void in
//            //
//        }
//    }
    func showChatView(userId:String,targetId:String,targetName:String){
        conversationVC.conversationType = RCConversationType.ConversationType_PRIVATE //会话类型，这里设置为 PRIVATE 即发起单聊会话。
        conversationVC.targetId = targetId; // 接收者的 targetId，这里为举例。
        conversationVC.targetName = targetName; // 接受者的 username，这里为举例。
        conversationVC.title = userId + " -> " + targetName; // 会话的 title。
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
//        RCIM.sharedKit().initWithAppKey(RONGCLOUD_IM_APPKEY, deviceToken: TOKEN2)
//        
//        RCIM.sharedKit().connectWithToken(TOKEN2, success: { (userId) -> Void in
//            println("userId \(userId)")
//            self.getUserInfo()
//            let bar = UIBarButtonItem(title: "取消", style: UIBarButtonItemStyle.Plain, target: self, action: "dismissChatList")
//            self.chatListVC.navigationItem.leftBarButtonItem = bar
//            
//            let navi = UINavigationController(rootViewController: self.chatListVC)
//            
//            self.presentViewController(navi, animated: true) { () -> Void in
//                //
//            }
//            }) { (status) -> Void in
//                println("status \(status)")
//        }
        connect(hostID, block: { () -> () in
            let bar = UIBarButtonItem(title: "取消", style: UIBarButtonItemStyle.Plain, target: self, action: "dismissChatList")
            self.chatListVC.navigationItem.leftBarButtonItem = bar
            
            let navi = UINavigationController(rootViewController: self.chatListVC)
            
            self.presentViewController(navi, animated: true) { () -> Void in
                //
            }
        })
        
    }
    
//    func connect(){
//        RCIM.sharedKit().initWithAppKey(RONGCLOUD_IM_APPKEY, deviceToken: token)
//        RCIM.sharedKit().connectWithToken(token, success: { (userId) -> Void in
//            println("userId \(userId)")
//            self.showChatView()
//            }) { (status) -> Void in
//                println("status \(status)")
//        }
//    }
    
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

