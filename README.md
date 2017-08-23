
# DGScrollableSegmentControl
An elegant scrollable segment control.

![screen shot 2017-08-23 at 3 04 10 pm](https://user-images.githubusercontent.com/12591229/29608611-626764ce-8814-11e7-9c13-20729ac74e5c.png)

# Usage
1. Drag DGScrollableSegmentControl.swift to your project.
2. Place a View on Storybard and assign DGScrollableSegmentControl class to that View.
3. Make outlet connection
4. Implement DGScrollableSegmentControlDataSource and DGScrollableSegmentControlDelegate

# DataSource Methods to implement 
        func numbersOfItem() -> Int 
        func itemfor(_ index: Int) -> DGItem 

# Delegate Methods to implement 
         func didSelect(_ item: DGItem, atIndex index: Int) 

For more reference See demo project


