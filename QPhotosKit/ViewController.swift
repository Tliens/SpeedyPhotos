//
//  ViewController.swift
//  QPhotosKit
//
//  Created by Quinn_F on 2018/7/25.
//  Copyright © 2018年 Quinn. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var imageV: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
        QAlbumPermissionRequest.requestPhotosPermision { (error) in
            guard error == nil else{
                print(#function,#line,error!)
                return
            }
            OperationQueue().addOperation {
                if let collection = QAlbumAssetCollections.getAssetCollections().firstObject{
                    let assets = QAlbumAssetsMaker.getAlbumAssets(collection: collection, ascending: false)
                    if let asset = assets?.object(at: 0){
                        let img = QAlbumImagesMaker.getImageWithAsset(asset, quality: .height,thumbnailSize:QAlbumImgMaxSize)
                        OperationQueue.main.addOperation {
                                self.imageV.image = img
                        }
                    }
                }
            }
        }
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

