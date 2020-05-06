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
    
    var initialCenter = CGPoint()
    
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

        let bottomConst = NSLayoutConstraint(item: popUpView, attribute: .bottom, relatedBy: .equal, toItem: btn, attribute: .top, multiplier: 1, constant: 50)
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
    
    var fixedPoint = CGPoint()
    
    @objc func gesture(_ sender: UIPanGestureRecognizer) {
        guard sender.view != nil else {return}
        let piece = sender.view!
        // Get the changes in the X and Y directions relative to
        // the superview's coordinate space.
        let translation = sender.translation(in: piece.superview)
        if sender.state == .began {
           // Save the view's original position.
           self.initialCenter = piece.center
        }
           // Update the position for the .began, .changed, and .ended states
        if sender.state != .cancelled {
           // Add the X and Y translation to the view's original position.
           
           print("FFfixedPoint.y = \(fixedPoint.y)")
            print("FFFinitialCenter.y = \(initialCenter.y)")
            var ss = initialCenter.y + translation.y
            
             print("ss.y = \(ss)")
            if ss > fixedPoint.y {
//                if initialCenter.y > fixedPoint.y {
//                    initialCenter.y = fixedPoint.y
//                }
                let newCenter = CGPoint(x: initialCenter.x , y: ss)
                
                print("FFFinewCenter.y = \(newCenter.y)")
                
                print("NewVal.y = \(view.frame.height - fixedPoint.y )")
                print("MMMM.y = \(view.frame.height - newCenter.y )")
                
                
                piece.center = newCenter
                print("ASAnewCenter.y = \(newCenter.y)")
                
            } else {
                if initialCenter.y < fixedPoint.y {
                    initialCenter.y = fixedPoint.y
                }
            }
           
            
            
          
          
        }
        else {
           // On cancellation, return the piece to its original location.
//            if initialCenter.y > fixedPoint.y {
//                initialCenter.y = fixedPoint.y
//            }
           piece.center = initialCenter
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

        changingConst.constant = -(10)
        UIView.animate(withDuration: 1) {

            self.view.layoutIfNeeded()
            let delay = ((40 / self.popUpView.frame.height) * 100) / 100
            UIView.animate(withDuration: 1, delay: TimeInterval(delay), options: .curveEaseIn, animations: {
                self.popUpView.alpha = 1
            }){ (_) in
                self.fixedPoint = self.popUpView.center
                print("SASAself.fixedPoint = \(self.fixedPoint)")
            }
            
            
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
