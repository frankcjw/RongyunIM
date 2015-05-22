//
//  ChatViewController.swift
//  RongyunIM
//
//  Created by QuickPlain on 5/19/15.
//  Copyright (c) 2015 cen. All rights reserved.
//

import UIKit

class ChatViewController: RCConversationViewController {
    override func willDisplayConversationTableCell(cell: RCMessageBaseCell!, atIndexPath indexPath: NSIndexPath!) {
        super.willDisplayConversationTableCell(cell, atIndexPath: indexPath)
    }
}
