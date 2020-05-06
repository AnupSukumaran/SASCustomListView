//
//  ViewController.swift
//  SASCustomListView
//
//  Created by Manu Puthoor on 06/05/20.
//  Copyright © 2020 Manu Puthoor. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var btn: UIButton!
    let tableV = UITableView()
    var popUpView = UIView()
    var changingConst = NSLayoutConstraint()
    var changingHeight = NSLayoutConstraint()
    var stringVal = ["1","2","3","1","2","3"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpBottomView()
       // setUpTableView()
       
        
        // Do any additional setup after loading the view.
       
        //popUpView.isHidden = true
    }
    
    func setUpBottomView() {
        let v = UIView()

        v.layer.cornerRadius = 10
        v.dropShadow(scale: true)
        v.backgroundColor = .green
        v.isUserInteractionEnabled = true
        self.view.addSubview(v)
        view.bringSubviewToFront(btn)
        v.translatesAutoresizingMaskIntoConstraints = false

        let bottomConst = NSLayoutConstraint(item: v, attribute: .bottomMargin, relatedBy: .equal, toItem: view, attribute: .bottomMargin, multiplier: 1, constant: 50)
        //        let leadConst = NSLayoutConstraint(item: v, attribute: .leading, relatedBy: .equal, toItem: view, attribute: .leading, multiplier: 1, constant: 10)
        //        let trailConst = NSLayoutConstraint(item: v, attribute: .trailing, relatedBy: .equal, toItem: view, attribute: .trailing, multiplier: 1, constant: -10)
        let widthConst =  NSLayoutConstraint(item: v, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: btn.frame.width)
        let heightConst = NSLayoutConstraint(item: v, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: 150)
        let center = NSLayoutConstraint(item: v, attribute: .centerX, relatedBy: .equal, toItem: btn, attribute: .centerX, multiplier: 1, constant: 0)
        changingConst = bottomConst
        changingHeight = heightConst
        view.addConstraints([center,bottomConst,widthConst,heightConst])
        let swipeGesture = UISwipeGestureRecognizer(target: self, action: #selector(swipeGesture(_:)))
        swipeGesture.direction = .down
        v.addGestureRecognizer(swipeGesture)
        //        let panGesture = UIPanGestureRecognizer(target: self, action: #selector(gesture))//UIPanGestureRecognizer(target: self, action:("handlePanGesture:"))
        //        v.addGestureRecognizer(panGesture)
        popUpView = v
        popUpView.alpha = 0
        setUpTableView()
    }
    
    func setUpTableView() {
        
        
        tableV.backgroundColor = .gray
        
        tableV.delegate = self
        tableV.dataSource = self
        tableV.isScrollEnabled = false
        tableV.rowHeight = UITableView.automaticDimension
        tableV.estimatedRowHeight = 100
        tableV.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
        tableV.layoutIfNeeded()
//        print("ContentHeight = \(tableV.contentSize.height)")
////        popUpView.layoutIfNeeded()
        tableV.separatorStyle = .none
        tableV.backgroundColor = .clear
        popUpView.addSubview(tableV)
        
        tableV.translatesAutoresizingMaskIntoConstraints = false
       // print("popUpHeight = \(popUpView.frame.height), popUpWidgt = \(popUpView.frame.width)")
        let widthConst =  NSLayoutConstraint(item: tableV, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: btn.frame.width - 10)
        let heightConst = NSLayoutConstraint(item: tableV, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: tableV.contentSize.height )
        let centerX = NSLayoutConstraint(item: tableV, attribute: .centerX, relatedBy: .equal, toItem: popUpView, attribute: .centerX, multiplier: 1, constant: 0)
        let centerY = NSLayoutConstraint(item: tableV, attribute: .centerY, relatedBy: .equal, toItem: popUpView, attribute: .centerY, multiplier: 1, constant: 0)
        popUpView.addConstraints([widthConst,heightConst,centerX,centerY])
        
       tableV.layoutIfNeeded()
       print("ContentHeight2 = \(tableV.contentSize.height)")
        heightConst.constant = tableV.contentSize.height
         changingHeight.constant = tableV.contentSize.height + 10
    }
    
    @objc func swipeGesture(_ sender: UISwipeGestureRecognizer) {
       
        
        print("Swiped down")
        
        changingConst.constant = btn.frame.height+18

        UIView.animate(withDuration: 1) {

            //widthConst.constant = self.view.frame.width - 20
             //v.layoutIfNeeded()
            self.view.layoutIfNeeded()
            let delay = ((40 / self.popUpView.frame.height) * 100) / 100
            UIView.animate(withDuration: 1, delay: TimeInterval(delay), options: .curveEaseIn, animations: {
                self.popUpView.alpha = 0
            }, completion: nil)
        }
//        switch sender.direction {
//        case .right:
//            print("Swiped right")
//        case .down:
//            print("Swiped down")
//        case .left:
//            print("Swiped left")
//        case .up:
//            print("Swiped up")
//        default:
//            break
//        }
        
//        if let swipeGesture = sender as? UISwipeGestureRecognizer {
//
//            switch swipeGesture.direction {
//            case .right:
//                print("Swiped right")
//            case .down:
//                print("Swiped down")
//            case .left:
//                print("Swiped left")
//            case .up:
//                print("Swiped up")
//            default:
//                break
//            }
//        }
    }
    
    
    
    @objc func gesture(_ sender: UIPanGestureRecognizer) {
        let panView = sender.view!
        let point = sender.translation(in: popUpView)
        
        panView.center = CGPoint(x: panView.center.x + point.x, y: panView.center.y + point.y)
        sender.setTranslation(.zero, in: view)
        
        switch sender.state {
        case .began:
            
            print("BEGAN - point.x = \(point.x), point.y = \(point.y)")
            
        case .changed:
            print("CHANGED - point.x = \(point.x), point.y = \(point.y)")
        case .ended:
             print("ENDED - point.x = \(point.x), point.y = \(point.y)")
//            UIView.animate(withDuration: 0.2) {
//                panView.center = self.oldPoint
//            }
        case .failed:
            print("failed")
        case .possible:
            print("possible")
        case .cancelled:
            print("cancelled")

        default:
             print("default")
        }
    }

    @IBAction func popUpAction(_ sender: Any) {
        callAView()
    }
    
    func callAView() {
//        let v = UIView()
//
//        v.layer.cornerRadius = 10
//        v.dropShadow(scale: true)
//        v.backgroundColor = .green
//        self.view.addSubview(v)
//        view.bringSubviewToFront(btn)
//        v.translatesAutoresizingMaskIntoConstraints = false
//
//        let topConst = NSLayoutConstraint(item: v, attribute: .top, relatedBy: .equal, toItem: btn, attribute: .top, multiplier: 1, constant: 10)
//        let leadConst = NSLayoutConstraint(item: v, attribute: .leading, relatedBy: .equal, toItem: view, attribute: .leading, multiplier: 1, constant: 10)
//        let trailConst = NSLayoutConstraint(item: v, attribute: .trailing, relatedBy: .equal, toItem: view, attribute: .trailing, multiplier: 1, constant: -10)
//        let widthConst =  NSLayoutConstraint(item: v, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: self.view.frame.width - 20)
//        let heightConst = NSLayoutConstraint(item: v, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: 50)
//        let center = NSLayoutConstraint(item: v, attribute: .centerX, relatedBy: .equal, toItem: btn, attribute: .centerX, multiplier: 1, constant: 0)
//        view.addConstraints([center,topConst,leadConst,trailConst,widthConst,heightConst])
        
//         btnConstraint.isActive = true
//         NSLayoutConstraint(item: v, attribute: .leading, relatedBy: .equal, toItem: view, attribute: .leading, multiplier: 1, constant: 10).isActive = true
//         NSLayoutConstraint(item: v, attribute: .trailing, relatedBy: .equal, toItem: view, attribute: .trailing, multiplier: 1, constant: -10).isActive = true
//        NSLayoutConstraint(item: v, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: self.view.frame.width - 20).isActive = true
//        NSLayoutConstraint(item: v, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: 50).isActive = true
        //btnConstraint.constant = -50
//        topConst.constant = -50
//        heightConst.constant = 50
        changingConst.constant = -(btn.frame.height+18)
         
//        UIView.animate(withDuration: 5, delay: 4, options: .curveEaseInOut, animations: {
//            self.view.layoutIfNeeded()
//        }, completion: nil)
        
        UIView.animate(withDuration: 1) {

            //widthConst.constant = self.view.frame.width - 20
             //v.layoutIfNeeded()
            self.view.layoutIfNeeded()
            let delay = ((40 / self.popUpView.frame.height) * 100) / 100
            UIView.animate(withDuration: 1, delay: TimeInterval(delay), options: .curveEaseIn, animations: {
                self.popUpView.alpha = 1
            }, completion: nil)
        }
    }

}

extension UIView {

  // OUTPUT 1
  func dropShadow(scale: Bool = true) {
    layer.masksToBounds = false
    layer.shadowColor = UIColor.black.cgColor
    layer.shadowOpacity = 0.5
    layer.shadowOffset = CGSize(width: -1, height: 1)
    layer.shadowRadius = 1

    layer.shadowPath = UIBezierPath(rect: bounds).cgPath
    layer.shouldRasterize = true
    layer.rasterizationScale = scale ? UIScreen.main.scale : 1
  }

  // OUTPUT 2
  func dropShadow(color: UIColor, opacity: Float = 0.5, offSet: CGSize, radius: CGFloat = 1, scale: Bool = true) {
    layer.masksToBounds = false
    layer.shadowColor = color.cgColor
    layer.shadowOpacity = opacity
    layer.shadowOffset = offSet
    layer.shadowRadius = radius

    layer.shadowPath = UIBezierPath(rect: self.bounds).cgPath
    layer.shouldRasterize = true
    layer.rasterizationScale = scale ? UIScreen.main.scale : 1
  }
}

extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return stringVal.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        cell.backgroundColor = .clear
        cell.selectionStyle = .none
        cell.textLabel?.text = stringVal[indexPath.row]
        cell.textLabel?.textAlignment = .center
        return cell
    }
    
    
}

extension ViewController: UITableViewDelegate {
    
}
