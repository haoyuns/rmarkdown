###  序言

- 我们最熟悉的饼图有它自身设计的巧妙 - 切分一个 360 度的圆圈给人以形象的“比例”展示，然而它表达数据的实际效果却不如条形图或 Cleveland 点图，因为**人眼对角度大小的敏感性不如长度**。我们应该尽量避免用饼图，无论我们多熟悉它。不过这种巧妙的设计却可以被用在其它场合，如提灯女士的玫瑰图。

- 尽量避免 3D 图形，除非它是可以交互操作的。三维立体图形看起来很炫很时髦，但它的缺点也是很明显的 — 对于静态的三维图形，我们在二维媒介上只能看到它的一个侧面，这样**可能会隐藏一些数据信息**。大多数情况下，三维图形可以被等高线代替（[4.8](https://bookdown.org/xiangyun/msg/gallery.html#sec:contour) 小节），后者可以让我们从平面上看到所有信息；如果需要使用三维图形，可以考虑 **rgl** 包等动态图形系统（[5.6](https://bookdown.org/xiangyun/msg/system.html#sec:rgl) 小节），这样我们的图形可以任意旋转角度、缩放。



### 2. 工具

贝尔实验室的的 Cleveland 在图形认知方面做了不少工作，告诉我们应该怎样合理构建图形以及解读图形，如 Cleveland ([1985](https://bookdown.org/xiangyun/msg/history.html#ref-Cleveland85)) 和 Cleveland ([1993](https://bookdown.org/xiangyun/msg/history.html#ref-Cleveland93)) 等，其中值得一提的是他可能是最早研究统计图形对读者心理感知的影响的统计学家之一，但不幸的是，这项工作似乎并没有引起人们的广泛重视（饼图直至今日仍然泛滥便是一个最好的例证），另外他提出了 S 语言中的 Trellis 图形，这对统计图形软件的发展来说也是具有划时代意义的贡献，后来 R 语言中的 **lattice** 包正是继承了 Trellis 图形的概念，近些年来也非常有影响力。关于统计图形的历史总结，Friendly and Denis ([2001](https://bookdown.org/xiangyun/msg/history.html#ref-Friendly01)) 是一份非常详尽的资料，该文档整理、记载了自 17 世纪以前至今数百年历史中较有影响力的统计图形。



**Excel vs 统计图形**

- Excel 的图形总体看来只有三种，从更广泛的意义上来说，Excel 展示的几乎都是原始数据，基于数据的统计推断的意味比较淡薄：
  - 第一种是表现绝对数值大小，如条形图、柱形图、折线图等
  - 第二种是表现比例，如饼图
  - 第三种则是表示二维平面上的变量关系，如 X-Y 散点图

- 统计学的核心研究对象是什么？
  - 答案应该是**分布（Distribution）**，注意分布不仅包含一元变量的分布，而且更重要的是多元变量的分布，诸如“均值”、“方差”、“相关”和“概率”等概念都可以归为分布的范畴
  - 相比之下，R 语言汇集**统计计算**与**统计图示**两种功能于一身，灵活的**面向对象**（Object-Oriented，OO）编程方式让我们可以很方便地控制图形输出，从而制作出既精美又专业的统计图形
  - 正式发行的 R 版本中默认包括了 **base**（R 基础包）、**stats**（统计函数包）、**graphics**（图形包）、**grDevices**（图形设备包）、**datasets**（数据集包）等基础程序包，其中包含了大量的统计模型函数，如：线性模型/广义线性模型、非线性回归模型、时间序列分析、经典的参数/非参数检验、聚类和光滑方法等，还有大批灵活的作图程序



### 3. 元素

#### 3.1 颜色

R 提供了一系列利用颜色生成模型如 RGB 模型（红绿蓝三原色混合）、HSV 色彩模型（色调、饱和度和纯度）、HCL 色彩模型（色调、色度和亮度）和灰色生成模型等。

**Hex code**

这些颜色都是由六个十六进制数字组成的，每两位数字（合起来取值从 0 到 255）分别表示红绿蓝（RGB 颜色）的比例。我们知道，当三原色完全混合时，生成的颜色是白色，上面结果的最后一个 `'#FFFFFF'` 正是纯白色。

**十六进制，简写为hex，A~F相当于十进制的10~15*

**RColorBrewer 调色板**

```R
# Sequential 连续型：18 种，通常用来标记连续型数值的大小
display.brewer.all(type = "seq")
# Diverging 极端化：9 种，可用来标记数据中的离群点
display.brewer.all(type = "div")
# Qualitative 离散型：8 种，通常用来标记分类数据
display.brewer.all(type = "qual")
```

统计图形并没有任何神秘可言，随着对图形元素的绘制以及统计量的逐渐深入了解，当一幅统计图形摆在我们面前，我们也应该能如“庖丁解牛”一般洞穿其架构。例如，从纯粹作图的意义上来讲，直方图、条形图、棘状图和马赛克图不过是矩形，条件密度图和饼图是多边形，散点图和带状图是点，折线图和向日葵散点图是线段，等等。事实上，用 R 语言的作图功能作音乐五线谱、画地图、做动画等等，都不足为奇。



### 4. 图库

#### 4.1 直方图

关于区间划分的一些讨论可以参考 Venables and Ripley ([2002](https://bookdown.org/xiangyun/msg/gallery.html#ref-Venables02))，这里我们需要特别指出的是，**直方图的理论并非想象中或看起来的那么简单，窗宽也并非可以任意选择，不同的窗宽或区间划分方法会导致不同的估计误差**。

关于这一点，Excel 的直方图可以说是非常不可靠的，因为它把区间的划分方法完全交给了用户去选择，这样随意制作出来的直方图很可能会导致大的估计误差、掩盖数据的真实分布情况。另外一点需要提醒的是关于直方图中的密度曲线，SPSS 软件在绘制直方图时会有选项提示是否添加正态分布密度曲线，这也是完全的误导，因为数据不一定来自正态分布，添加正态分布的密度曲线显然是不合理的。

相比之下，图 [4.2](https://bookdown.org/xiangyun/msg/gallery.html#fig:hist-density) 的做法才是真正从数据本来的分布出发得到的密度曲线。图 [4.2](https://bookdown.org/xiangyun/msg/gallery.html#fig:hist-density) 的核密度曲线基于函数 `density()` 计算而来，它的参数包括核函数和窗宽等，实际应用中我们可能需要尝试不同的核函数以及窗宽值，Venables and Ripley ([2002](https://bookdown.org/xiangyun/msg/gallery.html#ref-Venables02)) 第 5.6 小节介绍了一些选择的经验可供参考。

```R
library(ggplot2)
library(cowplot)
demo("hist_geyser", package = "MSG")
df <- data.frame(
  x = seq(40, 110, 5), y = 0,
  xend = seq(40, 110, 5), yend = ht
)
p <- ggplot(aes(waiting), data = geyser)
p2 <- p + geom_histogram(breaks = seq(40, 110, by = 5), aes(y = ..density..))
p2 + geom_density(fill = "lightgray", color = "black") +
  geom_segment(aes(x = x, y = y, xend = xend, yend = yend),
    data = df, lty = 3
  )
```

![xdtjtx-hist-density-1](/Users/hs/Documents/GitHub/rmarkdown/notes/xdtjtx-hist-density-1.svg)



#### 4.3 箱线图

箱线图（Box Plot 或 Box-and-Whisker Plot）主要是从四分位数的角度出发描述数据的分布，它通过最大值（Q4）、上四分位数（Q3）、中位数（Q2）、下四分位数（Q1）和最小值（Q0）五处位置来获取一维数据的分布概况。

我们知道，这五处位置之间依次包含了四段数据，每段中数据量均为总数据量的1/4。通过每一段数据占据的长度，我们可以大致推断出数据的集中或离散趋势（长度越短，说明数据在该区间上越密集，反之则稀疏）。

<img src="/Users/hs/Documents/GitHub/rmarkdown/notes/xdtjtx-boxplot-1.jpg" alt="xdtjtx-boxplot-1" style="zoom:75%;" />

参数 `x` 为一个数值向量或者列表，若为列表则对列表中每一个子对象依次作出箱线图； `range` 是一个延伸倍数，决定了箱线图的末端（须）延伸到什么位置，这主要是考虑到离群点的原因，在数据中存在离群点的情况下，将箱线图末端直接延伸到最大值和最小值对描述数据分布来说并不合适（图形缺乏稳健性），所以 R 中的箱线图默认只将图形延伸到离箱子两端 range × (Q3−Q1)处，即上下四分位数分别加/减内四分位距（Interquartile Range，简称 **IQR** ≡ Q3−Q1）的倍数，**超过这个范围的数据点就被视作离群点**，在图中直接以点的形式表示出来。

箱线图凹槽：比较多组的中位数置信区间，即x±数值



#### 4.4 条形图

条形图目前是各种统计图形中应用最广泛的，但条形图所能展示的统计量比较贫乏：它只能以矩形条的长度展示原始数值，对数据没有任何概括或推断。



#### 4.8 等高线图

等高图（Contour Plot）和等高线（Contour Line）表面上看起来是二维形式，但实际上展示的是三维数据。注意等高线之间不可能相交，因为同一点不可能同时有两种高度。



#### 4.16 马赛克图

马赛克图的表现形式为与频数成比例的矩形块，整幅图形看起来就像是若干块马赛克放置在平面上。马赛克图背后的统计理论是对数线性模型（log-linear model）。



#### 4.18 三维透视图

三维透视图的数据基础是网格数据（回顾 [4.8](https://bookdown.org/xiangyun/msg/gallery.html#sec:contour) 小节和图 [4.9](https://bookdown.org/xiangyun/msg/gallery.html#fig:contour-grid)），它将一个矩阵中包含的高度数值用曲面连接起来，R 中透视图的函数为 `persp()`。



#### 4.23 星状图、蛛网图、雷达图

星状图（Star Plot）、蛛网图（Spider Plot）和雷达图（Radar Plot）本质上是一类图形，它们都用线段离中心的长度来表示变量值的大小



#### 4.26 符号图

符号图是用各种符号展示高维数据的图示工具，符号图的基础是散点图，因此首先要给出两个参数 `x` 和 `y` 以便作散点图，然后在散点的位置上画出符号；R 中的符号图函数为 `symbols()`，它提供了六种基本符号：圆、正方形、长方形、星形、温度计和箱线图，这六种符号图能展示的数据维度分别为 3、3、4、≥5、5 或 6、7。



#### 4.31 生存函数图

在很多医学研究中，我们主要关心的变量是病人的某种事件发生的时间，例如死亡、疾病复发等。事实上，以“生存时间”为研究对象的领域并不仅限于医学，例如在金融领域，我们可能需要了解信用卡持有者的信用风险发生时间。这类数据一般统称为生存数据（survival data），而生存数据通常有一个特征就是删失，即观测对象因为某种原因退出了我们的观察。关于生存分析的详细理论请参考 Therneau and Grambsch ([2000](https://bookdown.org/xiangyun/msg/gallery.html#ref-Therneau00)) 等。



#### 4.35 脸谱图

脸谱图由 Chernoff ([1973](https://bookdown.org/xiangyun/msg/gallery.html#ref-Chernoff73)) 提出，它以一种非常形象有趣的方式来展示多元数据：人的脸部（确切来说是头部）有很多特征，例如眼睛大小、眉毛弧度、脸宽、鼻高等，由于这些特征都可以用数值大小来测量，因此我们也可以反过来将一批数值对应到这些脸部特征上来，如数据的第一列控制眼睛大小、第二列控制嘴巴大小等，每一行观测数据都可以像这样画出一个人脸来。由于人眼通常很容易辨别这些脸谱的具体特征（如谁的脸胖、谁笑得最夸张），因此脸谱图能很好反映其背后的数值大小。



CRAN分类导航：https://cran.r-project.org/web/views/Spatial.html



### 5. 系统

### 6. 数据













### 附录

#### A.1 对象类型

**向量 （vector）**是最简单的数据结构，它是若干数据点的简单集合。以向量的形式进行元素运算是 R 语言计算的重要特征，向量的运算一般都是针对每一个元素的运算。

**因子（factor）**对应着统计中的分类数据，它的形式和向量很相像，只是因子数据具有水平（level）和标签（label），前者即分类变量的不同取值，后者即各类取值的名称。

**数组（array）和矩阵（matrix）**是具有维度属性（dimension）的数据结构，注意这里的维度并非统计上所说的“列”，而是一般的计算机语言中所定义的维度（数据下标的个数）。矩阵是数组的特例，它的维度为 2。数组和矩阵可以分别由 `array()` 和 `matrix()` 函数生成。注意矩阵中所有元素必须为同一种类型，要么全都是数值，要么全都是字符

矩阵相对于数组来说在统计中应用更为广泛，尤其是大量的统计理论都涉及到矩阵的运算。顺便提一下，R 包 Matrix (Bates and Maechler [2019](https://bookdown.org/xiangyun/msg/programming.html#ref-Matrix)) 在处理（高维）稀疏或稠密矩阵时效率会比 R 自身的矩阵运算效率更高。

**数据框（data frame）和列表（list）**是 R 中非常灵活的数据结构。数据框也是二维表的形式，与矩阵非常类似，区别在于数据框只要求各列内的数据类型相同，而各列的类型可以不同；列表则是更灵活的数据结构，它可以包含任意类型的子对象。数据框和列表分别可以由 `data.frame()` 和 `list()` 生成。

矩阵的本质是（带有维度属性的）向量，数据框的本质是（整齐的）列表。

R 中也可以自定义**函数（function）** ，以便编程中可以以不同的参数值重复使用一段代码。定义函数的方式为：`function(arglist) expr return(value)`；其中 `arglist` 是参数列表，`expr` 是函数的主体，`return()` 用来返回函数值。注意，R 中有时候不必用函数 `return()` 指定返回值，默认情况下，函数主体的最后一行即为函数返回值。

**泛型函数 （generic function）**的作用原理：根据第一个参数的类（class）去调用了相应的“子函数”。



#### B.1 par() 函数

R 的图形参数既可以通过函数 `par()` 预先全局设置，也可以在具体作图函数（如 `plot()`、`lines()` 等）中设置临时参数值；二者的区别在于前者的设置会一直在当前图形设备中起作用，除非将图形设备（参见 [B.6](https://bookdown.org/xiangyun/msg/tricks.html#sec:device) 小节）关闭，而后者的设置只是临时性的，不会影响后面其它作图函数的图形效果。

![xdtjtx-plot-region-1](/Users/hs/Documents/GitHub/rmarkdown/notes/xdtjtx-plot-region-1.svg)

整个作图设备实际上可以分为三个区域，分别是：作图区域（Plot Region）、图形区域（Figure Region）和 设备区域（Device Region），这三个区域也对应着两种边界：图形边界（Figure Margin）和 外边界（Outer Margin）。

R 中的图形都是作在一个图形设备中，最常见的图形设备就是一个图形窗口，也可以在其它设备中（参见附录 [B.6](https://bookdown.org/xiangyun/msg/tricks.html#sec:device)）；整个设备内的区域就称为设备区域，也就是图 [B.3](https://bookdown.org/xiangyun/msg/tricks.html#fig:plot-region) 中最大的灰色区域，图形区域是设备区域内的白色实框方形区域，最里面的灰色虚框区域就是作图区域，我们的图形实体部分就作在这个区域。



