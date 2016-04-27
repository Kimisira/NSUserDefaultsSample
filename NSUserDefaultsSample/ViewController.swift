//
//  ViewController.swift
//  NSUserDefaultsSample
//
//  Created by Kimisira on 2016/03/27.
//  Copyright © 2016年 Kimisira. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        //クラッシュしたらデータが消える
        userDefault1()
        
        //データの永続化(synchronize)
        userDefault2()
        
        

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func userDefault1(){
        let defaults = NSUserDefaults.standardUserDefaults()
        
        //UserDefaultsのデータの保存(Int)
        defaults.setInteger(20000, forKey: "sample")
        
        //UserDefaultsのデータ削除(Int)
        defaults.removeObjectForKey("sample")
        
        //UserDefaultsの取得
        print(defaults.integerForKey("sample"))
    }
    
    func userDefault2(){
      let defaults = NSUserDefaults.standardUserDefaults()
        
        //データの保存
        defaults.setObject("text", forKey: "textSample")
        print(defaults.objectForKey("textSample"))
        
        //データの永続化
        let success = defaults.synchronize()
        if success {
            print("成功")
        }else {
            print("失敗")
        }
    }
    
    
    @IBAction func respondToSaveButonClick(sender: AnyObject) {
        let defaults = NSUserDefaults.standardUserDefaults()
//        
//        //データの作成
//        let array = ["http://www.apple.com","http://twitter.com/","http://www.9revolution9.com"]
//        
//        //追加
//        defaults.setObject(array, forKey: "bookmarks")
//        let successful = defaults.synchronize()
//        if successful {
//            print("成功")
//        }else {
//            print("失敗")
//        }
        
        //自作クラスのUserDefaultをアーカイブして保存
        let addres1 = Address(zipCode: "104-0061",state: "東京都",city: "台東区",other: "上野１丁目")
        let tanakatarou = Person(name: "田中太郎",address: addres1)
        let yamamotohirosi = Person(name: "山本浩",address: addres1)
        
        let addres2 = Address(zipCode: "604-8124", state: "京都市", city: "京都府", other: "中央区")
        let jiroTanaka = Person(name: "田中二郎",address: addres2)
        
        let archivedTanakatarou = NSKeyedArchiver.archivedDataWithRootObject(tanakatarou)
        let archivedYamamotohirosi = NSKeyedArchiver.archivedDataWithRootObject(yamamotohirosi)
        let archivedJiroTanaka = NSKeyedArchiver.archivedDataWithRootObject(jiroTanaka)
        
        //保存するデータをまとめる
        let array = [archivedTanakatarou,archivedYamamotohirosi,archivedJiroTanaka]
        defaults.setObject(array, forKey: "address-list")
        let successful = defaults.synchronize()
        if successful {
            print("成功")
        }else {
            print("失敗")
        }
        
        
        
    }
    
    @IBAction func respondToLoadButtonClick(sender: AnyObject) {
        let defaults = NSUserDefaults.standardUserDefaults()
        
//        //データの読み取り
//        let bookmarks:AnyObject! = defaults.objectForKey("bookmarks")
//        print(bookmarks)
        
        //自作したオブジェクトを読み込み
        let addressList = defaults.arrayForKey("address-list") as! [NSData]
        for data in addressList {
            let person = NSKeyedUnarchiver.unarchiveObjectWithData(data as NSData) as! Person
            print(person.name)
            print(person.address.zipCode)
            print(person.address.state)
            print(person.address.city)
            print(person.address.other)
    
        }
        
    }
    
    
    
    
    
}

