//
//  CWChatTabBarController.swift
//  CWWeChat
//
//  Created by chenwei on 16/6/22.
//  Copyright © 2016年 chenwei. All rights reserved.
//

import UIKit

class CWChatTabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        setupViewContollers()
        // Do any additional setup after loading the view.
    }
    
    func setupViewContollers() {
        
        let titleArray = ["微信", "通讯录", "发现", "我"]
        
        let normalImagesArray = [
            CWAsset.Tabbar_mainframe.image,
            CWAsset.Tabbar_contacts.image,
            CWAsset.Tabbar_discover.image,
            CWAsset.Tabbar_me.image,
            ]
        
        let selectedImagesArray = [
            CWAsset.Tabbar_mainframeHL.image,
            CWAsset.Tabbar_contactsHL.image,
            CWAsset.Tabbar_discoverHL.image,
            CWAsset.Tabbar_meHL.image,
            ]
        
        let viewControllerArray = [
            CWConversationsViewController(),
            CWAddressBookViewController(),
            CWDiscoverViewController(),
            CWMineViewController()
        ]
        
        let selectAttributes = [NSForegroundColorAttributeName : UIColor.chatSystemColor()]
        let normalAttributes = [NSForegroundColorAttributeName : UIColor.lightGrayColor()]
        
        var navigationVCArray = [CWChatNavigationController]()
        for (index, controller) in viewControllerArray.enumerate() {
            controller.tabBarItem.title = titleArray[index]
            controller.tabBarItem.image = normalImagesArray[index].imageWithRenderingMode(.AlwaysOriginal)
            controller.tabBarItem.selectedImage = selectedImagesArray[index].imageWithRenderingMode(.AlwaysOriginal)
            controller.tabBarItem.setTitleTextAttributes(normalAttributes, forState: .Normal)
            controller.tabBarItem.setTitleTextAttributes(selectAttributes, forState: .Selected)
            let navigationController = CWChatNavigationController(rootViewController: controller)
            navigationVCArray.append(navigationController)
        }
        
        self.viewControllers = navigationVCArray
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
