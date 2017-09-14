//
//  AVPlayerViewController.swift
//  Demo1
//
//  Created by 智衡宋 on 2017/8/4.
//  Copyright © 2017年 智衡宋. All rights reserved.
//

import UIKit
import AVKit
import AVFoundation
class AVPlayerViewController: UIViewController {

    //播放器容器
    var containerView:UIView!
    //播放/暂停按钮
    var playOrPauseButton:UIButton!
    //播放进度
    var progress:UIProgressView!
    //显示播放时间
    var timeLabel:UILabel!
    
    //播放器对象
    var player:AVPlayer?
    //播放资源
    var playerItem:AVPlayerItem?
    //播放者
    var playerlayer:AVPlayerLayer?
    
    //时间观察者
    var timeObserver:Any!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupUI()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    deinit {
        removeObserver()
    }
    
}


extension AVPlayerViewController {
    
    func setupUI() {
        
        containerView = UIView()
//        containerView.backgroundColor = .red
        view.addSubview(containerView)
        
        playOrPauseButton = UIButton(type: .system)
        playOrPauseButton.backgroundColor = .blue
        playOrPauseButton.setImage(UIImage(named:"player_play"), for: .normal)
        playOrPauseButton.addTarget(self, action: #selector(playOrPauseButtonClicked(button:)), for: .touchUpInside)
        view.addSubview(playOrPauseButton)
        
        
        progress = UIProgressView()
        progress.progressTintColor = UIColor.blue
        progress.trackTintColor = UIColor.gray
        view.addSubview(progress)
        
        
        timeLabel = UILabel()
        timeLabel.font = UIFont.systemFont(ofSize: 12.0)
        timeLabel.textColor = UIColor.green
        timeLabel.backgroundColor = .red
        view.addSubview(timeLabel)
        
        
        containerView.mas_makeConstraints { (make) in
            
            make?.left.equalTo()(self.view.mas_left)
            make?.right.equalTo()(self.view.mas_right)
            make?.top.equalTo()(self.view.mas_top)?.offset()(67)
            make?.height.mas_equalTo()(200)
            
            
        }
        
        playOrPauseButton.mas_makeConstraints { (make) in
            
            make?.left.equalTo()(self.containerView.mas_left)?.offset()(5)
            make?.top.equalTo()(self.containerView.mas_bottom)?.offset()(5)
            make?.size.mas_equalTo()(CGSize(width: 16, height: 16))
            
        }
        
        
        progress.mas_makeConstraints { (make) in
            
            make?.left.equalTo()(self.playOrPauseButton.mas_right)?.offset()(5)
            make?.right.equalTo()(self.timeLabel.mas_left)?.offset()(-5)
            make?.centerY.equalTo()(self.playOrPauseButton.mas_centerY)
            make?.height.mas_equalTo()(20)
            
        }
        
        
        timeLabel.mas_makeConstraints { (make) in
            
            make?.right.equalTo()(self.containerView.mas_right)?.offset()(-5)
            make?.size.mas_equalTo()(CGSize(width: 60, height: 20))
            make?.centerY.equalTo()(self.progress.mas_centerY)
            
        }
        
        
        addPlayerToAVPlayerLayer()
        
    }
    
    func addPlayerToAVPlayerLayer() {
        //获取本地视频资源
        //guard let path = Bundle.main.path(forResource: "", ofType: "") else { return  }
        //播放本地视频
        //let url = NSURL(fileURLWithPath: path)
        //播放网络视频
        guard let url = NSURL(string: "http://bos.nj.bpc.baidu.com/tieba-smallvideo/11772_3c435014fb2dd9a5fd56a57cc369f6a0.mp4") else { return  }
        playerItem = AVPlayerItem(url: url as URL)
        player = AVPlayer(playerItem: playerItem)
        
        //创建视频播放器图层对象
        playerlayer = AVPlayerLayer(player: player)
        playerlayer?.frame = CGRect(x: 0, y: 0, width: self.view.bounds.width, height: 200)
        playerlayer?.videoGravity = AVLayerVideoGravityResizeAspect //视频填充模式
        containerView.layer.addSublayer(playerlayer!)
        
        addProgressObserver()
        addObserver()
        
    }
    
    
    func addProgressObserver()  {
        
        timeObserver = player?.addPeriodicTimeObserver(forInterval: CMTimeMake(Int64(1.0), Int32(1.0)), queue: DispatchQueue.main, using: { [weak self](time: CMTime) in
            
            //CMTimeGetSeconds函数是将CMTime转换为秒，如果CMTime无效，将返回NaN
            let currentTime = CMTimeGetSeconds(time)
            let totalTime = CMTimeGetSeconds(self!.playerItem!.duration)
            //更新显示的时间和进度条
            
            self!.timeLabel.text = self!.formatPlayTime(seconds: CMTimeGetSeconds(time))
            self!.progress.setProgress(Float(currentTime/totalTime), animated: true)
            print("当前已经播放\(self!.formatPlayTime(seconds: CMTimeGetSeconds(time)))")
            
            
        })
        
    }
    
    
    
    
    func addObserver() {
        
       
        //为AVPlayerItem添加status属性观察，得到资源准备好，开始播放视频
        playerItem?.addObserver(self, forKeyPath: "status", options: .new, context: nil)
        //监听AVPlayerItem的loadedTimeRanges属性来监听缓冲进度更新
        playerItem?.addObserver(self, forKeyPath: "loadedTimeRanges", options: .new, context: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(AVPlayerViewController.playerItemDidReachEnd(notification:)), name: Notification.Name.AVPlayerItemDidPlayToEndTime, object: playerItem)
    }
    
    
    ///  通过KVO监控播放器状态
    ///
    /// - parameter keyPath: 监控属性
    /// - parameter object:  监视器
    /// - parameter change:  状态改变
    /// - parameter context: 上下文
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        guard let object = object as? AVPlayerItem  else { return }
        guard let keyPath = keyPath else { return }
        if keyPath == "status"{
            if object.status == .readyToPlay{ //当资源准备好播放，那么开始播放视频
                player?.play()
                print("正在播放...，视频总长度:\(formatPlayTime(seconds: CMTimeGetSeconds(object.duration)))")
            }else if object.status == .failed || object.status == .unknown{
                print("播放出错")
            }
        }else if keyPath == "loadedTimeRanges"{
            let loadedTime = avalableDurationWithplayerItem()
            print("当前加载进度\(loadedTime)")
        }
    }
    
    //将秒转成时间字符串的方法，因为我们将得到秒。
    func formatPlayTime(seconds: Float64)->String{
        let Min = Int(seconds / 60)
        let Sec = Int(seconds.truncatingRemainder(dividingBy: 60))
        return String(format: "%02d:%02d", Min, Sec)
    }
    
    //计算当前的缓冲进度
    func avalableDurationWithplayerItem()->TimeInterval{
        guard let loadedTimeRanges = player?.currentItem?.loadedTimeRanges,let first = loadedTimeRanges.first else {fatalError()}
        //本次缓冲时间范围
        let timeRange = first.timeRangeValue
        let startSeconds = CMTimeGetSeconds(timeRange.start)//本次缓冲起始时间
        let durationSecound = CMTimeGetSeconds(timeRange.duration)//缓冲时间
        let result = startSeconds + durationSecound//缓冲总长度
        return result
    }
    
    //播放结束，回到最开始位置，播放按钮显示带播放图标
    func playerItemDidReachEnd(notification: Notification){
        player?.seek(to: kCMTimeZero, toleranceBefore: kCMTimeZero, toleranceAfter: kCMTimeZero)
        progress.progress = 0.0
        playOrPauseButton.setImage(UIImage(named:"player_play"), for: .normal)
    }
    
    
    
    //点击播放/暂停按钮
    func playOrPauseButtonClicked(button: UIButton){
        if let player = player{
            if player.rate == 0{//点击时已暂停
                button.setImage(UIImage(named:"player_pause"), for: .normal)
                player.play()
            }else if player.rate == 1{//点击时正在播放
                player.pause()
                button.setImage(UIImage(named:"player_play"), for: .normal)
            }
        }
    }
    
    //去除观察者
    func removeObserver(){
        playerItem?.removeObserver(self, forKeyPath: "status")
        playerItem?.removeObserver(self, forKeyPath: "loadedTimeRanges")
        player?.removeTimeObserver(timeObserver)
        NotificationCenter.default.removeObserver(self, name:  Notification.Name.AVPlayerItemDidPlayToEndTime, object: playerItem)
    }
    
    
   
    
}
