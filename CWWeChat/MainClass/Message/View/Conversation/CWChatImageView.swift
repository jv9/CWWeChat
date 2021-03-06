//
//  CWChatImageView.swift
//  CWWeChat
//
//  Created by chenwei on 16/4/6.
//  Copyright © 2016年 chenwei. All rights reserved.
//

import UIKit
import AlamofireImage

///下载展示imageView
class CWChatImageView: UIView {
    
    /// 放置内容
    var contentImageView: UIImageView = {
        let contentImageView = UIImageView()
        contentImageView.backgroundColor = UIColor.grayColor()
        return contentImageView
    }()
    //引导
    let activityView = UIActivityIndicatorView(activityIndicatorStyle: .White)
    
    let indicatorbackgroundView:UIView = {
        let indicatorbackgroundView = UIView()
        indicatorbackgroundView.backgroundColor = UIColor(hexString: "#808080", withAlpha: 0.8)
        return indicatorbackgroundView
    }()
    
    let indicatorLable:UILabel = {
        let indicatorLable = UILabel()
        indicatorLable.font = UIFont.systemFontOfSize(11)
        indicatorLable.textAlignment = .Center
        indicatorLable.textColor = UIColor.whiteColor()
        indicatorLable.text = "00%"
        return indicatorLable
    }()
    
    ///用来分割
    lazy var maskLayer: CAShapeLayer = {
       let maskLayer = CAShapeLayer()
        maskLayer.contentsCenter = CGRect(x: 0.5, y: 0.6, width: 0.1, height: 0.1)
        maskLayer.contentsScale = UIScreen.mainScreen().scale
        return maskLayer
    }()
    
    ///用来分割
    var backgroundImage: UIImage? {
        didSet {
            self.maskLayer.contents = backgroundImage?.CGImage
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.layer.mask = self.maskLayer
        self.addSubview(contentImageView)
        self.addSubview(indicatorbackgroundView)
        self.addSubview(activityView)
        self.addSubview(indicatorLable)
        
        //设置frame
        activityView.startAnimating()
        
        //初始化状态
        self.indicatorbackgroundView.hidden = true
        self.activityView.stopAnimating()
        self.indicatorLable.hidden = true
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.maskLayer.frame = self.bounds
        self.contentImageView.frame = self.bounds
        
        
        self.indicatorbackgroundView.frame = self.bounds
        self.activityView.center = CGPoint(x: self.bounds.midX, y: self.bounds.midY-10)
        
        self.indicatorLable.frame.size = CGSize(width: 100, height: 15)
        self.indicatorLable.frame.center = CGPoint(x: self.bounds.midX, y: self.bounds.midY+8)
    }
    
    
    
    func setThumbnailPath(imagePath: String?) {
        contentImageView.image = nil
        if imagePath == nil {
            return
        }
        self.contentImageView.image = UIImage(named: imagePath!)
    }
    
    func setThumbnailURL(imageURL: String?) {
        contentImageView.image = nil
        guard let imageURL = imageURL else {
            return
        }
        
        let httpHost = "http://7xsmd8.com1.z0.glb.clouddn.com/"
        let url = NSURL(string: httpHost+imageURL)
        let progress = {(bytesRead: Int64, totalBytesRead: Int64, totalExpectedBytesToRead: Int64) in
            let progress = CGFloat(totalBytesRead)/CGFloat(totalExpectedBytesToRead)
            self.updateProgressView(progress, result: .Loading)
        }
        contentImageView.af_setImageWithURL(url!, placeholderImage: nil,
                                            progress: progress) { response in
                                                if let image = response.result.value {
                                                    self.contentImageView.image = image
                                                    let path = CWUserAccount.sharedUserAccount().pathUserChatImage(imageURL)
                                                    NSFileManager.saveContentImage(image, imagePath: path)
                                                    self.updateProgressView(1, result: .Success)
                                                } else {
                                                    self.updateProgressView(0, result: .Fail)
                                                }
                                                
                                                
        }
    }
    
    /// 更新cell状态
    func updateProgressView(progress:CGFloat, result: CWMessageUploadState) {
        
        if result == .Loading {
            self.indicatorbackgroundView.hidden = false
            self.activityView.startAnimating()
            self.indicatorLable.hidden = false
            self.indicatorLable.text = String(format: "%02d%%",Int(progress*100))
        } else {
            self.indicatorbackgroundView.hidden = true
            self.activityView.stopAnimating()
            self.indicatorLable.hidden = true
        }
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
