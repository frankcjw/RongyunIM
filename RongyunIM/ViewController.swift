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
let TOKEN = "ye/RMvPpwki49cfEhSoFGy2GkrVUQvL0GUEcUhn8by94uP4K0hqkrvA0i3dUobQjVGYZk9bTRtfZPt2ZrHF9NrWALH7ayqzk"
let TOKEN2 = "lRsa2JC63e+49cfEhSoFGy2GkrVUQvL0GUEcUhn8by94uP4K0hqkrhOmyjor4tcZVGYZk9bTRtfZPt2ZrHF9NjOQE0FNLNKb"
class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
//hello
//        RCIMClient.sharedRCIMClient()
        
    }

    func showChatView(){
        let conversationVC = RCConversationViewController()
        conversationVC.conversationType = RCConversationType.ConversationType_PRIVATE //会话类型，这里设置为 PRIVATE 即发起单聊会话。
//        RCConversationType.ConversationType_PRIVATE

        conversationVC.targetId = "402880ef4a"; // 接收者的 targetId，这里为举例。
        conversationVC.targetName = "name"; // 接受者的 username，这里为举例。
        conversationVC.title = "nam1"; // 会话的 title。
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

