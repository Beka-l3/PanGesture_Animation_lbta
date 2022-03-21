//
//  ViewController.swift
//  tutorial
//
//  Created by Bekzhan Talgat on 01.03.2022.
//

import UIKit

class ViewController: UIViewController {
    
    let amountOfViewsInRow = 15
    var cells = [String : UIView]()
    
    var previousCell : UIView?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
        let sideLength = view.frame.width / CGFloat(amountOfViewsInRow)
        
        let amountOfRows = Int(view.frame.height / CGFloat(sideLength))
        
        for i in 0...amountOfRows {
            for j in 0..<amountOfViewsInRow {
//
                let cellView = UIView()
                cellView.backgroundColor = randomColor()
                
                cellView.frame = CGRect(
                    x: CGFloat(j) * sideLength,
                    y: CGFloat(i) * sideLength,
                    width: sideLength,
                    height: sideLength
                )
                
                cellView.layer.borderWidth = 0.5
                cellView.layer.borderColor = UIColor.black.cgColor
                
                let key = "\(i)|\(j)"
                cells[key] = cellView
                
                view.addSubview(cellView)
            }
        }
        
        view.addGestureRecognizer(UIPanGestureRecognizer(target: self, action: #selector(handlePan)))
        
        
    }
    
    
    @objc func handlePan(gesture: UIPanGestureRecognizer) {
        let location = gesture.location(in: view)
        let sideLength = view.frame.width / CGFloat(amountOfViewsInRow)
        
        let i = Int(location.y / sideLength)
        let j = Int(location.x / sideLength)
        let key = "\(i)|\(j)"
        
        guard let cellView = cells[key] else { return }
        
        if previousCell != cellView {
            UIView.animate(
                withDuration: 0.5,
                delay: 0,
                usingSpringWithDamping: 1,
                initialSpringVelocity: 1,
                options: .curveEaseOut,
                animations: {
                    self.previousCell?.layer.transform = CATransform3DIdentity
                },
                completion: nil
            )
        }
        previousCell = cellView
        
        view.bringSubviewToFront(cellView)
        
        UIView.animate(
            withDuration: 0.5,
            delay: 0,
            usingSpringWithDamping: 1.0,
            initialSpringVelocity: 1.0,
            options: .curveEaseOut,
            animations: {
                cellView.layer.transform = CATransform3DMakeScale(3, 3, 3)
            },
            completion: nil
        )
        
        if gesture.state == .ended {
            UIView.animate(
                withDuration: 0.5,
                delay: 0.25,
                usingSpringWithDamping: 0.5,
                initialSpringVelocity: 0.5,
                options: .curveEaseOut,
                animations: {
                    cellView.layer.transform = CATransform3DIdentity
                },
                completion: { (_) in
                    
                })
        }
        
    }
    
    
    func randomColor() -> UIColor {
        let red = CGFloat( drand48() )
        let green = CGFloat( drand48() )
        let blue = CGFloat( drand48() )
        
        return UIColor(red: red, green: green, blue: blue, alpha: 1.0)
    }


}

