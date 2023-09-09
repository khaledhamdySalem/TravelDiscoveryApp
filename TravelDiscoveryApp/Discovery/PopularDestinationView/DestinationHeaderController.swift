//
//  DestinationHeaderController.swift
//  TravelDiscoveryApp
//
//  Created by Khaled Hamdy on 07/08/2023.
//

import SwiftUI
import Kingfisher

struct DestinationHeaderController: UIViewControllerRepresentable {
    
    let imageURLStrings: [String]
    let selectedIndex: Int
    
    func makeUIViewController(context: Context) -> UIViewController {
        typealias UIViewControllerType = UIViewController
        let pvc = CustomPageViewController(imageURLStrings : imageURLStrings, selectedIndex: selectedIndex)
        return pvc
    }
    
    func updateUIViewController(_ uiViewController: UIViewController, context: Context) {}
}

// MARK: - Custom PageViewController
class CustomPageViewController: UIPageViewController {
    
    var allControllers: [UIViewController] = [UIViewController]()
    let selectedIndex: Int
    
    init(imageURLStrings: [String], selectedIndex: Int) {
        self.selectedIndex = selectedIndex
        super.init(transitionStyle: .scroll, navigationOrientation: .horizontal)
        
        allControllers = imageURLStrings.map({ imageName in
            let vc = UIHostingController(
                rootView:
                    ZStack {
                        Color.black
                        KFImage(URL(string: imageName))
                        .resizable()
                        .scaledToFit()
                    }
            )
            vc.view.clipsToBounds = true
            return vc
        })
        
        if selectedIndex < allControllers.count {
            setViewControllers([allControllers[selectedIndex]], direction: .forward, animated: true)
        }
                
        handleColorOfPageIndicator()
        configureView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

struct DestinationHeaderController_previews: PreviewProvider {
    static var previews: some View {
        DestinationHeaderController(imageURLStrings: ["eiffel_tower", "new_york", "japan"], selectedIndex: 0)
        DiscoveryView()
    }
}

extension CustomPageViewController: UIPageViewControllerDataSource, UIPageViewControllerDelegate {
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        guard let index = allControllers.firstIndex(of: viewController) else { return nil }
        if index == 0 {
            return nil
        }
        return allControllers[index - 1]
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        guard let index = allControllers.firstIndex(of: viewController) else { return nil }
        if allControllers.count - 1 == index {
            return nil
        }
        return allControllers[index + 1]
    }
    
    func presentationCount(for pageViewController: UIPageViewController) -> Int {
        return allControllers.count
    }
    
    func presentationIndex(for pageViewController: UIPageViewController) -> Int {
        self.selectedIndex
    }
    
    private func handleColorOfPageIndicator() {
        UIPageControl.appearance().pageIndicatorTintColor = UIColor.systemGray5
        UIPageControl.appearance().currentPageIndicatorTintColor = .red
    }
    
    private func configureView() {
        self.dataSource = self
        self.delegate = self
    }
}
