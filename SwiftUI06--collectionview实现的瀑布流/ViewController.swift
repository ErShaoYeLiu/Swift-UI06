//
//  ViewController.swift
//  SwiftUI06--collectionview实现的瀑布流
//
//  Created by liutao on 17/3/24.
//  Copyright © 2017年 UTOUU. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    var width:CGFloat!
    var images:Array<UIImage>!
    var collectionView:UICollectionView!
    var maskView:UIView!
    var cellRect:CGRect!
    var changeRect:CGRect!

    override func viewDidLoad() {
        //MARK:--life cycle
        super.viewDidLoad()
        waterfallCollectionView()
    }
    
    private func waterfallCollectionView() {
    
    width = (view.bounds.size.width - 20)/3
        let layout = WaterCollectionViewLayout()
        images = []
        for i in 1..<13 {
            let image = UIImage(named: String.init(format: "aion%d.jpg", i))
            images.append(image!)
        }
    
        layout.setSize = {_ in
        return self.images
        
        }
        
        collectionView = UICollectionView(frame: self.view.bounds, collectionViewLayout: layout)
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "newCell")
        collectionView.backgroundColor = UIColor.purple
        collectionView.alwaysBounceVertical = true
        collectionView.delegate = self
        collectionView.dataSource = self
        view.addSubview(collectionView)
    }

    func showPic(btn:UIButton) {
        UIView.animate(withDuration: 0.5, animations: {
            btn.frame = self.cellRect
        }) { (finish) in
            btn.removeFromSuperview()
            self.maskView.removeFromSuperview()
            self.maskView = nil
            self.cellRect = nil
        }
    }
 
}

extension ViewController:UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout {

// MARK:-- UICollectionviewDelegate
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return images.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "newCell", for: indexPath as IndexPath)
        let imageView = UIImageView(frame: cell.bounds)
        imageView.image = images[indexPath.row]
        let bgView = UIView(frame: cell.bounds)
        bgView.addSubview(imageView)
        cell.backgroundView = bgView
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let cell = collectionView.cellForItem(at: indexPath)
        maskView = UIView.init(frame: view.bounds)
        maskView.backgroundColor = UIColor.black
        maskView.alpha = 0.5
        view.addSubview(maskView)
        
        // 截取图片在cell在父视图的位置  cellRect 给button  做frame
        cellRect = cell!.convert(cell!.bounds, to: view)
        let btn = WaterButton.init(frame: cellRect)
        
        // 取数组的图片 给button设置 
        let img = images[indexPath.row]
        btn.wImage = img
        
        // 设置点击事件 来 消除点击缩小图片的范围
        btn.addTarget(self, action: #selector(showPic(btn:)), for: UIControlEvents.touchUpInside)
        view.addSubview(btn)
        
        
        var changeH:CGFloat
        var changeW:CGFloat
        // 图片的宽高比 以及 super 的宽高比比较
        if img.size.width/img.size.height >= view.frame.size.width/view.frame.size.height{
            //对比图片实际宽与屏幕宽
            if img.size.width>view.frame.size.width {
                // imageH * view -W / imageW
                changeH = img.size.height*view.frame.size.width/img.size.width
                // 居中
                changeRect = CGRect(x: 0, y: (view.frame.size.height-changeH)/2, width:view.frame.size.width, height: changeH)
            }else{
                changeRect = CGRect(x: (view.frame.size.width-img.size.width)/2, y: (view.frame.size.height-img.size.height)/2, width: img.size.width,height: img.size.height)
            }
        }else{
            if img.size.height>view.frame.size.height {
                changeW = img.size.width*view.frame.size.height/img.size.height
                changeRect = CGRect(x: (view.frame.size.width-changeW)/2, y: 0, width: changeW, height: view.frame.size.height)
            }else{
                changeRect = CGRect(x: (view.frame.size.width-img.size.width)/2, y: (view.frame.size.height-img.size.height)/2, width: img.size.width,height: img.size.height)
            }
        }
        
        UIView.animate(withDuration: 0.5, animations: {
            btn.frame = self.changeRect
        })
        
    }
    
}




