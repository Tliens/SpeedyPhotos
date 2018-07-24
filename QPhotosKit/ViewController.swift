//
//  ViewController.swift
//  QPhotosKit
//
//  Created by Quinn_F on 2018/7/24.
//  Copyright © 2018年 Quinn. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var collectionView: UICollectionView!
    
    var imgs = [UIImage]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        self.collectionView.delegate = self
        self.collectionView.dataSource = self
        getData()
    }
    
    func getData(){
        QAlbumPermissionRequest.requestPhotosPermision { (error) in
            guard error == nil else{return}
            if let imgs = QAlbumImagesMaker.getImagesWith(albumName: "今天相机", ascending: false){
                DispatchQueue.main.async {[weak self]in
                    self?.imgs = imgs
                    self?.collectionView.reloadData()
                }
            }
        }
    }


}
extension ViewController:UICollectionViewDelegate,UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! CollectionViewCell
        cell.imageV.image = imgs[indexPath.row]
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return imgs.count
    }
}

