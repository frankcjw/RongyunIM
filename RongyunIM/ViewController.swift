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
let TOKEN  = "ye/RMvPpwki49cfEhSoFGy2GkrVUQvL0GUEcUhn8by94uP4K0hqkrvA0i3dUobQjVGYZk9bTRtfZPt2ZrHF9NrWALH7ayqzk"
let TOKEN2 = "2BaCLqwmomLn8g/oziOoo5E/5bdhTP0LFYPGfeRoPvPtx5/dnYqHaor+VY9h9DXzn0/iRZSMwtITsErf6SWVL/C6KJlawn48"
class ViewController: UIViewController ,RCIMUserInfoFetcherDelegagte{

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
//hello
//        RCIMClient.sharedRCIMClient()
        getUserInfo()
    }
    
    func getUserInfo(){
        RCIM.sharedKit().setUserInfoFetcherWithDelegate(self)
        
    }
    
    func getUserInfoWithUserId(userId: String!, completion: ((RCUserInfo!) -> Void)!) {
        var user = RCUserInfo()
        user.userId = userId;
        
        if userId == "402880ef4b" {
            user.name = "百度";
            //http://avatar.wolaizuo.com/100000_avatar_lOHMcaS8Pv.jpg
            user.portraitUri = "https://ss0.baidu.com/73t1bjeh1BF3odCf/it/u=1756054607,4047938258&fm=96&s=94D712D20AA1875519EB37BE0300C008"
        }else{
            user.name = "傻逼";
            user.portraitUri = "http://avatar.wolaizuo.com/100000_avatar_lOHMcaS8Pv.jpg";

        }
        
        
        return completion(user);
    }

    func showChatView(){
        let conversationVC = RCConversationViewController()
        conversationVC.conversationType = RCConversationType.ConversationType_PRIVATE //会话类型，这里设置为 PRIVATE 即发起单聊会话。
//        RCConversationType.ConversationType_PRIVATE

        conversationVC.targetId = "402880ef4a"; // 接收者的 targetId，这里为举例。
        conversationVC.targetName = "cao"; // 接受者的 username，这里为举例。
        conversationVC.title = "nam1"; // 会话的 title。
//        conversationVC.inp
        conversationVC.setMessageAvatarStyle(RCUserAvatarStyle.Cycle)
        let navi = UINavigationController(rootViewController: conversationVC)

        self.presentViewController(navi, animated: true) { () -> Void in
            //
        }
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
//        let vc = ChatListViewController()
//        self.presentViewController(vc, animated: true) { () -> Void in
//            //
//        }
        let tk = TOKEN2

        RCIM.sharedKit().initWithAppKey(RONGCLOUD_IM_APPKEY, deviceToken: tk)
        RCIM.sharedKit().connectWithToken(tk, success: { (userId) -> Void in
            println("userId \(userId)")
            self.showChatView()
            }) { (status) -> Void in
                println("status \(status)")
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

