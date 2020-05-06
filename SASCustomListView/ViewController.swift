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
    
    var trayOriginalCenter: CGPoint!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        setUpBottomView()
    }
    
    func setUpBottomView() {
        popUpView.alpha = 0
        popUpView.layer.cornerRadius = 10
        popUpView.dropShadow(scale: true)
        popUpView.backgroundColor = .green
        popUpView.isUserInteractionEnabled = true
        self.view.addSubview(popUpView)
        view.bringSubviewToFront(btn)
        popUpView.translatesAutoresizingMaskIntoConstraints = false

        let bottomConst = NSLayoutConstraint(item: popUpView, attribute: .bottomMargin, relatedBy: .equal, toItem: view, attribute: .bottomMargin, multiplier: 1, constant: 50)
        let widthConst =  NSLayoutConstraint(item: popUpView, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: btn.frame.width)
        let heightConst = NSLayoutConstraint(item: popUpView, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: 150)
        let center = NSLayoutConstraint(item: popUpView, attribute: .centerX, relatedBy: .equal, toItem: btn, attribute: .centerX, multiplier: 1, constant: 0)
        
        changingConst = bottomConst
        changingHeight = heightConst
        
        view.addConstraints([center,bottomConst,widthConst,heightConst])
        
//        let swipeGesture = UISwipeGestureRecognizer(target: self, action: #selector(swipeGesture(_:)))
//        swipeGesture.direction = .down
//        popUpView.addGestureRecognizer(swipeGesture)
//
        let panGesture = UIPanGestureRecognizer(target: self, action: #selector(gesture))
        popUpView.addGestureRecognizer(panGesture)
        
        setUpTableView()
    }
    
    @objc func gesture(_ sender: UIPanGestureRecognizer) {
        
        let panView = sender.view!
        let point = sender.translation(in: view)
        let velocity = sender.velocity(in: view)
        
        
        if velocity.y > 0 {
            print("+SASvelocity.y - \(velocity.y)")
            UIView.animate(withDuration: 0.3, animations: { () -> Void in
           //trayView.center = trayDown
           })
        } else {
             print("-SASvelocity.y - \(velocity.y)")
            UIView.animate(withDuration: 0.3, animations: { () -> Void in
           //trayView.center = trayUp
           })
        }
      //  if point.y > 0 {
//        panView.center = CGPoint(x: panView.center.x , y: panView.center.y + point.y )
             
             //print("SAS point.y = \(point.y)")
      //  }
      //print("SAS point.y = \(point.y)")
      // sender.setTranslation(.zero, in: view)
        
        switch sender.state {
        case .began:
            trayOriginalCenter = panView.center
            print("BEGAN - point.x = \(point.x), point.y = \(point.y)")
            
        case .changed:
             panView.center = CGPoint(x: trayOriginalCenter.x, y: trayOriginalCenter.y + point.y)
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
    
    func setUpTableView() {
        
        tableV.backgroundColor = .gray
        tableV.delegate = self
        tableV.dataSource = self
        tableV.isScrollEnabled = false
        tableV.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
        tableV.layoutIfNeeded()
        tableV.separatorStyle = .none
        tableV.backgroundColor = .clear
        popUpView.addSubview(tableV)
        
        tableV.translatesAutoresizingMaskIntoConstraints = false
        let widthConst =  NSLayoutConstraint(item: tableV, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: btn.frame.width - 10)
        let heightConst = NSLayoutConstraint(item: tableV, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: tableV.contentSize.height )
        let centerX = NSLayoutConstraint(item: tableV, attribute: .centerX, relatedBy: .equal, toItem: popUpView, attribute: .centerX, multiplier: 1, constant: 0)
        let centerY = NSLayoutConstraint(item: tableV, attribute: .centerY, relatedBy: .equal, toItem: popUpView, attribute: .centerY, multiplier: 1, constant: 0)
        popUpView.addConstraints([widthConst,heightConst,centerX,centerY])
        
       tableV.layoutIfNeeded()
       heightConst.constant = tableV.contentSize.height
       changingHeight.constant = tableV.contentSize.height + 10
    }
    
    
    
    @objc func swipeGesture(_ sender: UISwipeGestureRecognizer) {

        changingConst.constant = btn.frame.height+18
        UIView.animate(withDuration: 1) {
            self.view.layoutIfNeeded()
            let delay = ((40 / self.popUpView.frame.height) * 100) / 100
            UIView.animate(withDuration: 1, delay: TimeInterval(delay), options: .curveEaseIn, animations: {
                self.popUpView.alpha = 0
            }, completion: nil)
        }

    }
    
    var firstCenterX: CGFloat = 0
    var firstCenterY: CGFloat = 0

    @IBAction func popUpAction(_ sender: Any) {
//        firstCenterX = popUpView.center.x
//        firstCenterY = popUpView.center.y
//        print("SAS - CenterX = \(popUpView.center.x), CenterY = \(popUpView.center.y)")
        callAView()
    }
    
    func callAView() {

        changingConst.constant = -(btn.frame.height+18)
        UIView.animate(withDuration: 1) {

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
        cell.textLabel?.textColor = .white
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    
}

extension ViewController: UITableViewDelegate {
    
}
