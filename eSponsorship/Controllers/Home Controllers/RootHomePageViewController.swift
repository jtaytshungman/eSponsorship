//
//  RootHomePageViewController.swift
//  eSponsorship
//
//  Created by Jeremy Tay on 06/10/2017.
//  Copyright © 2017 Jeremy Tay. All rights reserved.
//

import UIKit

class RootHomePageViewController: UIPageViewController, UIPageViewControllerDataSource {
    
    
    
    var viewControllerList : [UIViewController] = {
        let sbPageVC = UIStoryboard(name: "Home", bundle: nil)
        
        let gamerTable = sbPageVC.instantiateViewController(withIdentifier: "GamersViewController")
        let tourTable = sbPageVC.instantiateViewController(withIdentifier: "TournamentsViewController")
        
        return [tourTable, gamerTable]
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.dataSource = self
        self.title = "Tournaments"
        if let initialViewController = viewControllerList.first {
            self.setViewControllers([initialViewController], direction: .forward, animated: true, completion: nil)
        }
        
        for vc in viewControllerList {
            if let viewController = vc as? TournamentsViewController {
                viewController.delegate = self
                continue
            }
            if let viewController = vc as? GamersViewController {
                viewController.delegate = self
                continue
            }
        }
        
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        guard let viewControllerIndex = viewControllerList.index(of: viewController) else { return nil }
        let previousIndex = viewControllerIndex - 1
        guard previousIndex >= 0 else { return nil }
        guard viewControllerList.count > previousIndex else { return nil }
        
        return viewControllerList[previousIndex]
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        
        guard let viewControllerIndex = viewControllerList.index(of: viewController) else { return nil }
        let nextIndex = viewControllerIndex + 1
        guard viewControllerList.count != nextIndex else { return nil }
        guard viewControllerList.count > nextIndex else { return nil }
        
        return viewControllerList[nextIndex]
    }

}

extension RootHomePageViewController : TitleDelegate {
    func changeTitle(to str: String) {
        self.title = str
    }
}
