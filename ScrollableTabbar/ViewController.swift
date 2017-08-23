//
//  ViewController.swift
//  ScrollableTabbar
//
//  Created by dpd Ghimire (dip kasyap) on 8/18/17.
//  Copyright © 2017 dip. dpd.ghimire@gmail.com All rights reserved.
//

/*
Copyright (c) <2017> <dpd Ghimire>

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.
*/


// dip.kasyap

import UIKit

class DataModel: NSObject {
    
    var isSelected = false
    var title = ""
    
    class func getFakeData()->[DataModel] {
        
        var datas:[DataModel] = []
        for i in 0...10 {
            let data = DataModel()
            data.isSelected = i == 0
            data.title = i == 0 ? "Test long title" : "title  \(i)"
            datas.append(data)
        }
        
        return datas
    }
    
}

class ViewController: UIViewController,DGScrollableSegmentControlDataSource,DGScrollableSegmentControlDelegate {


    @IBOutlet weak var segmentControl:DGScrollableSegmentControl!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.segmentControl.delegate = self
        self.segmentControl.datasource = self

    }
    
    var dataSource = DataModel.getFakeData()
    
    func numbersOfItem() -> Int {
        return dataSource.count
    }
    
    func itemfor(_ index: Int) -> DGItem {
        
        let item = DGItem()
        
        item.setTitle(self.dataSource[index].title, for: .normal)
        item.isSelected = dataSource[index].isSelected

        if index == 4 {
            item.setTitle("Hello this is long \(index)", for: .normal)
        } else if index == 8 {
            item.setTitle("Hello Michel \(index)", for: .normal)
        }
        
        
        return item
        
    }
    
    func didSelect(_ item: DGItem, atIndex index: Int) {
        
        //self.segmentControl.reload()
        
        //item.backgroundColor = UIColor.lightGray
        
        
    }
    
}
