//
//  FirstViewController.swift
//  To_Do_List
//
//  Created by Tomomi Tamura on 6/21/16.
//  Copyright © 2016 Tomomi Tamura. All rights reserved.
//

import UIKit

//２つ目のview controllerでも使えるようにclassの外にdeclare
var toDoList = [String]()

class FirstViewController: UIViewController, UITableViewDelegate  {
    
    
    @IBOutlet var toDoListTable: UITableView!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        //アプリを一度終了してもリストの中身が消えないように保存。NSUserDefaultsを使用
        if NSUserDefaults.standardUserDefaults().objectForKey("toDoList") != nil {
        
            toDoList = NSUserDefaults.standardUserDefaults().objectForKey("toDoList") as! [String]
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //リストの行の数をきめる
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return toDoList.count
        
    }
    
    //このメソッドでリダーンされるのはtodolistのarrayにおいて選択された行によるitemの値を表示したcell
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = UITableViewCell(style: UITableViewCellStyle.Default, reuseIdentifier: "Cell")
        
        cell.textLabel?.text = toDoList[indexPath.row]
        
        return cell
        
    }
    
    //swipe & deleteができるように
    func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        
        //UITableViewCellEditingStyle.Deleteは左スワイプ
        if editingStyle == UITableViewCellEditingStyle.Delete {
            
            toDoList.removeAtIndex(indexPath.row)
            //リストの更新がNSUserDefaultsにも反映されるようにする
            NSUserDefaults.standardUserDefaults().setObject(toDoList, forKey: "toDoList")
            //テーブルを更新
            toDoListTable.reloadData()
        }
        
    }

    
    //TableViewが更新される度に値が更新されるする。これはアプリの起動時だけじゃなくアプリが更新される度にアプデートされる
    override func viewDidAppear(animated: Bool) {
        
        toDoListTable.reloadData()
        
    }
    
}

