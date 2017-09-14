//
//  FMDBManager.swift
//  DemoSwift
//
//  Created by 智衡宋 on 2017/7/28.
//  Copyright © 2017年 智衡宋. All rights reserved.
//

import UIKit
import FMDB
class FMDBManager: NSObject {


    //单例
    static let shareInstance : FMDBManager = FMDBManager()
    private override init() {
        super.init()
        
        //打开数据库
        openDB(name: "personInfo.sqlite")
        
    }
    
    var db : FMDatabase?
    func openDB(name:String){
        
        // 1.拼接路径
        let path = documentPath(name: name)
        // 2.创建数据库对象
        db = FMDatabase(path: path)
        // 3.打开数据库
        // open()特点: 如果数据库文件不存在就创建一个新的, 如果存在就直接打开
        if !db!.open() {
            print("打开数据库失败")
            return
        }
        
        let TableName = "Person"
        let arFieldsName = ["NAME","AGE","NUMBER"]
        let arFieldsType  = ["text","text","text"]
        
        //4.创建表
        if !createTable(tableName:TableName , arFields: arFieldsName, arFieldsType: arFieldsType) {
            print("创建数据库表失败")
            return
        }
        
        db?.close()
        
    }
    
    
    //拼接路径
    func documentPath(name:String) -> String {
        
        let documentsFolder = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0] as String
        let path = documentsFolder.appending("/\(name)")
        
        return path
    }
    
    
    //创建表
    func createTable(tableName:String,arFields:[Any], arFieldsType:[Any]) -> Bool {
        
        // 1.编写SQL语句
        var  sql = "CREATE TABLE IF NOT EXISTS " + tableName + "(id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, "
        let arFieldsKey:[String] = arFields as! [String]
        let arFieldsType:[String] = arFieldsType as! [String]
        for i in 0..<arFieldsType.count {
            if i != arFieldsType.count - 1 {
                sql = sql + arFieldsKey[i] + " " + arFieldsType[i] + ", "
            }else{
                sql = sql + arFieldsKey[i] + " " + arFieldsType[i] + ")"
            }
            
        }
        do{
            try db?.executeUpdate(sql, values: nil)
            
            return true
        }catch{
            print(db?.lastErrorMessage() ?? "")
            
            
            return false
        }
    }

    //增
    func insertData(person:Person) {
        
        if db!.open() {
            let sql = "INSERT INTO Person(NAME,AGE,NUMBER)VALUES(?,?,?)"
            
            
            do{
                try db?.executeUpdate(sql, values: [person.name ?? "",person.age ?? "",person.number ?? ""])
                print("添加成功")
            }catch{
                print(db?.lastErrorMessage() ?? "")
    
            }

        }
        
        
        db?.close()
        
    }
    //删
    func deleteData(person:Person) {
        
        if db!.open() {
            let sql = "DELETE FROM Person WHERE NUMBER = ?"
            
            do{
                try db?.executeUpdate(sql, values: [person.number ?? ""])
                print("删除成功")
            }catch{
                print(db?.lastErrorMessage() ?? "")
                
            }
            
        }

        db?.close()
        
        
    }
    //改
    func modificationData(person:Person) {
        
        if db!.open() {
            let sql = "update Person set NAME = '%@' AGE = '%@' WHERE NUMBER ='%@';"
            
            do{
                try db?.executeUpdate(sql, values: [person.name ?? "",person.age ?? "",person.number ?? ""])
                print("修改成功")
            }catch{
                print(db?.lastErrorMessage() ?? "")
                
            }
            
        }
        db?.close()
    }
    //查单个数据
    func selectOneData(personNum:String) {
        
        if db!.open() {
            
            let sql = "SELECT * FROM Person where NUMBER = '%@'"
            
            do{
                let rs = try db?.executeQuery(sql, values: [personNum])
                
                let model = Person()
                while rs!.next() {
                   
                    model.name = rs?.string(forColumn: "NAME")
                    model.age = rs?.string(forColumn: "AGE")
                    model.number = rs?.string(forColumn: "NUMBER")
                    
                }
                
                
                print("单个查询成功\(String(describing: model.name))--\(String(describing: model.age))---\(String(describing: model.number))")
                
            }catch{
                print(db?.lastErrorMessage() ?? "")
            }
            
            
        }
        
        db?.close()
        
    }
     //查所有的数据
    func selectAllData() {
        
        if db!.open() {
            
            let sql = "SELECT * FROM Person"
            do{
                let rs = try db?.executeQuery(sql, values: nil)
                var array = [Any]()
                
                while rs!.next() {
                    let model = Person()
                    model.name = rs?.string(forColumn: "NAME")
                    model.age = rs?.string(forColumn: "AGE")
                    model.number = rs?.string(forColumn: "NUMBER")
                    array.append(model)
                    
                }
                
                print("所有查询成功\(array.count)")
                
            }catch{
                print(db?.lastErrorMessage() ?? "")
            }
            
        }
        
        db?.close()
    }
    
}
