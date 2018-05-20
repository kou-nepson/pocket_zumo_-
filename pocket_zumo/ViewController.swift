//
//  ViewController.swift
//  pocket_zumo
//
//  Created by 杉山航 on 2018/01/31.
//  Copyright © 2018年 杉山航. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    //積み上げた重さの合計
    var omosa: Float = 0
    //プレイヤーの順番
    var turn: Int = 1
    //重さの上限
    var jogen: Int = 100
    //重りの画像を判定するための変数
    var image_num: Int!
    //
    var random_omori: Float!
    
    var get_random: Float!
    
    var moriage_R: Float!
   
    /*
     //ランキング機能
    let saveData: UserDefaults = UserDefaults.standard//スコアを保存する場所を作ります
    var sukoaname1: String = ""
    var sukoaname2: String = ""
    var sukoaname3: String = ""
    var minussukoaname1: String = ""
    var minussukoaname2: String = ""
    var minussukoaname3: String = ""
    */
    
    //使ったお守りの数をカウントする変数の配列
    var countArray: [Int] = [0,0,0,0,0,0]
    //重りの画像
    var imageArray:[String] = ["小.png","中.png","大.png"]
    //重りを表示するイメージビューの配列
    @IBOutlet var imageviewArray: [UIImageView]!
    //重りの重さを表示するラベルの配列
    @IBOutlet var hyouji_omosa: [UILabel]!
    
    //〇〇の番と表示させるラベル
    @IBOutlet weak var turn_L: UILabel!
    //重さの上限を入力するテキストフィールド
    @IBOutlet weak var jogen_F: UITextField!
    //積み上げた重さの合計を表示させるラベル
    @IBOutlet weak var omosalabel: UILabel!
    //左のプレイヤーの名前を入力するテキストフィールド
    @IBOutlet weak var hidari_P: UITextField!
    //右のプレイヤーの名前を入力するテキストフィールド
    @IBOutlet weak var migi_P: UITextField!
    //左のプレイヤーの大の重りを使った数を表示するラベル
    @IBOutlet weak var hidari_D: UILabel!
    //左のプレイヤーの中の重りを使った数を表示するラベル
    @IBOutlet weak var hidari_C: UILabel!
    //左のプレイヤーの小の重りを使った数を表示するラベル
    @IBOutlet weak var hidari_S: UILabel!
    //右のプレイヤーの大の重りを使った数を表示するラベル
    @IBOutlet weak var migi_D: UILabel!
    //右のプレイヤーの中の重りを使った数を表示するラベル
    @IBOutlet weak var migi_C: UILabel!
    //右のプレイヤーの小の重りを使った数を表示するラベル
    @IBOutlet weak var migi_S: UILabel!
    
    //左のプレイヤーの名前を格納する変数
    var playername1 = ""
    //右のプレイヤーの名前を格納する変数
    var playername2 = ""
    
    
    //MARK: キーボードが出ている状態で、キーボード以外をタップしたらキーボードを閉じる
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        //非表示にする。
        if(hidari_P.isFirstResponder){
            hidari_P.resignFirstResponder()
        }
        if(migi_P.isFirstResponder){
            migi_P.resignFirstResponder()
        }
        if(jogen_F.isFirstResponder){
            jogen_F.resignFirstResponder()
        }
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.jogen_F.keyboardType = UIKeyboardType.numberPad
        
        moof("rect", recv)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    //右のプレイヤーの大重りボタン
    @IBAction func migiue(_ sender: Any) {
        if jogen_F.text == String("") {
            self.bug_stop()
        }
        if turn % 2 == 0 {
            var random = Float(arc4random_uniform(UInt32(jogen))) / 100 + (Float(jogen)/4*3)/10
            if omosa >= Float(jogen - (jogen/20)) {
                random = self.moriage(get_random: random)
            }
            omosa += random
            omosalabel.text = String(omosa)
            self.turnchange()
            self.hantei()
            countArray[0] += 1
            migi_D.text = String(countArray[0])
            omori_animation(image_num: 2, random_omori: random)
        }
    }
    //右のプレイヤーの中重りボタン
    @IBAction func migiue_2(_ sender: Any) {
        if jogen_F.text == String("") {
            self.bug_stop()
        }
        if turn % 2 == 0 {
            var random = Float(arc4random_uniform(UInt32(jogen))) / 100 + (Float(jogen)/2)/10
            if omosa >= Float(jogen - (jogen/20)) {
                random = self.moriage(get_random: random)
            }
            omosa += random
            omosalabel.text = String(omosa)
            self.turnchange()
            self.hantei()
            countArray[1] += 1
            migi_C.text = String(countArray[1])
            omori_animation(image_num: 1, random_omori: random)
        }
    }
    //右のプレイヤーの小重りボタン
    @IBAction func migishita_2(_ sender: Any) {
        if jogen_F.text == String("") {
            self.bug_stop()
        }
        if turn % 2 == 0 {
            var random = Float(arc4random_uniform(UInt32(jogen))) / 100 + (Float(jogen)/4)/10
            if omosa >= Float(jogen - (jogen/20)) {
                random = self.moriage(get_random: random)
            }
            omosa += random
            omosalabel.text = String(omosa)
            self.turnchange()
            self.hantei()
            countArray[2] += 1
            migi_S.text = String(countArray[2])
            omori_animation(image_num: 0, random_omori: random)
        }
    }
    //左のプレイヤーの大重りボタン
    @IBAction func hidariue(_ sender: Any) {
        if jogen_F.text == String("") {
            self.bug_stop()
        }
        jogen = Int(jogen_F.text!)!
        if turn % 2 == 1 {
            var random = Float(arc4random_uniform(UInt32(jogen))) / 100 + (Float(jogen)/4*3)/10
            if omosa >= Float(jogen - (jogen/20)) {
                random = self.moriage(get_random: random)
            }
            omosa += random
            omosalabel.text = String(omosa)
            self.turnchange()
            self.hantei()
            countArray[3] += 1
            hidari_D.text = String(countArray[3])
            omori_animation(image_num: 2, random_omori: random)
        }
    }
    //左のプレイヤーの中重りボタン
    @IBAction func hidariue_2(_ sender: Any) {
        if jogen_F.text == String("") {
            self.bug_stop()
        }
        jogen = Int(jogen_F.text!)!
        if turn % 2 == 1 {
            var random = Float(arc4random_uniform(UInt32(jogen))) / 100 + (Float(jogen)/2)/10
            if omosa >= Float(jogen - (jogen/20)) {
                random = self.moriage(get_random: random)
            }
            omosa += random
            omosalabel.text = String(omosa)
            self.turnchange()
            self.hantei()
            countArray[4] += 1
            hidari_C.text = String(countArray[4])
            omori_animation(image_num: 1, random_omori: random)
        }
    }
    //左のプレイヤーの小重りボタン
    @IBAction func hidarishita_2(_ sender: Any) {
        if jogen_F.text == String("") {
            self.bug_stop()
        }
        jogen = Int(jogen_F.text!)!
        if turn % 2 == 1 {
            var random = Float(arc4random_uniform(UInt32(jogen))) / 100 + (Float(jogen)/4)/10
            if omosa >= Float(jogen - (jogen/20)) {
                random = self.moriage(get_random: random)
            }
            omosa += random
            omosalabel.text = String(omosa)
            self.turnchange()
            self.hantei()
            countArray[5] += 1
            hidari_S.text = String(countArray[5])
            omori_animation(image_num: 0, random_omori: random)
        }
    }
    //ゲームを始めるときに押されるボタン（セッティングなど）
    @IBAction func game_start(_ sender: Any) {
        if jogen_F.text == String("") {
            self.bug_stop()
        }
        jogen = Int(jogen_F.text!)!
        playername1 = hidari_P.text!
        playername2 = migi_P.text!
        turn_L.text = playername1
        print("\n\n\n\n\n上限\(jogen)\n\n\n\n\n\n\n")
        
        if omosa >= 0 {
            omosa = 0
        }
    }
    //次のゲームを始めるためにラベルなどをリセットする
    @IBAction func game_reset(_ sender: Any) {
        omosa = 0
        turn = 1
        turn_L.text = ""
        omosalabel.text = "0"
        for i in 0...5 {
            countArray[i] = 0
        }
        migi_D.text = "0"
        migi_C.text = "0"
        migi_S.text = "0"
        hidari_D.text = "0"
        hidari_C.text = "0"
        hidari_S.text = "0"
        for i in 0...9 {
            imageviewArray[i].image = nil
            hyouji_omosa[i] .text = ""
            Swift.print("フォ文内のターン\(turn)")
        }
    }
    //必殺技のボタン
//    @IBAction func arawaza(_ sender: Any) {
//        if countArray[0] % 5 == 0 {
//            self.hissatu(random: <#Float#>)
//            hidari_D.backgroundColor = UIColor.yellow
//        }
//    }
//    @IBAction func arawaza_M(_ sender: Any) {
//        if countArray[3] % 5 == 0 {
//            self.hissatu()
//            migi_D.backgroundColor = UIColor.yellow
//        }
//    }
    //ターン（順番）を管理するメソッド
    func turnchange(){
        turn += 1
        if turn % 2 == 1 {
            turn_L.text = playername1
        }
        if turn % 2 == 0 {
            turn_L.text = playername2
        }
    }
    //勝敗を決めるメソッド
    func hantei(){
        if jogen <= Int(omosa) {
            if turn % 2 == 0{
                let alert:UIAlertController = UIAlertController(title: "勝負あり！", message: ""+playername2+"の勝ち！", preferredStyle: .alert)
                alert.addAction(
                    UIAlertAction(
                        title: "OK",
                        style:.default,
                        handler: {action in
                            //ボタンが押された時の動作
                            NSLog("OKが押された")
                            self.omosa = 0
                    }
                    )
                )
                present(alert, animated: true, completion: nil)
            }
            if turn % 2 == 1 {
                let alert:UIAlertController = UIAlertController(title: "勝負あり！", message: ""+playername1+"の勝ち！", preferredStyle: .alert)
                alert.addAction(
                    UIAlertAction(
                        title: "OK",
                        style:.default,
                        handler: {action in
                            //ボタンが押された時の動作
                            NSLog("OKが押された")
                            self.omosa = 0
                    }
                    )
                )
                present(alert, animated: true, completion: nil)
            }
        }
    }
    //重りを積み上げるアニメーションを作るメソッド
    func omori_animation(image_num: Int,random_omori: Float){
        Swift.print("メソッドに入ったときターン\(turn)")
        if (turn-2) % 10 == 0 && (turn-2) != 0{
            for i in 0...9 {
                imageviewArray[i].image = nil
                hyouji_omosa[i] .text = ""
                Swift.print("フォ文内のターン\(turn)")
            }
            turn -= 10
            Swift.print("いふ文内のターン\(turn)")
            imageviewArray[turn-2].image = UIImage(named:imageArray[image_num])
            hyouji_omosa[turn-2].text = String(random_omori)
        }
        else {
            Swift.print("いふ文に入るときターン\(turn)")
            imageviewArray[turn-2].image = UIImage(named:imageArray[image_num])
            Swift.print("画像セットしたよ〜")
            hyouji_omosa[turn-2].text = String(random_omori)
            Swift.print("文字もセットしたよ〜")
            Swift.print("いふ文を抜けるとき\(turn)")
        }
        Swift.print("メソッドを抜けるとき\(turn)")
    }
    func bug_stop(){
        if jogen_F.text == String("") {
            let alert:UIAlertController = UIAlertController(title: "重さの上限を入力してください", message: "", preferredStyle: .alert)
            alert.addAction(
                UIAlertAction(
                    title: "OK",
                    style:.default,
                    handler: {action in
                        //ボタンが押された時の動作
                        NSLog("OKが押された")
                        self.jogen_F.text = String("100")
                        self.jogen = Int(self.jogen_F.text!)!
                }
                )
            )
            present(alert, animated: true, completion: nil)
        }
        if hidari_P.text == String("") && migi_P.text == String("") {
            hidari_P.text = String("Every Child Has A")
            playername1 = "Beautiful Name"
            migi_P.text = String("Beautiful Name")
            playername2 = "Beautiful Name"
        }
        if hidari_P.text == String("") {
            hidari_P.text = String("Beautiful Name")
            playername1 = "Beautiful Name"
        }
        if migi_P.text == String("") {
            migi_P.text = String("Beautiful Name")
            playername2 = "Beautiful Name"
        }
    }
    
    func moriage(get_random: Float) -> Float {
        let hoge_random: Float = get_random - (Float(jogen)/4)/10
        Swift.print("盛り上げランダムとは\(hoge_random)")
//        hoge_random -= get_random
//        Swift.print("盛り上げランダムとは\(hoge_random)")
        moriage_R = hoge_random
        Swift.print("盛り上げランダムとは\(moriage_R)\n\n\n\n\n\n\n")
        return moriage_R
    }
    
    func moof(_ items: Any..., function: String = #function) {
        
        let icon = Thread.isMainThread ? "🐕💚" : "🐄"
        
        Swift.print(icon + " \(function) ", terminator: "")
        if items.isEmpty {
            Swift.print("")
        } else {
            Swift.debugPrint(items)
        }
    }
    func hissatu(random: Float) -> Float {
        let random = Float(arc4random_uniform(UInt32(jogen))) / 100 + (Float(jogen)/4*3)/10 * -1
        omosa -= random
        return random
    }
}

