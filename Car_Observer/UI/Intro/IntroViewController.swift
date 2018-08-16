//
//  IntroViewController.swift
//  Car_Observer
//
//  Created by Andrew Scherbina on 29.06.2018.
//  Copyright © 2018 Andrew Scherbina. All rights reserved.
//

import UIKit

class IntroViewController: UIViewController, UIScrollViewDelegate  {
    
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var pageControl: UIPageControl!
    @IBOutlet weak var bkgImageView: UIImageView!
    let impactFeedback = UIImpactFeedbackGenerator(style: .medium)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let pages = createPages()
        fillScrollView(with: pages)
        impactFeedback.prepare()
    }
    
    
    private func createPages() -> [Page]{
        let page1: Page = Bundle.main.loadNibNamed("Page", owner: self, options: nil)?.first as! Page
        page1.imageView.image = UIImage(named: "step1")
        let page2: Page = Bundle.main.loadNibNamed("Page", owner: self, options: nil)?.first as! Page
        page2.imageView.image = UIImage(named: "step2")
        let page3: Page = Bundle.main.loadNibNamed("Page", owner: self, options: nil)?.first as! Page
        page3.imageView.image = UIImage(named: "step3")
        let page4: Page = Bundle.main.loadNibNamed("Page", owner: self, options: nil)?.first as! Page
        page4.imageView.image = UIImage(named: "step4")
        let page5: Page = Bundle.main.loadNibNamed("Page", owner: self, options: nil)?.first as! Page
        page5.imageView.image = UIImage(named: "step5")
        page5.button.isHidden = false
        page5.button.addTarget(self, action: #selector(dismiss), for: .touchUpInside)
        
        
        return [page1, page2, page3, page4, page5]
    }
    
    private func fillScrollView(with pages:[Page]){
        scrollView.frame = CGRect(x: 0, y: 0, width: view.bounds.width, height: view.bounds.height)
        scrollView.contentSize = CGSize(width: view.bounds.width*CGFloat(pages.count), height: view.bounds.height);
        
        for index in 0..<pages.count{
            pages[index].frame = CGRect(x: view.bounds.width*CGFloat(index), y: 0, width: view.bounds.width, height: view.bounds.height)
            scrollView.insertSubview(pages[index], at: 0)
        }
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
        let xOffset = scrollView.contentOffset.x/15
        bkgImageView.transform = CGAffineTransform(translationX: -xOffset, y: 0)
        let currentPage = Int(scrollView.contentOffset.x / view.bounds.width)
        pageControl.currentPage = currentPage
    }
    
    @objc @IBAction func dismiss(_ sender: Any) {
        impactFeedback.impactOccurred()
        self.dismiss(animated: true, completion: nil)
        print("tapped")
        
    }
    
    
}
