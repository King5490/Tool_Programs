( function () {document.querySelector("body > div.container > div.section0.topindex.ani > div.start_btn.on").click(); //点击开始学习
setTimeout(() => { //等待video标签加载出来，等待2秒
  var video = document.querySelector("video");
  video.currentTime = 9999;//拉满视频进度条，因网络原因需要等待视频资源加载完成
  setTimeout(()=>{ //等待video标签加载完成，等待1秒
    document.querySelector("body > div.container > div.section1.topindex1").style.display = "none";
    video.play();//重新播放视频
    console.log("我成功了");
  }, 1000);
}, 2000);})()
