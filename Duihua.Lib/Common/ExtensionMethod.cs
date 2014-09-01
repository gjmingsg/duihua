using System.Runtime.Serialization;
using System.Collections.Generic;
using System;
using System.Reflection;


namespace Duihua.Lib.Common
{
    public static class ExtensionMethod
    {
        // Methods
        public static object ChangeType(this object value, Type type)
        {
            object obj2;
            if ((value == null) && type.IsGenericType)
            {
                return Activator.CreateInstance(type);
            }
            if (value == null)
            {
                return null;
            }
            if (type == value.GetType())
            {
                return value;
            }
            if (type.IsEnum)
            {
                if (value is string)
                {
                    return Enum.Parse(type, value as string);
                }
                return Enum.ToObject(type, value);
            }
            if (!type.IsInterface && type.IsGenericType)
            {
                if (value == null)
                {
                    return null;
                }
                if (string.IsNullOrEmpty(value as string))
                {
                    return null;
                }
                System.ComponentModel.NullableConverter converter = new System.ComponentModel.NullableConverter(type);
                type = converter.UnderlyingType;
                return value.ChangeType(type);
            }
            try
            {
                if ((value is string) && (type == typeof(Guid)))
                {
                    if (string.IsNullOrEmpty(value as string))
                    {
                        return Guid.Empty;
                    }
                    return new Guid(value as string);
                }
                if ((value is string) && (type == typeof(DateTime)))
                {
                    DateTime time;
                    if (string.IsNullOrEmpty(value as string))
                    {
                        return null;
                    }
                    if (!DateTime.TryParse(value as string, out time))
                    {
                        throw new Exception("Can not convert " + value.ToString() + " to datetime format!");
                    }
                    return time;
                }
                if ((value is string) && (type == typeof(Version)))
                {
                    return new Version(value as string);
                }
                if (!(value is IConvertible))
                {
                    return value;
                }
                obj2 = Convert.ChangeType(value, type);
            }
            catch (Exception exception)
            {
                throw exception;
            }
            return obj2;
        }

        public static string GetDescription(this Enum o)
        {
            Type enumType = o.GetType();
            string name = Enum.GetName(enumType, o);
            EnumMemberAttribute customAttribute = (EnumMemberAttribute)Attribute.GetCustomAttribute(enumType.GetField(name), typeof(EnumMemberAttribute));
            if (customAttribute != null)
            {
                return customAttribute.Value;
            }
            return name;
        }

        public static string Substring(this string strOrg, int length, string endOf)
        {
            if (!string.IsNullOrEmpty(strOrg) && ((length >= 0) && (length <= strOrg.Length)))
            {
                return (strOrg.Substring(0, length) + endOf);
            }
            return strOrg;
        }


        public static bool? ToBoolean(this string str)
        {
            bool flag;
            if (bool.TryParse(str, out flag))
            {
                return new bool?(flag);
            }
            return null;
        }

        public static DateTime? ToDateTime(this string str)
        {
            DateTime time;
            if (!string.IsNullOrEmpty(str) && DateTime.TryParse(str, out time))
            {
                return new DateTime?(time);
            }
            return null;
        }


        public static Dictionary<int, string> ToDisplayArray(this Enum o)
        {
            Dictionary<int, string> dictionary = new Dictionary<int, string>();
            Type enumType = o.GetType();
            if (!enumType.IsEnum)
            {
                throw new Exception("ToDisplayArray must be have a enum type parameters!");
            }
            foreach (string str in Enum.GetNames(enumType))
            {
                EnumMemberAttribute customAttribute = (EnumMemberAttribute)Attribute.GetCustomAttribute(enumType.GetField(str), typeof(EnumMemberAttribute));
                string str2 = (customAttribute == null) ? str : customAttribute.Value;
                int key = (int)Enum.Parse(enumType, str, true);
                dictionary.Add(key, str2);
            }
            return dictionary;
        }


        public static Guid? ToGuid(this string str)
        {
            if (string.IsNullOrEmpty(str))
            {
                return null;
            }
            try
            {
                return new Guid?(new Guid(str));
            }
            catch
            {
                return null;
            }
        }

        public static int? ToInt(this string str)
        {
            int num;
            if (int.TryParse(str, out num))
            {
                return new int?(num);
            }
            return null;
        }


        #region Extend Function For Type Enum
        /// <summary>
        /// 将枚举类型转换成一个字典；
        /// </summary>
        /// <param name="o"></param>
        /// <returns></returns>
        public static Dictionary<int, string> ToNameArray(this Enum o)
        {
            Dictionary<int, string> result = new Dictionary<int, string>();
            Type oType = o.GetType();
            foreach (int i in Enum.GetValues(oType))
            {
                string name = Enum.GetName(oType, i);
                result.Add(i, name);
            }
            return result;
        }


        #endregion


        /// <summary>
        /// 
        /// 
        /// </summary>
        /// <param name="str"></param>
        /// <param name="strOperat"></param>
        /// <param name="needQuit"></param>
        /// <returns></returns>
        public static string strFilter(this string inputString)
        {
            //return @"LIKE '%' + REPLACE(REPLACE(#PartName#,'_','\_'),'%','\%') + '%' ESCAPE '\'";
            inputString = inputString.Trim();
            inputString = inputString.Replace("'", "");
            inputString = inputString.Replace(";--", "");
            inputString = inputString.Replace("--", "");
            inputString = inputString.Replace("=", "");
            //and|exec|insert|select|delete|update|chr|mid|master|or|truncate|char|declare|join|count|*|%|union 等待关键字过滤
            //不要忘记为你的用户名框，密码框设定 允许输入的最多字符长度 maxlength的值哦，这样他们就无法编写太长的东西来再次拼成第一次过滤掉的关键字 如 oorr一次replace过滤后又成了 or 喔。
            inputString = inputString.Replace("and", "");
            inputString = inputString.Replace("exec", "");
            inputString = inputString.Replace("insert", "");
            inputString = inputString.Replace("select", "");
            inputString = inputString.Replace("delete", "");
            inputString = inputString.Replace("update", "");
            inputString = inputString.Replace("chr", "");
            inputString = inputString.Replace("mid", "");
            inputString = inputString.Replace("master", "");
            inputString = inputString.Replace("or", "");
            inputString = inputString.Replace("truncate", "");
            inputString = inputString.Replace("char", "");
            inputString = inputString.Replace("declare", "");
            inputString = inputString.Replace("join", "");
            inputString = inputString.Replace("count", "");
            inputString = inputString.Replace("*", "");
            inputString = inputString.Replace("%", "");
            inputString = inputString.Replace("union", "");
            return inputString;

        }
    }
}
