
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

#region Additional Namespaces
using eBike.Data.Entities;
using eBikeSystem.DAL;
#endregion
namespace ChinookSystem.BLL
{
    public class EmployeeController
    {
        public Employee Employee_Get(int employeeid)
        {
            using (var context = new eBikeContext())
            {
                return context.Employees.Find(employeeid);
            }
        }
    }
}
