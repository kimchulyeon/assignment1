//
//  CommonUtil.swift
//  Mail_Plug_Assignment
//
//  Created by chulyeon kim on 10/26/23.
//

import UIKit

class CommonUtil {
    /// 화면에 떠있는 뷰컨트롤러
    static func getNowPresentViewController() -> UIViewController? {
        var nowPresentViewController: UIViewController?
        
        let scenes = UIApplication.shared.connectedScenes
        let windowScene = scenes.first as? UIWindowScene
        let window = windowScene?.windows.first
        guard let rootViewController = window?.rootViewController else { return nil }
        nowPresentViewController = rootViewController
        
        while let viewController = rootViewController.presentedViewController {
            nowPresentViewController = viewController
        }
        
        return nowPresentViewController
    }
}
