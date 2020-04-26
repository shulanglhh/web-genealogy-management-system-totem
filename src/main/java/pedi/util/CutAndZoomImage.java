package pedi.util;

import java.awt.Canvas;
import java.awt.Graphics;
import java.awt.image.AreaAveragingScaleFilter;
import java.awt.image.BufferedImage;
import java.awt.image.FilteredImageSource;
import java.io.File;
import java.io.FileNotFoundException;
import java.io.IOException;


import javax.imageio.ImageIO;


/**
 * @desc 缩放和裁剪图片
 *
 */
public class CutAndZoomImage {


	/**
	 * 得到图片的宽度和高度
	 * @param source  图片存放的路径
	 * @return 返回一个int数组<br>
	 *  <ul>
	 *    <li>[0] 为图片宽度</li>
	 *    <li>[1] 为图片高度</li>
	 *  </ul>
	 */
	public static int[] getImageWH(String source){
		int wh[] = new int[2];
		if(source == null || "".equals(source)){
			return wh;
		}
		try {
			BufferedImage buffer = equalScale(source);
			wh[0] = buffer.getWidth();
			wh[1] = buffer.getHeight();
		} catch (Exception e) {
			e.printStackTrace();
		}
		return wh;
	}
	
	/**
	 * 根据起始和终止坐标裁剪图片
	 * @param source 原图片存放的路径
	 * @param dist 裁剪后的图片存放路径
	 * @param x1  裁剪的起始 x坐标
	 * @param y1  裁剪的起始 y 坐标
	 * @param x2  裁剪终止 x 坐标
	 * @param y2 裁剪终止 y 坐标
	 * @return 裁剪成功返回true，否则返回false。
	 */
	public static boolean cutImageByCoord(String source, String dist, int x1, int y1, int x2, int y2){
		return cutImage(source, dist, x1, y1, x2 - x1, y2 - y1);
	}
	
	/**
	 * 根据起始坐标和要裁剪的图片的宽度和高度裁剪图片
	 * @param source  原图的存放路径
	 * @param dist   裁剪后图片存放路径
	 * @param x      起始x坐标
	 * @param y      起始y坐标
	 * @param width  要裁剪的图片的宽度
	 * @param height 要裁剪的图片的高度
	 * @return  裁剪成功返回true，否则返回false
	 */
	public static boolean cutImage(String source, String dist, int x, int y, int width, int height){
		if(source == null || "".equals(source) || dist == null || "".equals(dist)){
			return false;
		}
		try {
			boolean b = ((x + y) == 0) || ((width + height) == 0);
			BufferedImage bi = equalScale(source);
			int imgWidth = bi.getWidth();
			int imgHeight = bi.getHeight();
			if(x >= imgWidth || y >= imgHeight || b){
				bi = zoomImage(bi, 400, 400);
				return ImageIO.write(bi, "JPEG", new File(dist));
			}
			
			if((x + width) >= imgWidth){
				width = imgWidth - x;
			}
			if((y + height) >= imgHeight){
				height = imgHeight - x;
			}
			BufferedImage result = bi.getSubimage(x, y, width, height);
			result = zoomImage(result, 400, 400);
			return ImageIO.write(result, "JPEG", new File(dist));
		} catch (FileNotFoundException e) {
			e.printStackTrace();
		} catch (IOException e) {
			e.printStackTrace();
		}
		return false;
	}
	
	public static BufferedImage equalScale(String source){
		return equalScale(source, 1000, 1000);
	}
	
	/**
	 * 根据缩放后图片的宽和高计算缩放的比例
	 * @version 2011-6-1
	 * @param source  图片的原始存放路径
	 * @param w  缩放后的图片的宽度
	 * @param h  缩放后的图片的高度
	 * @return 返回缩放后的图片的缓存
	 */
	public static BufferedImage equalScale(String source, int w, int h){
		
		if(source == null || "".equals(source.trim())){
			return null;
		}
		try {
			BufferedImage buffer = ImageIO.read(new File(source));
			int sh = buffer.getHeight(null);
			int sw = buffer.getWidth(null);
			if(sh <= h && sw <= w){
				return buffer;
			}
			int finalW = 0;
			int finalH = 0;
			if(sh > h && sw < w){
				double scale = (double)h / (double) sh;
				finalW = (int)(sw * scale);
				finalH = h;
			}else if(sh < h && sw > w){
				finalW = w;
				double scale = (double)h / (double) sh;
				finalH = (int)(sh * scale);
			}else if(sh > h && sw > w){
				double scale = (double)h / (double) sh;
				if(sh > sw){
					scale = (double)h / (double) sh;
				}else if(sw > sh){
					scale = (double)w / (double) sw;
				}
				finalH = (int)(sh * scale);
				finalW = (int)(sw * scale);
			}
			return zoomImage(buffer, finalW, finalH);
		} catch (IOException e) {
			e.printStackTrace();
		}
		
		return null;
	}
	
	
	
	/***
	 * 缩放图像
	 * @param buffer 图片缓存
	 * @param width  缩放后的宽度
	 * @param height 缩放后的高度
	 * @return 返回缩放后的 图片缓存
	 */
	public static BufferedImage zoomImage(BufferedImage buffer, int width, int height){
		try {
			if(buffer == null){
				return buffer;
			}
			 AreaAveragingScaleFilter areaAveragingScaleFilter = new AreaAveragingScaleFilter(  
		                width, height);  
		        FilteredImageSource filteredImageSource = new FilteredImageSource(buffer  
		                .getSource(), areaAveragingScaleFilter);
			BufferedImage result = new BufferedImage(width, height, BufferedImage.TYPE_INT_RGB);
			Graphics g =  result.getGraphics();
			Canvas canvas = new Canvas();
			g.drawImage(canvas.createImage(filteredImageSource), 0, 0, null);
			return result;
		} catch (Exception e) {
			e.printStackTrace();
		}
		return null;
	}
	
	/**
	 * 缩放图片
	 * @param source 原图存放路径
	 * @param dist   缩放后图片存放的路径
	 * @param width  缩放后图片的宽度
	 * @param height 缩放后图片的高度
	 * @return 缩放成功返回true，否则返回false
	 */
	public static boolean zoomImage(String source, String dist, int width, int height){
		if(source == null || "".equals(source) || dist == null || "".equals(dist)){
			return false;
		}
		try {
			BufferedImage bi = equalScale(source, width, height);
			//bi = zoomImage(bi, width, height);
			return ImageIO.write(bi, "JPEG", new File(dist));
		} catch (IOException e) {
			e.printStackTrace();
		}
		return false;
	}
	
}
