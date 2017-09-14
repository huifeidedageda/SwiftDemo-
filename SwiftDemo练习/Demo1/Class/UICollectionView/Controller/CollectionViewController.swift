//
//  CollectionViewController.swift
//  TestSwiftDemo
//
//  Created by 智衡宋 on 2017/7/27.
//  Copyright © 2017年 智衡宋. All rights reserved.
//

import UIKit

class CollectionViewController: UIViewController {

    var collectionView : UICollectionView?
    var nowName = [Any]()
    var nextName = [Any]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        loadData()
        setupUI()
    }


    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    
}

//设置View
extension CollectionViewController {
    
    func loadData(){
        
        nowName = ["A-1","A-2","A-3","A-4","A-5","A-6","A-7","A-8","A-9","A-10","A-11"]
        
        nextName = ["B-1","B-2","B-3","B-4","B-5","B-6","B-7","B-8","B-9","B-10","B-11"]
        
    }
    
    func setupUI()  {
        
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: 80, height: 35)
        layout.minimumLineSpacing = 15
        layout.minimumInteritemSpacing = 30
        layout.sectionInset = UIEdgeInsetsMake(10, 10, 10, 10)
        
        collectionView = UICollectionView.init(frame: view.bounds, collectionViewLayout: layout)
        view.addSubview(collectionView!)
        collectionView?.backgroundColor = .red
        collectionView?.delegate = self
        collectionView?.dataSource = self;
        
         collectionView!.register(hotcell.self, forCellWithReuseIdentifier:"HotCell")
    }
    
    
}

//代理方法
extension CollectionViewController:UICollectionViewDelegate,UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 2
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if section == 0 {
            return nowName.count
        } else {
            return nextName.count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "HotCell", for: indexPath) as! hotcell
        
        cell.backgroundColor = .blue
        
        if indexPath.section == 0 {
            cell.label.text  = nowName[indexPath.row] as? String
        } else {
            cell.label.text  = nextName[indexPath.row] as? String
        }
        
        return cell
        
    }
    
    
    
}


class hotcell: UICollectionViewCell {
    
    var label = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        label = UILabel.init(frame: self.bounds)
        self.addSubview(label)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}


