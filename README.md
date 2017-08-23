
# DGScrollableSegmentControl
An elegant scrollable segment control.

![simulator screen shot - iphone 7 plus - 2017-08-23 at 11 17 04](https://user-images.githubusercontent.com/12591229/29600286-b4e21872-87f4-11e7-8e8f-582686cf6e91.png)

# Usage
1. Drag DGScrollableSegmentControl.swift to your project.
2. Place a View on Storybard and assign DGScrollableSegmentControl class to that View.
3. Make outlet connection
4. Implement DGScrollableSegmentControlDataSource and DGScrollableSegmentControlDelegate

# DataSource Methods to implement 
        func numbersOfItem() -> Int 
        func itemfor(_ index: Int) -> DGItem 

# Delegate Methods to implement 
         func didSelect(_ item: DGItem, atIndex index: Int) {

For more reference See demo project


