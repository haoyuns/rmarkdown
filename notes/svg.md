SVG诞生于2001年，直到高分辨率设备的出现才被广泛注意和采用。

### SVG的根元素
SVG的根元素有`width`、`height`、`viewBox`属性。

```
<svg width="198px" height="188px" viewBox="0 0 99 94">
```

**视口**，即在设备上能够观看内容的面积；举例来说，一部手机的视口可能只有320 x 480px，桌面电脑则一般为1920 x 1080px。  
宽度和高度属性对于创造一个视口十分有用。透过这个定义的视口，我们可以看到内部定义的SVG形状。  
SVG的内容可能会比视口大，但并不意味着多余的部分不存在，只是我们看不到而已。

The canvas is the space or area where the SVG content is drawn. Conceptually, this canvas is infinite in both dimensions.  
The SVG can therefore be of any size. However, it is rendered on the screen relative to a finite region known as the viewport.  
Areas of the SVG that lie beyond the boundaries of the viewport are clipped off and not visible.  
You specify the size of the viewport using the `width` and `height` attributes on the outermost `<svg>` element.

**视框** `viewBox`，则定义了SVG中所有形状都需要遵循的坐标系。  
视框值 0 0 99 94 是对矩形左上角 (0, 0) 和右下角 (99, 94) 的位置描述。

```
viewBox = <min-x> <min-y> <width> <height>
```

参考：
- [Understanding SVG Coordinate Systems and Transformations](https://www.sarasoueidan.com/blog/svg-coordinate-systems/)
- [SVG Viewport and View Box](http://tutorials.jenkov.com/svg/svg-viewport-view-box.html)

### 元素g
`<g>`元素能把其他元素捆绑在一起，有助于图形编辑软件再次打开这个图像。

### SVG形状元素
可用的现成形状：path, rect, circle, ellipse, line, polyline, polygon。

### SVG路径
和SVG形状有所区别，它们由任意数量的连接点组成，允许自由创造形状

### 使用工具创建SVG
- Adobe Illustrator
- Sketch
- Inkscape
- [Method Draw](https://editor.method.ac/)
- SVG 图标网站，https://icomoon.io/

