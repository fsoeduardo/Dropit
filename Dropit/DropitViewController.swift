//
//  DropitViewController.swift
//  Dropit
//
//  Created by Eduardo Furtado on 5/23/15.
//  Copyright (c) 2015 Eduardo Furtado. All rights reserved.
//

import UIKit

class DropitViewController: UIViewController {
    @IBOutlet weak var gameView: UIView!
    
    let gravity = UIGravityBehavior()
    
    lazy var collider: UICollisionBehavior = {
        let lazilyCreatedCollider = UICollisionBehavior()
        lazilyCreatedCollider.translatesReferenceBoundsIntoBoundary = true //The edges of the referenceView are boundaries
        return lazilyCreatedCollider
    }()
    
    lazy var animator: UIDynamicAnimator = {
        let lazilyCreatedDynamicAnimator = UIDynamicAnimator(referenceView: self.gameView)
        return lazilyCreatedDynamicAnimator
    }()
    //lazy var because because game view is not fully initialized. It's done together with this animator and every other variable
    //Could be done in viewDidLoad or using "lazy", that will only execute when some asks for it
    
    override func viewDidLoad() {
        super.viewDidLoad()
        animator.addBehavior(gravity)
        animator.addBehavior(collider)
    }
    
    var dropsPerRow = 10
    var dropSize: CGSize {
        let size = gameView.bounds.size.width/CGFloat(dropsPerRow)
        
        return CGSize(width: size, height: size)
    }
    
    @IBAction func drop(sender: UITapGestureRecognizer) {
        drop()
    }
    
    func drop() {
        var frame = CGRect(origin: CGPointZero, size: dropSize)
        frame.origin.x = CGFloat.random(dropsPerRow) * dropSize.width
        
        let dropView = UIView(frame: frame)
        dropView.backgroundColor = UIColor.random
        
        gameView.addSubview(dropView)
        
        gravity.addItem(dropView)
        collider.addItem(dropView)
    }
}

private extension CGFloat {
    static func random(max: Int) -> CGFloat {
        return CGFloat(arc4random() % UInt32(max))
    }
}

private extension UIColor {
    class var random: UIColor {
        switch arc4random() % 5 {
        case 0: return UIColor.greenColor()
        case 1: return UIColor.blueColor()
        case 2: return UIColor.orangeColor()
        case 3: return UIColor.redColor()
        case 4: return UIColor.purpleColor()
        default: return UIColor.blackColor()
        }
    }
}