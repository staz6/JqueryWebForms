using Dapper;
using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.Script.Services;
using System.Web.Services;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace WebApplication2
{
    public partial class crud : System.Web.UI.Page
    {
        const string connectionString = "Server=localhost;Database=webforms;Trusted_Connection=True";
        protected void Page_Load(object sender, EventArgs e)
        {

        }


        [WebMethod]
        [ScriptMethod(UseHttpGet = true)]
        public static List<Person> GetCustomers()
        {
            using(SqlConnection sqlCon = new SqlConnection(connectionString))
            {
                return sqlCon.Query<Person>("Select * from Person", commandType: CommandType.Text).ToList();
            }    
        }
        [WebMethod]
        public static void PostCustomer(string Name)
        {
            DynamicParameters param = new DynamicParameters();
            param.Add("@Name", Name);
            using (SqlConnection sqlCon = new SqlConnection(connectionString))
            {
                sqlCon.Execute("Insert into Person(Name) Values(@Name)", param, commandType: CommandType.Text);
            }

        }

        [WebMethod]
        public static void DeleteCustomer(int id)
        {
            DynamicParameters param = new DynamicParameters();
            param.Add("@Id", id);
            using (SqlConnection sqlCon = new SqlConnection(connectionString))
            {
                sqlCon.Execute("Delete from Person where Id=@Id", param, commandType: CommandType.Text);
            }
        }
        [WebMethod]
        public static void EditCustomer(int Id,string Name)
        {
            DynamicParameters param = new DynamicParameters();
            param.Add("@Id", Id);
            param.Add("@Name", Name);
            using (SqlConnection sqlCon = new SqlConnection(connectionString))
            {
                sqlCon.Execute("Update Person Set Name=@Name where Id=@Id", param, commandType: CommandType.Text);
            }
        }
    }

    public class Person
    {
        public int Id { get; set; }
        public string Name { get; set; }
    }
}