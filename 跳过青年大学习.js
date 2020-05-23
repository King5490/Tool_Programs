使用参考
https://blog.csdn.net/konley233/article/details/104899396
https://www.cnblogs.com/Mayfly-nymph/p/12613510.html

//调节视频时间相当于调整进度条,以下三行可以互换
Bvideo.currentTime=300;//300为你想跳转到的时间,单位为秒
//Cvideo.currentTime=300;//300可适当改大
//document.getElementById('Bvideo').currentTime=300;

video.ended=1;//如果没有反应加上这一行
score=100;allScore=100;//得分
__vconsole.style.display="none";//隐藏vconsole按钮
