//
//  File.swift
//  Instagram
//
//  Created by Ami Hirahara on 2021/05/10.
//

import UIKit
import Firebase
import SVProgressHUD

class CommentsViewController: UIViewController {
    var postData: PostData!
    
    @IBOutlet weak var textView: UITextView!
    //コメント投稿ボタンをタップした時に呼ばれるメソッド
    @IBAction func handlePostButton(_ sender: Any){
        
        //HUDで投稿処理中に表示を開始
        SVProgressHUD.show()
        
        //HUDで投稿完了に表示する
        SVProgressHUD.showSuccess(withStatus: "コメントを投稿しました。")
        //投稿処理が完了したので先頭画面に戻る
        UIApplication.shared.windows.first{ $0.isKeyWindow }?.rootViewController?.dismiss(animated: true, completion: nil)
        
        //コメントを更新する
        var comments = ""
        let commenter = Auth.auth().currentUser?.displayName
        let comment = self.textView.text!
        comments = commenter! + ":" + comment
        
        //コメントの更新データを作成する
        var updateValue: FieldValue
        if comment.isEmpty{
            return
        } else {
            //今回新たにコメントした場合は、コメント入力者とコメント内容を追加する更新データを作成
            updateValue = FieldValue.arrayUnion([comments])
            //コメントに更新データを書き込む
            let postRef = Firestore.firestore().collection(Const.PostPath).document(postData.id)
            postRef.updateData(["comments":updateValue])
        }
    }
    //キャンセルボタンをタップした時に呼ばれるメソッド
    @IBAction func handleCancelButton(_ sender: Any){
        //前画面に戻る
        self.dismiss(animated: true, completion: nil)
    }
}

