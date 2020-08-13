//
//  ChatViewController.swift
//  gigpeople
//
//  Created by Vinoth Kannan on 13/05/2019 .
//  Copyright © 2019 VinothKannan. All rights reserved.
//

import UIKit
import IQKeyboardManager
import FTPopOverMenu
import FCAlertView

class ChatViewController: UIViewController,UITableViewDataSource,UITableViewDelegate,UITextFieldDelegate,UINavigationControllerDelegate,UIImagePickerControllerDelegate,FCAlertViewDelegate {

    @IBOutlet weak var messageField: UITextField!
    @IBOutlet weak var msgInPutView: UIView!
    @IBOutlet weak var sendChatBtn: UIButton!
    @IBOutlet weak var chatTable: UITableView!
    
    var originalRect = CGRect.zero
    var sphBubbledata: [AnyHashable] = []
    var isfromMe = false
    var getPageFrom:String = ""
    
    override func viewDidLoad()
    {
        super.viewDidLoad()

        IQKeyboardManager.shared().isEnabled = false
        IQKeyboardManager.shared().isEnableAutoToolbar = false
        isfromMe = true
        sphBubbledata = [AnyHashable]()
        
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(self.dismissKeyboard))
        chatTable.addGestureRecognizer(tap)
        chatTable.backgroundColor = UIColor.clear
        
        setupDummyMessages()
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: 5, height: 20))
        messageField.leftView = paddingView
        messageField.leftViewMode = .always
    }
    @IBAction func backBtn(_ sender: Any)
    {
        self.navigationController?.popViewController(animated: true)
    }
    @IBAction func menuBtn(_ sender: Any)
    {
        let arrayVal = ["Block this user"]
        let configuration = FTPopOverMenuConfiguration.default()
        configuration?.allowRoundedArrow = !(configuration?.allowRoundedArrow)!
        configuration?.backgroundColor = UIColor.darkGray
        configuration?.textColor = UIColor.white
        configuration?.separatorColor = UIColor.groupTableViewBackground
        FTPopOverMenu.show(forSender: (sender as! UIView), withMenuArray: arrayVal, imageArray: nil, configuration: configuration, doneBlock: { selectedIndex in
            
        })
        {
            print("user canceled. do nothing.")
        }
    }
    @IBAction func addPhotoBtn(_ sender: Any)
    {
        let arrayOfButtonTitles = ["Gallery", "Take Photo"]
        let cusAlert = FCAlertView()
        cusAlert.delegate = self
        cusAlert.showAlert(inView: self, withTitle: "", withSubtitle: "Add Photo", withCustomImage: nil, withDoneButtonTitle: "Cancel", andButtons: arrayOfButtonTitles)
        cusAlert.subtitleFont = UIFont(name: "Geomanist", size: 18)
        cusAlert.subTitleColor = UIColor.white
        cusAlert.doneButtonTitleColor = UIColor.white
        cusAlert.colorScheme = UIColor(red:1.00, green:0.46, blue:0.01, alpha:1.0)
        cusAlert.alertBackgroundColor = UIColor(red:1.00, green:0.46, blue:0.01, alpha:1.0)
        cusAlert.firstButtonCustomFont = UIFont(name: "Geomanist", size: 16)
        cusAlert.secondButtonCustomFont = UIFont(name: "Geomanist", size: 16)
        cusAlert.firstButtonTitleColor = UIColor.black
        cusAlert.secondButtonTitleColor = UIColor.black
    }
    func fcAlertView(_ alertView: FCAlertView, clickedButtonIndex index: Int, buttonTitle title: String)
    {
        if title == "Gallery"
        {
            let customerpickerObj = UIImagePickerController()
            customerpickerObj.delegate = self
            customerpickerObj.sourceType = .photoLibrary
            customerpickerObj.allowsEditing = true
            present(customerpickerObj, animated: true)
        }
        else if title == "Take Photo"
        {
            let customerpickerObj = UIImagePickerController()
            customerpickerObj.delegate = self
            customerpickerObj.sourceType = .camera
            customerpickerObj.allowsEditing = true
            present(customerpickerObj, animated: true)
        }
    }
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any])
    {
        picker.dismiss(animated: true)
    }
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController)
    {
        picker.dismiss(animated: true)
    }
    @IBAction func sendBtn(_ sender: Any)
    {
        
    }
    override func viewWillDisappear(_ animated: Bool)
    {
        super.viewWillDisappear(true)
        IQKeyboardManager.shared().isEnabled = true
        IQKeyboardManager.shared().isEnableAutoToolbar = true
    }
    
    @objc func dismissKeyboard()
    {
        view.endEditing(true)
    }
    func registerForKeyboardNotifications()
    {
        originalRect = msgInPutView.frame
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWillShow(_:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWillHide(_:)), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    @objc func keyboardWillShow(_ notification: Notification?)
    {
        let info = notification?.userInfo
        let duration = info?[UIResponder.keyboardAnimationDurationUserInfoKey] as? NSNumber
        let curve = info?[UIResponder.keyboardAnimationCurveUserInfoKey] as? NSNumber
        let endKbSize: CGSize? = (info?[UIResponder.keyboardFrameEndUserInfoKey] as AnyObject).cgRectValue.size
        
        var baseFrame: CGRect = msgInPutView.frame
        baseFrame.origin.y = msgInPutView.frame.maxY - ((endKbSize?.height ?? 0.0) - 5) - 50
        
        UIView.animate(withDuration: TimeInterval(duration?.floatValue ?? 0.0), delay: 0.0, options: UIView.AnimationOptions(rawValue: UInt(curve?.intValue ?? 0)), animations: {
            self.msgInPutView.frame = baseFrame
        }) { finished in
            self.msgInPutView.frame = baseFrame
        }
    }
    @objc func keyboardWillHide(_ notification: Notification?)
    {
        let info = notification?.userInfo
        let duration = info?[UIResponder.keyboardAnimationDurationUserInfoKey] as? NSNumber
        let curve = info?[UIResponder.keyboardAnimationCurveUserInfoKey] as? NSNumber
        
        UIView.animate(withDuration: TimeInterval(duration?.floatValue ?? 0.0), delay: 0.0, options: UIView.AnimationOptions(rawValue: UInt(curve?.intValue ?? 0)), animations: {
            self.msgInPutView.frame = self.originalRect
        })
    }
    
    // MARK: tableview delegate
    
    func numberOfSections(in tableView: UITableView) -> Int
    {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return sphBubbledata.count
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat
    {
        var feed_data = SPH_PARAM_List()
        if let object = sphBubbledata[indexPath.row] as? SPH_PARAM_List
        {
            feed_data = object
        }
        
        if (feed_data.chat_media_type == kImagebyme) || (feed_data.chat_media_type == kImagebyOther) {
            return 180
        }
        let labelSize = feed_data.chat_message.boundingRect(with: CGSize(width: 226.0, height: Double(MAXFLOAT)), options: .usesLineFragmentOrigin, attributes: [
            NSAttributedString.Key.font: UIFont.systemFont(ofSize: 14.0)
            ], context: nil).size
        return labelSize.height + 30 + CGFloat(TOP_MARGIN)
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        
        let L_CellIdentifier = "SPHTextBubbleCell"
        let R_CellIdentifier = "SPHMediaBubbleCell"
        
        var feed_data = SPH_PARAM_List()
        if let object = sphBubbledata[indexPath.row] as? SPH_PARAM_List
        {
            feed_data = object
        }
        
        var cell = tableView.dequeueReusableCell(withIdentifier: L_CellIdentifier) as? SPHTextBubbleCell
        if cell == nil
        {
            cell = SPHTextBubbleCell(style: .subtitle, reuseIdentifier: L_CellIdentifier)
        }
        if (feed_data.chat_media_type == kTextByme) || (feed_data.chat_media_type == kTextByOther)
        {
            cell?.bubbletype = (feed_data.chat_media_type == kTextByme) ? "LEFT" : "RIGHT"
            cell?.textLabel!.text = feed_data.chat_message
            cell?.textLabel!.tag = indexPath.row
            cell?.timestampLabel.text = "02:20 AM"
            cell?.avatarImageView.image = (feed_data.chat_media_type == kTextByme) ? UIImage(named: "SenderProfilePic") : UIImage(named: "ReceiverProfilePic")
        }
        return cell!

    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        if sphBubbledata.count > 2 {
            perform(#selector(self.scrollTableview), with: nil, afterDelay: 0.0)
        }
        var tableviewframe: CGRect = chatTable.frame
        tableviewframe.size.height -= 260
        UIView.animate(withDuration: 0.25, animations: {
            self.msgInPutView.frame = CGRect(x: 0, y: self.view.frame.size.height - 305, width: self.view.frame.size.width, height: 50)
            self.chatTable.frame = tableviewframe
        })
    }
    func textFieldDidEndEditing(_ textField: UITextField) {
        var tableviewframe: CGRect = chatTable.frame
        tableviewframe.size.height += 260
        UIView.animate(withDuration: 0.25, animations: {
            self.msgInPutView.frame = CGRect(x: 0, y: self.view.frame.size.height - 50, width: self.view.frame.size.width, height: 50)
            self.chatTable.frame = tableviewframe
        })
        if sphBubbledata.count > 2 {
            perform(#selector(self.scrollTableview), with: nil, afterDelay: 0.25)
        }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        view.endEditing(true)
        return true
    }
    @objc func messageSent(_ rownum: String?)
    {
        
    }
    @objc func scrollTableview()
    {
        let item: Int = chatTable.numberOfRows(inSection: 0) - 1
        let lastIndexPath = IndexPath(item: item, section: 0)
        chatTable.scrollToRow(at: lastIndexPath, at: .bottom, animated: true)
    }
    func adddMediaBubbledata(_ mediaType: String?, mediaPath: String?, mtime messageTime: String?, thumb thumbUrl: String?, downloadstatus: String?, sendingStatus: String?, msg_ID msgID: String?) {
        
        let feed_data = SPH_PARAM_List()
        feed_data.chat_message = mediaPath
        feed_data.chat_date_time = messageTime
        feed_data.chat_media_type = mediaType
        feed_data.chat_send_status = sendingStatus
        feed_data.chat_Thumburl = thumbUrl
        feed_data.chat_downloadStatus = downloadstatus
        feed_data.chat_messageID = msgID
        sphBubbledata.append(feed_data)
    }
    func genRandStringLength(_ len: Int) -> String? {
        
        let letters = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"
        let randomString = String(repeating: "\0", count: len)
        return randomString
    }
    func setupDummyMessages()
    {
        let date = Date()
        let formatter = DateFormatter()
        formatter.dateFormat = "hh:mm a"
        
        adddMediaBubbledata(kTextByOther, mediaPath: "Hello! How are you?", mtime: formatter.string(from: date), thumb: "", downloadstatus: "", sendingStatus: kSent, msg_ID: genRandStringLength(7))
        adddMediaBubbledata(kTextByme, mediaPath: "I'm doing Great!", mtime: formatter.string(from: date), thumb: "", downloadstatus: "", sendingStatus: kSent, msg_ID: genRandStringLength(7))
        adddMediaBubbledata(kTextByme, mediaPath: "lets meet some time for dinner! hope you will like it. Ya sure. We'll meet there in some time.", mtime: formatter.string(from: date), thumb: "", downloadstatus: "", sendingStatus: kSent, msg_ID: genRandStringLength(7))
        adddMediaBubbledata(kTextByOther, mediaPath: "Ya sure. We'll meet there in some time. lets meet some time for dinner! hope you will like it. Thanks, bye.", mtime: formatter.string(from: date), thumb: "", downloadstatus: "", sendingStatus: kSent, msg_ID: genRandStringLength(7))
        chatTable.reloadData()
        if sphBubbledata.count > 0 {
            chatTable.scrollToRow(at: IndexPath(row: sphBubbledata.count - 1, section: 0), at: .bottom, animated: true)
        }
    }
}
