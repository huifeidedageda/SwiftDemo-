//
//  UserDefaultViewController.swift
//  Demo1
//
//  Created by 智衡宋 on 2017/8/2.
//  Copyright © 2017年 智衡宋. All rights reserved.
//

import UIKit

class UserDefaultViewController: UIViewController {
    @IBOutlet weak var textField: UITextField!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    
    //保存
    @IBAction func saveButtonAction(_ sender: Any) {
        
        saveInfo(name: textField.text!)
    }
    
    //读取
    @IBAction func readButtonAction(_ sender: Any) {
      textField.text  = readInfo(name: "name")
    }
    
    //删除
    @IBAction func deleteButtonAction(_ sender: Any) {
        
        deleteInfo(name: "name")
    }
    
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}

//对数据的增，删，改，查
extension UserDefaultViewController {
    
    func saveInfo(name: String) {
        
        if name.characters.count > 0 {
            
            self.textField.resignFirstResponder()
            
            let userdefault = UserDefaults.standard
            userdefault.set(name, forKey: "name")
            userdefault.synchronize()
            
            
            
            let alertController = UIAlertController.init(title: "温馨提示", message: "保存成功!", preferredStyle: .alert)
            let cancelAction = UIAlertAction(title: "我知道了", style: .default, handler: nil)
            alertController.addAction(cancelAction)
            self.present(alertController, animated: true, completion: nil)
            
            
            
        }
        
    }
    
    func readInfo(name: String) -> String{
        let userDefault = UserDefaults.standard
        let name = userDefault.object(forKey: name)
        
        if let name = name {
            return name as! String
        }
        
        return ""
    }
    
    func deleteInfo(name: String) {
        
        let userdefault = UserDefaults.standard
        userdefault.removeObject(forKey: name)
        
        print("删除成功")
    }
    
}

//对原生数据类型的储存和读取
extension UserDefaultViewController {
    
    func showUserDefaultData()  {
        
        let userDefault = UserDefaults.standard
        
        //Any
        userDefault.set("hangge.com", forKey: "Object")
        let objectValue:Any? = userDefault.object(forKey: "Object")
        
        //Int类型
        userDefault.set(123, forKey: "Int")
        let intValue = userDefault.integer(forKey: "Int")
        
        //Float类型
        userDefault.set(3.2, forKey: "Float")
        let floatValue = userDefault.float(forKey: "Float")
        
        //Double类型
        userDefault.set(5.44444, forKey: "Double")
        let doubleValue = userDefault.double(forKey: "Double")
        
        //Bool类型
        userDefault.set(true, forKey: "Bool")
        let boolValue = userDefault.bool(forKey: "Bool")
        
        //URL类型
        userDefault.set(URL(string:"http://hangge.com"), forKey: "URL")
        let urlValue = userDefault.url(forKey: "URL")
        
        //String类型
        userDefault.set("hangge.com", forKey: "String")
        let stringValue = userDefault.string(forKey: "String")
        
        //NSNumber类型
        var number = NSNumber(value:22)
        userDefault.set(number, forKey: "NSNumber")
        number = userDefault.object(forKey: "NSNumber") as! NSNumber
        
        //Array类型
        var array:Array = ["123","456"]
        userDefault.set(array, forKey: "Array")
        array = userDefault.array(forKey: "Array") as! [String]
        
        //Dictionary类型
        var dictionary = ["1":"hangge.com"]
        userDefault.set(dictionary, forKey: "Dictionary")
        dictionary = userDefault.dictionary(forKey: "Dictionary") as! [String : String]
        
    }
    
}

//系统对象的存储与读取
extension UserDefaultViewController {
    //系统对象实现存储，需要通过 archivedData 方法转换成 Data 为载体，才可以存储
    
    //UILabel
    func objectSaveAndRead1() {
        let userDeafult = UserDefaults.standard
        
        //对象存储
        let label = UILabel()
        label.text = "欢迎访问hagge.com"
        let labelData = NSKeyedArchiver.archivedData(withRootObject: label)
        userDeafult.set(labelData, forKey: "labelData")
        
        //对象读取
        let objData = userDeafult.data(forKey: "labelData")
        let myLabel = NSKeyedUnarchiver.unarchiveObject(with: objData!) as? UILabel
        print(myLabel ?? "")
    }
    //UIImage
    func objectSaveAndRead2() {
        //存储
        let userDeafult = UserDefaults.standard
        let image1 = UIImage(named: "xxx.png")
        let image2 = UIImage(cgImage: (image1?.cgImage)!, scale: (image1?.scale)!, orientation: (image1?.imageOrientation)!)
        let imageData = NSKeyedArchiver.archivedData(withRootObject: image2)
        userDeafult.set(imageData, forKey: "imageData")
        
        //读取
        let objData = userDeafult.data(forKey: "imageData")
        let myImage = NSKeyedUnarchiver.unarchiveObject(with: objData!) as? UIImage
        print(myImage ?? "")
        
    }
}

//自定义对象的存储和读取
extension UserDefaultViewController {
    
    func customUserDefault()  {
        let userDefault = UserDefaults.standard
        
        //自定义对象存储
        let model = UserInfo(name: "xxx", phone: "10010")
        let modelData = NSKeyedArchiver.archivedData(withRootObject: model)
        userDefault.set(modelData, forKey: "myModel")
        
        
        //自定义对象读取
        let myModelData = userDefault.data(forKey: "myModel")
        let myModel = NSKeyedUnarchiver.unarchiveObject(with: myModelData!)
        print(myModel ?? "")
    }
    
}

//如果想要存储自己定义的类，首先需要对该类实现 NSCoding 协议来进行归档和反归档（序列化和反序列化）。即该类内添加 func encode(with coder: NSCoder) 方法和 init(coder decoder: NSCoder) 方法，将属性进行转换。
class UserInfo: NSObject,NSCoding {
    var name:String
    var phone:String
    
    //构造方法
    required init(name:String="", phone:String="") {
        self.name = name
        self.phone = phone
        super.init()
    }
    
    //从object解析回来
    required init(coder decoder: NSCoder) {
        self.name = decoder.decodeObject(forKey: "Name") as? String ?? ""
        self.phone = decoder.decodeObject(forKey: "Phone") as? String ?? ""
    }
    
    //编码成object
    func encode(with coder: NSCoder) {
        coder.encode(name, forKey:"Name")
        coder.encode(phone, forKey:"Phone")
    }
    
}

