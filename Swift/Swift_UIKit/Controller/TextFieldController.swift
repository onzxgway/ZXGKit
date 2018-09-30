//
//  TextFieldController.swift
//  Swift_UIKit
//
//  Created by 朱献国 on 2018/9/29.
//  Copyright © 2018年 朱献国. All rights reserved.
//

import UIKit

class TextFieldController: BaseController {

    private lazy var tf: UITextField = {
        let img = UITextField(frame: CGRect(x: 52, y: 88, width: 210, height: 66))
        img.backgroundColor = .white
        view.addSubview(img)
        return img
    }()
    
}

extension TextFieldController {
    override func setAttribute() {
        
        tf.placeholder = "请输入..." // default is nil. string is drawn 70% gray
//        open var text: String? // default is nil
//
//        @available(iOS 6.0, *)
//        @NSCopying open var attributedText: NSAttributedString? // default is nil
//        @available(iOS 6.0, *)
//        @NSCopying open var attributedPlaceholder: NSAttributedString? // default is nil

        tf.textColor = .blue                    // default is nil. use opaque black
        tf.font = UIFont.systemFont(ofSize: 16) // default is nil. use system font 12 pt
        tf.textAlignment = .center              // default is NSLeftTextAlignment

        tf.borderStyle = .bezel // default is UITextBorderStyleNone. If set to UITextBorderStyleRoundedRect, custom background images are ignored.

//        @available(iOS 7.0, *)
//        open var defaultTextAttributes: [String : Any] // applies attributes to the full range of text. Unset attributes act like default values.

        tf.adjustsFontSizeToFitWidth = true // default is NO. if YES, text will shrink to minFontSize along baseline
        tf.minimumFontSize = 8 // default is 0.0. actual min may be pinned to something readable. used if adjustsFontSizeToFitWidth is YES

        tf.delegate = self // default is nil. weak reference

        tf.background = UIImage(named: "bg_Img") // default is nil. draw in border rect. image should be stretchable
        tf.disabledBackground = UIImage(named: "nut_highlight") // default is nil. ignored if background not set. image should be stretchable


//        open var isEditing: Bool { get }
//
//        @available(iOS 6.0, *)
//        open var allowsEditingTextAttributes: Bool // default is NO. allows editing text attributes with style operations and pasting rich text
//        @available(iOS 6.0, *)
//        open var typingAttributes: [String : Any]? // automatically resets when the selection changes


        // You can supply custom views which are displayed at the left or right
        // sides of the text field. Uses for such views could be to show an icon or
        // a button to operate on the text in the field in an application-defined
        // manner.
        //
        // A very common use is to display a clear button on the right side of the
        // text field, and a standard clear button is provided.
        tf.clearButtonMode = .whileEditing // sets when the clear button shows up. default is UITextFieldViewModeNever

        let vi = UIView(frame: CGRect(x: 0, y: 0, width: 22, height: 22))
        vi.backgroundColor = .red
        tf.leftView = vi                    // e.g. magnifying glass
        tf.leftViewMode = .whileEditing     // sets when the left view shows up. default is UITextFieldViewModeNever

        /**
         UITextField默认的rightView是clearButton，如果手动设置了rightView，则clearButton失效。
         */
        let vie = UIView(frame: CGRect(x: 0, y: 0, width: 22, height: 22))
        vie.backgroundColor = .red
        tf.rightView = vie                  // e.g. bookmarks button
        tf.rightViewMode = .whileEditing    // sets when the right view shows up. default is UITextFieldViewModeNever

        // Presented when object becomes first responder.  If set to nil, reverts to following responder chain.  If
        // set while first responder, will not take effect until reloadInputViews is called.
        let vieww = UIView(frame: CGRect(x: 0, y: 0, width: 0, height: 222))
        vieww.backgroundColor = .red
        
        let accessoryView = UIView(frame: CGRect(x: 0, y: 0, width: 0, height: 44))
        accessoryView.backgroundColor = .blue
        
//        tf.inputView = vieww
        tf.inputAccessoryView = accessoryView

        tf.clearsOnBeginEditing = true // 开始编辑的时候，清空文本框
        
//        tf.clearsOnInsertion = true // defaults to NO. if YES, the selection UI is hidden, and inserting text will replace the contents of the field. changing the selection will automatically set this to NO.
    }
}

extension TextFieldController: UITextFieldDelegate {
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
//        tf.isEnabled = !tf.isEnabled
    }
}
