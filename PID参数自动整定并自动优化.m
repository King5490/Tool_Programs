注:本文用于给出阶跃响应的性能指标的PID系统,
   简单调制可在simulink中的添加PID的模块(注意模块的PID的表达式)中找到自动优化工具箱(模块设置最下一行)
   本文使用的为simulink的simulink design optimization 工具箱

相关文档:
1.https://zhuanlan.zhihu.com/p/48737419
2.https://ww2.mathworks.cn/help/sldo/gs/optimize-controller-parameters-to-meet-step-response-requirements-gui.html
3.本仓库<PID参数自整定示例.doc>文件

简明步骤:

1.simulink搭建系统
2.参数自整定法预整定参数
3.matlab工作区设置要优化的PID的变量,并设置为预整定的值(为减小优化运算时间)
4.添加Check Step Response Characteristics模块,并设置要求的性能指标
5.模块最下面一行有 响应优化按钮
6.Design Variables Set,设置要优化的参数,箭头导入参数
7.Evaluate Requirements按钮
8.Optimize按钮
9.完成的参数优化在matlab工作区中查看

