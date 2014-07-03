using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Drawing;
using System.Drawing.Imaging;
using System.Drawing.Drawing2D;
using System.Text;
namespace Duihua.WebApp
{
    public partial class ImageValidator : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            int clen = 4, ctype = 0; ;
            try
            {
                clen = Convert.ToInt16(Request.QueryString["Len"].ToString().Trim());
                ctype = Convert.ToInt16(Request.QueryString["Type"].ToString().Trim());
            }
            catch
            { }
            string checkcodestr = CreateCheckCode(clen, ctype);
            //对checkcodestr进行加密 
            Session["CheckStr"] = checkcodestr;


        }

        /// <summary> 
        /// 创建验证码,返回验证码字符串 
        /// </summary> 
        /// <param name="CodeLen">int CodeLe:验证码长度</param> 
        /// <param name="CodeType">int CodeType:0纯数字;1纯字母;2数字与字母混合;3纯汉字</param> 
        /// <returns></returns> 
        /// 
        private string CreateCheckCode(int CodeLen, int CodeType)
        {
            /**参数说明：CodeLen(验证码长度）;CodeType(0纯数字，1纯字母,2,数字与字母混合，3,纯汉字)**/
            if (CodeType > 3)
            {
                CodeType = 3;
            }
            string codestring = "";
            //定义验证图片的长度与宽度 
            int Clen = 30 * CodeLen, Cheight = 30;
            //定义验证图片的背景颜色 
            Color CBcolor = Color.FromArgb(200, 200, 200);
            string[] font = { "Bell MT", "Verdana", "Microsoft Sans Serif", "Comic Sans MS", "Arial", "宋体", "幼圆", "楷体_GB2312", "仿宋_GB2312" };
            Font Cfont = new Font("Arial", 15, FontStyle.Bold);
            //产生随机验证码--------------------------------------------------------------------------------------------------- 
            switch (CodeType)
            {
                //纯数字 
                case 0:
                    Random random1 = new Random();
                    codestring = random1.Next((int)System.Math.Pow(10, CodeLen - 1), (int)System.Math.Pow(10, CodeLen) - 1).ToString();
                    break;
                //纯数字 
                //纯字母 
                case 1:
                    string Vchar1 = "A,B,C,D,E,F,G,H,I,J,K,L,M,N,O,P,Q,R,S,T,U,W,X,Y,Z,a,b,c,d,e,f,g,h,i,j,k,l,m,n,o,p,q,r,s,t,u,v,w,x,y,z";
                    String[] VcArray1 = Vchar1.Split(',');
                    int vclen1 = VcArray1.Length;
                    int vcindex1;
                    Random random2 = new Random();
                    for (int i = 0; i < CodeLen; i++)
                    {
                        vcindex1 = random2.Next(vclen1);
                        codestring = codestring + VcArray1[vcindex1];
                    }
                    break;
                case 2:
                    string Vchar2 = "0,1,2,3,4,5,6,7,8,9,A,B,C,D,E,F,G,H,I,J,K,L,M,N,O,P,Q,R,S,T,U,W,X,Y,Z,0,1,2,3,4,5,6,7,8,9,a,b,c,d,e,f,g,h,i,j,k,l,m,n,o,p,q,r,s,t,u,v,w,x,y,z";
                    String[] VcArray2 = Vchar2.Split(',');
                    int vclen2 = VcArray2.Length;
                    int vcindex2;
                    Random random3 = new Random();
                    for (int i = 0; i < CodeLen; i++)
                    {
                        vcindex2 = random3.Next(vclen2);
                        codestring = codestring + VcArray2[vcindex2];
                    }
                    break;
                //纯字母 
                //纯汉字 
                case 3:
                    //定义一个字符串数组储存汉字编码的组成元素 
                    string[] rBase = new String[16] { "0", "1", "2", "3", "4", "5", "6", "7", "8", "9", "a", "b", "c", "d", "e", "f" };

                    Random rnd = new Random();
                    int strlength = CodeLen * 2;
                    //定义一个object数组用来 
                    object[] bytes = new object[strlength];

                    /**/
                    /*每循环一次产生一个含两个元素的十六进制字节数组，并将其放入bject数组中 
                    每个汉字有四个区位码组成 
                    区位码第1位和区位码第2位作为字节数组第一个元素 
                    区位码第3位和区位码第4位作为字节数组第二个元素 
                    */
                    for (int i = 0; i < strlength; i++)
                    {
                        //区位码第1位 
                        int r1 = rnd.Next(11, 14);
                        string str_r1 = rBase[r1].Trim();

                        //区位码第2位 
                        rnd = new Random(r1 * unchecked((int)DateTime.Now.Ticks) + i);//更换随机数发生器的种子避免产生重复值 
                        int r2;
                        if (r1 == 13)
                        {
                            r2 = rnd.Next(0, 7);
                        }
                        else
                        {
                            r2 = rnd.Next(0, 16);
                        }
                        string str_r2 = rBase[r2].Trim();

                        //区位码第3位 
                        rnd = new Random(r2 * unchecked((int)DateTime.Now.Ticks) + i);
                        int r3 = rnd.Next(10, 16);
                        string str_r3 = rBase[r3].Trim();

                        //区位码第4位 
                        rnd = new Random(r3 * unchecked((int)DateTime.Now.Ticks) + i);
                        int r4;
                        if (r3 == 10)
                        {
                            r4 = rnd.Next(1, 16);
                        }
                        else if (r3 == 15)
                        {
                            r4 = rnd.Next(0, 15);
                        }
                        else
                        {
                            r4 = rnd.Next(0, 16);
                        }
                        string str_r4 = rBase[r4].Trim();

                        //定义两个字节变量存储产生的随机汉字区位码 
                        byte byte1 = Convert.ToByte(str_r1 + str_r2, 16);
                        byte byte2 = Convert.ToByte(str_r3 + str_r4, 16);
                        //将两个字节变量存储在字节数组中 
                        byte[] str_r = new byte[] { byte1, byte2 };

                        //将产生的一个汉字的字节数组放入object数组中 
                        bytes.SetValue(str_r, i);

                    }
                    Encoding gb = Encoding.GetEncoding("gb2312");
                    //根据汉字编码的字节数组解码出中文汉字 
                    for (int i = 0; i < strlength / 2; i++)
                    {
                        codestring = codestring + gb.GetString((byte[])Convert.ChangeType(bytes[i], typeof(byte[])));
                    }
                    break;
                //纯汉字 
            }

            //显示验证码----------------------------------------------------------------------------------------------------- 
            //创建一个图像 
            //定义画笔，用于绘制文字 
            Brush brush1 = new SolidBrush(Color.Black);
            Bitmap bitmap1 = new System.Drawing.Bitmap(Clen, Cheight);
            //从图像获取一个绘画面 
            Graphics graphics1 = Graphics.FromImage(bitmap1);
            //清除整个绘图画面并用颜色填充 
            graphics1.Clear(CBcolor);
            PointF Cpoint1 = new PointF(5, 5);
            Random rnd1 = new Random();
            int x1 = 0, y1 = 0;
            //绘制边框 
            graphics1.DrawRectangle(new Pen(Color.Silver), 0, 0, bitmap1.Width - 1, bitmap1.Height - 1);

            //绘制文字 
            for (int i = 0; i < codestring.Length; i++)
            {
                //随机字符位置 
                x1 = 25 * i;//rnd1.Next(10) + 20 * i;
                y1 = 5;//bitmap1.Height / 4;//rnd1.Next(bitmap1.Height / 4);
                Cpoint1 = new PointF(x1, y1);
                //随机字符颜色,应根据背景作适当调整以免显示模糊不清 
                brush1 = new SolidBrush(Color.FromArgb(rnd1.Next(100), rnd1.Next(100), rnd1.Next(100)));
                Cfont = new Font(font[rnd1.Next(font.Length - 1)], 15, FontStyle.Bold);
                //随机倾斜字符 
                graphics1.TranslateTransform(10, 0);
                Matrix transform = graphics1.Transform;
                transform.Shear(Convert.ToSingle(rnd1.NextDouble() - 0.5), 0.001f);
                graphics1.Transform = transform;
                graphics1.DrawString(codestring.Substring(i, 1), Cfont, brush1, Cpoint1);
                graphics1.ResetTransform();

            }
            //绘制干扰点 
            rnd1 = new Random();
            for (int i = 0; i < 50 * CodeLen; i++)
            {
                //随机干扰位置 
                x1 = rnd1.Next(bitmap1.Width);
                y1 = rnd1.Next(bitmap1.Height);
                bitmap1.SetPixel(x1, y1, Color.FromArgb(rnd1.Next(50), rnd1.Next(50), rnd1.Next(50)));
            }
            //绘制干扰线 
            rnd1 = new Random();
            //for (int i = 0; i < 10; i++)
            //{
            //    //随机干扰位置 
            //    x1 = rnd1.Next(bitmap1.Width);
            //    y1 = rnd1.Next(bitmap1.Height);
            //    int x2 = rnd1.Next(bitmap1.Width);
            //    int y2 = rnd1.Next(bitmap1.Height);
            //    //随机干扰线颜色 
            //    Pen pen1 = new Pen(Color.FromArgb(rnd1.Next(100, 255), rnd1.Next(100, 255), rnd1.Next(100, 255)));
            //    graphics1.DrawLine(pen1, x1, y1, x2, y2);
            //}
            bitmap1.Save(Response.OutputStream, ImageFormat.Jpeg);
            bitmap1.Dispose();
            graphics1.Dispose();
            return codestring;
        }
    }
}