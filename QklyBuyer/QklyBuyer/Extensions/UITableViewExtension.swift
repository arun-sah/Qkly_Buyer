//
//  UITableViewExtension.swift
//  Qkly
//
//  Created by Arun Sah on 03/08/2022.
//
import UIKit

extension UITableView {
    func register(nibName: String){
           register(UINib(nibName: nibName, bundle: nil), forCellReuseIdentifier: nibName)
       }
       
       ///if the class name is the same as the reuseidentifier
       func registerCell(ofClass classname: UITableViewCell.Type){
           register(nibName: String(describing: classname.self))
       }

       func dequeue<T: UITableViewCell>(withIdentifier identifier: String = String(describing: T.self)) -> T {
           guard let cell = self.dequeueReusableCell(withIdentifier: identifier) as? T
               else { fatalError("Could not dequeue cell with identifier \(identifier) from tableView \(self)") }
           return cell
       }

       func dequeue<T: UITableViewCell>(withIdentifier identifier: String = String(describing: T.self), at indexPath: IndexPath) -> T {
           guard let cell = self.dequeueReusableCell(withIdentifier: identifier, for: indexPath) as? T
               else { fatalError("Could not dequeue cell with identifier \(identifier) from tableView \(self)") }
           return cell
       }

       func dequeueHeaderFooterView<T: UITableViewHeaderFooterView>(withIdentifier identifier: String = String(describing: T.self)) -> T {
           guard let cell = self.dequeueReusableHeaderFooterView(withIdentifier: identifier) as? T else {
               fatalError("Could not dequeue cell with identifier \(identifier) from tableView \(self)") }
           return cell
       }
}
