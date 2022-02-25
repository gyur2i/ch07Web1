//
//  ViewController.swift
//  ch07Web
//
//  Created by 김규리 on 2022/01/18.
//

import UIKit
import WebKit

class ViewController: UIViewController, WKNavigationDelegate {
    @IBOutlet var txtUrl: UITextField!
    @IBOutlet var myWebView: WKWebView!
    @IBOutlet var myActivityIndicator: UIActivityIndicatorView!
    
    // 웹 페이지 로드하는 함수
    func loadWebPage(_ url: String) {
        let myUrl = URL(string: url) // URL 변수 생성
        let myRequest = URLRequest(url: myUrl!) // URL 변수를 이용해 Request 변수를 생성
        myWebView.load(myRequest) // Request 변수를 이용해 파일 로딩
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        myWebView.navigationDelegate = self
        loadWebPage("http://2sam.net")
    }
    
    // 인디케이터
    // myWebView가 로딩 중이면 인디케이터를 실행하고 화면에 나타냄
    func webView(_ webView: WKWebView, didCommit navigation: WKNavigation!) {
        myActivityIndicator.startAnimating()
        myActivityIndicator.isHidden = false
    }
    
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        myActivityIndicator.stopAnimating()
        myActivityIndicator.isHidden = true
    }
    
    func webView(_ webView: WKWebView, didFail navigation: WKNavigation!, withError error: Error) {
        myActivityIndicator.stopAnimating()
        myActivityIndicator.isHidden = true
    }
    //
    
    
    func checkUrl(_ url: String) ->String {
        var strUrl = url
        let flag = strUrl.hasPrefix("http://") // http 를 가지고 있는지 확인해서 true false로 반환
        if !flag { // 가지고 있지 않으면
            strUrl = "http://" + strUrl // 입력 받은 url에 http 추가
        }
        return strUrl
    }
    
    
    @IBAction func btnGotoUrl(_ sender: UIButton) {
        let myUrl = checkUrl(txtUrl.text!) // 입력 받은 url 저장
        txtUrl.text = "" // 빈 텍스트로 바꿔주기
        loadWebPage(myUrl) // 페이지 로드
    }
    
    @IBAction func btnGoSite1(_ sender: UIButton) {
        loadWebPage("http://fallinmac.tistory.com")
    }
    @IBAction func btnGoSite2(_ sender: UIButton) {
        loadWebPage("http://blog.2sam.net")
    }
    // html string을 웹뷰로
    @IBAction func btnLoadHtmlString(_ sender: UIButton) {
        let htmlString = "<h1> HTML String </h1><p> String 변수를 이용한 웹 페이지 </p><p><a href=\"http://2sam.net\">2sam</a>으로 이동</p>"
        myWebView.loadHTMLString(htmlString, baseURL: nil)
    }
    // html file을 읽어서 웹뷰로
    @IBAction func btnLoadHtmlFile(_ sender: UIButton) {
        let filePath = Bundle.main.path(forResource: "htmlView", ofType: "html") // html 파일에 대한 패스변수 생성
        let myUrl = URL(fileURLWithPath: filePath!) // 패스변수를 이용해 URL변수 생성
        let myRequest = URLRequest(url: myUrl) // URL변수를 이용해 Request변수 생성
        myWebView.load(myRequest) // Request변수를 이용해 HTML 파일 로딩
    }
    
    
    @IBAction func btnStop(_ sender: UIBarButtonItem) {
        myWebView.stopLoading()
    }
    @IBAction func btnReload(_ sender: UIBarButtonItem) {
        myWebView.reload()
    }
    @IBAction func btnGoBack(_ sender: UIBarButtonItem) {
        myWebView.goBack()
    }
    @IBAction func btnGoForward(_ sender: UIBarButtonItem) {
        myWebView.goForward()
    }
    
}


