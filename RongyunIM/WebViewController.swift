//
//  WebViewController.swift
//  RongyunIM
//
//  Created by cen on 19/5/15.
//  Copyright (c) 2015 cen. All rights reserved.
//

import UIKit

class WebViewController: UIViewController {

    var bridge:WebViewJavascriptBridge!
    
    @IBOutlet weak var webView: UIWebView!
    
    func send(){
        bridge.send("caocao")
    }
    
    override func viewDidLoad() {
        var bar = UIBarButtonItem(title: "hello", style: UIBarButtonItemStyle.Plain, target: self, action: "send")
        super.viewDidLoad()
        self.navigationItem.rightBarButtonItem = bar
        webView.loadRequest(NSURLRequest(URL: NSURL(string: "http://app.cenjiawen.com/ry/js.html")!))
        bridge = WebViewJavascriptBridge(forWebView: webView, handler: { (object, callback:WVJBResponseCallback!) -> Void in
            println("object \(object)")
            if object is NSDictionary {
                if let abc = object["FF"] as? String {
                    println("\(abc)")
                }else{
                    println("e1")
                }
            }else{
                println("e2")
            }
            callback("fuck you")
        })
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
