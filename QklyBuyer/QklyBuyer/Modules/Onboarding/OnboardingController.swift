//
//  OnboardingController.swift
//  Qkly
//
//  Created by Arun sah on 1/21/23.
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
    @IBOutlet weak var pageControl: UIPageControl!
   
    var viewModel: OnboardingViewModel!
   
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupSlideScrollView(slides: viewModel.slides)
        getStartedButton.setTitle("Next", for: .normal)
        pageControl.numberOfPages = viewModel.slides.count
        pageControl.currentPage = 0
        view.bringSubviewToFront(pageControl)
        
        getStartedButton.qklyButtonround()
        pageControl.round()
        getStartedButton.addTarget(self, action: #selector(onBoardingNextAction), for: .touchUpInside)
        skipButton.addTarget(self, action: #selector(onboardingDone), for: .touchUpInside)
        
        
    }
    @objc func onboardingDone(){
            self.viewModel.cacheManager.set(Bool.self, value: true, key: FrameworkCacheKey.isOnboardingDone)
        viewModel.trigger.send(AuthRoute.finish)
    }
    
    @objc func onBoardingNextAction(){
        if viewModel.isLastPage {
            onboardingDone()
        } else {
            let newcurrentIndex = viewModel.currentPage + 1
            if newcurrentIndex == viewModel.slides.count {
                return
            }
            viewModel.offSet = (self.view.bounds.size.width * CGFloat(newcurrentIndex))
              DispatchQueue.main.async() {
                  UIView.animate(withDuration: 0.3, delay: 0, options: UIView.AnimationOptions.curveLinear, animations: {
                      self.scrollView.contentOffset.x = CGFloat(self.viewModel.offSet)
                  }, completion: nil)
              }
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
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if scrollView.contentOffset.y > 0 || scrollView.contentOffset.y < 0 {
           scrollView.contentOffset.y = 0
        }
        let pageIndex = round(scrollView.contentOffset.x/view.frame.width)
        viewModel.changeValue(pageIndex: pageIndex)
        updateUIOnScroll()

    }
    
    func updateUIOnScroll(){
        pageControl.currentPage = viewModel.currentPage
        getStartedButton.setTitle(viewModel.isLastPage ? "Get Started" :"Next" , for: .normal)

    }
    
    func scrollView(_ scrollView: UIScrollView, didScrollToPercentageOffset percentageHorizontalOffset: CGFloat) {
    }
}

