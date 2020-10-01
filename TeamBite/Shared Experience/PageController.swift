//
//  OnboardingViewController.swift
//  TeamBite
//
//  Created by Cameron Rivera on 10/1/20.
//  Copyright © 2020 Christian Hurtado. All rights reserved.
//

import UIKit

class PageController: UIPageViewController {

    // Add the ViewControllers for the onboarding sequence here. 
    private let onboardingControllers: [UIViewController] = []
    
    init() {
        super.init(transitionStyle: .scroll, navigationOrientation: .horizontal, options: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("required init?(coder: NSCoder) has not been implemented.")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureController()
        styleViewController()
    }
    
    private func configureController() {
        dataSource = self
        view.backgroundColor = UIColor.systemBackground
        
        if let first = onboardingControllers.first {
            setViewControllers([first], direction: .forward, animated: true, completion: nil)
        }
    }
    
    private func styleViewController() {
        let pageControl = UIPageControl.appearance(whenContainedInInstancesOf: [type(of: self)])
        
        pageControl.backgroundColor = UIColor.systemBackground
        pageControl.pageIndicatorTintColor = UIColor.systemGray4
        pageControl.currentPageIndicatorTintColor = UIColor.systemTeal
        pageControl.isUserInteractionEnabled = false
        
    }
}

extension PageController: UIPageViewControllerDataSource {
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        
        guard let controllerIndex = onboardingControllers.firstIndex(of: viewController), controllerIndex + 1 < onboardingControllers.count else {
            return nil
        }
        
        return onboardingControllers[controllerIndex + 1]
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        
        guard let controllerIndex = onboardingControllers.firstIndex(of: viewController), controllerIndex - 1 >= 0 else {
            return nil
        }
        
        return onboardingControllers[controllerIndex - 1]
    }
    
    func presentationCount(for pageViewController: UIPageViewController) -> Int {
        return onboardingControllers.count
    }
    
    func presentationIndex(for pageViewController: UIPageViewController) -> Int {
        return 0
    }
    
}
