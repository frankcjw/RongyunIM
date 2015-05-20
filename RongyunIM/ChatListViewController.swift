//
//  ChatListViewController.swift
//  RongyunIM
//
//  Created by QuickPlain on 5/19/15.
//  Copyright (c) 2015 cen. All rights reserved.
//

import UIKit

class ChatListViewController: RCConversationListViewController {
   
    override func onSelectedTableRow(conversationModelType: RCConversationModelType, conversationModel model: RCConversationModel!, atIndexPath indexPath: NSIndexPath!) {
        let conversationVC = ChatViewController()
        conversationVC.conversationType = model.conversationType //会话类型，这里设置为 PRIVATE 即发起单聊会话。
        conversationVC.targetId = model.targetId; // 接收者的 targetId，这里为举例。
        conversationVC.targetName = model.conversationTitle; // 接受者的 username，这里为举例。
        conversationVC.title = model.conversationTitle; // 会话的 title。
        conversationVC.setMessageAvatarStyle(RCUserAvatarStyle.Cycle)
        self.navigationController?.pushViewController(conversationVC, animated: true)
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        self.refreshConversationTableViewIfNeeded()
    }
}

/*

-(void)onSelectedTableRow:(RCConversationModelType)conversationModelType conversationModel:(RCConversationModel *)model atIndexPath:(NSIndexPath *)indexPath
{
RCConversationViewController *conversationVC = [[RCConversationViewController alloc]init];
conversationVC.conversationType =model.conversationType;
conversationVC.targetId = model.targetId;
conversationVC.targetName =model.conversationTitle;
conversationVC.title = model.conversationTitle;
[self.navigationController pushViewController:conversationVC animated:YES];
}
*/