// 参考ページ https://sites.google.com/view/gutugutu3030/other/processingdehuamianquantinosukurinshottowocuoru
// Processing 3 (https://processing.org) による開発
// BSD2項ライセンスとする。 (c) T.Hori

import java.awt.Dimension;
import java.awt.Toolkit;
import java.awt.Robot;
import java.awt.Rectangle;
import java.awt.image.*;

int WW=320;
int HH=640;

void setup() {
  size(640, 200); //通知する(色を付ける)ウインドウのサイズ
  surface.setLocation(640,500); //通知するウインドウの表示位置
  frameRate(5);
}

void draw() {
  background(64); //グレーにしておく
  PImage img=screenshot();
  img.loadPixels();
  int red=0;
  for(int px : img.pixels){
    if(red(px)>0xb0 && green(px)<0x30 && blue(px)<0x30){
      red++;
    }
  }
  if(red>100*100){ //赤色の画素が10000個以上あったら
    background(255,0,0); // 赤にする
  }
}

PImage screenshot() {//スクショをPImage型で保存
  try {
    Robot robot = new Robot();
    Dimension screenSize = Toolkit.getDefaultToolkit().getScreenSize();
    BufferedImage img = robot.createScreenCapture(new Rectangle(screenSize));
    return b2p(img);
  }
  catch(Exception e) {
  }
  return null;
}

PImage b2p(BufferedImage img1) {// 画面左端WW幅 真ん中のHH高さのBufferedImageをPImageに変更
  PImage img2 = createImage(WW, HH, ARGB);
  Raster r=img1.getRaster();
  int cnt=0;
  for (int j = img1.getHeight()/2-HH/2; j < img1.getHeight()/2+HH/2; j++) {
    for (int i = 0; i < WW; i++) {
      int data[]=r.getPixel(i, j, new int[4]);
      img2.pixels[cnt++] = img1.getRGB(i, j);
    }
  }
  img2.updatePixels();
  return img2;
}
