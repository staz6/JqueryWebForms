using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.Services;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace WebApplication2
{
    public partial class _Default : Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            
        }

        [WebMethod]
        public static void GetCustomers(string email,string password)
        {
            Console.WriteLine(email);
        }
    }

    public class Customer
    {
        public string Email { get; set; }
        public string Password { get; set; }
    }
}