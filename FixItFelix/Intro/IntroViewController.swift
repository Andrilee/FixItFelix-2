//
//  IntroViewController.swift
//  Timo
//
//  Created by Prince Alvin Yusuf on 30/03/20.
//  Copyright © 2020 sambalpete. All rights reserved.
//

import UIKit

class IntroViewController: UIViewController {
    @IBOutlet weak var skipButton: UIButton!
    
    fileprivate let items = [
        OnboardingItemInfo(informationImage: Asset.tradein_image.image,
                           title: "",
                           description: "Nearly 30% Of The World’s Population Is Obese",
                           pageIcon: Asset.indicator_sad_icon.image,
                           color: UIColor(red: 0.86, green: 0.93, blue: 0.87, alpha: 1.00),
                           titleColor: UIColor.black, descriptionColor: UIColor.black, titleFont: titleFont, descriptionFont: descriptionFont),
        
        OnboardingItemInfo(informationImage: Asset.curhat_image.image,
                           title: "",
                           description: "Diets Don't Work — a Lifestyle Change Is Necessary",
                           pageIcon: Asset.indicator_opinion_icon.image,
                           color: UIColor(red: 0.86, green: 0.93, blue: 0.87, alpha: 1.00),
                           titleColor: UIColor.black, descriptionColor: UIColor.black, titleFont: titleFont, descriptionFont: descriptionFont),
        
//        color: #colorLiteral(red: 0.3333333333, green: 0.937254902, blue: 0.768627451, alpha: 1),
        
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        skipButton.isHidden = true
        
        setupPaperOnboardingView()
        
        view.bringSubviewToFront(skipButton)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    private func setupPaperOnboardingView() {
        let onboarding = PaperOnboarding()
        onboarding.delegate = self
        onboarding.dataSource = self
        onboarding.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(onboarding)
        
        // Add constraints
        for attribute: NSLayoutConstraint.Attribute in [.left, .right, .top, .bottom] {
            let constraint = NSLayoutConstraint(item: onboarding,
                                                attribute: attribute,
                                                relatedBy: .equal,
                                                toItem: view,
                                                attribute: attribute,
                                                multiplier: 1,
                                                constant: 0)
            view.addConstraint(constraint)
        }
    }
}

// MARK: Actions

extension IntroViewController {
    @IBAction func skipButtonTapped(_: UIButton) {
        print(#function)
        print("button skip")
        
        //Pergi ke menu utama
        performSegue(withIdentifier: "gotomainmenu", sender: nil)
    }
}

// MARK: PaperOnboardingDelegate

extension IntroViewController: PaperOnboardingDelegate {
    func onboardingWillTransitonToIndex(_ index: Int) {
        skipButton.isHidden = index == 1 ? false : true
    }
    
    func onboardingDidTransitonToIndex(_: Int) {
    }
    
    func onboardingConfigurationItem(_ item: OnboardingContentViewItem, index: Int) {
        
    }
}

// MARK: PaperOnboardingDataSource

extension IntroViewController: PaperOnboardingDataSource {
    func onboardingItem(at index: Int) -> OnboardingItemInfo {
        return items[index]
    }
    
    func onboardingItemsCount() -> Int {
        return 2
    }
    
}


//MARK: Constants
extension IntroViewController {
    private static let titleFont = UIFont(name: "Nunito-Bold", size: 36.0) ?? UIFont.boldSystemFont(ofSize: 36.0)
    private static let descriptionFont = UIFont(name: "Nunito-Bold", size: 24.0) ?? UIFont.systemFont(ofSize: 24.0)
}
