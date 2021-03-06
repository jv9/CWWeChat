//
//  CWGuideViewController.swift
//  CWWeChat
//
//  Created by chenwei on 16/6/28.
//  Copyright © 2016年 chenwei. All rights reserved.
//

import UIKit

class CWGuideViewController: UIViewController {

    @IBOutlet weak var launchImageView: UIImageView!
    
    @IBOutlet weak var registerButton: UIButton!
    @IBOutlet weak var loginButton: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()

        
        let imageNameArray = ["LaunchImage",
                              "LaunchImage-700-568h",
                              "LaunchImage-800-667h",
                              "LaunchImage-800-Portrait-736h"]

        launchImageView.image = UIImage(named: imageNameArray[2])
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func buttonAction(sender: UIButton) {
        let loginVC = CWLoginViewController()
        let nav = UINavigationController(rootViewController: loginVC)
        self.presentViewController(nav, animated: true, completion: nil)
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
