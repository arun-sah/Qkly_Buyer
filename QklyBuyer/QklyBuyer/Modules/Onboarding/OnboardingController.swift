//
//  OnboardingController.swift
//  Qkly
//
//  Created by Asmin Ghale on 1/21/22.
//

import UIKit

class OnboardingController: BaseController, UIScrollViewDelegate {
    
    @IBOutlet weak var skipButton: UIButton!
    @IBOutlet weak var getStartedButton: UIButton!

    @IBOutlet weak var scrollView: UIScrollView!{
        didSet{
            scrollView.delegate = self
        }
    }
    
    var isLastPage: Bool = false
    var offSet:CGFloat = 0
    @IBOutlet weak var pageControl: UIPageControl!

    var viewModel: OnboardingViewModel!
    
    var slides: [OnboardingSlide]{
        return viewModel.slides
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupSlideScrollView(slides: viewModel.slides)
        getStartedButton.setTitle("Next", for: .normal)
        pageControl.numberOfPages = viewModel.slides.count
        pageControl.currentPage = 0
        view.bringSubviewToFront(pageControl)
        
        getStartedButton.qklyButtonround()
        pageControl.round()
        getStartedButton.addTarget(self, action: #selector(onboardingDone), for: .touchUpInside)
        skipButton.addTarget(self, action: #selector(onboardingDone), for: .touchUpInside)
        
    }
    @objc func onboardingDone(){
        self.viewModel.cacheManager.set(Bool.self, value: true, key: FrameworkCacheKey.isOnboardingDone)
        viewModel.trigger.send(AuthRoute.finish)
    }
    @objc func onboardNext(){
        let totalPossibleOffset = CGFloat(slides.count - 1) * self.view.bounds.size.width
            
                  offSet += self.view.bounds.size.width
    
              DispatchQueue.main.async() {
                  UIView.animate(withDuration: 0.3, delay: 0, options: UIView.AnimationOptions.curveLinear, animations: {
                      self.scrollView.contentOffset.x = CGFloat(self.offSet)
                  }, completion: nil)
              }
    }
    
    func setupSlideScrollView(slides : [OnboardingSlide]) {
        scrollView.frame = CGRect(x: 0, y: 0, width: view.frame.width, height: view.frame.height)
        scrollView.contentSize = CGSize(width: view.frame.width * CGFloat(slides.count), height: view.frame.height)
        scrollView.isPagingEnabled = true
        
        for i in 0 ..< slides.count {
            slides[i].onboardingView.frame = CGRect(x: view.frame.width * CGFloat(i), y: 0, width: view.frame.width, height: view.frame.height)
            scrollView.addSubview(slides[i].onboardingView)
        }
    }
    
    
    /*
     * default function called when view is scolled. In order to enable callback
     * when scrollview is scrolled, the below code needs to be called:
     * slideScrollView.delegate = self or
     */
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if scrollView.contentOffset.y > 0 || scrollView.contentOffset.y < 0 {
           scrollView.contentOffset.y = 0
        }
        let pageIndex = round(scrollView.contentOffset.x/view.frame.width)
        let currentPage = Int(pageIndex)
        pageControl.currentPage = currentPage
        
        isLastPage  = currentPage == (slides.count - 1)
        if isLastPage {
            getStartedButton.setTitle("Get Started", for: .normal)
            getStartedButton.addTarget(self, action: #selector(onboardingDone), for: .touchUpInside)
        }else {
            getStartedButton.addTarget(self, action: #selector(onboardNext), for: .touchUpInside)

        }

    }
    
    func scrollView(_ scrollView: UIScrollView, didScrollToPercentageOffset percentageHorizontalOffset: CGFloat) {
    }
}

