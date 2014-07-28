using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.IO;
using log4net;

namespace Duihua.Lib.Common
{
    public class ImageHelper
    {
        private readonly ILog Logger = LogManager.GetLogger(typeof(ImageHelper));
        /// <summary>
        /// 缩略图处理
        /// </summary>
        /// <param name="StrPath">物理目录</param>
        /// <param name="FirstUrl">原图片路径</param>
        /// <param name="iWidth">缩略图宽度</param>
        /// <param name="iHeigth">缩略图高度</param>
        /// <param name="strLocation">缩略图片路径</param>
        /// <param name="bRate">是否按比例缩放</param>
        /// <returns></returns>
        public  string ThumbPic(string StrPath, string FirstUrl, int iWidth, int iHeigth, bool bRate)
        {
            System.Drawing.Image oImage = null; //原图
            System.Drawing.Bitmap tImage = null;//缩略图
            System.Drawing.Graphics gx = null;
            int oWidth = 0;
            int oHeight = 0;
            int tWidth = iWidth;
            int tHeight = iHeigth;
            String filePath = string.Empty;
            try
            {
                //读取原图
                oImage = System.Drawing.Image.FromFile(StrPath + FirstUrl);
                oWidth = oImage.Width; //原图宽度 
                oHeight = oImage.Height; //原图高度 

                //按比例缩放
                if (bRate)
                {
                    //按比例计算出缩略图的宽度和高度 
                    if (oWidth >= oHeight)
                        tHeight = (int)Math.Floor(Convert.ToDouble(oHeight) * (Convert.ToDouble(tWidth) / Convert.ToDouble(oWidth)));
                    else
                        tWidth = (int)Math.Floor(Convert.ToDouble(oWidth) * (Convert.ToDouble(tHeight) / Convert.ToDouble(oHeight)));
                }

                //生成缩略原图 
                tImage = new System.Drawing.Bitmap(tWidth, tHeight);
                gx = System.Drawing.Graphics.FromImage(tImage);
                gx.InterpolationMode = System.Drawing.Drawing2D.InterpolationMode.High; //设置高质量插值法 
                gx.SmoothingMode = System.Drawing.Drawing2D.SmoothingMode.HighQuality;//设置高质量,低速度呈现平滑程度 
                gx.Clear(System.Drawing.Color.Transparent); //清空画布并以透明背景色填充 
                gx.DrawImage(oImage, new System.Drawing.Rectangle(0, 0, tWidth, tHeight), new System.Drawing.Rectangle(0, 0, oWidth, oHeight), System.Drawing.GraphicsUnit.Pixel);
                filePath = FirstUrl.Substring(0, FirstUrl.LastIndexOf('.')) + "_small" + FirstUrl.Substring(FirstUrl.LastIndexOf('.'));
                Logger.Info("xxx==========================================================");
                Logger.Info(FirstUrl);
                Logger.Info(filePath);
                Logger.Info(StrPath + filePath);
                Logger.Info("==========================================================");
                //先判断缩略图片路径是否存在，若存在则不保存
                if (!File.Exists(StrPath + filePath))
                {
                    //以JPG格式保存图片 
                    tImage.Save(StrPath + filePath, System.Drawing.Imaging.ImageFormat.Jpeg);
                }
            }
            catch (System.Exception ex)
            {
                Logger.Error("图片处理失败", ex);
                return "";
            }
            finally
            {
                //释放资源 
                oImage.Dispose();
                gx.Dispose();
                tImage.Dispose();
            }
            return  filePath;
        }

    }
}
