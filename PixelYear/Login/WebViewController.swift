//
//  WebViewController.swift
//  PixelYear
//
//  Created by Елизавета on 31.07.2020.
//  Copyright © 2020 Elizaveta. All rights reserved.
//

import WebKit


class WebViewController: UIViewController {
    let loginService = MandarinShowLoginService()
    var webView = WKWebView()

    override func viewDidLoad() {
        super.viewDidLoad()

        guard let myRequest = loginService.autorizePageRequest() else {
            return
        }
        webView.navigationDelegate = self
        webView.uiDelegate = self
        webView.load(myRequest)
    }


    func clearCookie() {
        webView.configuration.websiteDataStore.httpCookieStore.getAllCookies { cookies in
            for cookie in cookies {
                if cookie.name == "USER_AUTH_L" {

                    self.webView.configuration.websiteDataStore.httpCookieStore.delete(cookie)

                } else {

                    print("\(cookie.name) is set to \(cookie.value)")
                }
            }
        }
    }

}

extension WebViewController: WKUIDelegate {
    override func loadView() {
        let webConfiguration = WKWebViewConfiguration()
        webView = WKWebView(frame: .zero, configuration: webConfiguration)
        view = webView
    }

}

extension WebViewController: WKNavigationDelegate {

    func webView(
        _ webView: WKWebView,
        decidePolicyFor navigationAction: WKNavigationAction,
        decisionHandler: @escaping (WKNavigationActionPolicy) -> Void) {

        if (navigationAction.navigationType == .linkActivated) {
            decisionHandler(.cancel)
        } else {
            decisionHandler(.allow)

            guard let url = navigationAction.request.url else {
                return
            }

            if url.absoluteString.contains("code") {
                //  clearCookie()
                guard let code = url.valueOf("code") else {
                    print("ретёрнуло 1")
                    return
                }
                guard let token = loginService.getAccessToken(with: code) else {
                    print("ретёрнуло 2")
                    return
                }
                SensitiveDataService().saveMandarinshowAccessToken(token: token)
                let storyboard = UIStoryboard(name: "Main", bundle: nil)
                let vc = storyboard.instantiateViewController(withIdentifier: "TabBarController") as UIViewController
                vc.modalPresentationStyle = .fullScreen
                present(vc, animated: true, completion: nil)
            }
        }
    }

}

