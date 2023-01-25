//
//  CollectionViewExtensions.swift
//  Qkly
//
//  Created by Arun Sah on 03/08/2022.
//

import Foundation
import UIKit

extension UICollectionView {

    
    func register(nibName: String){
        register(UINib(nibName: nibName, bundle: nil), forCellWithReuseIdentifier: nibName)
    }
    
    ///if the class name is the same as the reuseidentifier
    func registerCell(ofClass classname: UICollectionViewCell.Type){
        register(nibName: String(describing: classname.self))
    }
    
    func dequeue<T: UICollectionViewCell>(withIdentifier identifier: String = String(describing: T.self),
                                          at indexPath: IndexPath) -> T {
        guard let cell = self.dequeueReusableCell(withReuseIdentifier: identifier, for: indexPath) as? T else {
            fatalError("Could not dequeue cell with identifier \(identifier) from collectionView \(self)")
        }
        return cell
    }
    
    public func reloadDataAndKeepOffset() {
      // stop scrolling
      setContentOffset(contentOffset, animated: false)

      // calculate the offset and reloadData
      let beforeContentSize = contentSize
      reloadData()
      layoutIfNeeded()
      let afterContentSize = contentSize

      // reset the contentOffset after data is updated
      let newOffset = CGPoint(
        x: contentOffset.x + (afterContentSize.width - beforeContentSize.width),
        y: contentOffset.y + (afterContentSize.height - beforeContentSize.height))
      setContentOffset(newOffset, animated: false)
    }
    
    public func batchUpdateForScroll(itemsToInsert count: Int, section: Int = 0) {
        let contentHeight = self.contentSize.height
        let offsetY = self.contentOffset.y
        let bottomOffset = contentHeight - offsetY

        CATransaction.begin()
        CATransaction.setDisableActions(true)

        performBatchUpdates({
            var indexPaths = [IndexPath]()
            for i in 0..<count {
                let index = self.numberOfItems(inSection: section) + i
                    if index >= self.numberOfItems(inSection: section) {
                        break
                    }
                    indexPaths.append(IndexPath(item: index, section: section))
            }
            if indexPaths.count > 0 {
                self.insertItems(at: indexPaths)
            }
            }, completion: {
                finished in
                self.reloadDataAndKeepOffset()
                CATransaction.commit()
        })
    }
    
}
