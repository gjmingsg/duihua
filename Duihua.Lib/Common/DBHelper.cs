using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Configuration;
using System.Data.SqlClient;
using System.Reflection;

namespace Duihua.Lib.Common
{
    public class DBHelper
    {
        private string constr;

        public DBHelper() {
            constr = ConfigurationManager.ConnectionStrings["DuihuaDB"].ConnectionString;
        }
        public DBHelper(string _constr) {
            constr = _constr;
        }

        /// <summary>
        /// 插入
        /// </summary>
        /// <param name="obj"></param>
        /// <param name="sql"></param> 
        public void ExecuteNonQuery<T>(T obj, string sql)
        {
            using (SqlConnection con = new SqlConnection(constr))
            {
                using (SqlCommand command = new SqlCommand(sql, con))
                {
                    con.Open();

                    Type t = obj.GetType();
                    foreach (PropertyInfo pi in t.GetProperties())
                    {
                        object temp = pi.GetValue(obj, null);
                        if (temp == null)
                            command.Parameters.AddWithValue("@" + pi.Name, DBNull.Value);
                        else
                            command.Parameters.AddWithValue("@" + pi.Name, pi.GetValue(obj, null));
                    }
                    command.ExecuteNonQuery();
                    con.Close();
                }
            }
        }

        /*
        public T QueryEntity<T>(Dictionary<string, object> obj, string sql)
        {
            using (SqlConnection myCon = new SqlConnection(constr))
            {
                myCon.Open();
                using (SqlCommand command = new SqlCommand(sql, myCon))
                {
                    foreach (var key in obj.Keys)
                    {
                        if (obj[key] == null)
                            command.Parameters.AddWithValue("@" + key, DBNull.Value);
                        else
                            command.Parameters.AddWithValue("@" + key, obj[key]);
                    }

                    SqlDataReader reader = command.ExecuteReader();
                    object o = Activator.CreateInstance(typeof(T));
                    while (reader.Read())
                    {
                        Type t = obj.GetType(); 
                        foreach (PropertyInfo pi in t.GetProperties())
                        {
                             string name = reader.GetName(i);
                            if (string.IsNullOrEmpty(name))
                                continue;
                            if (reader.IsDBNull(reader.GetOrdinal(name)) == false)
                                 
                            pi.SetValue(obj, reader.GetString(reader.GetOrdinal(name)), null);
                        }
                         
                    }
                    return o;
                }
            }
        }*/
        /*
        public List<T> QueryListData<T>(T obj, string sql)
        {
            using (SqlConnection con = new SqlConnection(constr))
            {
                using (SqlCommand command = new SqlCommand(sql, con))
                {
                    con.Open();

                    Type t = obj.GetType();
                    foreach (PropertyInfo pi in t.GetProperties())
                    {
                        object temp = pi.GetValue(obj, null);
                        if (temp == null)
                            command.Parameters.AddWithValue("@" + pi.Name, DBNull.Value);
                        else
                            command.Parameters.AddWithValue("@" + pi.Name, pi.GetValue(obj, null));
                    }

                    SqlDataReader reader = command.ExecuteReader();
                    List<T> list = new List<T>();
                    while (reader.Read())
                    {
                        T item = new T();
                        for (int i = 0; i < reader.FieldCount; i++)
                        {
                            string name = reader.GetName(i);
                            if (string.IsNullOrEmpty(name))
                                continue;
                            if (reader.IsDBNull(reader.GetOrdinal(name)) == false)
                                item.Add(name, reader.GetString(reader.GetOrdinal(name)));
                        }
                        list.Add(item);
                    }
                    return list;
                }
            }
        }
         */


        public void ExecuteNonQuery(Dictionary<string, object> obj, string sql)
        {
           
            using (SqlConnection con = new SqlConnection(constr))
            {
                using (SqlCommand command = new SqlCommand(sql, con))
                {
                    con.Open();
               
                    foreach (KeyValuePair<string, object> pi in obj)
                    {
                        command.Parameters.AddWithValue("@" + pi.Key, pi.Value);
                    }
                    //command.Prepare();
                    command.ExecuteNonQuery();
                    con.Close();
                }
            }
           
        }
        public object QueryScalar(Dictionary<String, Object> obj, String sql)
        {
            using (SqlConnection myCon = new SqlConnection(constr))
            {
                myCon.Open();
                using (SqlCommand command = new SqlCommand(sql, myCon))
                {
                    foreach (var key in obj.Keys)
                    {
                        object temp = obj[key];

                        if (temp == null)
                            command.Parameters.AddWithValue("@" + key, DBNull.Value);
                        else
                            command.Parameters.AddWithValue("@" + key, temp);
                    }
                    
                    return command.ExecuteScalar();
                }
            }
        }
        public List<Dictionary<String, Object>> QueryListData(Dictionary<String, Object> obj, String sql)
        {
            using (SqlConnection myCon = new SqlConnection(constr))
            {
                myCon.Open();
                using (SqlCommand command = new SqlCommand(sql, myCon))
                {
                    foreach (var key in obj.Keys)
                    {
                        object temp = obj[key];
                        
                        if (temp == null)
                            command.Parameters.AddWithValue("@" + key, DBNull.Value);
                        else
                            command.Parameters.AddWithValue("@" + key, temp);
                    }

                    SqlDataReader reader = command.ExecuteReader();
                    List<Dictionary<String, Object>> list = new List<Dictionary<String, Object>>();
                    while (reader.Read())
                    {
                        Dictionary<String, Object> item = new Dictionary<String, Object>();
                        for (int i = 0; i < reader.FieldCount; i++)
                        {
                            string name = reader.GetName(i);
                            if (string.IsNullOrEmpty(name))
                                continue;
                            if (reader.IsDBNull(reader.GetOrdinal(name)) == false)
                                item.Add(name, reader.GetValue(reader.GetOrdinal(name)));
                        }
                        list.Add(item);
                    }
                    return list;
                }
            }
        }
    }
}
