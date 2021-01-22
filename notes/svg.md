SVG诞生于2001年，直到高分辨率设备的出现才被广泛注意和采用。

### SVG的根元素
SVG的根元素有`width`、`height`、`viewBox`属性。

```
<svg width="198px" height="188px" viewBox="0 0 99 94">
```

**视口**，即在设备上能够观看内容的面积；举例来说，一部手机的视口可能只有320 x 480px，桌面电脑则一般为1920 x 1080px。  
宽度和高度属性对于创造一个视口十分有用。透过这个定义的视口，我们可以看到内部定义的SVG形状。  
SVG的内容可能会比视口大，但并不意味着多余的部分不存在，只是我们看不到而已。

The viewport is the visible area of the SVG image.  
An SVG image can logically be as wide and high as you want, but only a certain part of the image can be visible at a time.  
The area that is visible is called the viewport.  
You specify the size of the viewport using the `width` and `height` attributes of the `<svg>` element.

**视框** `viewBox`，则定义了SVG中所有形状都需要遵循的坐标系。  
视框值 0 0 99 94 是对矩形左上角和右下角的位置描述。

- [Understanding SVG Coordinate Systems and Transformations](https://www.sarasoueidan.com/blog/svg-coordinate-systems/)
- [SVG Viewport and View Box](http://tutorials.jenkov.com/svg/svg-viewport-view-box.html)
