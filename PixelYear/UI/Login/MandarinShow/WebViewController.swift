//
//  WebViewController.swift
//  PixelYear
//
//  Created by Елизавета on 31.07.2020.
//  Copyright © 2020 Elizaveta. All rights reserved.
//

import WebKit


class WebViewController: UIViewController {
    var webView = WKWebView()
    let presenter: WebViewPresenter = WebViewPresenter()

    override func viewDidLoad() {
        super.viewDidLoad()
        webView.navigationDelegate = self
        webView.uiDelegate = self
        presenter.setViewDelegate(viewDelegate: self)
        presenter.displayWebSite()
    }

// need for login tests
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

// MARK: - WKUIDelegate extention
extension WebViewController: WKUIDelegate {
    override func loadView() {
        let webConfiguration = WKWebViewConfiguration()
        webView = WKWebView(frame: .zero, configuration: webConfiguration)
        view = webView
    }

}

// MARK: - WKNavigationDelegate extention
extension WebViewController: WKNavigationDelegate {
    func webView(_ webView: WKWebView,
        decidePolicyFor navigationAction: WKNavigationAction,
        decisionHandler: @escaping (WKNavigationActionPolicy) -> Void) {
        if (navigationAction.navigationType == .linkActivated) {
            decisionHandler(.cancel)
        } else {
            decisionHandler(.allow)
            guard let url = navigationAction.request.url else { return }
            if !url.absoluteString.contains("code") { return }
            // clearCookie()
            guard let code = url.valueOf("code") else { return }
            presenter.getAccessToken(with: code)
        }
    }

}

// MARK: - WebViewDelegate extention
extension WebViewController: WebViewPesenterDelegate {
    func openWebSite(with request: URLRequest) {
        webView.load(request)
    }

    func presentMain() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "TabBarController") as UIViewController
        vc.modalPresentationStyle = .fullScreen
        self.present(vc, animated: true, completion: nil)
    }

}
